#!/data/data/com.termux/files/usr/bin/env python

import pybrain
from pybrain.tools.shortcuts import buildNetwork
from pybrain.structure import TanhLayer
from pybrain.datasets import SupervisedDataSet
from pybrain.supervised.trainers import BackpropTrainer

net = buildNetwork(2, 2, 1, bias=True, hiddenclass=TanhLayer)

ds = SupervisedDataSet(2, 1)
ds.addSample((0, 0), (0,))
ds.addSample((0, 1), (1,))
ds.addSample((1, 0), (1,))
ds.addSample((1, 1), (0,))

trainer = BackpropTrainer(net, ds)

print('Untrained:')
print([1,0], net.activate([1,0]))
print([0,1], net.activate([0,1]))
print([0,0], net.activate([0,0]))
print([1,1], net.activate([1,1]))

while trainer.train() > 0.001:
    pass

print('Trained:')
print([1,0], net.activate([1,0]))
print([0,1], net.activate([0,1]))
print([0,0], net.activate([0,0]))
print([1,1], net.activate([1,1]))
