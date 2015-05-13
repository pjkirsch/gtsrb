-- Include required libraries
require 'scripts/funcs'

require 'torch' -- torch
require 'image' 
require 'xlua' -- for progression bars
require 'csvigo' -- To read CSV files

-- Path to database
local path = 'data/GTSRB/Final_Test/Images/'
local csvPath = 'data/GT-final_test.csv'

-- Get number of images in the dataset
local nbImg = tonumber(io.popen('find ' .. path .. ' -type f -name "*.ppm" | wc -l'):read("*all"))

nbTest = nbImg
testData = {
	data = torch.Tensor(nbTest, 1, 32, 32),
	labels = {},
}
-- Sample counters
local testCnt = 1

-- csv header: Filename;Width;Height;Roi.X1;Roi.Y1;Roi.X2;Roi.Y2;ClassId
-- Open csv file
local csvFile = csvigo.load{path=csvPath, separator=';', header=false, skip=1}
	
for k,imgFile in pairs(csvFile.var_1) do
	local x1 = csvFile.var_4[k]
	local y1 = csvFile.var_5[k]
	local x2 = csvFile.var_6[k]
	local y2 = csvFile.var_7[k]
	local label = csvFile.var_8[k]
		
	print(path..imgFile)
	-- Load the image	
	local img = image.load(path .. imgFile)
	-- Crop and rescale the image
	img = image.crop(img, x1, y1, x2, y2)
	img = image.scale(img, 32, 32)
	--RGB --> YUV conversion
	img = image.rgb2yuv(img)
	
	-- Keep only grey scale
	img = img:select(1,1)

	-- Save in the dataset structure
	testData.data[{testCnt, 1, {}, {}}] = img
	testData.labels[testCnt] = num2classId(label)
	testCnt = testCnt + 1
end

-- Store the preprocessed dataset
torch.save('data/testDataGrey.t7', testData)
