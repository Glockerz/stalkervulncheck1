-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StalkerVoice = require(ReplicatedStorage:WaitForChild("StalkerVoice"))
local t = {
	FACTION_LINE_CHANCE = 0.4
}
local t2 = {
	"Heard there\'s a stash past the rail bridge. Nobody\'s come back with it yet.",
	"Anomaly field shifted near the old farmstead. Watch your step out there.",
	"Detector\'s been screaming near the checkpoint. Give it a wide berth.",
	"Anyone got spare 5.45? Paying over the odds.",
	"Third day without a decent find. The Zone\'s laughing at me.",
	"Cold one tonight. Fire\'s the only thing keeping me out here.",
	"Radio\'s been quiet. Too quiet.",
	"Word is the Ecologists are paying well for artifacts this week.",
	"Mutants are bolder after dark. Don\'t travel alone.",
	"Somebody left a boot in the stash. Thanks for that. Really.",
	"Military\'s rotating patrols again. Roads will be busy.",
	"Whole swamp smells wrong today. Something moved in.",
	"If you hear whistling past the treeline, that is not the wind.",
	"Traded my last bandage for a tin of stew. Regretting it already.",
	"Anyone else hear that?",
	"Name of the game is G.A.B.O.S. Game Ain\'t Based on Sympathy.",
	"Two of us went out this morning. One came back.",
	"Batteries are worth more than roubles out here.",
	"Rain\'s coming. Always brings the rads down with it.",
	"Found a body picked clean already. Somebody\'s fast out there."
}
local t3 = {
	Loner = { "If you\'re new out here, stick to the roads and keep your detector on.", "Camp\'s got a fire going if anyone needs to warm up.", "Lost my rifle in a firefight. Not my proudest week.", "Watch each other\'s backs out there. It\'s all we\'ve got.", "Saw a rookie head north on his own. Hope he turns around.", "Share the coordinates if you find a good stash. We all eat." },
	Bandit = { "Nice gear you\'re all carrying. Be a shame if something happened to it.", "Toll road up north now. My road, my rules.", "Keep chatting on this channel. Makes you easier to find.", "We don\'t rob everyone. Just the ones who look like you.", "Somebody\'s been shooting at us. Rude." }
}

function t.Pick(p1) --[[ Pick | Line: 67 | Upvalues: StalkerVoice (copy), t (copy), t3 (copy), t2 (copy) ]]
	local v1 = if p1 then p1 else Random.new()
	local v2 = StalkerVoice.RollSpeaker(v1)
	local v3 = if v1:NextNumber() < t.FACTION_LINE_CHANCE then t3[v2.faction] else nil

	if not v3 or #v3 == 0 then
		v3 = t2
	end

	if #v3 == 0 then
		return nil
	end

	return v2.npcId, v3[v1:NextInteger(1, #v3)], v2.name, v2.uniform, v2.skin
end

return t