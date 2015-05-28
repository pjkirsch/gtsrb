require "scripts/funcs"

require "torch"

-- Generate the datasets if not generated yet
if fileExists("data/trainDataGrey.t7") and fileExists("data/validDataGrey.t7") then
    trainData = torch.load('data/trainDataGrey.t7')
    validData = torch.load('data/validDataGrey.t7')
else
    dofile("scripts/loadTrainGrey.lua")
end

if fileExists("data/testDataGrey.t7") then
    testData = torch.load('data/testDataGrey.t7')
else
    dofile("scripts/loadTestGrey.lua")
end

-- Load the model
dofile("scripts/models/cnn2.lua")

-- Define the training and testing procedure
dofile("scripts/train.lua")
dofile("scripts/valid.lua")
dofile("scripts/test.lua")

-- Start learning procedure
while true do
    train()
    valid()
    test()
end
