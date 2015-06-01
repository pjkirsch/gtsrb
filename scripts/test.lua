-- This script is mostly based on  the one provided by Clement Farabet for Torch tutorial (test for supervised case)

require 'torch'   -- torch
require 'xlua'    -- xlua provides useful tools, like progress bars
require 'optim'   -- an optimization package, for online and batch methods

require 'scripts/funcs'
----------------------------------------------------------------------

print '==> defining test procedure'
local nTest = testData.size()
-- test function
function test()
	-- Open file containing results
	local resultFile = assert(io.open(paths.concat(opt.save, "hyp_epoch".. epoch .. ".csv"), "w"))
	print("Test results file opened.")

	-- write file header
	resultFile:write("ImageId,Label\n")

   -- local vars
   local time = sys.clock()

   -- set model to evaluate mode (for modules that differ in training and testing, like Dropout)
   model:evaluate()

   -- test over test data
   print('==> testing on test set:')
   for t = 1,nTest do
      -- disp progress
      xlua.progress(t, nTest)

      -- get new sample
      local input = testData.data[t]
      if opt.type == 'double' then input = input:double()
      elseif opt.type == 'cuda' then input = input:cuda() end

      -- test sample
      local _,pred = torch.max(model:forward(input),1) -- return the predicted class
		resultFile:write(t, ',', classId2num(pred[1]),"\n") -- Write the predicted number
   end

   -- timing
   time = sys.clock() - time
   time = time / nTest
   print("\n==> time to test 1 sample = " .. (time*1000) .. 'ms')

	-- Close test results file
	resultFile:close()
	print("Test results file closed.")
	
   -- Reset confusion matrix
   confusion:zero()
end
