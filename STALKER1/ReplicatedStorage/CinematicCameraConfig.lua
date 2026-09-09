-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Version = "0.1.0",
	Whitelist = { 68620354, 184460696, 42855420 },
	Keys = {
		Toggle = Enum.KeyCode.F7,
		CycleMotion = Enum.KeyCode.M,
		Reset = Enum.KeyCode.Home,
		FovDown = Enum.KeyCode.LeftBracket,
		FovUp = Enum.KeyCode.RightBracket,
		FovFineModifier = Enum.KeyCode.LeftAlt,
		HideUI = Enum.KeyCode.Backspace,
		CursorFree = Enum.KeyCode.CapsLock,
		Overlays = {
			Grid = Enum.KeyCode.G,
			Letterbox = Enum.KeyCode.L,
			Level = Enum.KeyCode.H,
			Info = Enum.KeyCode.I,
			FocusRect = Enum.KeyCode.F,
			LightingPanel = Enum.KeyCode.P,
			ControlPanel = Enum.KeyCode.C,
			HoverHighlight = Enum.KeyCode.V
		}
	},
	Speed = {
		Base = 40,
		Boost = 4,
		Precise = 0.25,
		ScrollStep = 0.1
	},
	Mouse = {
		Sensitivity = 0.0025
	},
	Smoothing = {
		PositionAlpha = 0.15,
		RotationAlpha = 0.2
	},
	Handheld = {
		PositionAmplitude = 0.15,
		RotationAmplitude = 0.5,
		Frequency = 1.4
	},
	Focus = {
		DefaultDistance = 20,
		ScrollFineStep = 0.5
	},
	DOF = {
		FarIntensity = 0.75,
		InFocusRadius = 8,
		NearIntensity = 0.25
	},
	Camera = {
		DefaultFOV = 70,
		MinFOV = 20,
		MaxFOV = 120
	},
	Character = {
		Freeze = true,
		Invulnerable = true,
		HideOperatorCharacter = false
	},
	ImageOverlays = {}
}