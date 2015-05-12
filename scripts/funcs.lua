-- Split function, copied from http://stackoverflow.com/questions/1426954/split-string-in-lua (accessed 2015-04-27)

function split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

-- Split file path, name and extension
function splitFileName(fileName)
	return string.match(fileName, "(.-)([^/]-([^/%.]+))$")
end

-- Convert number labels to class-id
function num2classId(num)
	return num+1
end

-- Convert class-id to number labels
function classId2num(id)
	return id-1
end

-- Rescale pixel input features from [0,256] to [-2,2] which is more appropriate for tanh activation function
function rescalePixFeat(pixel)
	return (pixel/64 - 2)
end

