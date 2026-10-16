-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local DeathCause = require(ReplicatedStorage:WaitForChild("DeathCause"));
local StalkerVoice = require(ReplicatedStorage:WaitForChild("StalkerVoice"));
local u1 = {
    CAUSE_CHANCE = 0.45,
    FIRST_DELAY = { 5, 12 }
};
local u2 = {
    respectful = { "Damn. He was a good stalker.", "Another one gone.", "The Zone takes everyone eventually.", "Pour one out. He knew the risks.", "Rest easy, stalker.", "Knew him. Quiet type. Didn\'t deserve that.", "Every name on that list was somebody\'s mate." },
    sarcastic = { "Ha. Rookie mistake.", "Told him not to touch that anomaly.", "Guess he found out the hard way.", "Natural selection, Zone edition.", "Bet he read the guide. Once.", "And he was doing so well right up until he wasn\'t." },
    hostile = { "Good riddance.", "Won\'t miss him.", "He had it coming.", "One less rifle pointed at me.", "Saves me a bullet." },
    dry = { "Well... there goes his stash.", "Hope somebody grabs his backpack.", "That\'s one less mouth at the campfire.", "Anyone know where he dropped?", "His gear\'s still warm.", "Mark it on the map. Free loot." }
};
local u3 = {
    gunfight = { "Bandits again. Cordon\'s crawling with them.", "Shot up. Somebody\'s getting bold out there.", "Heard the shooting from here.", "That\'s the third one this week on that road." },
    anomaly = { "Anomaly got him. They always drift after a storm.", "Should\'ve thrown a bolt.", "That\'s what the detector is for.", "The Zone moved them again. It always does." },
    mutant = { "Mutants. They\'re feeding closer to camp every week.", "Something chewed him up out there.", "Don\'t go out alone. That\'s how this happens." },
    radiation = { "Rads. Slow way to go.", "No amount of vodka fixes that dose.", "Check your detector, people." },
    emission = { "Caught in the open when the sky went red.", "The Ecologist warned everyone. Not everyone listened.", "Emission got him. Should\'ve found a roof." },
    bleeding = { "Bled out. All he needed was a bandage.", "Carry more dressings. Seriously.", "Slow one. Rough way to go." },
    pvp = { "Stalker on stalker. The Zone didn\'t even have to try.", "We\'re doing the Zone\'s work for it now.", "That wasn\'t the Zone. That was one of us." },
    unknown = { "No idea what got him.", "PDA just went quiet. That\'s all we know.", "Nobody saw it happen." }
};
u1.FactionName = StalkerVoice.FactionName;

function u1.Pick(p4, p5, p6) -- Line: 117
    -- upvalues: StalkerVoice (copy), u1 (copy), u3 (copy), DeathCause (copy), u2 (copy)
    local v7 = p6 or Random.new();
    local v8 = StalkerVoice.RollSpeaker(v7, p5);
    local v9;

    if v7:NextNumber() < u1.CAUSE_CHANCE then
        v9 = u3[DeathCause.Category(p4)];
    else
        v9 = nil;
    end;

    if not v9 or #v9 == 0 then
        v9 = u2[StalkerVoice.PickTone(v8.tones, v7)];
    end;

    if v9 and #v9 ~= 0 then
        return v8.npcId, v9[v7:NextInteger(1, #v9)], v8.name, v8.uniform, v8.skin;
    end;

    return nil;
end;

return u1;