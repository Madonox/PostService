-- Madonox
-- 2021

local InstanceReference = {}
local main = script.Parent.Parent
local instances = {}
local loaded = false

local Signal = require(script.Parent.Signal)
local selfSignal = Signal.new({"OnLoad"})
InstanceReference.OnLoad = selfSignal.OnLoad
InstanceReference.Loaded = false

local function preload(dir,allowed)
	for i,v in ipairs(dir:GetDescendants()) do
		if table.find(allowed,v.ClassName) then
			if instances[v.Name] == nil then
				instances[v.Name] = v
			else
				warn("Cannot register instance due to an instance with the same name already registered!  Instance: "..v:GetFullName())
			end
		end
	end
end
function InstanceReference.init()
	if loaded == false then
		loaded = true
		preload(main.Instances,{"RemoteFunction","RemoteEvent"})
		InstanceReference.Loaded = true
		selfSignal:Fire("OnLoad",loaded)
	end
end
function InstanceReference.create(ty,properties,par)
	local inst = Instance.new(ty)
	if inst then
		for i,v in pairs(properties) do
			inst[i] = v
		end
		inst.Parent = par
		return inst
	else
		warn(ty.." is not a valid instance!")
		return {}
	end
end
function InstanceReference.get(name)
	if instances[name] then
		return instances[name]
	else
		warn("Cannot find a registered instance by the name of "..name)
		return {}
	end
end
return InstanceReference
