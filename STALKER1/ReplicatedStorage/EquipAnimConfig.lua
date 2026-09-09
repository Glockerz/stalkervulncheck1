-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	TypeRank = {
		Uniform = 1,
		BodyGear = 2,
		Backpack = 3,
		HeadGear = 4,
		FaceWear = 5
	},
	PLACEHOLDER = "rbxassetid://0",
	ByType = {
		HeadGear = {
			animId = "rbxassetid://126026512673567",
			sounds = {
				Equip = "rbxassetid://78141668144579",
				Foley = { "rbxassetid://85638201640521", "rbxassetid://..." }
			},
			PutOn = { "rbxassetid://112761559587899" }
		},
		FaceWear = {
			animId = "rbxassetid://98297222633060",
			sounds = {
				Adjust = "rbxassetid://...",
				Foley = { "rbxassetid://...", "rbxassetid://..." }
			}
		},
		BodyGear = {
			animId = "rbxassetid://128399246302287",
			sounds = {
				Velcro = { "rbxassetid://130090184642358", "rbxassetid://130082548624763" },
				Strap = { "rbxassetid://...", "rbxassetid://..." },
				Foley = { "rbxassetid://9116257572", "rbxassetid://9116257799" }
			}
		},
		Uniform = {
			animId = "rbxassetid://107959383499259",
			sounds = {
				Zipper = "rbxassetid://9121003784",
				Cuff = { "rbxassetid://...", "rbxassetid://..." },
				Foley = { "rbxassetid://9116198981", "rbxassetid://9116198866" }
			}
		},
		Backpack = {
			animId = "rbxassetid://92878680290707",
			sounds = {
				Strap = { "rbxassetid://...", "rbxassetid://..." },
				Foley = { "rbxassetid://...", "rbxassetid://..." }
			}
		}
	},
	ByItem = {},
	SoundVolume = 1,
	SoundMaxDistance = 60,
	SoundsOnUnequip = true,
	BlendTime = 0.15,
	MoveCancelGrace = 0.15,
	SpawnSuppress = 2,
	CoalesceWindow = 0.1,
	Debug = false
}