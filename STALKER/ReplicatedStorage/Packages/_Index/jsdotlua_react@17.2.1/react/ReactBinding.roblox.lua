-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols;
require(script.Parent.Parent:WaitForChild("shared"));
local Symbol = v1.Symbol;
local u2 = require(script.Parent:WaitForChild("createSignal.roblox"));
local u3 = Symbol("BindingImpl");
local u4 = {};
local u9 = {
    __index = {
        getValue = function(p5: table) -- Line: 45, Name: getValue
            -- upvalues: u4 (copy)
            return u4.getValue(p5);
        end,

        map = function(p6: table, p7: function) -- Line: 49, Name: map
            -- upvalues: u4 (copy)
            return u4.map(p6, p7);
        end
    },

    __tostring = function(p8) -- Line: 58, Name: __tostring
        return string.format("RoactBinding(%s)", (tostring(p8:getValue())));
    end
};

function u4.update(p10, p11) -- Line: 63
    -- upvalues: u3 (copy)
    return p10[u3].update(p11);
end;

function u4.subscribe(p12: any, p13: function) -- Line: 67
    -- upvalues: u3 (copy)
    return p12[u3].subscribe(p13);
end;

function u4.getValue(p14) -- Line: 71
    -- upvalues: u3 (copy)
    return p14[u3]:getValue();
end;

function u4.create(p15) -- Line: 75
    -- upvalues: u2 (copy), ReactSymbols (copy), u3 (copy), u9 (copy)
    local v16, u17 = u2();
    local u18 = {
        value = p15,
        subscribe = v16
    };

    function u18.update(p19: userdata) -- Line: 82
        -- upvalues: u18 (copy), u17 (copy)
        u18.value = p19;
        u17(p19);
    end;

    function u18.getValue() -- Line: 87
        -- upvalues: u18 (copy)
        return u18.value;
    end;

    local v20;

    if _G.__DEV__ then
        v20 = debug.traceback("Binding created at:", 3);
    else
        v20 = nil;
    end;

    return setmetatable({
        ["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE,
        [u3] = u18,
        _source = v20
    }, u9), u18.update;
end;

function u4.map(u21: table, u22: function) -- Line: 105
    -- upvalues: ReactSymbols (copy), u4 (copy), u3 (copy), u9 (copy)
    if _G.__DEV__ then
        local v23;

        if typeof(u21) == "table" then
            v23 = u21["$$typeof"] == ReactSymbols.REACT_BINDING_TYPE;
        else
            v23 = false;
        end;

        assert(v23, "Expected `self` to be a binding");
        local v24 = typeof(u22) == "function";
        assert(v24, "Expected arg #1 to be a function");
    end;

    local v28 = {
        subscribe = function(u25) -- Line: 121, Name: subscribe
            -- upvalues: u4 (ref), u21 (copy), u22 (copy)
            return u4.subscribe(u21, function(p26) -- Line: 122
                -- upvalues: u25 (copy), u22 (ref)
                u25(u22(p26));
            end);
        end,

        update = function(p27) -- Line: 127, Name: update
            error("Bindings created by Binding:map(fn) cannot be updated directly", 2);
        end,

        getValue = function() -- Line: 131, Name: getValue
            -- upvalues: u22 (copy), u21 (copy)
            return u22(u21:getValue());
        end
    };
    local v29;

    if _G.__DEV__ then
        v29 = debug.traceback("Mapped binding created at:", 3);
    else
        v29 = nil;
    end;

    return setmetatable({
        ["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE,
        [u3] = v28,
        _source = v29
    }, u9);
end;

function u4.join(u30: table) -- Line: 152
    -- upvalues: ReactSymbols (copy), u4 (copy), u3 (copy), u9 (copy)
    if _G.__DEV__ then
        local v31 = typeof(u30) == "table";
        assert(v31, "Expected arg #1 to be of type table");

        for i, v in u30 do
            if typeof(v) ~= "table" or v["$$typeof"] ~= ReactSymbols.REACT_BINDING_TYPE then
                local v32 = ("Expected arg #1 to contain only bindings, but key %q had a non-binding value"):format((tostring(i)));
                error(v32, 2);
            end;
        end;
    end;

    local v33 = {};

    local function getValue() -- Line: 173
        -- upvalues: u30 (copy)
        local v34 = {};

        for i, v in pairs(u30) do
            v34[i] = v:getValue();
        end;

        return v34;
    end;

    function v33.subscribe(u35) -- Line: 184
        -- upvalues: u30 (copy), u4 (ref), getValue (copy)
        local u36 = {};

        for i, v in u30 do
            u36[i] = u4.subscribe(v, function(p37) -- Line: 189
                -- upvalues: u35 (copy), getValue (ref)
                u35((getValue()));
            end);
        end;

        return function() -- Line: 194
            -- upvalues: u36 (ref)
            if u36 == nil then
                return;
            end;

            for _, v in u36 do
                v();
            end;

            u36 = nil;
        end;
    end;

    function v33.update(p38) -- Line: 207
        error("Bindings created by joinBindings(...) cannot be updated directly", 2);
    end;

    function v33.getValue() -- Line: 211
        -- upvalues: getValue (copy)
        return getValue();
    end;

    local v39;

    if _G.__DEV__ then
        v39 = debug.traceback("Joined binding created at:", 2);
    else
        v39 = nil;
    end;

    return setmetatable({
        ["$$typeof"] = ReactSymbols.REACT_BINDING_TYPE,
        [u3] = v33,
        _source = v39
    }, u9);
end;

return u4;