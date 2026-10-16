-- Decompiled with Potassium's decompiler.

local script_Promise = require(script.Promise);
local u1 = setmetatable({}, {
    __tostring = function() -- Line: 16, Name: __tostring
        return "LinkToInstanceIndex";
    end
});
local u2 = {
    ClassName = "Janitor",
    CurrentlyCleaning = true,
    SuppressInstanceReDestroy = false
};
u2.__index = u2;
local u3 = setmetatable({}, {
    __mode = "k"
});
local u4 = {
    ["function"] = true,
    thread = true,
    RBXScriptConnection = "Disconnect"
};

function u2.new() -- Line: 150
    -- upvalues: u2 (copy)
    return setmetatable({
        CurrentlyCleaning = false
    }, u2);
end;

function u2.Is(p5) -- Line: 163
    -- upvalues: u2 (copy)
    local v6;

    if type(p5) == "table" then
        v6 = getmetatable(p5) == u2;
    else
        v6 = false;
    end;

    return v6;
end;

u2.instanceof = u2.Is;

local function Remove(p7, p8) -- Line: 179
    -- upvalues: u3 (copy)
    local v9 = u3[p7];

    if v9 then
        local u10 = v9[p8];

        if not u10 then
            return p7;
        end;

        local v11 = p7[u10];

        if v11 then
            if v11 == true then
                if type(u10) == "function" then
                    u10();
                else
                    local v12;

                    if coroutine.running() == u10 then
                        v12 = nil;
                    else
                        v12 = pcall(function() -- Line: 196
                            -- upvalues: u10 (copy)
                            task.cancel(u10);
                        end);
                    end;

                    if not v12 then
                        task.defer(function() -- Line: 203
                            -- upvalues: u10 (copy)
                            task.cancel(u10);
                        end);
                    end;
                end;
            else
                local v13 = u10[v11];

                if v13 then
                    if p7.SuppressInstanceReDestroy and (v11 == "Destroy" and typeof(u10) == "Instance") then
                        pcall(v13, u10);
                    else
                        v13(u10);
                    end;
                end;
            end;

            p7[u10] = nil;
        end;

        v9[p8] = nil;
    end;

    return p7;
end;

local function Add(p14, p15, p16, p17) -- Line: 230
    -- upvalues: Remove (copy), u3 (copy), u4 (copy)
    if p17 then
        Remove(p14, p17);
        local v18 = u3[p14];

        if not v18 then
            v18 = {};
            u3[p14] = v18;
        end;

        v18[p17] = p15;
    end;

    local v19 = typeof(p15);
    local v20 = p16 or (u4[v19] or "Destroy");

    if v19 == "function" or v19 == "thread" then
        if v20 ~= true then
            warn(string.format("Object is a %* and as such expected `true?` for the method name and instead got %*. Traceback: %*", v19, tostring(v20), debug.traceback(nil, 2)));
        end;
    elseif not p15[v20] then
        warn(string.format("Object %* doesn\'t have method %*, are you sure you want to add it? Traceback: %*", tostring(p15), tostring(v20), debug.traceback(nil, 2)));
    end;

    p14[p15] = v20;

    return p15;
end;

u2.Add = Add;

function u2.AddObject(p21: table, p22: table, p23: any, p24: any, ...) -- Line: 383
    -- upvalues: Add (copy)
    return Add(p21, p22.new(...), p23, p24);
end;

function u2.AddPromise(u25, u26) -- Line: 417
    -- upvalues: script_Promise (copy), Add (copy), Remove (copy)
    if not script_Promise then
        return u26;
    end;

    if not script_Promise.is(u26) then
        error(string.format("Invalid argument #1 to \'Janitor:AddPromise\' (Promise expected, got %* (%*)) Traceback: %*", typeof(u26), tostring(u26), debug.traceback(nil, 2)));
    end;

    if u26:getStatus() ~= script_Promise.Status.Started then
        return u26;
    end;

    local u27 = newproxy(false);
    local v31 = Add(u25, script_Promise.new(function(p28, p29, p30) -- Line: 428
        -- upvalues: u26 (copy)
        if p30(function() -- Line: 429
            -- upvalues: u26 (ref)
            u26:cancel();
        end) then
            return;
        end;

        p28(u26);
    end), "cancel", u27);
    v31:finally(function() -- Line: 438
        -- upvalues: Remove (ref), u25 (copy), u27 (copy)
        Remove(u25, u27);
    end);

    return v31;
end;

u2.Remove = Remove;

function u2.RemoveNoClean(p32, p33) -- Line: 510
    -- upvalues: u3 (copy)
    local v34 = u3[p32];
    local v35 = v34 and v34[p33];

    if v35 then
        p32[v35] = nil;
        v34[p33] = nil;
    end;

    return p32;
end;

function u2.RemoveList(p36, ...) -- Line: 565
    -- upvalues: u3 (copy), Remove (copy)
    if u3[p36] then
        local v37 = select("#", ...);

        if v37 == 1 then
            return Remove(p36, ...);
        end;

        if v37 == 2 then
            local v38, v39 = ...;
            Remove(p36, v38);
            Remove(p36, v39);

            return p36;
        end;

        if v37 == 3 then
            local v40, v41, v42 = ...;
            Remove(p36, v40);
            Remove(p36, v41);
            Remove(p36, v42);

            return p36;
        end;

        for i = 1, v37 do
            Remove(p36, (select(i, ...)));
            local _ = i;
        end;
    end;

    return p36;
