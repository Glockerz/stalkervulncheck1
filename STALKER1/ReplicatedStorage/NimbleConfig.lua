-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Windows = {
		{
			Name = "Morning",
			StartHour = 8,
			EndHour = 11
		},
		{
			Name = "Afternoon",
			StartHour = 13,
			EndHour = 16
		},
		{
			Name = "Evening",
			StartHour = 19,
			EndHour = 22
		}
	},
	WindowTimeZone = "US Central (CST/CDT)",
	ActiveSeconds = 1800,
	LeavingSoonSeconds = 900,
	TickSeconds = 30,
	SpawnCFrame = CFrame.new(-156.1038, 23.227, -82.1254, 0, 0, -1, 0, 1, 0, 1, 0, 0),
	IdleAnimationId = "rbxassetid://138428040158569",
	TemplatePath = { "NPCs", "Nimble" },
	TraderFolderPath = { "Map", "NPCs", "Traders" },
	StockSlots = 8,
	GuaranteedRareWeapons = 1,
	MagazinePerPlayer = 6,
	SkinChance = 0.35,
	SkinSlots = 2,
	SenderName = "Nimble",
	Messages = {
		Arrival = { "Just made it to the Warehouses. I\'ve got some premium gear you\'ll want to get your hands on.", "Checked in at the Warehouses. Got a limited supply of weapons to help you in the Zone.", "Made it through in one piece. Fresh stock, and not much of it.", "Nimble here. Warehouses. Good gear, limited supply. You know the routine." },
		LeavingSoon = { "Gonna be packing up here soon. Buy while you can.", "Almost done here. If you wanted something, now\'s the time.", "I\'m leaving the Warehouses soon. Last chance before the stock goes with me." },
		Departure = { "That\'s it. I\'m moving out. If you missed me, stay alive long enough to catch me next time." }
	},
	WebhookSlot = "Nimble",
	MentionRoleId = "1542143768440995910",
	Discord = {
		Arrival = {
			Title = "Nimble has arrived",
			Color = 13148746,
			Footer = "Warehouses, Lobby",
			Mention = true
		},
		LeavingSoon = {
			Title = "Nimble is packing up",
			Color = 9071151,
			Footer = "Warehouses, Lobby"
		}
	}
}