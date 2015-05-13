-- Include required libraries
require 'scripts/funcs'

require 'torch' -- torch
require 'xlua' -- for progression bars
require 'csvigo' -- To read CSV files

-- Path to csv files
csvHypPath = arg[1]
csvRefPath = arg[2]

-- Open csv files
csvRef = csvigo.load{path=csvRefPath, separator=';', header=false, skip=1}
-- csv header: Filename;Width;Height;Roi.X1;Roi.Y1;Roi.X2;Roi.Y2;ClassId

csvHyp = csvigo.load{path=csvHypPath, separator=',', header=false, skip=1}
-- csv header: sampleId;ClassId
	
print('hyp\t==>\tref')

nSample = 0
nCorrect = 0
for k,refClass in pairs(csvRef.var_8) do
	hypClass = csvHyp.var_2[k] 
	if tonumber(hypClass) == tonumber(refClass) then 
		nCorrect = nCorrect+1 
	else
		print(hypClass .. '\t==>\t' .. refClass)
	end
	nSample = nSample+1
end

print('Score on test set: ' .. nCorrect/nSample*100 .. ' %')

