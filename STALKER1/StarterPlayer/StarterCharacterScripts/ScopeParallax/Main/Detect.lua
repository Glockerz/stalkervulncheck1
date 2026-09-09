-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	timeout = 5
}
local Patcher = require(script.Parent:WaitForChild("Patcher"))

function t.init() --[[ init | Line: 6 | Upvalues: t (copy), Patcher (copy) ]]
	local t2 = {}
	local v1 = 0

	for v2, v3 in script.Parent.Patcher:GetChildren() do
		local autoDetectMethod = require(v3).autoDetectMethod

		table.insert(t2, autoDetectMethod)
	end

	task.spawn(function() --[[ Line: 14 | Upvalues: v1 (ref), t (ref), t2 (copy), Patcher (ref) ]]
		while not (v1 >= t.timeout) do
			v1 = v1 + task.wait()

			for v12, v2 in t2 do
				local v3 = v2()

				if v3 then
					Patcher.update(v3)

					return
				end
			end
		end
	end)
end

return t