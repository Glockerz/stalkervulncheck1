-- Decompiled with Potassium's decompiler.

local u1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Error = u1.Error;
local inspect = u1.util.inspect;

return {
    __ERROR_DIVIDER = "\n------ Error caught by React ------\n",

    describeError = function(p2) -- Line: 33, Name: describeError
        -- upvalues: u1 (copy)
        if typeof(p2) ~= "string" then
            return p2;
        end;

        local _, v3 = string.find(p2, ":[%d]+: ");

        if v3 then
            p2 = string.sub(p2, v3 + 1);
        end;

        local v4 = u1.Error.new(p2);
        v4.stack = debug.traceback(nil, 2);

        return v4;
    end,

    errorToString = function(p5) -- Line: 53, Name: errorToString
        -- upvalues: inspect (copy)
        if typeof(p5) ~= "table" then
            return inspect(p5);
        end;

        if p5.message and p5.stack then
            return "\n------ Error caught by React ------\n" .. p5.message .. "\n------ Error caught by React ------\n" .. tostring(p5.stack);
        end;

        return inspect(p5);
    end,

    parseReactError = function(p6: string) -- Line: 79, Name: parseReactError
        -- upvalues: Error (copy)
        local string_split_ret = string.split(p6, "\n------ Error caught by React ------\n");

        if #string_split_ret ~= 3 then
            local v7 = Error.new(p6);
            v7.stack = nil;

            return v7, "";
        end;

        local table_unpack_ret, v8, v9 = table.unpack(string_split_ret);
        local v10 = Error.new(v8);
        v10.stack = v9;

        return v10, table_unpack_ret;
    end
};