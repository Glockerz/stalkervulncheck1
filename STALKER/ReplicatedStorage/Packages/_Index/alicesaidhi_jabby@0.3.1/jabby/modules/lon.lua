-- Decompiled with Potassium's decompiler.

local function stream(u1: string) -- Line: 2
    local u2 = 0;
    local u3 = 1;
    local u4 = 1;

    return {
        peek = function() -- Line: 8, Name: peek
            -- upvalues: u1 (copy), u2 (ref)
            return string.sub(u1, u2 + 1, u2 + 1);
        end,

        next = function() -- Line: 12, Name: next
            -- upvalues: u1 (copy), u2 (ref), u3 (ref), u4 (ref)
            local string_sub_ret = string.sub(u1, u2 + 1, u2 + 1);
            u2 = u2 + 1;

            if string_sub_ret ~= "\n" then
                u4 = u4 + 1;

                return string_sub_ret;
            end;

            u3 = u3 + 1;
            u4 = 1;

            return string_sub_ret;
        end,

        eof = function() -- Line: 22, Name: eof
            -- upvalues: u1 (copy), u2 (ref)
            return string.sub(u1, u2 + 1, u2 + 1) == "";
        end,

        croak = function(p5) -- Line: 34, Name: croak
            -- upvalues: u3 (ref), u4 (ref)
            error(`{p5} ({u3}:{u4})`, 0);
        end,

        pos = function() -- Line: 26, Name: position
            -- upvalues: u2 (ref), u3 (ref), u4 (ref)
            return {
                pos = u2,
                line = u3,
                col = u4
            };
        end
    };
end;

