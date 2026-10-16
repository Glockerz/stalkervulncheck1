-- Decompiled with Potassium's decompiler.

local collections = require(script.Parent.Parent.Parent:WaitForChild("collections"));
local Array = collections.Array;
local Object = collections.Object;
local boolean = require(script.Parent.Parent.Parent:WaitForChild("boolean"));
local string2 = require(script.Parent.Parent.Parent:WaitForChild("string"));
require(script.Parent.Parent.Parent:WaitForChild("es7-types"));
local inspect = collections.inspect;
local Error = require(script.Parent.Parent:WaitForChild("Error"));
local u1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"));
local u2 = {
    stderr = {
        isTTY = false,
        columns = 0,

        hasColors = function(...) -- Line: 45, Name: hasColors
            return true;
        end
    }
};

function ErrorCaptureStackTrace(p3, ...)
    -- upvalues: Error (copy)
    Error.captureStackTrace(p3, ...);
end;

local function removeColors(p4) -- Line: 57
    return p4;
end;

local u5 = "";
local u6 = "";
local u7 = "";
local u8 = "";
local u9 = {
    deepStrictEqual = "Expected values to be strictly deep-equal:",
    strictEqual = "Expected values to be strictly equal:",
    strictEqualObject = "Expected \"actual\" to be reference-equal to \"expected\":",
    deepEqual = "Expected values to be loosely deep-equal:",
    notDeepStrictEqual = "Expected \"actual\" not to be strictly deep-equal to:",
    notStrictEqual = "Expected \"actual\" to be strictly unequal to:",
    notStrictEqualObject = "Expected \"actual\" not to be reference-equal to \"expected\":",
    notDeepEqual = "Expected \"actual\" not to be loosely deep-equal to:",
    notIdentical = "Values have same structure but are not reference-equal:",
    notDeepEqualUnequal = "Expected values not to be loosely deep-equal:"
};

local function copyError(p10) -- Line: 85
    -- upvalues: Object (copy)
    local v11 = {};

    for _, v in Object.keys(p10) do
        v11[v] = p10[v];
    end;

    v11.message = p10.message;

    return v11;
end;

local function inspectValue(p12) -- Line: 96
    -- upvalues: inspect (copy)
    return inspect(p12, {
        compact = false,
        customInspect = false,
        depth = 1000,
        maxArrayLength = (1 / 0),
        showHidden = false,
        showProxy = false,
        sorted = true,
        getters = true
    });
end;

