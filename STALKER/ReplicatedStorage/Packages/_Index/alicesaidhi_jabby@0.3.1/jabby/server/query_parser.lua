-- Decompiled with Potassium's decompiler.

local u1 = {
    a = "\7",
    b = "\8",
    f = "\f",
    n = "\n",
    r = "\r",
    t = "\t",
    v = "\11",
    ["\\"] = "\\",
    ["\""] = "\"",
    ["\'"] = "\'"
};

local function stream(u2: string) -- Line: 46
    local u3 = 0;
    local u4 = 1;
    local u5 = 1;

    return {
        peek = function() -- Line: 52, Name: peek
            -- upvalues: u2 (copy), u3 (ref)
            return string.sub(u2, u3 + 1, u3 + 1);
        end,

        next = function() -- Line: 56, Name: next
            -- upvalues: u2 (copy), u3 (ref), u4 (ref), u5 (ref)
            local string_sub_ret = string.sub(u2, u3 + 1, u3 + 1);
            u3 = u3 + 1;

            if string_sub_ret ~= "\n" then
                u5 = u5 + 1;

                return string_sub_ret;
            end;

            u4 = u4 + 1;
            u5 = 1;

            return string_sub_ret;
        end,

        eof = function() -- Line: 66, Name: eof
            -- upvalues: u2 (copy), u3 (ref)
            return string.sub(u2, u3 + 1, u3 + 1) == "";
        end,

        croak = function(p6) -- Line: 78, Name: croak
            -- upvalues: u4 (ref), u5 (ref)
            error(`{p6} ({u4}:{u5})`, 0);
        end,

        pos = function() -- Line: 70, Name: position
            -- upvalues: u3 (ref), u4 (ref), u5 (ref)
            return {
                pos = u3,
                line = u4,
                col = u5
            };
        end
    };
end;

local function lex(p7: string) -- Line: 92
    -- upvalues: stream (copy), u1 (copy)
    local u8 = stream(p7);

    local function is_whitespace(p9: string) -- Line: 96
        return string.match(p9, "[\t ]") and true or false;
    end;

    local function is_digit(p10: string) -- Line: 100
        return string.match(p10, "%d") and true or false;
    end;

    local function is_start_identifier(p11: string) -- Line: 104
        return string.match(p11, "[%a_]") and true or false;
    end;

    local function is_identifier(p12: string) -- Line: 108
        return string.match(p12, "[%a_:%.]") and true or false;
    end;

    local function is_op_char(p13: string) -- Line: 112
        return (p13 == "#" or (p13 == "!" or p13 == "*")) and true or p13 == "$";
    end;

    local function is_punc(p14: string) -- Line: 116
        return string.match(p14, "[%(%);,]") and true or false;
    end;

    local function read_while(p15: function) -- Line: 120
        -- upvalues: u8 (copy)
        local v16 = "";

        while u8.eof() == false and p15(u8.peek()) do
            v16 = v16 .. u8.next();
        end;

        return v16;
    end;

    local function skip_whitespace() -- Line: 128
        -- upvalues: read_while (copy), is_whitespace (copy)
        read_while(is_whitespace);
    end;

    local function read_string() -- Line: 132
        -- upvalues: u8 (copy), u1 (ref)
        local v17 = u8.next();
        local v18 = u8.pos();
        local v19 = "";
        local v20 = false;

        while u8.eof() == false and (u8.peek() ~= v17 or v20) do
            local v21 = u8.next();
            v20 = v21 == "\\" and true or v20;

            if v20 then
                v19 = v19 .. (u1[v21] or u8.croak((`cannot escape {v21}`)));
                v20 = false;
            else
                v19 = v19 .. v21;
            end;
        end;

        local v22 = u8.pos();

        if u8.peek() ~= v17 then
            u8.croak("unterminated string");
        end;

        u8.next();

        return {
            type = "string",
            s = v19,
            from = v18,
            to = v22
        };
    end;

    local function read_number() -- Line: 162
        -- upvalues: u8 (copy), read_while (copy)
        local u23 = false;
        local v24 = u8.pos();
        local v26 = read_while(function(p25) -- Line: 165
            -- upvalues: u23 (ref)
            if u23 and p25 == "." then
                return false;
            end;

            if p25 == "." then
                u23 = true;
            end;

            return string.match(p25, "%d") and true or false;
        end);
        local v27 = u8.pos();
        local v28 = tonumber(v26);

        if not v28 then
            u8.croak((`could not read {v26} as number`));
        end;

        return {
            type = "number",
            s = assert(v28),
            from = v24,
            to = v27
        };
    end;

    local function read_identifier() -- Line: 181
        -- upvalues: u8 (copy), read_while (copy), is_identifier (copy)
        local v29 = u8.pos();

        return {
            type = "identifier",
            s = read_while(is_identifier),
            from = v29,
            to = u8.pos()
        };
    end;

    local function read_next() -- Line: 193
        -- upvalues: read_while (copy), is_whitespace (copy), u8 (copy), read_string (copy), read_number (copy), is_identifier (copy)
        read_while(is_whitespace);

        if u8.eof() then
            return {
                type = "eof",
                s = "eof"
            };
        end;

        local v30 = u8.peek();

        if v30 == "\"" or v30 == "\'" then
            return read_string();
        end;

        if string.match(v30, "%d") and true or false then
            return read_number();
        end;

        if string.match(v30, "[%a_]") and true or false then
            local v31 = u8.pos();

            return {
                type = "identifier",
                s = read_while(is_identifier),
                from = v31,
                to = u8.pos()
            };
        end;

        if (v30 == "#" or (v30 == "!" or v30 == "*")) and true or v30 == "$" then
            return {
                type = "operator",
                s = u8.next()
            };
        end;

        if string.match(v30, "[%(%);,]") and true or false then
            return {
                type = "symbol",
                s = u8.next()
            };
        end;

        u8.croak((`cannot lex {v30}`));
        error("fail");
    end;

    local u32 = {};

    return {
        peek = function(p33: number?) -- Line: 216, Name: peek
            -- upvalues: u32 (copy), read_next (copy)
            local v34 = p33 or 1;

            while #u32 < v34 do
                table.insert(u32, read_next());
            end;

            return u32[v34];
        end,

        next = function() -- Line: 211, Name: next
            -- upvalues: u32 (copy), read_next (copy)
            local table_remove_ret = table.remove(u32, 1);

            if table_remove_ret == nil then
                return read_next();
            end;

            return table_remove_ret;
        end,

        eof = function() -- Line: 224, Name: eof
            -- upvalues: u32 (copy), read_next (copy)
            while #u32 < 1 do
                table.insert(u32, read_next());
            end;

            local v35;

            if u32[1].type == "eof" then
                v35 = true;
            else
                v35 = false;
            end;

            return v35;
        end,

        croak = u8.croak,
        pos = u8.pos
    };
