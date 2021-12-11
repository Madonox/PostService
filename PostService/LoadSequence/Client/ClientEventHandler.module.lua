-- Madonox
-- 2021

local InstanceReference = require(script.Parent.Parent.Parent.Libraries.InstanceReference)
local Executor = require(script.Parent.Parent.Parent.Libraries.Executor)

return function()
	if InstanceReference.Loaded == true then
		local RE = InstanceReference.get("CoreEvent")
		local RF = InstanceReference.get("CoreFunction")
		local BE = InstanceReference.get("BulkEvent")

		RE.OnClientEvent:Connect(function(method,...)
			local args = {...}
			local success,err = pcall(function()
				Executor.execute(method,table.unpack(args))
			end)
			if not success then
				warn(string.format("RemoteEvent error:\nResponse: "..err))
			end
		end)
		RF.OnClientInvoke = function(method,...)
			local args = {...}
			local res = nil
			local success,err = pcall(function()
				res = Executor.execute(method,table.unpack(args))
			end)
			if not success then
				warn(string.format("RemoteEvent error:\nResponse: "..err))
				return {}
			else
				return res
			end
		end
		BE.OnClientEvent:Connect(function(tab)
			if typeof(tab) == "table" then
				for i,v in ipairs(tab) do
					if typeof(v) == "table" then
						if #v >= 1 then
							local method = tab[1]
							local args = {}
							for i2,v2 in ipairs(v) do
								if i2 > 1 then
									args[i2] = v2
								end
							end
							local success,err = pcall(function()
								Executor.execute(method,table.unpack(args))
							end)
							if not success then
								warn(string.format("RemoteEvent BULK error:\nResponse: "..err))
							end
						end
					end
				end
			end
		end)
	else
		InstanceReference.OnLoad:Connect(function(isLoaded)
			if isLoaded == true then
				local RE = InstanceReference.get("CoreEvent")
				local RF = InstanceReference.get("CoreFunction")
				local BE = InstanceReference.get("BulkEvent")

				RE.OnClientEvent:Connect(function(method,...)
					local args = {...}
					local success,err = pcall(function()
						Executor.execute(method,table.unpack(args))
					end)
					if not success then
						warn(string.format("RemoteEvent error:\nResponse: "..err))
					end
				end)
				RF.OnClientInvoke = function(method,...)
					local args = {...}
					local res = nil
					local success,err = pcall(function()
						res = Executor.execute(method,table.unpack(args))
					end)
					if not success then
						warn(string.format("RemoteEvent error:\nResponse: "..err))
						return {}
					else
						return res
					end
				end
				BE.OnClientEvent:Connect(function(tab)
					if typeof(tab) == "table" then
						for i,v in ipairs(tab) do
							if typeof(v) == "table" then
								if #v >= 1 then
									local method = tab[1]
									local args = {}
									for i2,v2 in ipairs(v) do
										if i2 > 1 then
											args[i2] = v2
										end
									end
									local success,err = pcall(function()
										Executor.execute(method,table.unpack(args))
									end)
									if not success then
										warn(string.format("RemoteEvent BULK error:\nResponse: "..err))
									end
								end
							end
						end
					end
				end)
			else
				warn("InstanceReference loading failed!  Cannot load "..script:GetFullName())
			end
		end)
	end
end
