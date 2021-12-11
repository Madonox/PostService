-- Madonox
-- 2021

local Client = {}

local InstanceReference = require(script.Parent.Parent.Libraries.InstanceReference)

local RE
local RF
local BE

delay(1,function()
	if InstanceReference.Loaded == true then
		RE = InstanceReference.get("CoreEvent")
		RF = InstanceReference.get("CoreFunction")
		BE = InstanceReference.get("BulkEvent")
	else
		InstanceReference.OnLoad:Connect(function(loaded)
			if loaded == true then
				RE = InstanceReference.get("CoreEvent")
				RF = InstanceReference.get("CoreFunction")
				BE = InstanceReference.get("BulkEvent")
			else
				warn("InstanceReference loading failed!  Cannot load "..script:GetFullName())
			end
		end)
	end
end)

function Client.fire(method,...)
	RE:FireServer(method,...)
end
function Client.get(method,...)
	return RF:InvokeServer(method,...)
end
function Client.bulkFire(dat)
	if typeof(dat) == "table" then
		BE:FireServer(dat)
	else
		warn("Bulk Fire requires a table for data!")
	end
end
local Executor = require(script.Parent.Parent.Libraries.Executor)
function Client.add(name,func)
	Executor.add(name,func)
end

return Client
