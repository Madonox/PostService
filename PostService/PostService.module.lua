-- Madonox
-- 2021

local PostService = {}

local RunService = game:GetService("RunService")
local Systems = {}
Systems.Core = {}
Systems.LoadSequence = {}
Systems.LoadSequence.Client = {}
Systems.LoadSequence.Server = {}
local function loadModule(module)
	local res = {}
	local success,err = pcall(function()
		res = require(module)
	end)
	if not success then
		warn(string.format("Error detected while module loading, module: "..module:GetFullName().."\n Error: "..err))
	end
	return res
end
for i,v in ipairs(script.Parent.Core:GetChildren()) do
	if v:IsA("ModuleScript") then
		Systems.Core[v.Name] = loadModule(v)
	else
		warn("Module load failed: "..v:GetFullName())
	end
end
for i,v in ipairs(script.Parent.LoadSequence.Client:GetChildren()) do
	if v:IsA("ModuleScript") then
		Systems.LoadSequence.Client[v.Name] = loadModule(v)
	else
		warn("Module load failed: "..v:GetFullName())
	end
end
for i,v in ipairs(script.Parent.LoadSequence.Server:GetChildren()) do
	if v:IsA("ModuleScript") then
		Systems.LoadSequence.Server[v.Name] = loadModule(v)
	else
		warn("Module load failed: "..v:GetFullName())
	end
end

local loaded = false
function PostService.get()
	if loaded == true then
		if RunService:IsServer() then
			return require(script.Parent.Core.Server)
		elseif RunService:IsClient() then
			return require(script.Parent.Core.Client)
		end
	else
		PostService.start()
		warn("ALERT: PostService.get() method auxilary loading is depreciated!  Please call PostService.start() before calling PostService.get() from now on!  The chances of an error occuring during loading if you continue doing this are very great!")
		if RunService:IsServer() then
			return Systems.Core["Server"]
		elseif RunService:IsClient() then
			return Systems.Core["Client"]
		end
	end
end

function PostService.start()
	if loaded == false then
		if RunService:IsServer() then
			loaded = true
			for i,v in pairs(Systems.LoadSequence.Server) do
				if typeof(v) == "function" then
					v()
				elseif typeof(v) == "table" then
					for i2,v2 in ipairs(v) do
						if typeof(v2) == "function" then
							v2()
						end
					end
				end
			end
		elseif RunService:IsClient() then
			loaded = true
			for i,v in pairs(Systems.LoadSequence.Client) do
				if typeof(v) == "function" then
					v()
				elseif typeof(v) == "table" then
					for i2,v2 in ipairs(v) do
						if typeof(v2) == "function" then
							v2()
						end
					end
				end
			end
		end
	end
end
return PostService