end;

return function(p36: string) -- Line: 269, Name: parse
    -- upvalues: lex (copy)
    local v37 = lex(p36);
    local v38 = false;
    local v39 = true;
    local v40 = false;
    local v41 = {};
    local v42 = false;
    local v43 = {};

    while true do
        local v44 = v37.peek();

        if v44.type == "eof" then
            break;
        end;

        if v38 or v44.type == "number" then
            if v38 then
                if v44.type ~= "number" then
                    v37.croak("expected number");
                    error("");
                end;
            else
                v37.croak("expected $");
            end;

            local v45 = {
                type = "Component",
                query = v39,
                exclude = v40
            };
            local v46 = {
                type = "Entity"
            };
            local s = v37.next().s;
            v46.entity = tonumber(s);
            v45.value = v46;
            table.insert(v41, v45);
            v39 = not v42 and true or v39;

            if not v42 then
                v40 = false;
            end;

            v38 = false;

            if v37.peek().type ~= "symbol" and v37.peek().type ~= "eof" then
                v37.croak("expected symbol or eof after identifier");
            end;
        elseif v44.type == "operator" then
            if v44.s == "#" then
                if v42 then
                    v37.croak("cannot tag inside relationship");
                end;

                v37.next();
                v39 = false;
            elseif v44.s == "!" then
                if v42 then
                    v37.croak("cannot exclude in relationship");
                end;

                v37.next();
                v39 = false;
                v40 = true;
            elseif v44.s == "$" then
                v37.next();
                v38 = true;
            elseif v44.s == "*" then
                if not v42 then
                    v37.croak("cannot use wildcards outside relationship");
                end;

                table.insert(v41, {
                    type = "Wildcard",
                    name = "*"
                });
                v37.next();
            end;
        elseif v44.type == "symbol" then
            if v44.s == "(" then
                if v42 == true then
                    v37.croak("relationship within relationship");
                end;

                v37.next();
                v42 = true;
            elseif v44.s == ")" then
                if v42 == false then
                    v37.croak("missing (");
                end;

                if #v41 == 2 then
                    local table_remove_ret = table.remove(v41);
                    local table_remove_ret2 = table.remove(v41);

                    if table_remove_ret2.type == "Wildcard" and table_remove_ret.type == "Wildcard" then
                        v37.croak("both components are wildcards");
                    end;

                    v37.next();
                    v39 = true;
                    v40 = false;
                    v41 = {
                        {
                            type = "Relationship",
                            query = v39,
                            exclude = v40,
                            left = table_remove_ret2,
                            right = table_remove_ret
                        }
                    };
                    v42 = false;
                else
                    v37.croak((`expected 2 components, got {#v41}`));
                end;
            elseif v44.s == "," or v44.s == ";" then
                if v42 then
                    v37.next();
                else
                    local table_remove_ret = table.remove(v41);

                    if table_remove_ret == nil then
                        v37.croak("no component provided");
                        error("");
                    end;

                    table.insert(v43, table_remove_ret);
                    v37.next();
                    v39 = true;
                    v40 = false;
                end;
            end;
        elseif v44.type == "identifier" then
            local v47 = {
                type = "Component",
                query = v39,
                exclude = v40,
                value = {
                    type = "Name",
                    name = v37.next().s
                }
            };
            table.insert(v41, v47);
            v39 = not v42 and true or v39;

            if not v42 then
                v40 = false;
            end;

            if v37.peek().type ~= "symbol" and v37.peek().type ~= "eof" then
                v37.croak("expected symbol or eof after identifier");
            end;
        elseif v44.type == "string" then
            local v48 = {
                type = "Component",
                query = v39,
                exclude = v40,
                value = {
                    type = "Name",
                    name = v37.next().s
                }
            };
            table.insert(v41, v48);
            v39 = not v42 and true or v39;

            if not v42 then
                v40 = false;
            end;

            if v37.peek().type ~= "symbol" and v37.peek().type ~= "eof" then
                v37.croak("expected symbol or eof after string");
            end;
        end;
    end;

    local table_remove_ret = table.remove(v41);
    table.insert(v43, table_remove_ret);

    return v43;
end;