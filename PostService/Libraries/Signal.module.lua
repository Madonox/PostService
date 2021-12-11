-- Madonox
-- 2021
local Signal = {}
Signal.__index = Signal
local internalSignal = {}
internalSignal.__index = internalSignal
function internalSignal.new()
	local new = {}
	new.functions = {}
	setmetatable(new,internalSignal)
	return new
end
function internalSignal:Connect(func)
	if typeof(func) == "function" then
		table.insert(self.functions,func)
	else
		warn("Function not supplied for connect method!")
	end
end
function internalSignal:Fire(...)
	for i,v in ipairs(self.functions) do
		v(...)
	end
end

function Signal.new(properties)
	local new = {}
	setmetatable(new,Signal)
	for i,v in ipairs(properties) do
		if new[v] == nil then
			new[v] = internalSignal.new()
		end
	end
	
	return new
end
function Signal:Fire(method,...)
	if self[method] then
		self[method]:Fire(...)
	else
		warn("Cannot find method "..method.." in signal.")
	end
end
return Signal
