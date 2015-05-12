require "scripts/funcs"

require "torch"

--dofile("scripts/loadTrain.lua")
--dofile("scripts/loadTest.lua")
trainData = torch.load('data/trainData.t7')
validData = torch.load('data/validData.t7')
testData = torch.load('data/testData.t7')

dofile("scripts/models/mlp.lua")

dofile("scripts/train.lua")
dofile("scripts/valid.lua")
dofile("scripts/test.lua")

while true do
	train()
	valid()
	test()
end
