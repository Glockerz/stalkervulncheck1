-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Version = "7/26/24",
	DEBUG = {
		["Pose Warns"] = false
	},
	["Velocity Mechanics"] = {
		idleSpeedSafetyRange = 0.025,
		walkSpeedSafetyRange = 1.25
	},
	["Landing Mechanics"] = {
		FindDefaultLandDelay = false,
		RevertToDefaultLandDelay = 0.5166666507720947,
		RevertToDefaultFallDamageDistance = 19,
		FallDistanceAddition = -5
	},
	Animations = {
		Sit = {
			ID = 0
		},
		Idle = {
			ID = 139243548599121
		},
		Walk = {
			ID = 0
		},
		Run = {
			ID = 115277924638122
		},
		Swim = {
			ID = 0
		},
		SwimIdle = {
			ID = 0
		},
		Climb = {
			ID = 0
		},
		Jump = {
			ID = 78793144230736
		},
		Fall = {
			ID = 128457947365982
		},
		Land = {
			ID = 135511902429046
		}
	}
}