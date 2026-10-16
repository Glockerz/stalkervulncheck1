-- Decompiled with Potassium's decompiler.

local _G___DEV__ = _G.__DEV__;
local CollectionService = game:GetService("CollectionService");
local v1 = require(script.Parent.Parent.Parent.Parent:WaitForChild("luau-polyfill"));
local Object = v1.Object;
local inspect = v1.util.inspect;
local console = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).console;
local react = require(script.Parent.Parent.Parent.Parent:WaitForChild("react"));
local ReactSymbols = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).ReactSymbols;
local SingleEventManager = require(script.Parent:WaitForChild("SingleEventManager"));
local Type = require(script.Parent.Parent.Parent.Parent:WaitForChild("shared")).Type;
local getDefaultInstanceProperty = require(script.Parent:WaitForChild("getDefaultInstanceProperty"));
require(script.Parent.Parent:WaitForChild("ReactRobloxHostTypes.roblox"));
local Tag = require(script.Parent.Parent.Parent.Parent:WaitForChild("react")).Tag;
local u2 = {};
local u3 = {};

local function identity(...) -- Line: 69
    return ...;
end;

local function setRobloxInstanceProperty(p4, p5, p6) -- Line: 73
    -- upvalues: getDefaultInstanceProperty (copy)
    if p6 == nil then
        local success, _ = pcall(p4.ResetPropertyToDefault, p4, p5);

        if success then
            return;
        end;

        local v7;
        v7, p6 = getDefaultInstanceProperty(p4.ClassName, p5);
    end;

    p4[p5] = p6;
end;

local function removeBinding(p8, p9) -- Line: 89
    -- upvalues: u3 (copy)
    local v10 = u3[p8];

    if v10 ~= nil then
        v10[p9]();
        v10[p9] = nil;
    end;
end;

local function attachBinding(u11, u12, u13) -- Line: 98
    -- upvalues: setRobloxInstanceProperty (copy), identity (copy), console (copy), u3 (copy), react (copy)
    local function updateBoundProperty(p14) -- Line: 99
        -- upvalues: setRobloxInstanceProperty (ref), identity (ref), u11 (copy), u12 (copy), u13 (copy), console (ref)
        local v15, v16 = xpcall(setRobloxInstanceProperty, identity, u11, u12, p14);

        if not v15 then
            local v17 = u13._source or "<enable DEV mode for stack>";
            local string_format_ret = string.format("Error updating binding or ref assigned to key %s of \'%s\' (%s).\n\nUpdated value:\n  %s\n\nError:\n  %s\n\n%s\n", u12, u11.Name, u11.ClassName, tostring(p14), v16, v17);
            console.error(string_format_ret);
            error(string_format_ret, 0);
        end;
    end;

    if u3[u11] == nil then
        u3[u11] = {};
    end;

    u3[u11][u12] = react.__subscribeToBinding(u13, updateBoundProperty);
    updateBoundProperty(u13:getValue());
end;

local function applyTags(p18: userdata, p19: string?, p20: string?) -- Line: 131
    -- upvalues: _G___DEV__ (copy), console (copy), inspect (copy), CollectionService (copy)
    if _G___DEV__ and (p20 ~= nil and typeof(p20) ~= "string") then
        console.error("Type provided for ReactRoblox.Tag is invalid - tags should be specified as a single string, with individual tags delimited by spaces. Instead received:\n%s", inspect(p20));

        return;
    end;

    local v21 = {};

    for i in string.gmatch(p19 or "", "%S+") do
        v21[i] = true;
    end;

    local v22 = {};

    for i in string.gmatch(p20 or "", "%S+") do
        v22[i] = true;
    end;

    for i, _ in v21 do
        if not v22[i] then
            CollectionService:RemoveTag(p18, i);
        end;
    end;

    for i, _ in v22 do
        if not v21[i] then
            CollectionService:AddTag(p18, i);
        end;
    end;
end;

local function removeAllTags(p23: userdata) -- Line: 165
    -- upvalues: CollectionService (copy)
    for _, v in CollectionService:GetTags(p23) do
        CollectionService:RemoveTag(p23, v);
    end;
end;

