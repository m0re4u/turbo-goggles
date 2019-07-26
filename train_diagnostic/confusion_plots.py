import glob
import numpy as np
import matplotlib.pyplot as plt


for file in glob.glob('confusion*.log'):
    plt.clf()
    W = np.loadtxt(file)
    plt.imshow(W)
    plt.colorbar()
    plt.savefig(f'{file.strip(".log")}.png')
