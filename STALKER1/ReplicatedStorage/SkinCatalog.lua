-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	SUPPORTED_SLOTS = {
		Uniform = true,
		BodyGear = true,
		HeadGear = true,
		FaceWear = true,
		Backpack = true,
		BeltGear = true
	},
	Skins = {
		PSZ9DProtectionCamo = {
			DevProductID = 3608674746,
			PriceRobux = 99
		},
		["Defender2 Assaulter Black"] = {
			DevProductID = 3608674300,
			PriceRobux = 99
		},
		["ALTYN Black"] = {
			DevProductID = 3608674379,
			PriceRobux = 99
		},
		["PMK4 Red Lens"] = {
			DevProductID = 3608674502,
			PriceRobux = 99
		},
		["Mercenary SOZ Uniform"] = {
			DevProductID = 3608674675,
			PriceRobux = 99
		},
		["Black LBT6094+PAPR"] = {
			DevProductID = 3608647583,
			PriceRobux = 99
		},
		["OPSCORE FAST (SOTZ)"] = {
			DevProductID = 3608674420,
			PriceRobux = 99
		},
		["Mira Half Mask Respirator"] = {
			DevProductID = 3608674484,
			PriceRobux = 99
		},
		["Freedom ERDL Gorka"] = {
			DevProductID = 3608674587,
			PriceRobux = 99
		},
		["IOTV+SMERSH"] = {
			DevProductID = 3608674356,
			PriceRobux = 99
		},
		["Altyn No Visor"] = {
			DevProductID = 3608674395,
			PriceRobux = 99
		},
		["FM12 Black"] = {
			DevProductID = 3608674447,
			PriceRobux = 99
		},
		MercenaryBDUCamo = {
			DevProductID = 3608674687,
			PriceRobux = 99
		},
		MercenaryCombatBDUCamo = {
			DevProductID = 3608674706,
			PriceRobux = 99
		},
		MercenaryGorka = {
			DevProductID = 3608674724,
			PriceRobux = 99
		},
		DutyBDU = {
			DevProductID = 3608674517,
			PriceRobux = 99
		},
		DutyRostokOutfit = {
			DevProductID = 3608674543,
			PriceRobux = 99
		},
		DutyBulat2 = {
			DevProductID = 3608674529,
			PriceRobux = 99
		},
		["Freedom BDU"] = {
			DevProductID = 3608674554,
			PriceRobux = 99
		},
		["Freedom Gorka"] = {
			DevProductID = 3608674607,
			PriceRobux = 99
		},
		["Freedom BDU + Jeans"] = {
			DevProductID = 3608674570,
			PriceRobux = 99
		}
	},
	Packs = {
		MercenaryFactionUniforms = {
			DisplayName = "Mercenary Faction Uniforms",
			GamepassID = 1874196433,
			Skins = { "MercenaryBDUCamo", "MercenaryCombatBDUCamo", "MercenaryGorka" }
		},
		DutySentinel = {
			DisplayName = "Duty Sentinel Loadout",
			GamepassID = 1899696834,
			Skins = { "PSZ9DProtectionCamo", "Defender2 Assaulter Black", "ALTYN Black", "PMK4 Red Lens" }
		},
		ShadowOfTheZoneMercenary = {
			DisplayName = "Shadow of the Zone Mercenary",
			GamepassID = 1871787128,
			Skins = { "Mercenary SOZ Uniform", "Black LBT6094+PAPR", "OPSCORE FAST (SOTZ)", "Mira Half Mask Respirator" }
		},
		FreedomVanguard = {
			DisplayName = "Freedom Vanguard Loadout",
			GamepassID = 1900122873,
			Skins = { "Freedom ERDL Gorka", "IOTV+SMERSH", "Altyn No Visor", "FM12 Black" }
		},
		DutyFactionUniforms = {
			DisplayName = "Duty Faction Uniforms",
			GamepassID = 1871751136,
			Skins = { "DutyBDU", "DutyRostokOutfit", "DutyBulat2" }
		},
		FreedomFactionUniforms = {
			DisplayName = "Freedom Faction Uniforms",
			GamepassID = 1870493214,
			Skins = { "Freedom BDU", "Freedom Gorka", "Freedom BDU + Jeans" }
		}
	},
	FoundersBundle = {
		DisplayName = "Sunrise Bundle",
		BadgeID = 2719880001437030,
		Skins = { "SunriseSuitGreen", "SunriseVest", "SunriseBelt", "PBF Gasmask" }
	}
}
local v1 = nil

function t.GetSkinForDevProduct(p1) --[[ GetSkinForDevProduct | Line: 176 | Upvalues: v1 (ref), t (copy) ]]
	if not v1 then
		v1 = {}

		for k, v in pairs(t.Skins) do
			if v.DevProductID and v.DevProductID ~= 0 then
				v1[v.DevProductID] = k
			end
		end
	end

	return v1[p1]
end
function t.IsSlotSupported(p1) --[[ IsSlotSupported | Line: 191 | Upvalues: t (copy) ]]
	return if p1 then t.SUPPORTED_SLOTS[p1] == true else p1
end

return t