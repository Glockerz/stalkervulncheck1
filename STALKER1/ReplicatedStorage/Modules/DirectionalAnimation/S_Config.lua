-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	STATES = {
		IDLE = "Idle",
		WALK = "Walk",
		WALKR = "WalkReverse",
		WALKL = "WalkLeft",
		WALKRIGHT = "WalkRight",
		WALKLD = "WalkLeftDiagonal",
		WALKLDR = "WalkLeftDiagonalReverse",
		WALKRD = "WalkRightDiagonal",
		WALKRDR = "WalkRightDiagonalReverse",
		CROUCH_IDLE = "CrouchIdle",
		CROUCH_WALK = "CrouchWalk",
		CROUCH_WALKR = "CrouchWalkReverse",
		CROUCH_WALKL = "CrouchWalkLeft",
		CROUCH_WALKRIGHT = "CrouchWalkRight",
		CROUCH_WALKLD = "CrouchWalkLeftDiagonal",
		CROUCH_WALKLDR = "CrouchWalkLeftDiagonalReverse",
		CROUCH_WALKRD = "CrouchWalkRightDiagonal",
		CROUCH_WALKRDR = "CrouchWalkRightDiagonalReverse",
		PRONE_IDLE = "ProneIdle",
		CROUCH_IDLE_ARMLESS = "CrouchIdleArmless",
		INJURED_WALK = "InjuredWalk",
		INJURED_WALKR = "InjuredWalkReverse",
		INJURED_WALKL = "InjuredWalkLeft",
		INJURED_WALKRIGHT = "InjuredWalkRight",
		INJURED_WALKLD = "InjuredWalkLeftDiagonal",
		INJURED_WALKLDR = "InjuredWalkLeftDiagonalReverse",
		INJURED_WALKRD = "InjuredWalkRightDiagonal",
		INJURED_WALKRDR = "InjuredWalkRightDiagonalReverse"
	},
	THRESHOLDS = {
		INPUT = 0.1,
		MOVEMENT = 1,
		SIDEWAYS = 0.1,
		DIRECTIONAL = 0.1,
		DIAGONAL = 0.4
	},
	REF_SPEEDS = {
		WALK = 10
	},
	TRANSITION_TIMES = {
		IDLE_TO_WALK = 0.9,
		WALK_DIRECTION = 0.07,
		WALK_TO_REVERSE = 1.3,
		REVERSE_TO_WALK = 1.3,
		WALK_TO_LEFT = 1.8,
		LEFT_TO_WALK = 1.3,
		WALK_TO_RIGHT = 1.8,
		RIGHT_TO_WALK = 1.3,
		LEFT_TO_RIGHT = 1.2,
		RIGHT_TO_LEFT = 1.2,
		LEFT_TO_IDLE = 1.2,
		RIGHT_TO_IDLE = 1.2,
		DIAG_TO_IDLE = 1,
		WALK_TO_LEFT_DIAG = 0.9,
		LEFT_DIAG_TO_WALK = 0.9,
		WALK_TO_RIGHT_DIAG = 0.9,
		RIGHT_DIAG_TO_WALK = 0.9,
		LEFT_DIAG_TO_RIGHT_DIAG = 0.5,
		RIGHT_DIAG_TO_LEFT_DIAG = 0.5,
		LEFT_DIAG_TO_LEFT_DIAG_REV = 0.5,
		RIGHT_DIAG_TO_RIGHT_DIAG_REV = 0.5,
		LEFT_DIAG_REV_TO_LEFT_DIAG = 1.2,
		RIGHT_DIAG_REV_TO_RIGHT_DIAG = 1.2,
		IDLE_TO_DIAG = 0.9
	},
	ANIMATION_SPEED_LIMITS = {
		WALK = {
			MIN = 0.1,
			MAX = 1.3
		},
		DIAGONAL = {
			MIN = 0.1,
			MAX = 1.25
		}
	},
	PHYSICS = {
		SPEED_DAMPING = 0.85
	},
	ENUMS = {
		HUMANOID_STATE_TYPE = Enum.HumanoidStateType,
		ANIMATION_PRIORITY = Enum.AnimationPriority,
		EASING_STYLE = Enum.EasingStyle.Cubic,
		EASING_DIRECTION = Enum.EasingDirection.Out,
		MATERIAL_AIR = Enum.Material.Air
	},
	DEBUG_MODE = false
}