-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	SlotCrossfadeSeconds = 30,
	SpatialRadiusMin = 40,
	SpatialRadiusMax = 120,
	TimeSlots = {
		{
			name = "Morning",
			startHour = 5,
			endHour = 8
		},
		{
			name = "Day",
			startHour = 8,
			endHour = 18
		},
		{
			name = "Evening",
			startHour = 18,
			endHour = 21
		},
		{
			name = "Night",
			startHour = 21,
			endHour = 5
		}
	},
	Bed = {
		Layers = {
			{
				thresholdMin = 0,
				baseVolume = 0.7,
				thresholdMax = 50,
				maxVolume = 1.1,
				path = { "Background", "Forest", "forest_wind" }
			},
			{
				thresholdMin = 10,
				baseVolume = 0.15,
				thresholdMax = 50,
				maxVolume = 1.1,
				path = { "Wind", "windwhistle3" }
			}
		}
	},
	EnvironmentalLoops = {
		Morning = {
			volume = 0.7,
			path = { "Background", "Forest", "forest_morning" }
		},
		Day = {
			volume = 0.7,
			path = { "Background", "Forest", "forest_day" }
		},
		Evening = {
			volume = 0.7,
			path = { "Background", "Forest", "forest_evening" }
		},
		Night = {
			volume = 0.7,
			path = { "Background", "Forest", "forest_night" }
		}
	},
	OneShots = {
		Global = {
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "birdsfear1" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "birdsfear2" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "birdsfear3" }
			}
		},
		Morning = {
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_1" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_2" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_3" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_4" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_5" }
			}
		},
		Day = {
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_6" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_7" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_8" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_9" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_forest_single_10" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Forest", "sfx_1" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Forest", "sfx_2" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Forest", "sfx_3" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Forest", "sfx_4" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Forest", "sfx_5" }
			}
		},
		Evening = {
			{
				volume = 1,
				spatial = true,
				weight = 2,
				path = { "SFX", "Forest", "sfx_6" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 2,
				path = { "SFX", "Forest", "sfx_7" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 2,
				path = { "SFX", "Forest", "sfx_8" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 2,
				path = { "SFX", "Forest", "sfx_9" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 2,
				path = { "SFX", "Forest", "sfx_10" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_1" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_2" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_3" }
			}
		},
		Night = {
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "ForestNight", "sfx_1" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "ForestNight", "sfx_2" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "ForestNight", "sfx_3" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "ForestNight", "sfx_4" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "ForestNight", "sfx_5" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "ForestNight", "sfx_6" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_1" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_2" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_3" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_4" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_5" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_6" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_7" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_8" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_9" }
			},
			{
				volume = 1.05,
				spatial = true,
				weight = 2,
				path = { "SFX", "Animals", "birds_single_night_10" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_4" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_5" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_6" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_7" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_8" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_9" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_10" }
			},
			{
				volume = 1,
				spatial = true,
				weight = 1,
				path = { "SFX", "Animals", "crickets_11" }
			}
		}
	},
	OneShotMeanIntervalSeconds = {
		Morning = 22,
		Day = 25,
		Evening = 13,
		Night = 8
	},
	SpatialHeightRange = {
		min = -10,
		max = 30
	},
	SpookOneShots = {
		Categories = {
			amd_dark = {
				volume = 1.15,
				spatial = false,
				weight = {
					Morning = 0,
					Day = 0,
					Evening = 1,
					Night = 1.2
				}
			},
			amd_night = {
				volume = 1.2,
				spatial = false,
				weight = {
					Morning = 0,
					Day = 0,
					Evening = 0.6,
					Night = 1.5
				}
			},
			Drone = {
				volume = 1.1,
				spatial = false,
				weight = {
					Morning = 0,
					Day = 0,
					Evening = 1.2,
					Night = 1.2
				}
			},
			mutants = {
				volume = 1.2,
				spatial = true,
				weight = {
					Morning = 0.3,
					Day = 0.3,
					Evening = 1.2,
					Night = 1.5
				}
			},
			screams = {
				volume = 1.15,
				spatial = true,
				weight = {
					Morning = 0.2,
					Day = 0.2,
					Evening = 1,
					Night = 1.2
				}
			},
			shooting = {
				volume = 0.85,
				spatial = true,
				rollOffMin = 50,
				rollOffMax = 800,
				weight = {
					Morning = 1.5,
					Day = 1.5,
					Evening = 1.8,
					Night = 2
				}
			},
			spooks = {
				volume = 1.2,
				spatial = true,
				weight = {
					Morning = 0,
					Day = 0,
					Evening = 1.2,
					Night = 1.5
				}
			}
		}
	},
	SpatialWind = {
		WindMagForMax = 30,
		Sources = {
			HouseWind = {
				namePattern = "^housewind",
				rollOffMin = 5,
				rollOffMax = 35,
				volumeMin = 0.4,
				volumeMax = 1,
				soundFolder = { "Wind" }
			},
			TreeWind = {
				namePattern = "^windtree",
				rollOffMin = 3,
				rollOffMax = 20,
				volumeMin = 0.3,
				volumeMax = 0.85,
				soundFolder = { "Wind" }
			},
			BushWind = {
				namePattern = "^windbush",
				rollOffMin = 2,
				rollOffMax = 12,
				volumeMin = 0.25,
				volumeMax = 0.7,
				soundFolder = { "Wind" }
			}
		}
	},
	WindDirector = {
		BaseMagnitudeMin = 3,
		BaseMagnitudeMax = 8,
		BaseDirectionDriftDegPerSec = 2,
		GustMeanIntervalSeconds = 35,
		GustRampUpSeconds = 1.2,
		GustPeakMagnitudeMin = 25,
		GustPeakMagnitudeMax = 50,
		GustHoldSeconds = 2.5,
		GustDecaySeconds = 4,
		GustDirectionJitterDeg = 8
	},
	Gust = {
		PeakMagnitudeThreshold = 22,
		MinSecondsBetweenOneShots = 10,
		PreferTaggedTreeRadius = 60,
		TreeTag = "WindShake",
		OneShots = {
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_1" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_2" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_3" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_4" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_5" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_6" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_7" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_8" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_9" }
			},
			{
				volume = 1.5,
				weight = 1,
				path = { "Wind", "windtree_10" }
			}
		}
	}
}

if not require(game:GetService("ReplicatedStorage"):WaitForChild("PlaceConfig")).HasAmbientWind then
	t.Bed = {
		Layers = {}
	}
	t.EnvironmentalLoops = {}
	t.OneShots = {
		Global = {},
		Morning = {},
		Day = {},
		Evening = {},
		Night = {}
	}
	t.OneShotMeanIntervalSeconds = {
		Morning = 180,
		Day = 180,
		Evening = 150,
		Night = 120
	}
	t.SpookOneShots = {
		Categories = {
			amd_dark = {
				volume = 0.35,
				spatial = false,
				weight = {
					Morning = 0.4,
					Day = 0.4,
					Evening = 0.7,
					Night = 0.9
				}
			},
			amd_night = {
				volume = 0.3,
				spatial = false,
				weight = {
					Morning = 0,
					Day = 0,
					Evening = 0.4,
					Night = 0.8
				}
			},
			Drone = {
				volume = 0.3,
				spatial = false,
				weight = {
					Morning = 0.5,
					Day = 0.5,
					Evening = 0.7,
					Night = 0.7
				}
			},
			shooting = {
				volume = 0.28,
				spatial = false,
				weight = {
					Morning = 0.7,
					Day = 0.8,
					Evening = 0.7,
					Night = 0.5
				}
			}
		}
	}
	t.SpatialWind = {
		WindMagForMax = 30,
		Sources = {}
	}
	t.Gust = {
		PeakMagnitudeThreshold = 999,
		MinSecondsBetweenOneShots = 999,
		PreferTaggedTreeRadius = 0,
		TreeTag = "WindShake",
		OneShots = {}
	}
end

return t