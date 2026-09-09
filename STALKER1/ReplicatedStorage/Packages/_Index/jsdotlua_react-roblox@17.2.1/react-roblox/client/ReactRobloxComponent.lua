-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Object = require(script.Parent.Parent.Parent:WaitForChild("luau-polyfill")).Object
local RobloxComponentProps = require(script.Parent:WaitForChild("roblox"):WaitForChild("RobloxComponentProps"))

require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"))

return {
	setInitialProperties = RobloxComponentProps.setInitialProperties,
	diffProperties = function(p1, p2, p3, p4, p5) --[[ diffProperties | Line: 31 | Upvalues: Object (copy) ]]
		local v1 = nil

		for v2, v3 in p3 do
			if p4[v2] == nil then
				local v4 = if v1 then v1 else table.create(2)

				table.insert(v4, v2)
				table.insert(v4, Object.None)
				v1 = v4
			end
		end

		for v5, v6 in p4 do
			if v6 ~= (if p3 == nil then nil else p3[v5]) then
				local v8 = if v1 then v1 else table.create(2)

				table.insert(v8, v5)
				table.insert(v8, v6)
				v1 = v8
			end
		end

		return v1
	end,
	updateProperties = RobloxComponentProps.updateProperties,
	cleanupHostComponent = RobloxComponentProps.cleanupHostComponent
}