local u6 = ("0123456789"):split("");
local u7 = ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"):split("");
local u8 = ("[]{}(),;.:"):split("");
local u9 = {
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
local u10 = { "true", "false" };

local function lex(p11: string) -- Line: 81
    -- upvalues: stream (copy), u6 (copy), u7 (copy), u8 (copy), u9 (copy), u10 (copy)
    local u12 = stream(p11);

    local function is_whitespace(p13: string) -- Line: 85
        return string.match(p13, "%s") and true or false;
    end;

    local function is_digit(p14: string) -- Line: 89
        -- upvalues: u6 (ref)
        return table.find(u6, p14) and true or false;
    end;

    local function is_identifier(p15: string) -- Line: 93
        -- upvalues: u7 (ref), u6 (ref)
        return table.find(u7, p15) and true or false or (table.find(u6, p15) and true or false);
    end;

    local function is_start_identifier(p16: string) -- Line: 97
        -- upvalues: u7 (ref)
        return table.find(u7, p16) and true or false;
    end;

    local function is_op_char(p17: string) -- Line: 101
        return p17 == "=";
    end;

    local function is_punc(p18: string) -- Line: 105
        -- upvalues: u8 (ref)
        return table.find(u8, p18) and true or false;
    end;

    local function read_while(p19: function) -- Line: 109
        -- upvalues: u12 (copy)
        local v20 = "";

        while u12.eof() == false and p19(u12.peek()) do
            v20 = v20 .. u12.next();
        end;

        return v20;
    end;

    local function skip_comment() -- Line: 117
        -- upvalues: read_while (copy)
        read_while(function(p21) -- Line: 118
            return p21 ~= "\n";
        end);
    end;

    local function skip_whitespace() -- Line: 121
        -- upvalues: read_while (copy), is_whitespace (copy)
        read_while(is_whitespace);
    end;

    local function read_string() -- Line: 125
        -- upvalues: u12 (copy), u9 (ref)
        local v22 = u12.next();
        local v23 = "";
        local v24 = false;

        while u12.eof() == false and (u12.peek() ~= v22 or v24) do
            local v25 = u12.next();
            v24 = v25 == "\\" and true or v24;

            if v24 then
                v23 = v23 .. (u9[v25] or u12.croak((`cannot escape {v25}`)));
                v24 = false;
            else
                v23 = v23 .. v25;
            end;
        end;

        if u12.peek() ~= v22 then
            u12.croak("unterminated string");
        end;

        u12.next();

        return {
            type = "string",
            s = v23
        };
    end;

    local function read_number() -- Line: 152
        -- upvalues: u12 (copy), read_while (copy), u6 (ref)
        local v26;

        if u12.peek() == "-" then
            u12.next();
            v26 = -1;
        else
            v26 = 1;
        end;

        local v28 = read_while(function(p27) -- Line: 156
            -- upvalues: u6 (ref)
            return table.find(u6, p27) and true or false or (p27 == "." and true or p27 == "e");
        end);
        local v29 = tonumber(v28);

        if not v29 then
            u12.croak((`could not read {v28} as number`));
        end;

        return {
            type = "number",
            s = assert(v29) * v26
        };
    end;

    local function read_identifier() -- Line: 169
        -- upvalues: read_while (copy), is_identifier (copy), u10 (ref)
        local v30 = read_while(is_identifier);

        return table.find(u10, v30) and {
            type = "keyword",
            s = v30
        } or {
            type = "identifier",
            s = v30
        };
    end;

    local function read_next() -- Line: 179
        -- upvalues: read_while (copy), is_whitespace (copy), u12 (copy), read_next (copy), read_string (copy), u6 (ref), read_number (copy), u7 (ref), read_identifier (copy), u8 (ref)
        read_while(is_whitespace);
        local v31 = u12.peek();

        if v31 == "#" then
            read_while(function(p32) -- Line: 118
                return p32 ~= "\n";
            end);

            return read_next();
        end;

        if v31 == "\"" or v31 == "\'" then
            return read_string();
        end;

        if table.find(u6, v31) and true or false then
            return read_number();
        end;

        if table.find(u7, v31) and true or false then
            return read_identifier();
        end;

        if v31 == "=" then
            return {
                type = "operator",
                s = u12.next()
            };
        end;

        if table.find(u8, v31) and true or false then
            return {
                type = "symbol",
                s = u12.next()
            };
        end;

        if v31 == "-" then
            return read_number();
        end;

        u12.croak((`cannot lex "{v31}" {string.byte(v31)}`));
        error("fail");
    end;

    local u33 = {};

    return {
        peek = function(p34: number?) -- Line: 209, Name: peek
            -- upvalues: u33 (copy), read_next (copy)
            local v35 = p34 or 1;

            while #u33 < v35 do
                table.insert(u33, read_next());
            end;

            return u33[v35];
        end,

        next = function() -- Line: 202, Name: next
            -- upvalues: u33 (copy), read_next (copy), read_while (copy), is_whitespace (copy)
            local table_remove_ret = table.remove(u33, 1);

            if table_remove_ret == nil then
                table_remove_ret = read_next();
            end;

            read_while(is_whitespace);

            return table_remove_ret;
        end,

        eof = u12.eof,
        croak = u12.croak,
        pos = u12.pos
    };
end;

local u36 = {};
local u39 = {
    Vector3 = Vector3,
    CFrame = CFrame,
    Vector2 = Vector2,
    Color3 = Color3,
    BrickColor = BrickColor,
    Enum = Enum,
    NumberSequence = NumberSequence,
    NumberSequenceKeypoint = NumberSequenceKeypoint,
    NumberRange = NumberRange,
    ColorSequence = ColorSequence,
    ColorSequenceKeypoint = ColorSequenceKeypoint,
    Region3 = Region3,
    Rect = Rect,

    OverlapParams = function(p37) -- Line: 573, Name: OverlapParams
        local OverlapParams_new_ret = OverlapParams.new();

        for i, v in p37 do
            OverlapParams_new_ret[i] = v;
        end;

        return OverlapParams_new_ret;
    end,

    RaycastParams = function(p38) -- Line: 580, Name: RaycastParams
        local RaycastParams_new_ret = RaycastParams.new();

        for i, v in p38 do
            RaycastParams_new_ret[i] = v;
        end;

        return RaycastParams_new_ret;
    end,

    game = game,
    workspace = workspace
};

local function compile(p40: table) -- Line: 593
    -- upvalues: u39 (copy), compile (copy), u36 (copy)
    if p40.type == "number" then
        return p40.value;
    end;

    if p40.type == "string" then
        return p40.value;
    end;

    if p40.type == "boolean" then
        return p40.value;
    end;

    if p40.type == "variable" then
        return u39[p40.value];
    end;

    if p40.type == "index" then
        return compile(p40.value)[compile(p40.key)];
    end;

    if p40.type == "functioncall" then
        for i = 1, #p40.args do
            u36[i] = compile(p40.args[i]);
            local _ = i;
        end;

        return compile(p40.value)(unpack(u36, 1, #p40.args));
    end;

    if p40.type == "methodcall" then
        for i = 1, #p40.args do
            u36[i] = compile(p40.args[i]);
            local _ = i;
        end;

        local v41 = compile(p40.value);

        return v41(v41, unpack(u36, 1, #p40.args));
    end;

    if p40.type ~= "table" then
        if p40.type == "assign" then
            error("bad ast, you cannot generate this");
        end;

        return nil;
    end;

    local v42 = 0;
    local v43 = {};

    for _, v in p40.value do
        if v.type == "assign" then
            v43[compile(v.key)] = compile(v.value);
        else
            v43[v42 + 1] = compile(v);
            v42 = v42 + 1;
        end;
    end;

    return v43;
end;

local buffer_create_ret = buffer.create(1024);
local u44 = 0;
local u45 = 0;
local u46 = true;
local u47 = 0;
local buffer_create_ret2 = buffer.create(1024);
local u48 = {};

local function prealloc(p49: number) -- Line: 650
    -- upvalues: buffer_create_ret (ref), u44 (ref)
    local buffer_len_ret = buffer.len(buffer_create_ret);

    if buffer_len_ret <= u44 + p49 then
        local v50 = buffer_len_ret + buffer_len_ret / 2;

        while v50 <= u44 + p49 do
            v50 = v50 + v50 / 2;
        end;

        local buffer_create_ret3 = buffer.create(v50);
        buffer.copy(buffer_create_ret3, 0, buffer_create_ret, 0, u44);
        buffer_create_ret = buffer_create_ret3;
    end;
end;

local function write_str(p51: string) -- Line: 665
    -- upvalues: buffer_create_ret (ref), u44 (ref), u47 (ref)
    local buffer_len_ret = buffer.len(buffer_create_ret);

    if buffer_len_ret <= u44 + #p51 then
        local v52 = buffer_len_ret + buffer_len_ret / 2;

        while v52 <= u44 + #p51 do
            v52 = v52 + v52 / 2;
        end;

        local buffer_create_ret3 = buffer.create(v52);
        buffer.copy(buffer_create_ret3, 0, buffer_create_ret, 0, u44);
        buffer_create_ret = buffer_create_ret3;
    end;

    buffer.writestring(buffer_create_ret, u44, p51, #p51);
    u44 = u44 + #p51;
    u47 = u47 + #p51;
end;

local function write_low_prec_float(p53: number) -- Line: 684
    -- upvalues: write_str (copy), u47 (ref)
    local string_format_ret = string.format("%.7g", p53);
    write_str(string_format_ret);
    u47 = u47 + #string_format_ret;
end;

local function char(p54: string) -- Line: 690
    return string.byte(p54);
end;

local function write_char(p55: number) -- Line: 694
    -- upvalues: buffer_create_ret (ref), u44 (ref), u47 (ref)
    local buffer_len_ret = buffer.len(buffer_create_ret);

    if buffer_len_ret <= u44 + 1 then
        local v56 = buffer_len_ret + buffer_len_ret / 2;

        while v56 <= u44 + 1 do
            v56 = v56 + v56 / 2;
        end;

        local buffer_create_ret3 = buffer.create(v56);
        buffer.copy(buffer_create_ret3, 0, buffer_create_ret, 0, u44);
        buffer_create_ret = buffer_create_ret3;
    end;

    buffer.writeu8(buffer_create_ret, u44, p55);
    u47 = u47 + 1;
    u44 = u44 + 1;
end;

local function display_string(p57: string) -- Line: 715
    -- upvalues: prealloc (copy), write_str (copy)
    local string_format_ret = string.format("%q", p57);
    prealloc(#string_format_ret);
    write_str(string_format_ret);
end;

local function write_line() -- Line: 721
    -- upvalues: u46 (ref), write_char (copy), write_str (copy), u45 (ref)
    if not u46 then
        write_char(32);

        return;
    end;

    write_char(10);
    write_str(string.rep("\t", u45));
end;

local u58 = nil;
local u59 = false;

local function to_path(p60: boolean, ...) -- Line: 733
    -- upvalues: u59 (ref), u44 (ref), u45 (ref), buffer_create_ret (ref), buffer_create_ret2 (copy), u58 (ref)
    local v61 = u59;
    u59 = true;

    if p60 then
        local v62 = {};
        local v63 = select("#", ...);
        local v64 = u44;
        local v65 = u45;
        local v66 = buffer_create_ret;
        buffer_create_ret = buffer_create_ret2;

        for i = v63, 2, -1 do
            u44 = 0;
            u45 = 0;
            u58(select(i, ...));
            v62[v63 - i] = buffer.readstring(buffer_create_ret2, 0, u44);
            local _ = i;
        end;

        u44 = v64;
        u45 = v65;
        buffer_create_ret = v66;
        u59 = v61;

        return `new({table.concat(v62, ", ")})`;
    end;

    local v67 = {};
    local v68 = select("#", ...);
    local v69 = u44;
    local v70 = u45;
    local v71 = buffer_create_ret;
    buffer_create_ret = buffer_create_ret2;

    for i = v68, 1, -1 do
        u44 = 0;
        u45 = 0;
        u58(select(i, ...));
        v67[v68 - i + 1] = `[{buffer.readstring(buffer_create_ret2, 0, u44)}]`;
        local _ = i;
    end;

    u44 = v69;
    u45 = v70;
    buffer_create_ret = v71;
    table.insert(v67, 1, "old");
    u59 = v61;

    return table.concat(v67);
end;

u58 = function(p72, ...) -- Line: 790, Name: display
    -- upvalues: u44 (ref), write_str (copy), prealloc (copy), u48 (copy), u45 (ref), write_char (copy), u46 (ref), u59 (ref), u58 (ref), to_path (copy), u47 (ref)
    if u44 > 8192 then
        return;
    end;

    if type(p72) == "number" then
        write_str((tostring(p72)));

        return;
    end;

    if type(p72) == "string" then
        local string_format_ret = string.format("%q", p72);
        prealloc(#string_format_ret);
        write_str(string_format_ret);

        return;
    end;

    if type(p72) == "boolean" then
        if p72 == true then
            write_str("true");

            return;
        end;

        write_str("false");

        return;
    end;

    if type(p72) == "table" and not u48[p72] then
        u48[p72] = true;
        u45 = u45 + 1;
        write_char(123);

        for i, v in p72 do
            if u46 then
                write_char(10);
                write_str(string.rep("\t", u45));
            else
                write_char(32);
            end;

            if type(i) == "string" and string.match(i, "^[a-zA-Z_][a-zA-Z0-9_]*$") then
                write_str(i);
            else
                write_char(91);
                local v73 = u59;
                u59 = true;
                u58(i);
                u59 = v73;
                write_char(93);
            end;

            write_char(32);
            write_char(61);
            write_char(32);
            u58(v, i, ...);
            write_char(44);
        end;

        u45 = u45 - 1;

        if u46 then
            write_char(10);
            write_str(string.rep("\t", u45));
        else
            write_char(32);
        end;

        write_char(125);

        return;
    end;

    if type(p72) == "table" and u48[p72] then
        if u59 then
            write_str("*cannot display table due to cyclic dependency*");

            return;
        end;

        write_str(to_path(true, ...));

        return;
    end;

    if type(p72) == "nil" then
        write_str("nil");

        return;
    end;

    if typeof(p72) == "BrickColor" then
        write_str("BrickColor.new(");
        write_str(p72.Name);
        write_char(41);

        return;
    end;

    if typeof(p72) == "CFrame" then
        if p72.Rotation == CFrame.new() then
            write_str("CFrame.new(");
            u58(p72.X);
            write_str(", ");
            u58(p72.Y);
            write_str(", ");
            u58(p72.Z);
            write_char(41);

            return;
        end;

        write_str("CFrame.fromMatrix(");
        u58(p72.Position);
        write_str(",\n");
        u58(p72.XVector);
        write_str(",\n");
        u58(p72.YVector);
        write_str(",\n");
        u58(p72.ZVector);
        write_str(",\n");

        return;
    end;

    if typeof(p72) == "EnumItem" then
        write_str((tostring(p72)));

        return;
    end;

    if typeof(p72) == "Enum" then
        write_str("Enum.");
        write_str((tostring(p72)));

        return;
    end;

    if typeof(p72) == "Enums" then
        write_str("Enum");

        return;
    end;

    if typeof(p72) == "Color3" then
        write_str("Color3.fromHex(");
        local v74 = p72:ToHex();
        local string_format_ret = string.format("%q", v74);
        prealloc(#string_format_ret);
        write_str(string_format_ret);
        write_char(41);

        return;
    end;

    if typeof(p72) == "Vector3" then
        write_str("Vector3.new(");
        write_str((tostring(p72)));
        write_char(41);

        return;
    end;

    if typeof(p72) == "Vector2" then
        write_str("Vector2.new(");
        write_str((tostring(p72)));
        write_char(41);

        return;
    end;

    if typeof(p72) == "NumberSequence" then
        write_str("NumberSequence.new(");

        if #p72.Keypoints == 2 then
            local string_format_ret = string.format("%.7g", p72.Keypoints[1].Value);
            write_str(string_format_ret);
            u47 = u47 + #string_format_ret;
            write_str(", ");
            local string_format_ret2 = string.format("%.7g", p72.Keypoints[2].Value);
            write_str(string_format_ret2);
            u47 = u47 + #string_format_ret2;
        else
            u58(p72.Keypoints);
        end;

        write_char(41);

        return;
    end;

    if typeof(p72) == "NumberSequenceKeypoint" then
        write_str("NumberSequenceKeypoint.new(");
        local string_format_ret = string.format("%.7g", p72.Time);
        write_str(string_format_ret);
        u47 = u47 + #string_format_ret;
        write_str(", ");
        local string_format_ret2 = string.format("%.7g", p72.Value);
        write_str(string_format_ret2);
        u47 = u47 + #string_format_ret2;

        if p72.Envelope > 0 then
            write_str(", ");
            local string_format_ret3 = string.format("%.7g", p72.Envelope);
            write_str(string_format_ret3);
            u47 = u47 + #string_format_ret3;
        end;

        write_char(41);

        return;
    end;

    if typeof(p72) == "NumberRange" then
        write_str("NumberRange.new(");
        local string_format_ret = string.format("%.7g", p72.Min);
        write_str(string_format_ret);
        u47 = u47 + #string_format_ret;

        if p72.Min ~= p72.Max then
            write_str(", ");
            local string_format_ret2 = string.format("%.7g", p72.Max);
            write_str(string_format_ret2);
            u47 = u47 + #string_format_ret2;
        end;

        write_char(41);

        return;
    end;

    if typeof(p72) == "ColorSequence" then
        write_str("ColorSequence.new(");

        if #p72.Keypoints == 2 then
            u58(p72.Keypoints[1].Value);
            write_str(", ");
            u58(p72.Keypoints[2].Value);
        else
            u58(p72.Keypoints);
        end;

        write_char(41);

        return;
    end;

    if typeof(p72) == "ColorSequenceKeypoint" then
        write_str("ColorSequenceKeypoint.new(");
        local string_format_ret = string.format("%.7g", p72.Time);
        write_str(string_format_ret);
        u47 = u47 + #string_format_ret;
        write_str(", ");
        u58(p72.Value);
        write_char(41);

        return;
    end;

    if typeof(p72) == "RaycastResult" then
        u58({
            Instance = p72.Instance,
            Material = p72.Material,
            Normal = p72.Normal,
            Position = p72.Position,
            Distance = p72.Distance
        });

        return;
    end;

    if typeof(p72) == "Region3" then
        local Position = p72.CFrame.Position;
        local Size = p72.Size;
        write_str("Region3.new(");
        u58(Position - Size / 2);
        write_str(", ");
        u58(Position + Size / 2);
        write_char(41);

        return;
    end;

    if typeof(p72) ~= "Rect" then
        if typeof(p72) == "OverlapParams" then
            write_str("OverlapParams(");
            u58({
                CollisionGroup = p72.CollisionGroup,
                FilterType = p72.FilterType,
                MaxParts = p72.MaxParts,
                RespectCanCollide = p72.RespectCanCollide
            });
            write_char(41);

            return;
        end;

        if typeof(p72) == "RaycastParams" then
            write_str("RaycastParams(");
            u58({
                CollisionGroup = p72.CollisionGroup,
                FilterType = p72.FilterType,
                RespectCanCollide = p72.RespectCanCollide
            });
            write_char(41);

            return;
        end;

        if typeof(p72) == "Instance" and not u59 then
            write_str(to_path(false, ...));

            return;
        end;

        if typeof(p72) == "Instance" and u59 then
            write_str(p72:GetFullName());

            return;
        end;

        write_str(to_path(false, ...));

        return;
    end;

    write_str("Rect.new(");
    local string_format_ret = string.format("%.7g", p72.Min.X);
    write_str(string_format_ret);
    u47 = u47 + #string_format_ret;
    write_str(", ");
    local string_format_ret2 = string.format("%.7g", p72.Min.Y);
    write_str(string_format_ret2);
    u47 = u47 + #string_format_ret2;
    write_str(", ");
    local string_format_ret3 = string.format("%.7g", p72.Max.X);
    write_str(string_format_ret3);
    u47 = u47 + #string_format_ret3;
    write_str(", ");
    local string_format_ret4 = string.format("%.7g", p72.Max.Y);
    write_str(string_format_ret4);
    u47 = u47 + #string_format_ret4;
    write_char(41);
end;

return {
    parse = function(p75: string) -- Line: 299, Name: parse
        -- upvalues: lex (copy)
        local u76 = lex(p75);
        local u77 = nil;

        local function set_node(p78: table) -- Line: 305
            -- upvalues: u77 (ref)
            u77 = p78;
        end;

        local function pop_node() -- Line: 309
            -- upvalues: u77 (ref), u76 (copy)
            local v79 = u77;
            u77 = nil;

            if v79 == nil then
                u76.croak("no available node");
                error("");
            end;

            return v79;
        end;

        local function is_symbol(p80: string) -- Line: 319
            -- upvalues: u76 (copy)
            local v81 = u76.peek();
            local v82;

            if v81.type == "symbol" then
                v82 = v81.s == p80;
            else
                v82 = false;
            end;

            return v82;
        end;

        local function is_op(p83: string) -- Line: 324
            -- upvalues: u76 (copy)
            local v84 = u76.peek();
            local v85;

            if v84.type == "operator" then
                v85 = v84.s == p83;
            else
                v85 = false;
            end;

            return v85;
        end;

        local function is_keyword(p86: string) -- Line: 329
            -- upvalues: u76 (copy)
            local v87 = u76.peek();
            local v88;

            if v87.type == "keyword" then
                v88 = v87.s == p86;
            else
                v88 = false;
            end;

            return v88;
        end;

        local function skip_symbol(p89) -- Line: 334
            -- upvalues: u76 (copy)
            local v90 = u76.peek();
            local v91;

            if v90.type == "symbol" then
                v91 = v90.s == p89;
            else
                v91 = false;
            end;

            if v91 then
                u76.next();

                return;
            end;

            u76.croak((`expecting symbol: "{p89}" got "{u76.peek(1).s}"`));
            error("");
        end;

        local function skip_operator(p92) -- Line: 343
            -- upvalues: u76 (copy)
            local v93 = u76.peek();
            local v94;

            if v93.type == "operator" then
                v94 = v93.s == p92;
            else
                v94 = false;
            end;

            if v94 then
                u76.next();

                return;
            end;

            u76.croak((`expecting op: "{p92}" got "{u76.peek().s}"`));
            error("");
        end;

        local function delimited(p95: any, p96: any, p97: any, p98: function) -- Line: 352
            -- upvalues: skip_symbol (copy), u76 (copy), u77 (ref)
            skip_symbol(p95);
            local v99 = {};
            local v100 = true;

            while not u76.eof() do
                local v101 = u76.peek();
                local v102;

                if v101.type == "symbol" then
                    v102 = v101.s == p96;
                else
                    v102 = false;
                end;

                if v102 then
                    break;
                end;

                if v100 then
                    v100 = false;
                elseif typeof(p97) == "string" then
                    skip_symbol(p97);
                elseif typeof(p97) == "function" then
                    p97();
                end;

                local v103 = u76.peek();
                local v104;

                if v103.type == "symbol" then
                    v104 = v103.s == p96;
                else
                    v104 = false;
                end;

                if v104 then
                    break;
                end;

                p98();
                local v105 = u77;
                u77 = nil;

                if v105 == nil then
                    u76.croak("no available node");
                    error("");
                end;

                table.insert(v99, v105);
            end;

            skip_symbol(p96);

            return v99;
        end;

        local u106 = nil;
        local u107 = nil;

        local function parse_table() -- Line: 380
            -- upvalues: delimited (copy), u76 (copy), skip_symbol (copy), u107 (ref), u77 (ref), u106 (ref)
            u77 = {
                type = "table",
                value = delimited("{", "}", ",", function() -- Line: 381
                    -- upvalues: u76 (ref), skip_symbol (ref), u107 (ref), u77 (ref), u106 (ref)
                    local v108 = u76.peek();
                    local v109;

                    if v108.type == "symbol" then
                        v109 = v108.s == "[";
                    else
                        v109 = false;
                    end;

                    if not v109 then
                        if u76.peek(2).type ~= "operator" or u76.peek(2).s ~= "=" then
                            u107();

                            return;
                        end;

                        u106("string");
                        local v110 = u77;
                        u77 = nil;

                        if v110 == nil then
                            u76.croak("no available node");
                            error("");
                        end;

                        local v111 = u76.peek();
                        local v112;

                        if v111.type == "operator" then
                            v112 = v111.s == "=";
                        else
                            v112 = false;
                        end;

                        if v112 then
                            u76.next();
                        else
                            u76.croak((`expecting op: "=" got "{u76.peek().s}"`));
                            error("");
                        end;

                        u107();
                        local v113 = u77;
                        u77 = nil;

                        if v113 == nil then
                            u76.croak("no available node");
                            error("");
                        end;

                        u77 = {
                            type = "assign",
                            key = v110,
                            value = v113
                        };

                        return;
                    end;

                    skip_symbol("[");
                    u107();
                    skip_symbol("]");
                    local v114 = u77;
                    u77 = nil;

                    if v114 == nil then
                        u76.croak("no available node");
                        error("");
                    end;

                    local v115 = u76.peek();
                    local v116;

                    if v115.type == "operator" then
                        v116 = v115.s == "=";
                    else
                        v116 = false;
                    end;

                    if v116 then
                        u76.next();
                    else
                        u76.croak((`expecting op: "=" got "{u76.peek().s}"`));
                        error("");
                    end;

                    u107();
                    local v117 = u77;
                    u77 = nil;

                    if v117 == nil then
                        u76.croak("no available node");
                        error("");
                    end;

                    u77 = {
                        type = "assign",
                        key = v114,
                        value = v117
                    };
                end)
            };
        end;

        local function parse_functioncall(p118: boolean) -- Line: 431
            -- upvalues: u77 (ref), u76 (copy), delimited (copy), u107 (ref)
            local v119 = u77;
            u77 = nil;

            if v119 == nil then
                u76.croak("no available node");
                error("");
            end;

            u77 = {
                type = p118 and "methodcall" or "functioncall",
                value = v119,
                args = delimited("(", ")", ",", function() -- Line: 433
                    -- upvalues: u107 (ref)
                    u107();
                end)
            };
        end;

        local function parse_index() -- Line: 444
            -- upvalues: u76 (copy), u77 (ref), skip_symbol (copy), u106 (ref), u107 (ref), parse_functioncall (ref)
            local v120 = u76.peek();
            local v121;

            if v120.type == "symbol" then
                v121 = v120.s == ".";
            else
                v121 = false;
            end;

            if v121 then
                local v122 = u77;
                u77 = nil;

                if v122 == nil then
                    u76.croak("no available node");
                    error("");
                end;

                skip_symbol(".");
                u106("string");
                local v123 = u77;
                u77 = nil;

                if v123 == nil then
                    u76.croak("no available node");
                    error("");
                end;

                u77 = {
                    type = "index",
                    value = v122,
                    key = v123
                };

                return;
            end;

            local v124 = u76.peek();
            local v125;

            if v124.type == "symbol" then
                v125 = v124.s == "[";
            else
                v125 = false;
            end;

            if v125 then
                local v126 = u77;
                u77 = nil;

                if v126 == nil then
                    u76.croak("no available node");
                    error("");
                end;

                skip_symbol("[");
                u107();
                skip_symbol("]");
                local v127 = u77;
                u77 = nil;

                if v127 == nil then
                    u76.croak("no available node");
                    error("");
                end;

                u77 = {
                    type = "index",
                    value = v126,
                    key = v127
                };

                return;
            end;

            local v128 = u76.peek();
            local v129;

            if v128.type == "symbol" then
                v129 = v128.s == ":";
            else
                v129 = false;
            end;

            if not v129 then
                u76.croak((`expected index or function call, got {u76.peek().s}`));

                return;
            end;

            local v130 = u77;
            u77 = nil;

            if v130 == nil then
                u76.croak("no available node");
                error("");
            end;

            skip_symbol(":");
            u106("string");
            local v131 = u77;
            u77 = nil;

            if v131 == nil then
                u76.croak("no available node");
                error("");
            end;

            u77 = {
                type = "index",
                value = v130,
                key = v131
            };
            parse_functioncall(true);
        end;

        u106 = function(p132: string) -- Line: 492, Name: parse_identifier
            -- upvalues: u76 (copy), u77 (ref)
            local v133 = u76.next();

            if v133 == nil then
                u76.croak("expected identifier, got eof");
                error("");
            end;

            if v133.type == "identifier" then
                u77 = {
                    type = p132,
                    value = v133.s
                };

                return;
            end;

            u76.croak((`expected identifier, got {v133.type}`));
        end;

        u107 = function() -- Line: 506, Name: parse_expression
            -- upvalues: u76 (copy), u106 (ref), parse_functioncall (ref), parse_index (ref), u77 (ref), parse_table (ref)
            local v134 = u76.peek();

            if v134.type == "identifier" then
                u106("variable");

                while u76.eof() == false do
                    local v135 = u76.peek();
                    local v136;

                    if v135.type == "symbol" then
                        v136 = v135.s == ".";
                    else
                        v136 = false;
                    end;

                    if not v136 then
                        local v137 = u76.peek();
                        local v138;

                        if v137.type == "symbol" then
                            v138 = v137.s == "[";
                        else
                            v138 = false;
                        end;

                        if not v138 then
                            local v139 = u76.peek();
                            local v140;

                            if v139.type == "symbol" then
                                v140 = v139.s == "(";
                            else
                                v140 = false;
                            end;

                            if not v140 then
                                local v141 = u76.peek();
                                local v142;

                                if v141.type == "symbol" then
                                    v142 = v141.s == ":";
                                else
                                    v142 = false;
                                end;

                                if not v142 then
                                    break;
                                end;
                            end;
                        end;
                    end;

                    if u76.eof() then
                        break;
                    end;

                    local v143 = u76.peek();
                    local v144;

                    if v143.type == "symbol" then
                        v144 = v143.s == "(";
                    else
                        v144 = false;
                    end;

                    if v144 then
                        parse_functioncall(false);
                    else
                        parse_index();
                    end;

                    if u76.eof() then
                        break;
                    end;
                end;
            else
                if v134.type == "string" then
                    u77 = {
                        type = "string",
                        value = assert(u76.next()).s
                    };

                    return;
                end;

                if v134.type == "number" then
                    u77 = {
                        type = "number",
                        value = assert(u76.next()).s
                    };

                    return;
                end;

                local v145 = u76.peek();
                local v146;

                if v145.type == "keyword" then
                    v146 = v145.s == "true";
                else
                    v146 = false;
                end;

                if v146 then
                    u77 = {
                        type = "boolean",
                        value = true
                    };
                    u76.next();

                    return;
                end;

                local v147 = u76.peek();
                local v148;

                if v147.type == "keyword" then
                    v148 = v147.s == "false";
                else
                    v148 = false;
                end;

                if v148 then
                    u77 = {
                        type = "boolean",
                        value = false
                    };
                    u76.next();

                    return;
                end;

                local v149 = u76.peek();
                local v150;

                if v149.type == "symbol" then
                    v150 = v149.s == "{";
                else
                    v150 = false;
                end;

                if v150 then
                    parse_table();

                    return;
                end;

                u76.croak((`expected expression, got {v134.type}" "{v134.s}"`));
            end;
        end;

        u107();
        local v151 = u77;
        u77 = nil;

        if v151 == nil then
            u76.croak("no available node");
            error("");
        end;

        return v151;
    end,

    compile = function(p152: table, p153: table) -- Line: 999, Name: compile
        -- upvalues: u39 (copy), compile (copy)
        setmetatable(u39, {
            __index = p153 or nil
        });
        local u154 = {
            symbol = "new"
        };
        local u155 = false;

        function u39.new(...) -- Line: 1004
            -- upvalues: u155 (ref), u154 (copy)
            u155 = true;

            return setmetatable({
                we_left_something = true,
                ...
            }, u154);
        end;

        local u156 = compile(p152);

        local function find(p157: table) -- Line: 1012
            -- upvalues: u156 (copy)
            local v158 = u156;

            for _, v in ipairs(p157) do
                v158 = v158[v];

                if v158 == nil then
                    return nil;
                end;
            end;

            return v158;
        end;

        local u159 = {};

        local function recurse(p160) -- Line: 1023
            -- upvalues: u154 (copy), u156 (copy), u159 (copy), recurse (copy)
            for i, v in pairs(p160) do
                if typeof(v) == "table" and getmetatable(v) == u154 then
                    local v161 = u156;

                    for _, v2 in ipairs(v) do
                        v161 = v161[v2];

                        if v161 == nil then
                            v161 = nil;
                            break;
                        end;
                    end;

                    p160[i] = v161;
                elseif typeof(v) ~= "table" or not u159[v] then
                    if typeof(v) == "table" then
                        u159[v] = true;
                        recurse(v);
                    end;
                end;
            end;
        end;

        if u155 and typeof(u156) == "table" then
            recurse(u156);
        end;

        return u156;
    end,

    output = function(p162: any, p163: boolean?, p164: boolean?) -- Line: 982
        -- upvalues: u46 (ref), u44 (ref), u45 (ref), u48 (copy), u59 (ref), u58 (ref), buffer_create_ret (ref)
        u46 = p163 == nil and true or p163;
        u44 = 0;
        u45 = 0;
        table.clear(u48);

        if p164 then
            u59 = true;
        end;

        u58(p162);
        u59 = false;

        return buffer.readstring(buffer_create_ret, 0, u44);
    end
};