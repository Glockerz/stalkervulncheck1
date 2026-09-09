-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ContextActionService = game:GetService("ContextActionService")
local t = {
	Enum.KeyCode.One,
	Enum.KeyCode.Two,
	Enum.KeyCode.Three,
	Enum.KeyCode.Four
}

ContextActionService:BindActionAtPriority("LobbyWeaponHotbarBlock", function(p1, p2) --[[ Line: 20 ]]
	if p2 == Enum.UserInputState.Begin then
		return Enum.ContextActionResult.Sink
	end

	return Enum.ContextActionResult.Pass
end, false, Enum.ContextActionPriority.High.Value, table.unpack(t))
print("[LobbyWeaponLockClient] active \226\128\148 hotbar keys 1-4 blocked in lobby")