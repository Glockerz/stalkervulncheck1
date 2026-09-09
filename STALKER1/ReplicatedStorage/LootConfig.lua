-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Body = {
		MaxLifetime = 600,
		EmptyGrace = 120,
		LockTimeout = 30,
		BodyBagModel = "BodyBag",
		LootPromptText = "Loot",
		LootHoldTime = 1,
		CleanupInterval = 5,
		MaxGridHeight = 10
	},
	Respawn = {
		DelaySeconds = 0,
		StarterLoadout = {
			{
				ID = "PETZLHeadlamp"
			},
			{
				ID = "SovietBelt"
			},
			{
				ID = "ImprovisedBackpack"
			},
			{
				ID = "Makarov"
			},
			{
				ID = "PM_Magazine_8"
			},
			{
				ID = "PM_Magazine_8"
			},
			{
				ID = "PM_Magazine_8"
			},
			{
				ID = "PM_Magazine_8"
			},
			{
				ID = "9x18mm_FMJ_Box"
			},
			{
				ID = "AI-2 Medkit"
			},
			{
				ID = "Field Dressing"
			}
		},
		SupporterLoadouts = {
			Drifter = {
				{
					ID = "PETZLHeadlamp"
				},
				{
					ID = "SovietBelt"
				},
				{
					ID = "ImprovisedBackpack"
				},
				{
					ID = "Glock 19 Custom"
				},
				{
					ID = "Glock_Magazine_15 Custom"
				},
				{
					ID = "Glock_Magazine_15 Custom"
				},
				{
					ID = "9x19mm_FMJ_Box"
				},
				{
					ID = "AI-2 Medkit (Supporter)"
				},
				{
					ID = "AI-2 Medkit (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Iodine (Supporter)"
				}
			},
			Veteran = {
				{
					ID = "PETZLHeadlamp"
				},
				{
					ID = "SovietBelt"
				},
				{
					ID = "ImprovisedBackpack"
				},
				{
					ID = "Glock 19 Custom"
				},
				{
					ID = "Glock_Magazine_15 Custom"
				},
				{
					ID = "Glock_Magazine_15 Custom"
				},
				{
					ID = "9x19mm_FMJ_Box"
				},
				{
					ID = "AI-2 Military Medkit (Supporter)"
				},
				{
					ID = "AI-2 Military Medkit (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Iodine (Supporter)"
				}
			},
			MasterStalker = {
				{
					ID = "PETZLHeadlamp"
				},
				{
					ID = "SovietBelt"
				},
				{
					ID = "ImprovisedBackpack"
				},
				{
					ID = "Glock 19 Custom"
				},
				{
					ID = "Glock_Magazine_15 Custom"
				},
				{
					ID = "Glock_Magazine_15 Custom"
				},
				{
					ID = "9x19mm_FMJ_Box"
				},
				{
					ID = "AI-2 Scientific Medkit (Supporter)"
				},
				{
					ID = "AI-2 Scientific Medkit (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Field Dressing (Supporter)"
				},
				{
					ID = "Iodine (Supporter)"
				}
			}
		}
	},
	Container = {
		WindowMinSize = Vector2.new(240, 320),
		WindowDefaultSize = Vector2.new(320, 400)
	},
	NpcDeathPool = {
		Common = {
			{
				id = "Field Dressing",
				chance = 0.25
			},
			{
				id = "Bolts",
				chance = 0.25
			},
			{
				id = "Nuts",
				chance = 0.25
			},
			{
				id = "ElectricalTape",
				chance = 0.25
			},
			{
				id = "ClothFabric",
				chance = 0.25
			},
			{
				id = "AAABattery",
				chance = 0.25
			}
		},
		Uncommon = {
			{
				id = "AI-2 Medkit",
				chance = 0.08
			},
			{
				id = "Brufen",
				chance = 0.08
			},
			{
				id = "Iodine",
				chance = 0.08
			},
			{
				id = "Pliers",
				chance = 0.08
			},
			{
				id = "Wrench",
				chance = 0.08
			},
			{
				id = "ElectronicCable",
				chance = 0.08
			},
			{
				id = "AramidFabrics",
				chance = 0.08
			}
		},
		Rare = {
			{
				id = "AntiRadVial",
				chance = 0.02
			},
			{
				id = "Capacitors",
				chance = 0.02
			},
			{
				id = "Gunpowder",
				chance = 0.02
			},
			{
				id = "MedicalTools",
				chance = 0.02
			},
			{
				id = "BrokenRadio",
				chance = 0.02
			},
			{
				id = "BrokenPhone",
				chance = 0.02
			},
			{
				id = "Camera",
				chance = 0.02
			}
		}
	}
}