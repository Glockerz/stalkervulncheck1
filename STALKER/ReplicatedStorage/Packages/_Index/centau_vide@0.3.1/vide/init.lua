-- Decompiled with Potassium's decompiler.

local v1 = {
    major = 0,
    minor = 3,
    patch = 1
};

if not game then
    script = require("test/relative-string");
end;

local script_root = require(script.root);
local script_mount = require(script.mount);
local script_create = require(script.create);
local script_apply = require(script.apply);
local script_source = require(script.source);
local script_effect = require(script.effect);
local script_derive = require(script.derive);
local script_cleanup = require(script.cleanup);
local script_untrack = require(script.untrack);
local script_read = require(script.read);
local script_batch = require(script.batch);
local script_context = require(script.context);
local script_switch = require(script.switch);
local script_show = require(script.show);
local v2, v3 = require(script.maps)();
local v4, u5 = require(script.spring)();
local v6 = require(script.action)();
local script_changed = require(script.changed);
local script_throw = require(script.throw);
local script_flags = require(script.flags);

local function step(p7: number) -- Line: 35
    -- upvalues: u5 (copy)
    if game then
        debug.profilebegin("VIDE STEP");
        debug.profilebegin("VIDE SPRING");
    end;

    u5(p7);

    if game then
        debug.profileend();
        debug.profileend();
    end;
end;

local u9 = game and game:GetService("RunService").Heartbeat:Connect(function(p8: number) -- Line: 49
    -- upvalues: step (copy)
    task.defer(step, p8);
end);
local v13 = {
    strict = nil,
    version = v1,
    root = script_root,
    mount = script_mount,
    create = script_create,
    source = script_source,
    effect = script_effect,
    derive = script_derive,
    switch = script_switch,
    show = script_show,
    indexes = v2,
    values = v3,
    cleanup = script_cleanup,
    untrack = script_untrack,
    read = script_read,
    batch = script_batch,
    context = script_context,
    spring = v4,
    action = v6,
    changed = script_changed,

    apply = function(u10: userdata) -- Line: 86, Name: apply
        -- upvalues: script_apply (copy)
        return function(p11: table) -- Line: 87
            -- upvalues: script_apply (ref), u10 (copy)
            script_apply(u10, p11);

            return u10;
        end;
    end,

    step = function(p12: number) -- Line: 94, Name: step
        -- upvalues: u9 (ref), step (copy)
        if u9 then
            u9:Disconnect();
            u9 = nil;
        end;

        step(p12);
    end
};
setmetatable(v13, {
    __index = function(p14, p15) -- Line: 104, Name: __index
        -- upvalues: script_flags (copy), script_throw (copy)
        if p15 == "strict" then
            return script_flags.strict;
        end;

        script_throw((`{tostring(p15)} is not a valid member of vide`));
    end,

    __newindex = function(p16, p17, p18) -- Line: 112, Name: __newindex
        -- upvalues: script_flags (copy), script_throw (copy)
        if p17 == "strict" then
            script_flags.strict = p18;

            return;
        end;

        script_throw((`{tostring(p17)} is not a valid member of vide`));
    end
});

return v13;