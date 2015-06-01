-- This script is mostly the one provided by Clement Farabet for Torch tutorial

require 'torch'   -- torch
require 'xlua'    -- xlua provides useful tools, like progress bars
require 'optim'   -- an optimization package, for online and batch methods

----------------------------------------------------------------------

-- Log results to files
validLogger = optim.Logger(paths.concat(opt.save, 'valid.log'))

nValid = validData.size()

print '==> defining validation procedure'

-- validation function
function valid()
   -- local vars
   local time = sys.clock()

   -- set model to evaluate mode (for modules that differ in training and testing, like Dropout)
   model:evaluate()

   -- test over validation data
   print('==> testing on valid set:')
   for t = 1,nValid do
      -- disp progress
      xlua.progress(t, nValid)

      -- get new sample
      local input = validData.data[t]
      if opt.type == 'double' then input = input:double()
      elseif opt.type == 'cuda' then input = input:cuda() end
      local target = validData.labels[t]

      -- valid sample
      local pred = model:forward(input)
      confusion:add(pred, target)
   end

   -- timing
   time = sys.clock() - time
   time = time / nValid
   print("\n==> time to test 1 sample = " .. (time*1000) .. 'ms')

   -- print confusion matrix
   print(confusion)

   -- update log/plot
   validLogger:add{['% mean class accuracy (valid set)'] = confusion.totalValid * 100}
   if opt.plot then
      validLogger:style{['% mean class accuracy (valid set)'] = '-'}
      validLogger:plot()
   end

   -- Reset confusion matrix
   confusion:zero()
end
