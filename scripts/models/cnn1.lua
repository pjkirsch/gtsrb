-- Define a small neural network model with 1 Conv. layer + 1 full hidden layer and 1 softmax layer

-- Load libraries
require 'torch'
require 'nn'

-- Define parameters
height = 32
width = 32
depth = 1
nPlanes = {depth, 8, 8}
poolRegion = 2
poolStep = 2

nInputs = height*width*depth
nHL1 = 30
nOutputs = 43

-- Define model
model = nn.Sequential() -- The NN model is considered as a sequence of functions
model:add(nn.SpatialConvolutionMM(nPlanes[1], nPlanes[2], 5, 5)) -- 8 kernels 1*5*5
model:add(nn.Tanh()) -- Hyperbolic tangent non-linear function
model:add(nn.SpatialMaxPooling(poolRegion, poolRegion, poolStep, poolStep))
model:add(nn.SpatialConvolutionMM(nPlanes[2], nPlanes[3], 3, 3)) -- 8 kernels 8*3*3
model:add(nn.Tanh()) -- Hyperbolic tangent non-linear function
model:add(nn.SpatialMaxPooling(poolRegion, poolRegion, poolStep, poolStep))

nConvFeats = 6*6*nPlanes[3]
model:add(nn.Reshape(nConvFeats, false)) -- Reshape features from 3*32*32 to 3072*1
model:add(nn.Linear(nConvFeats, nHL1)) -- Connection weights
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
