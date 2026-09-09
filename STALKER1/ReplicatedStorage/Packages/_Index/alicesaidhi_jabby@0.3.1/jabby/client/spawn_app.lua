-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local vide = require(script.Parent.Parent.Parent.vide)

require(script.Parent.Parent.modules.types)

local t = {}

return {
	unmount_all = function() --[[ unmount_all | Line: 8 | Upvalues: t (copy) ]]
		for v1 in t do
			v1()
		end
	end,
	spawn_app = function(p1, p2) --[[ spawn_app | Line: 14 | Upvalues: vide (copy), t (copy), Players (copy) ]]
		return vide.root(function(p12) --[[ Line: 15 | Upvalues: t (ref), p1 (copy), p2 (copy), Players (ref), vide (ref) ]]
			local function f1() --[[ Line: 17 | Upvalues: t (ref), p12 (copy) ]]
				t[p12] = nil
				p12()
			end

			local v2 = p1.mount(p2, f1)

			v2.Parent = Players.LocalPlayer.PlayerGui
			vide.cleanup(v2)
			t[f1] = true

			return f1
		end)
	end
}