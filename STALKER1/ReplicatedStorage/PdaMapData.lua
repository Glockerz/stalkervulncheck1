-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Cordon = {
		PlumsMap = "Map_Cordon",
		DefaultZoom = 1200,
		Traders = {
			{
				Id = "Crow",
				WorldPos = Vector3.new(-42, 7, 54),
				Label = "Crow"
			}
		},
		Doctors = {
			{
				Id = "ZoneDoctor",
				WorldPos = Vector3.new(-54, 6, 65),
				Label = "Zone Doctor"
			}
		},
		Stashes = {
			{
				Id = "Stash_Cordon_405_-568",
				WorldPos = Vector3.new(405, 11, -568),
				Label = "Stash"
			},
			{
				Id = "Stash_Cordon_-79_-2740",
				WorldPos = Vector3.new(-78, 28, -2739),
				Label = "Stash"
			},
			{
				Id = "Stash_Cordon_1246_-1370",
				WorldPos = Vector3.new(1247, 3, -1370),
				Label = "Stash"
			}
		},
		Locations = {
			{
				Name = "Abandoned Military Refueling Depot",
				WorldPos = Vector3.new(682.1, 23.8, 607.5),
				Size = Vector3.new(272.2, 123.4, 306.5)
			},
			{
				Name = "Bandit Camp",
				WorldPos = Vector3.new(616.2, -10.8, -887),
				Size = Vector3.new(225.4, 49.1, 207.6)
			},
			{
				Name = "Checkpoint to Outskirts",
				WorldPos = Vector3.new(146.3, 15.8, -3136.3),
				Size = Vector3.new(147.8, 102.3, 154.3)
			},
			{
				Name = "Construction Yard",
				WorldPos = Vector3.new(117.6, 39.4, -1130.9),
				Size = Vector3.new(119, 49.1, 144.6)
			},
			{
				Name = "Cordon Entrance",
				WorldPos = Vector3.new(350.6, 23.8, 728.5),
				Size = Vector3.new(83.2, 123.4, 132.9)
			},
			{
				Name = "Military Camp",
				WorldPos = Vector3.new(-148.5, 19.5, -506.5),
				Size = Vector3.new(134.6, 75.1, 158.9)
			},
			{
				Name = "Military Watchtower",
				WorldPos = Vector3.new(1073.7, 38.7, -746.5),
				Size = Vector3.new(182.1, 148.2, 129.8)
			},
			{
				Name = "Rookie Village",
				WorldPos = Vector3.new(-30.1, 30, 34.8),
				Size = Vector3.new(240, 54.2, 395.8)
			},
			{
				Name = "The Gauntlet",
				WorldPos = Vector3.new(-147.1, 12.5, -1342.2),
				Size = Vector3.new(322.2, 123.4, 342.2)
			},
			{
				Name = "Trailer Park Encampment",
				WorldPos = Vector3.new(163.6, 17.9, -576.6),
				Size = Vector3.new(94.1, 49.1, 103.1)
			},
			{
				Name = "Tunnel To Darkscape",
				WorldPos = Vector3.new(1679.6, 38.7, -1215.7),
				Size = Vector3.new(222.3, 148.2, 217.3)
			},
			{
				Name = "Warehouses",
				WorldPos = Vector3.new(-28.5, 15.8, -2148.3),
				Size = Vector3.new(147.8, 102.3, 154.3)
			}
		},
		Anomalies = {},
		Camps = {}
	}
}

t._regions = {
	Cordon = t.Cordon
}
function t.GetRegion(p1) --[[ GetRegion | Line: 48 | Upvalues: t (copy) ]]
	return t._regions[p1] or t.Cordon
end

return t