-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StalkerVoice = require(ReplicatedStorage:WaitForChild("StalkerVoice"));
local u1 = {
    FACTION_LINE_CHANCE = 0.4
};
local u2 = {
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
};
local u3 = {
    Loner = { "If you\'re new out here, stick to the roads and keep your detector on.", "Camp\'s got a fire going if anyone needs to warm up.", "Lost my rifle in a firefight. Not my proudest week.", "Watch each other\'s backs out there. It\'s all we\'ve got.", "Saw a rookie head north on his own. Hope he turns around.", "Share the coordinates if you find a good stash. We all eat." },
    Bandit = { "Nice gear you\'re all carrying. Be a shame if something happened to it.", "Toll road up north now. My road, my rules.", "Keep chatting on this channel. Makes you easier to find.", "We don\'t rob everyone. Just the ones who look like you.", "Somebody\'s been shooting at us. Rude." }
};
u1.MONOLITH_SIGHTINGS = { "Saw men in white near the reeds. Didn\'t look like Duty. Didn\'t look friendly either.", "Monolith. In the Swamps. Thought those bastards stayed further north.", "Just saw a patrol moving through the fog. White camo. No chatter. Keep your eyes open.", "Something\'s wrong out there. Three armed men passed the old trail and never said a word.", "If anyone\'s heading through the marsh, watch yourself. Monolith are moving.", "Spotted fanatics near the flooded road. I\'m not sticking around to find out why.", "Monolith this far south? That\'s new.", "White suits in the reeds. Armed heavy. I\'m turning back.", "Anyone else seeing Monolith out here, or am I losing it?", "Saw one of them standing in the water like he was waiting for something. Didn\'t move for minutes." };
u1.MONOLITH_SIGHTINGS_AREA = { "Monolith patrol moving {area}. White camo, heavy guns. Stay clear.", "Saw men in white {area}. I\'m not sticking around to find out why.", "Fanatics {area}. Three, maybe more. Keep your distance.", "Heads up, Monolith spotted {area}. No chatter, just walking.", "White suits {area}. If you\'re headed that way, turn around.", "Monolith, {area}. Thought they stayed further north.", "Something\'s moving {area}. Monolith. Armed heavy." };
u1.MONOLITH_TRANSMISSIONS = { "The Monolith sees.", "The path opens.", "We hear His voice.", "The unbelievers wander closer.", "His light reaches even here.", "The marsh cannot hide you.", "The faithful have returned.", "He calls, and we obey.", "The weak flee from His gaze.", "The stone remembers.", "All roads lead inward.", "You walk where you were not invited.", "The Zone has chosen.", "Do not fear the silence. He speaks through it.", "The waters part for the faithful.", "The lost will be gathered." };
u1.MONOLITH_RARE = { "You have been seen.", "Turn back." };
u1.MONOLITH_ODDS = {
    sighting = 0.5,
    transmission = 0.45,
    rare = 0.05
};
u1.MILITARY_SIGHTINGS = { "Army patrol out on the roads. Keep off the tarmac.", "Soldiers moving through. They shoot first out here, so stay out of sight.", "Military\'s walking a patrol again. Give them room.", "Heard boots on the road. Army. I\'m staying in the reeds." };
u1.MILITARY_SIGHTINGS_AREA = { "Military patrol moving {area}. Keep your head down.", "Soldiers {area}, out on foot. Stay off the road.", "Army patrol spotted {area}. They\'re not friendly.", "Heads up, soldiers {area}. Full kit, looking for trouble.", "Saw an army squad {area}. I\'m going around them." };

function u1.PickMilitary(p4, u5) -- Line: 137
    -- upvalues: u1 (copy)
    local v6 = p4 or Random.new();

    if type(u5) == "string" and u5 ~= "" then
        return "sighting", u1.MILITARY_SIGHTINGS_AREA[v6:NextInteger(1, #u1.MILITARY_SIGHTINGS_AREA)]:gsub("{area}", function() -- Line: 141
            -- upvalues: u5 (copy)
            return u5;
        end);
    end;

    return "sighting", u1.MILITARY_SIGHTINGS[v6:NextInteger(1, #u1.MILITARY_SIGHTINGS)];
end;

function u1.PickMonolith(p7, u8) -- Line: 150
    -- upvalues: u1 (copy)
    local v9 = p7 or Random.new();
    local MONOLITH_ODDS = u1.MONOLITH_ODDS;
    local v10 = v9:NextNumber();
    local v11, v12;

    if v10 < MONOLITH_ODDS.sighting then
        v11 = "sighting";
        v12 = u1.MONOLITH_SIGHTINGS;

        if type(u8) == "string" and u8 ~= "" then
            return v11, u1.MONOLITH_SIGHTINGS_AREA[v9:NextInteger(1, #u1.MONOLITH_SIGHTINGS_AREA)]:gsub("{area}", function() -- Line: 159
                -- upvalues: u8 (copy)
                return u8;
            end);
        end;
    elseif v10 < MONOLITH_ODDS.sighting + MONOLITH_ODDS.transmission then
        v12 = u1.MONOLITH_TRANSMISSIONS;
        v11 = "transmission";
    else
        v12 = u1.MONOLITH_RARE;
        v11 = "rare";
    end;

    return v11, v12[v9:NextInteger(1, #v12)];
end;

function u1.Pick(p13) -- Line: 171
    -- upvalues: StalkerVoice (copy), u1 (copy), u3 (copy), u2 (copy)
    local v14 = p13 or Random.new();
    local v15 = StalkerVoice.RollSpeaker(v14);
    local v16;

    if v14:NextNumber() < u1.FACTION_LINE_CHANCE then
        v16 = u3[v15.faction];
    else
        v16 = nil;
    end;

    if not v16 or #v16 == 0 then
        v16 = u2;
    end;

    if #v16 == 0 then
        return nil;
    end;

    return v15.npcId, v16[v14:NextInteger(1, #v16)], v15.name, v15.uniform, v15.skin;
end;

return u1;