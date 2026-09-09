-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	OpenKey = Enum.KeyCode.G,
	GuiName = "EmoteWheelGui",
	MaxEmotes = 12,
	WheelScale = 0.42,
	ButtonRadius = 0.72,
	DeadZoneScale = 0.32,
	BlendTime = 0.15,
	MoveCancelGrace = 0.15,
	Emotes = {
		{
			name = "Squat",
			animId = "rbxassetid://107217665460041",
			loop = true
		},
		{
			name = "Fit Check",
			animId = "rbxassetid://88540879147150"
		},
		{
			name = "Wall Lean 1",
			animId = "rbxassetid://85884356653900",
			loop = true
		},
		{
			name = "Relaxed Sit 1",
			animId = "rbxassetid://114910056503175",
			loop = true
		},
		{
			name = "Side Sleep",
			animId = "rbxassetid://100512769720114",
			loop = true
		}
	}
}