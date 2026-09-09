-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Rewards = {
		{
			roubles = 2000,
			itemTier = "Small"
		},
		{
			roubles = 2500,
			itemTier = "Small"
		},
		{
			roubles = 3000,
			itemTier = "Medium"
		},
		{
			roubles = 3500,
			itemTier = "Medium"
		},
		{
			roubles = 4000,
			itemTier = "Medium"
		},
		{
			roubles = 4500,
			itemTier = "Medium"
		},
		{
			roubles = 30000,
			itemTier = "Finale"
		}
	},
	ItemPools = {
		Small = {
			{
				itemId = "Bolts",
				weight = 20,
				countRange = { 2, 3 }
			},
			{
				itemId = "AAABattery",
				weight = 20,
				countRange = { 2, 3 }
			},
			{
				itemId = "ElectricalTape",
				weight = 15,
				countRange = { 1, 2 }
			},
			{
				itemId = "HydrogenPeroxide",
				weight = 15,
				countRange = { 1, 2 }
			},
			{
				itemId = "Field Dressing",
				weight = 15,
				countRange = { 2, 3 }
			},
			{
				itemId = "Iodine",
				weight = 15,
				countRange = { 1, 2 }
			}
		},
		Medium = {
			{
				itemId = "MedicalScraps",
				weight = 20,
				countRange = { 1, 1 }
			},
			{
				itemId = "GunCleaningLubricant",
				weight = 18,
				countRange = { 1, 2 }
			},
			{
				itemId = "Brufen",
				weight = 18,
				countRange = { 1, 2 }
			},
			{
				itemId = "Yadulin",
				weight = 16,
				countRange = { 1, 2 }
			},
			{
				itemId = "MedicalTools",
				weight = 14,
				countRange = { 1, 1 }
			},
			{
				itemId = "AntiRadVial",
				weight = 14,
				countRange = { 1, 1 }
			}
		},
		Finale = {
			{
				itemId = "JPC2",
				weight = 27,
				countRange = { 1, 1 }
			},
			{
				itemId = "KORSAR",
				weight = 24,
				countRange = { 1, 1 }
			},
			{
				itemId = "Attack 2 Raid Backpack",
				weight = 24,
				countRange = { 1, 1 }
			},
			{
				itemId = "MP5A3",
				weight = 14,
				countRange = { 1, 1 }
			},
			{
				itemId = "M17",
				weight = 11,
				countRange = { 1, 1 }
			}
		}
	},
	ItemDrawCount = {
		Small = 1,
		Medium = 1,
		Finale = 1
	},
	FinaleItemId = "ALTYN Green"
}

t.FinalePreviewItemId = t.FinaleItemId or t.ItemPools.Finale[1].itemId

return t