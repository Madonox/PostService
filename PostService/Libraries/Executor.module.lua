-- Madonox
-- 2021

local Executor = {}
local methods = {}

local RunService = game:GetService("RunService")

function Executor.add(name,func)
	if typeof(func) == "function" then
		if methods[name] == nil then
			methods[name] = func
		else
			methods[name] = func
		end
	else
		warn("Please supply a valid function to use the .add method!")
	end
end
function Executor.execute(name,...)
	if methods[name] then
		return methods[name](...)
	else
		if RunService:IsServer() then
			local args = {...}
			if args[1]:IsA("Player") then
				args[1]:Kick(string.format("Post Service ERROR:\nIf you are seeing this message, please report it to the game developer!\nError: Unknown method, client kicked."))
			end
		end
	end
end
return Executor
