-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DeathCause = require(ReplicatedStorage:WaitForChild("DeathCause"))
local StalkerVoice = require(ReplicatedStorage:WaitForChild("StalkerVoice"))
local t = {
	CAUSE_CHANCE = 0.45,
	FIRST_DELAY = { 5, 12 }
}
local t2 = {
	respectful = { "Damn. He was a good stalker.", "Another one gone.", "The Zone takes everyone eventually.", "Pour one out. He knew the risks.", "Rest easy, stalker.", "Knew him. Quiet type. Didn\'t deserve that.", "Every name on that list was somebody\'s mate." },
	sarcastic = { "Ha. Rookie mistake.", "Told him not to touch that anomaly.", "Guess he found out the hard way.", "Natural selection, Zone edition.", "Bet he read the guide. Once.", "And he was doing so well right up until he wasn\'t." },
	hostile = { "Good riddance.", "Won\'t miss him.", "He had it coming.", "One less rifle pointed at me.", "Saves me a bullet." },
	dry = { "Well... there goes his stash.", "Hope somebody grabs his backpack.", "That\'s one less mouth at the campfire.", "Anyone know where he dropped?", "His gear\'s still warm.", "Mark it on the map. Free loot." }
}
local t3 = {
	gunfight = { "Bandits again. Cordon\'s crawling with them.", "Shot up. Somebody\'s getting bold out there.", "Heard the shooting from here.", "That\'s the third one this week on that road." },
	anomaly = { "Anomaly got him. They always drift after a storm.", "Should\'ve thrown a bolt.", "That\'s what the detector is for.", "The Zone moved them again. It always does." },
	mutant = { "Mutants. They\'re feeding closer to camp every week.", "Something chewed him up out there.", "Don\'t go out alone. That\'s how this happens." },
	radiation = { "Rads. Slow way to go.", "No amount of vodka fixes that dose.", "Check your detector, people." },
	bleeding = { "Bled out. All he needed was a bandage.", "Carry more dressings. Seriously.", "Slow one. Rough way to go." },
	pvp = { "Stalker on stalker. The Zone didn\'t even have to try.", "We\'re doing the Zone\'s work for it now.", "That wasn\'t the Zone. That was one of us." },
	unknown = { "No idea what got him.", "PDA just went quiet. That\'s all we know.", "Nobody saw it happen." }
}

t.FactionName = StalkerVoice.FactionName
function t.Pick(p1, p2, p3) --[[ Pick | Line: 111 | Upvalues: StalkerVoice (copy), t (copy), t3 (copy), DeathCause (copy), t2 (copy) ]]
	local v1 = if p3 then p3 else Random.new()
	local v2 = StalkerVoice.RollSpeaker(v1, p2)
	local v3 = if v1:NextNumber() < t.CAUSE_CHANCE then t3[DeathCause.Category(p1)] else nil

	if not v3 or #v3 == 0 then
		v3 = t2[StalkerVoice.PickTone(v2.tones, v1)]
	end

	local v4 = v1

	if v3 and #v3 ~= 0 then
		return v2.npcId, v3[v4:NextInteger(1, #v3)], v2.name, v2.uniform, v2.skin
	end

	return nil
end

return t