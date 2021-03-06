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
BATCH_SIZE = 64


class DiagnosticDataset(Dataset):
    """
    Dataset used in training the diagnostic classifier.
    """

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
    """
    Perform evaluation on :val_set for :limit batches with :model
    """
    val_loader = DataLoader(val_set, batch_size=BATCH_SIZE,
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
        div = limit * BATCH_SIZE
    else:
        div = len(val_set)

    if do_entropy:
        return correct / div, np.average(ents)
    else:
        return correct / div, np.nan


def stop_on_accs(n, validation_accuracy, repeat_stop=5, print_every=300):
    """
    Check whether we had the same validation accuracy for :repeat_stop prints,
    return a signal we should stop if that is the case.
    """
    if (n // print_every) > repeat_stop:
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
    train_loader = DataLoader(train_set, batch_size=BATCH_SIZE,
                              shuffle=True, num_workers=0)

    logging.info(f"Initialized dataset: {len(train_loader)} batches")

    model = torch.nn.Sequential(
        torch.nn.Linear(128, args.n_targets),
        # torch.nn.ReLU(),
        # torch.nn.Linear(32, 18),
    ).to(device)
    optimizer = torch.optim.Adam(model.parameters(), lr=args.lr)
    criterion = torch.nn.CrossEntropyLoss()

    val_accs = []
    t = 0
    stop = False

    for i in range(args.epochs):
        if stop is True:
            break
        logging.info(f"Start of epoch: {i}")
        for n, batch in enumerate(train_loader):
            t += 1
            data_in = batch[0].to(device)
            label = batch[1].type(torch.long).to(device)
            optimizer.zero_grad()
            output = model(data_in)
            loss = criterion(output, label.flatten())
            loss.backward()
            optimizer.step()
            if n % args.print_every == 0:
                val_acc, val_ent = validation_eval(
                    val_set, model, args.show_entropy)
                train_acc, train_ent = validation_eval(
                    train_set, model, args.show_entropy, limit=-1)
                val_accs.append(val_acc)

                if args.show_entropy:
                    logging.info(
                        f"Epoch: {i:2} - Step {n:5} - Loss: {loss:1.3f} - TAcc: {train_acc:1.5f}({train_ent:1.5f}) - VAcc: {val_acc:1.5f} ({val_ent:1.5f})")
                else:
                    logging.info(
                        f"Epoch: {i:2} - Step {n:5} - Loss: {loss:1.3f} - TAcc: {train_acc:1.5f} - VAcc: {val_acc:1.5f}")

                if stop_on_accs(t, val_accs, args.repeat_stop, args.print_every):
                    logging.warning("Stopping after stuck validation accuracy")
                    stop = True
                    break

    if args.machine:
        print(f"{args.outfile.replace('.pt','')},{train_acc:1.5f},{val_acc:1.5f}")
    else:
        print(
            f"Saving trained model to {args.outfile} with T:{train_acc:1.5f} V:{val_acc:1.5f}")
    torch.save(model.state_dict(), args.outfile)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("--data_dir", default="data/reason_dataset/", type=str,
                        help="Directory pointing to training data (REQUIRED)")
    parser.add_argument("--n_targets", default=18, type=int,
                        help="number of targets for diagnostic classifier")
    parser.add_argument("--epochs", default=50, type=int,
                        help="How many epochs to train")
    parser.add_argument("--lr", default=0.001, type=float,
                        help="Learning rate for Adam optimizer")
    parser.add_argument("--show_entropy", default=False, action='store_true',
                        help="Show entropy of prediction tensor")
    parser.add_argument("--seed", default=1, type=int,
                        help="Seeding")
    parser.add_argument("--repeat_stop", default=10, type=int,
                        help="How many steps to check for validation accuracy stuck")
    parser.add_argument("--print_every", default=100, type=int,
                        help="Print every X batches")
    parser.add_argument("--outfile", default='trained_diag.pt', type=str,
                        help="Trained network output name")
    parser.add_argument("--machine", default=False, action='store_true',
                        help="no print, machine output of stats")

    args = parser.parse_args()

    torch.manual_seed(args.seed)
    np.random.seed(args.seed)
    torch.cuda.manual_seed_all(args.seed)

    LOG_FORMAT = '%(asctime)s %(name)-6s %(levelname)-6s %(message)s'
    logging.basicConfig(format=LOG_FORMAT,
                        filename='train_diag.log',
                        level=getattr(logging, 'info'.upper()))
    if args.machine:
        logging.disable(logging.CRITICAL)
    config = vars(args)
    logging.info("Parameters:")
    for k, v in config.items():
        logging.info(f"  {k:>21} : {v}")

    main(args)
