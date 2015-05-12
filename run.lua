require "scripts/funcs"

require "torch"

--dofile("scripts/loadTrain.lua")
--dofile("scripts/loadTest.lua")
trainData = torch.load('data/trainDataGrey.t7')
validData = torch.load('data/validDataGrey.t7')
testData = torch.load('data/testDataGrey.t7')

dofile("scripts/models/mlp-toy2.lua")

dofile("scripts/train.lua")
dofile("scripts/valid.lua")
dofile("scripts/test.lua")

while true do
	train()
	valid()
	test()
end
