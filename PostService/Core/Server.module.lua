-- Madonox
-- 2021

local Server = {}

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

function Server.fire(player,method,...)
	if typeof(player) == "table" then
		for i,v in ipairs(player) do
			if v:IsA("Player") then
				RE:FireClient(player,method,...)
			end
		end
	elseif player:IsA("Player") then
		RE:FireClient(player,method,...)
	end
end
function Server.get(player,method,...)
	return RF:InvokeClient(player,method,...)
end
function Server.bulkFire(player,dat)
	if typeof(player) == "table" then
		for i,v in ipairs(player) do
			if v:IsA("Player") then
				if typeof(dat) == "table" then
					BE:FireClient(player,dat)
				else
					warn("Bulk Fire requires a table for data!")
				end
			end
		end
	elseif player:IsA("Player") then
		if typeof(dat) == "table" then
			BE:FireClient(player,dat)
		else
			warn("Bulk Fire requires a table for data!")
		end
	end
end
local Executor = require(script.Parent.Parent.Libraries.Executor)
function Server.add(name,func)
	Executor.add(name,func)
end

return Server