local function applyProp(p24: userdata, p25: any, p26: any, p27: any) -- Line: 171
    -- upvalues: Type (copy), u2 (copy), SingleEventManager (copy), ReactSymbols (copy), u3 (copy), attachBinding (copy), Tag (copy), applyTags (copy), getDefaultInstanceProperty (copy)
    local v28 = Type.of(p25);

    if v28 == Type.HostEvent or v28 == Type.HostChangeEvent then
        local v29 = u2[p24];

        if v29 == nil then
            v29 = SingleEventManager.new(p24);
            u2[p24] = v29;
        end;

        local name = p25.name;

        if v28 == Type.HostChangeEvent then
            v29:connectPropertyChange(name, p26);

            return;
        end;

        v29:connectEvent(name, p26);

        return;
    end;

    local v30;

    if typeof(p26) == "table" then
        v30 = p26["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE;
    else
        v30 = false;
    end;

    local v31;

    if p27 == nil or typeof(p27) ~= "table" then
        v31 = false;
    else
        v31 = p27["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE;
    end;

    if v31 then
        local v32 = u3[p24];

        if v32 ~= nil then
            v32[p25]();
            v32[p25] = nil;
        end;
    end;

    if v30 then
        attachBinding(p24, p25, p26);

        return;
    end;

    if p25 == Tag then
        applyTags(p24, p27, p26);

        return;
    end;

    if p26 == nil then
        local success, _ = pcall(p24.ResetPropertyToDefault, p24, p25);

        if success then
            return;
        end;

        local v33;
        v33, p26 = getDefaultInstanceProperty(p24.ClassName, p25);
    end;

    p24[p25] = p26;
end;

local function applyProps(p34: userdata, p35: table) -- Line: 216
    -- upvalues: applyProp (copy)
    for i, v in p35 do
        if i ~= "ref" and i ~= "children" then
            applyProp(p34, i, v);
        end;
    end;
end;

local function safelyApplyProperties(p36: any, p37: table, p38: table) -- Line: 256
    -- upvalues: Object (copy), applyProp (copy)
    for i = 1, #p37, 2 do
        local v39 = p37[i];
        local v40 = p37[i + 1];

        if v40 == Object.None then
            v40 = nil;
        end;

        local v41;

        if v39 == "ref" or v39 == "children" then
            v41 = i;
        else
            applyProp(p36, v39, v40, p38[v39]);
            v41 = i;
        end;
    end;
end;

local function cleanupBindings(p42) -- Line: 309
    -- upvalues: u3 (copy)
    local v43 = u3[p42];

    if v43 ~= nil then
        for _, v in v43 do
            v();
        end;

        u3[p42] = nil;
    end;
end;

return {
    setInitialProperties = function(p44: any, p45: string, p46: table, p47: any) -- Line: 227, Name: setInitialProperties
        -- upvalues: applyProps (copy), identity (copy), console (copy), u2 (copy)
        local v48, v49 = xpcall(applyProps, identity, p44, p46);

        if not v48 then
            local string_format_ret = string.format("Error applying initial props to Roblox Instance \'%s\' (%s):\n  %s\n", p44.Name, p44.ClassName, v49);
            console.error(string_format_ret);
            error(string_format_ret, 0);
        end;

        if u2[p44] ~= nil then
            u2[p44]:resume();
        end;
    end,

    updateProperties = function(p50: any, p51: table, p52: table) -- Line: 275, Name: updateProperties
        -- upvalues: u2 (copy), safelyApplyProperties (copy), identity (copy), console (copy)
        if u2[p50] ~= nil then
            u2[p50]:suspend();
        end;

        local v53, v54 = xpcall(safelyApplyProperties, identity, p50, p51, p52);

        if not v53 then
            local string_format_ret = string.format("Error updating props on Roblox Instance \'%s\' (%s):\n  %s\n", p50.Name, p50.ClassName, v54);
            console.error(string_format_ret);
            error(string_format_ret, 0);
        end;

        if u2[p50] ~= nil then
            u2[p50]:resume();
        end;
    end,

    cleanupHostComponent = function(p55) -- Line: 321, Name: cleanupHostComponent
        -- upvalues: u2 (copy), u3 (copy), CollectionService (copy)
        if u2[p55] ~= nil then
            u2[p55] = nil;
        end;

        local v56 = u3[p55];

        if v56 ~= nil then
            for _, v in v56 do
                v();
            end;

            u3[p55] = nil;
        end;

        if typeof(p55) ~= "Instance" then
            return;
        end;

        for _, v in CollectionService:GetTags(p55) do
            CollectionService:RemoveTag(p55, v);
        end;

        for _, descendant in p55:GetDescendants() do
            if u2[descendant] ~= nil then
                u2[descendant] = nil;
            end;

            local v57 = u3[descendant];

            if v57 ~= nil then
                for _, v in v57 do
                    v();
                end;

                u3[descendant] = nil;
            end;

            for _, v in CollectionService:GetTags(p55) do
                CollectionService:RemoveTag(p55, v);
            end;
        end;
    end,

    _instanceToEventManager = u2,
    _instanceToBindings = u3
};