-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require("./types")

local t = {
	Gamepad1 = "Controller",
	Gamepad2 = "Controller",
	Gamepad3 = "Controller",
	Gamepad4 = "Controller",
	Gamepad5 = "Controller",
	Gamepad6 = "Controller",
	Gamepad7 = "Controller",
	Gamepad8 = "Controller",
	Touch = "Touch",
	MouseButton1 = "Desktop",
	MouseButton2 = "Desktop",
	MouseButton3 = "Desktop",
	MouseMovement = "Desktop",
	MouseWheel = "Desktop",
	Keyboard = "Desktop"
}
local v1 = "Desktop"

return function(p1) --[[ getInputDevice | Line: 23 | Upvalues: t (copy), v1 (ref) ]]
	local v12 = t[p1.Name]

	if not v12 then
		return v1
	end

	v1 = v12

	return v12
end