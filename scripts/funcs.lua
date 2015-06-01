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

-- Check if a file exists
function fileExists(path)
	local file = io.open(path, "r")
	if file ~= nil then 
		io.close(file)
		return true
	else
		return false
	end
end
