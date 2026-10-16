-- Decompiled with Potassium's decompiler.

local u1 = {
    Messages = {
        Killed = { "was killed by", "was neutralized by", "was made a casualty by", "was oof\'d by", "died of wounds inflicted by" },
        Falling = { "fell from a deadly height", "shattered their legs", "hit the ground too fast" },
        Death = { "died under mysterious circumstances", "inexplicably died", "suddenly fainted", "slipped into a coma", "entered a vegetative state" }
    }
};

function u1.GetMessage(p2) -- Line: 25
    -- upvalues: u1 (copy)
    local v3 = u1.Messages[p2];

    return v3[math.random(#v3)];
end;

return u1;