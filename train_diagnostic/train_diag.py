import os
import torch
import logging
import argparse

import numpy as np

from torch.distributions.categorical import Categorical

from torch.utils.data.dataset import Dataset
from torch.utils.data import DataLoader
from machine.util.agent import ModelAgent


device = torch.device("cuda" if torch.cuda.is_available() else "cpu")


class DiagnosticDataset(Dataset):
    def __init__(self, dirname):
        files = [f for f in os.listdir(
            dirname) if os.path.isfile(os.path.join(dirname, f))]
        self.embeddings = []
        self.labels = []
        for file in files:
            data = np.load(os.path.join(dirname, file))
            self.embeddings.extend(data[:, 0])
            self.labels.extend(data[:, 1])

    def __getitem__(self, index):
        X = torch.Tensor(self.embeddings[index])
        y = torch.Tensor([self.labels[index]])
        return X, y

    def __len__(self):
        return len(self.embeddings)


def validation_eval(val_set, model, do_entropy=False, limit=-1):
    B_SIZE = 32
    val_loader = DataLoader(val_set, batch_size=B_SIZE,
                            shuffle=True, num_workers=0)
    correct = 0
    ents = []
    for n, batch in enumerate(val_loader):
        if limit > 0 and n > limit:
            break
        data_in = batch[0].to(device)
        label = batch[1].type(torch.long).to(device)
        h = model(data_in)
        if do_entropy:
            x = torch.distributions.Categorical(h).entropy()
            ents.append(x.mean().item())
        _, output = h.max(1)
        local_acc = sum(label.flatten() == output)
        correct += local_acc.item()
    if limit > 0:
        div = limit * B_SIZE
    else:
        div = len(val_set)
    return correct / div, np.average(ents)


def stop_on_accs(n, validation_accuracy, repeat_stop=5):
    if (n // 300) > repeat_stop:
        accs = np.array(validation_accuracy[-repeat_stop:])
        red = accs - accs[-1]
        trth = np.isclose(red, np.zeros(red.shape))
        return trth.all()


def main(args):
    # Create dataset
    dataset = DiagnosticDataset(args.data_dir)
    # Split data
    split = int(np.floor(0.2 * len(dataset)))
    train_set, val_set = torch.utils.data.random_split(
        dataset, [len(dataset) - split, split])
    train_loader = DataLoader(train_set, batch_size=32,
                              shuffle=True, num_workers=0)

    logging.info(f"Initialized dataset")

    model = torch.nn.Sequential(
        torch.nn.Linear(128, 18),
        torch.nn.ReLU(),
        torch.nn.LogSoftmax(dim=1)
    ).to(device)
    optimizer = torch.optim.Adam(model.parameters(), lr=args.lr)
    criterion = torch.nn.NLLLoss()

    val_accs = []
    t = 0
    stop = False

    for i in range(args.epochs):
        if stop is True:
            break
        logging.info(f"Start of epoch: {i}")
        for n, batch in enumerate(train_loader):
            t+=1
            data_in = batch[0].to(device)
            label = batch[1].type(torch.long).to(device)
            optimizer.zero_grad()
            output = model(data_in)
            loss = criterion(output, label.flatten())
            loss.backward()
            optimizer.step()
            if n % 300 == 0:
                val_acc, val_ent = validation_eval(
                    val_set, model, args.show_entropy)
                train_acc, train_ent = validation_eval(
                    train_set, model, args.show_entropy, limit=500)
                val_accs.append(val_acc)

                if args.show_entropy:
                    logging.info(
                        f"Epoch: {i:2} - Step {n:5} - Loss: {loss:1.3f} - TAcc: {train_acc:1.5f}({train_ent:1.5f}) - VAcc: {val_acc:1.5f} ({val_ent:1.5f})")
                else:
                    logging.info(
                        f"Epoch: {i:2} - Step {n:5} - Loss: {loss:1.3f} - TAcc: {train_acc:1.5f} - VAcc: {val_acc:1.5f}")

                if stop_on_accs(t, val_accs, args.repeat_stop):
                    logging.warning("Stopping after stuck validation accuracy")
                    stop = True
                    break

    torch.save(model.state_dict(), 'trained_diag.pt')


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--data_dir", default="reason_dataset/", type=str,
                        help="Directory pointing to training data (REQUIRED)")
    parser.add_argument("--epochs", default=5, type=int,
                        help="How many epochs to train")
    parser.add_argument("--lr", default=0.001, type=float,
                        help="Learning rate for Adam optimizer")
    parser.add_argument("--show_entropy", default=False, action='store_true',
                        help="Show entropy of prediction tensor")
    parser.add_argument("--seed", default=1, type=int,
                        help="Seeding")
    parser.add_argument("--repeat_stop", default=5, type=int,
                        help="How many steps to check for validation accuracy stuck")
    args = parser.parse_args()

    torch.manual_seed(args.seed)
    np.random.seed(args.seed)

    LOG_FORMAT = '%(asctime)s %(name)-6s %(levelname)-6s %(message)s'
    logging.basicConfig(format=LOG_FORMAT,
                        level=getattr(logging, 'info'.upper()))

    config = vars(args)
    logging.info("Parameters:")
    for k, v in config.items():
      logging.info(f"  {k:>21} : {v}")


    main(args)