local function createErrDiff(p13, p14, p15) -- Line: 111
    -- upvalues: inspect (copy), string2 (copy), boolean (copy), u9 (copy), u2 (copy), u5 (ref), u8 (ref), Array (copy), u6 (ref), u7 (ref)
    local v16 = "";
    local v17 = "";
    local v18 = "";
    local v19 = false;
    local v20 = inspect(p13, {
        compact = false,
        customInspect = false,
        depth = 1000,
        maxArrayLength = (1 / 0),
        showHidden = false,
        showProxy = false,
        sorted = true,
        getters = true
    });
    local v21 = string2.split(v20, "\n");
    local v22 = string2.split(inspect(p14, {
        compact = false,
        customInspect = false,
        depth = 1000,
        maxArrayLength = (1 / 0),
        showHidden = false,
        showProxy = false,
        sorted = true,
        getters = true
    }), "\n");
    local v23 = 0;
    local v24 = "";
    local v25 = p15 == "strictEqual" and (typeof(p13) == "table" and (p13 ~= nil and (typeof(p14) == "table" and p14 ~= nil)) or typeof(p13) == "function" and typeof(p14) == "function") and "strictEqualObject" or p15;

    if #v21 == 1 and (#v22 == 1 and v21[1] ~= v22[1]) then
        local v26 = v21[1];
        local v27;

        if boolean.toJSBoolean(false) then
            v27 = v22[1];
        else
            v27 = v22[1];
        end;

        local v28 = string.len(v26) + string.len(v27);

        if v28 <= 12 then
            if not (typeof(p13) == "table" and p13 ~= nil or (typeof(p14) == "table" and p14 ~= nil or p13 == 0 and p14 == 0)) then
                return ("%s\n\n"):format(u9[v25]) .. ("%s !== %s\n"):format(v21[1], v22[1]);
            end;
        elseif v25 ~= "strictEqualObject" and v28 < (not u2.stderr.isTTY and 80 or u2.stderr.columns) then
            while string.sub(v26, v23 + 1, v23 + 1) == string.sub(v27, v23 + 1, v23 + 1) do
                v23 = v23 + 1;
            end;

            if v23 > 2 then
                v24 = ("\n  %s^"):format(string.rep(" ", v23));
                v23 = 0;
            end;
        end;
    end;

    local v29 = v21[#v21];
    local v30 = v22[#v22];
    local v31;

    while true do
        if v29 ~= v30 then
            v31 = v23;
            break;
        end;

        v31 = v23 + 1;

        if v23 < 3 then
            v18 = ("\n  %s%s"):format(v29, v18);
        else
            v16 = v29;
        end;

        table.remove(v21);
        table.remove(v22);

        if #v21 == 0 or #v22 == 0 then
            break;
        end;

        v29 = v21[#v21];
        v30 = v22[#v22];
        v23 = v31;
    end;

    local math_max_ret = math.max(#v21, #v22);

    if math_max_ret == 0 then
        local v32 = string2.split(v20, "\n");

        if #v32 > 50 then
            v32[47] = ("%s...%s"):format(u5, u8);

            while #v32 > 47 do
                table.remove(v32);
            end;
        end;

        return ("%s\n\n"):format("Values have same structure but are not reference-equal:") .. ("%s\n"):format(Array.join(v32, "\n"));
    end;

    if v31 >= 5 then
        v18 = ("\n%s...%s%s"):format(u5, u8, v18);
        v19 = true;
    end;

    if v16 ~= "" then
        v18 = ("\n  %s%s"):format(v16, v18);
        v16 = "";
    end;

    local v33 = 0;
    local v34 = 0;
    local v35 = u9[v25] .. ("\n%s+ actual%s %s- expected%s"):format(u6, u8, u7, u8);
    local v36 = (" %s...%s Lines skipped"):format(u5, u8);
    local v37 = ("%s+%s"):format(u6, u8);
    local v38 = #v22;
    local v39;

    if #v21 < math_max_ret then
        v37 = ("%s-%s"):format(u7, u8);
        v38 = #v21;
        v39 = v22;
    else
        v39 = v21;
    end;

    for i = 1, math_max_ret do
        if v38 < i then
            if v34 > 2 then
                if v34 > 3 then
                    if v34 > 4 then
                        if v34 == 5 then
                            v17 = v17 .. ("\n  %s"):format(v39[i - 3]);
                            v33 = v33 + 1;
                        else
                            v17 = v17 .. ("\n%s...%s"):format(u5, u8);
                            v19 = true;
                        end;
                    end;

                    v17 = v17 .. ("\n  %s"):format(v39[i - 2]);
                    v33 = v33 + 1;
                end;

                v17 = v17 .. ("\n  %s"):format(v39[i - 1]);
                v33 = v33 + 1;
            end;

            v34 = 0;

            if v39 == v21 then
                v17 = v17 .. ("\n%s %s"):format(v37, v39[i]);
            else
                v16 = v16 .. ("\n%s %s"):format(v37, v39[i]);
            end;

            v33 = v33 + 1;
        else
            local v40 = v22[i];
            local v41 = v21[i];
            local v42;

            if v41 == v40 then
                v42 = false;
            else
                v42 = not boolean.toJSBoolean(string2.endsWith(v41, ",")) or string2.slice(v41, 0, -1) ~= v40;
            end;

            if v42 and (string2.endsWith(v40, ",") and string2.slice(v40, 0, -1) == v41) then
                v41 = v41 .. ",";
                v42 = false;
            end;

            if v42 then
                if v34 > 2 then
                    if v34 > 3 then
                        if v34 > 4 then
                            if v34 == 5 then
                                v17 = v17 .. ("\n  %s"):format(v21[i - 3]);
                                v33 = v33 + 1;
                            else
                                v17 = v17 .. ("\n%s...%s"):format(u5, u8);
                                v19 = true;
                            end;
                        end;

                        v17 = v17 .. ("\n  %s"):format(v21[i - 2]);
                        v33 = v33 + 1;
                    end;

                    v17 = v17 .. ("\n  %s"):format(v21[i - 1]);
                    v33 = v33 + 1;
                end;

                v17 = v17 .. ("\n%s+%s %s"):format(u6, u8, v41);
                v16 = v16 .. ("\n%s-%s %s"):format(u7, u8, v40);
                v33 = v33 + 2;
                v34 = 0;
            else
                v17 = v17 .. v16;
                v16 = "";
                v34 = v34 + 1;

                if v34 <= 2 then
                    v17 = v17 .. ("\n  %s"):format(v41);
                    v33 = v33 + 1;
                end;
            end;
        end;

        if v33 > 50 and i < math_max_ret - 2 then
            return ("%s%s\n%s\n%s...%s%s\n"):format(v35, v36, v17, u5, u8, v16) .. ("%s...%s"):format(u5, u8);
        end;

        local _ = i;
    end;

    return ("%s%s\n%s%s%s%s"):format(v35, not v19 and "" or v36, v17, v16, v18, v24);
end;

local u43 = setmetatable({}, {
    __index = Error
});
u43.__index = u43;

function u43.__tostring(p44) -- Line: 391
    return p44:toString();
end;

function u43.new(p45: table) -- Line: 404
    -- upvalues: Error (copy), u43 (copy), u2 (copy), u5 (ref), u6 (ref), u8 (ref), u7 (ref), Array (copy), Object (copy), u1 (copy), createErrDiff (copy), u9 (copy), string2 (copy), inspect (copy), boolean (copy)
    local message = p45.message;
    local operator = p45.operator;
    local stackStartFn = p45.stackStartFn;
    local actual = p45.actual;
    local expected = p45.expected;
    local v46;

    if message == nil then
        if u2.stderr.isTTY then
            if u2.stderr:hasColors() then
                u5 = "\27[34m";
                u6 = "\27[32m";
                u8 = "\27[39m";
                u7 = "\27[31m";
            else
                u5 = "";
                u6 = "";
                u8 = "";
                u7 = "";
            end;
        end;

        local v47, v48;

        if typeof(actual) == "table" and (actual ~= nil and (typeof(expected) == "table" and (expected ~= nil and (Array.indexOf(Object.keys(actual), "stack") ~= -1 and (u1(actual, Error) and (Array.indexOf(Object.keys(expected), "stack") ~= -1 and u1(expected, Error))))))) then
            v47 = {};

            for _, v in Object.keys(actual) do
                v47[v] = actual[v];
            end;

            v47.message = actual.message;
            v48 = {};

            for _, v in Object.keys(expected) do
                v48[v] = expected[v];
            end;

            v48.message = expected.message;
        else
            v48 = expected;
            v47 = actual;
        end;

        if operator == "deepStrictEqual" or operator == "strictEqual" then
            local v49 = Error.new(createErrDiff(v47, v48, operator));
            v46 = setmetatable(v49, u43);
            expected = v48;
            actual = v47;
        elseif operator == "notDeepStrictEqual" or operator == "notStrictEqual" then
            local v50 = u9[operator];
            local v51 = string2.split(inspect(v47, {
                compact = false,
                customInspect = false,
                depth = 1000,
                maxArrayLength = (1 / 0),
                showHidden = false,
                showProxy = false,
                sorted = true,
                getters = true
            }), "\n");
            local v52 = operator == "notStrictEqual" and (typeof(v47) == "table" and v47 ~= nil or typeof(v47) == "function") and "Expected \"actual\" not to be reference-equal to \"expected\":" or v50;

            if #v51 > 50 then
                v51[47] = ("%s...%s"):format(u5, u8);

                while #v51 > 47 do
                    table.remove(v51);
                end;
            end;

            if #v51 == 1 then
                local v53 = Error.new(("%s%s%s"):format(v52, string.len(v51[1]) > 5 and "\n\n" or " ", v51[1]));
                v46 = setmetatable(v53, u43);
                expected = v48;
                actual = v47;
            else
                local v54 = Error.new(("%s\n\n%s\n"):format(v52, Array.join(v51, "\n")));
                v46 = setmetatable(v54, u43);
                expected = v48;
                actual = v47;
            end;
        else
            local v55 = inspect(v47, {
                compact = false,
                customInspect = false,
                depth = 1000,
                maxArrayLength = (1 / 0),
                showHidden = false,
                showProxy = false,
                sorted = true,
                getters = true
            });
            local v56 = inspect(v48, {
                compact = false,
                customInspect = false,
                depth = 1000,
                maxArrayLength = (1 / 0),
                showHidden = false,
                showProxy = false,
                sorted = true,
                getters = true
            });
            local v57 = u9[tostring(operator)];

            if operator == "notDeepEqual" and v55 == v56 then
                local v58 = ("%s\n\n%s"):format(v57, v55);

                if string.len(v58) > 1024 then
                    v58 = ("%s..."):format(string2.slice(v58, 0, 1021));
                end;

                local v59 = Error.new(v58);
                v46 = setmetatable(v59, u43);
                expected = v48;
                actual = v47;
            else
                if string.len(v55) > 512 then
                    v55 = ("%s..."):format(string2.slice(v55, 0, 509));
                end;

                if string.len(v56) > 512 then
                    v56 = ("%s..."):format(string2.slice(v56, 0, 509));
                end;

                if operator == "deepEqual" then
                    v55 = ("%s\n\n%s\n\nshould loosely deep-equal\n\n"):format(v57, v55);
                else
                    local v60 = u9[("%sUnequal"):format((tostring(operator)))];

                    if boolean.toJSBoolean(v60) then
                        v55 = ("%s\n\n%s\n\nshould not loosely deep-equal\n\n"):format(v60, v55);
                    else
                        v56 = (" %s %s"):format(tostring(operator), v56);
                    end;
                end;

                local v61 = Error.new(("%s%s"):format(v55, v56));
                v46 = setmetatable(v61, u43);
                expected = v48;
                actual = v47;
            end;
        end;
    else
        local v62 = Error.new((tostring(message)));
        v46 = setmetatable(v62, u43);
    end;

    v46.generatedMessage = not boolean.toJSBoolean(message);
    v46.name = "AssertionError [ERR_ASSERTION]";
    v46.code = "ERR_ASSERTION";
    v46.actual = actual;
    v46.expected = expected;
    v46.operator = operator;
    ErrorCaptureStackTrace(v46, stackStartFn or u43.new);
    v46.name = "AssertionError";

    return v46;
end;

function u43.toString(p63) -- Line: 573
    return ("%s [%s]: %s"):format(p63.name, p63.code, p63.message);
end;

u43.name = "AssertionError";

return {
    AssertionError = u43
};