end;

function u2.RemoveListNoClean(p43, ...) -- Line: 636
    -- upvalues: u3 (copy)
    local v44 = u3[p43];

    if v44 then
        local v45 = select("#", ...);

        if v45 == 1 then
            local v46 = ...;
            local v47 = v44[v46];

            if v47 then
                p43[v47] = nil;
                v44[v46] = nil;
            end;

            return p43;
        end;

        if v45 == 2 then
            local v48, v49 = ...;
            local v50 = v44[v48];

            if v50 then
                p43[v50] = nil;
                v44[v48] = nil;
            end;

            local v51 = v44[v49];

            if v51 then
                p43[v51] = nil;
                v44[v49] = nil;
            end;

            return p43;
        end;

        if v45 == 3 then
            local v52, v53, v54 = ...;
            local v55 = v44[v52];

            if v55 then
                p43[v55] = nil;
                v44[v52] = nil;
            end;

            local v56 = v44[v53];

            if v56 then
                p43[v56] = nil;
                v44[v53] = nil;
            end;

            local v57 = v44[v54];

            if v57 then
                p43[v57] = nil;
                v44[v54] = nil;
            end;

            return p43;
        end;

        for i = 1, v45 do
            local v58 = select(i, ...);
            local v59 = v44[v58];
            local v60;

            if v59 then
                p43[v59] = nil;
                v44[v58] = nil;
                v60 = i;
            else
                v60 = i;
            end;
        end;
    end;

    return p43;
end;

function u2.Get(p61, p62) -- Line: 723
    -- upvalues: u3 (copy)
    local v63 = u3[p61];

    if v63 then
        return v63[p62];
    end;

    return nil;
end;

function u2.GetAll(p64) -- Line: 753
    -- upvalues: u3 (copy)
    local v65 = u3[p64];

    return not v65 and {} or table.freeze(table.clone(v65));
end;

local function GetFenv(u66) -- Line: 758
    return function() -- Line: 759
        -- upvalues: u66 (copy)
        for i, v in next, u66 do
            if i ~= "SuppressInstanceReDestroy" then
                return i, v;
            end;
        end;
    end;
end;

local function Cleanup(u67) -- Line: 768
    -- upvalues: u3 (copy)
    if not u67.CurrentlyCleaning then
        u67.CurrentlyCleaning = nil;

        local function v68() -- Line: 759
            -- upvalues: u67 (copy)
            for i, v in next, u67 do
                if i ~= "SuppressInstanceReDestroy" then
                    return i, v;
                end;
            end;
        end;

        local u69, v70 = v68();

        while u69 and v70 do
            if v70 == true then
                if type(u69) == "function" then
                    u69();
                elseif type(u69) == "thread" then
                    local v71;

                    if coroutine.running() == u69 then
                        v71 = nil;
                    else
                        v71 = pcall(function() -- Line: 782
                            -- upvalues: u69 (ref)
                            task.cancel(u69);
                        end);
                    end;

                    if not v71 then
                        local u72 = u69;
                        task.defer(function() -- Line: 789
                            -- upvalues: u72 (copy)
                            task.cancel(u72);
                        end);
                    end;
                end;
            else
                local v73 = u69[v70];

                if v73 then
                    if u67.SuppressInstanceReDestroy and (v70 == "Destroy" and typeof(u69) == "Instance") then
                        pcall(v73, u69);
                    else
                        v73(u69);
                    end;
                end;
            end;

            u67[u69] = nil;
            u69, v70 = v68();
        end;

        local v74 = u3[u67];

        if v74 then
            table.clear(v74);
            u3[u67] = nil;
        end;

        u67.CurrentlyCleaning = false;
    end;
end;

u2.Cleanup = Cleanup;

function u2.Destroy(p75) -- Line: 852
    -- upvalues: Cleanup (copy)
    Cleanup(p75);
    table.clear(p75);
    setmetatable(p75, nil);
end;

u2.__call = Cleanup;

local function LinkToInstance(u76: any, p77: userdata, p78: boolean?) -- Line: 860
    -- upvalues: u1 (copy), Add (copy), Cleanup (copy)
    local v79;

    if p78 then
        v79 = newproxy(false);
    else
        v79 = u1;
    end;

    return Add(u76, p77.Destroying:Connect(function() -- Line: 863
        -- upvalues: Cleanup (ref), u76 (copy)
        Cleanup(u76);
    end), "Disconnect", v79);
end;

u2.LinkToInstance = LinkToInstance;
u2.LegacyLinkToInstance = LinkToInstance;

function u2.LinkToInstances(p80, ...) -- Line: 926
    -- upvalues: u2 (copy), LinkToInstance (copy)
    local v81 = u2.new();

    for i = 1, select("#", ...) do
        local v82 = select(i, ...);
        local v83;

        if typeof(v82) == "Instance" then
            v81:Add(LinkToInstance(p80, v82, true), "Disconnect");
            v83 = i;
        else
            v83 = i;
        end;
    end;

    return v81;
end;

function u2.__tostring(p84) -- Line: 940
    return "Janitor";
end;

return u2;