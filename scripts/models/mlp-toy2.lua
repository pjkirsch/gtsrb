-- Define a toy neural network model with 1 hidden layer and 1 softmax layer

-- Load libraries
require 'torch'
require 'nn'

-- Define parameters
height = 32
width = 32
depth = 1

nInputs = height*width*depth
nHL1 = 30
nOutputs = 43

-- Define model
model = nn.Sequential() -- The NN model is considered as a sequence of functions
model:add(nn.Reshape(nInputs, false)) -- Reshape features from 1*32*32 to 1024*1
model:add(nn.Linear(nInputs, nHL1)) -- Connection weights
model:add(nn.ReLU()) -- Hyperbolic tangent non-linear function
model:add(nn.Linear(nHL1, nOutputs)) -- Connection weights
model:add(nn.LogSoftMax())

-- Display model description
print("Model description:")
print(model)

-- Define cost function
cfn = nn.ClassNLLCriterion()
print("Cost function:")
print(cfn)
