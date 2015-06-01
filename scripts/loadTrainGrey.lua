-- Include required libraries
require 'scripts/funcs'

require 'torch' -- torch
require 'image' 
require 'xlua' -- for progression bars
require 'csvigo' -- To read CSV files

-- Path to database
local path = 'data/GTSRB/Final_Training/Images/'

-- Get number of images in the dataset
local nbImg = tonumber(io.popen('find ' .. path .. ' -type f -name "*.ppm" | wc -l'):read("*all"))

local nbTrain = nbImg - 43*30
trainData = {
	data = torch.Tensor(nbTrain, 1, 32, 32),
	labels = {},
	size = function() return trainData.data:size(1) end
}

local nbValid = 43*30
validData = {
	data = torch.Tensor(nbValid, 1, 32, 32),
	labels = {},
	size = function() return validData.data:size(1) end
}
-- Sample counters
local trainCnt = 1
local validCnt = 1

-- Get the list of csv files containing lables
local csvPathList = io.popen('ls -1 data/GTSRB/Final_Training/Images/*/*.csv')

for csvPath in csvPathList:lines() do
	-- Get the path of the data class
	local classPath = splitFileName(csvPath)

	-- csv header: Filename;Width;Height;Roi.X1;Roi.Y1;Roi.X2;Roi.Y2;ClassId
	-- Open csv file
	local csvFile = csvigo.load{path=csvPath, separator=';', header=false, skip=1}
	
	for k,imgFile in pairs(csvFile.var_1) do
		local x1 = csvFile.var_4[k]
		local y1 = csvFile.var_5[k]
		local x2 = csvFile.var_6[k]
		local y2 = csvFile.var_7[k]
		local label = csvFile.var_8[k]
		
		print(classPath..imgFile)
		-- Load the image	
		local img = image.load(classPath .. imgFile)
		-- Crop and rescale the image
		img = image.crop(img, x1, y1, x2, y2)
		img = image.scale(img, 32, 32)
		--RGB --> YUV conversion
		img = image.rgb2yuv(img)
		
		-- Keep only grey scale
		img = img:select(1,1)
	
		if k <= 30 then -- The 30 first images are for the validation set
			-- Save in the dataset structure
			validData.data[{validCnt, 1, {}, {}}] = img
			validData.labels[validCnt] = num2classId(label)
			validCnt = validCnt + 1
	
		else
			-- Save in the dataset structure
			trainData.data[{trainCnt, {}, {}, {}}] = img
			trainData.labels[trainCnt] = num2classId(label)
			trainCnt = trainCnt + 1
		end	
	end
end

-- Store the preprocessed dataset
torch.save('data/trainDataGrey.t7', trainData)
torch.save('data/validDataGrey.t7', validData)
