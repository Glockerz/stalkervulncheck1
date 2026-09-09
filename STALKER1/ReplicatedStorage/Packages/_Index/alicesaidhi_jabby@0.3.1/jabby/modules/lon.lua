-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function stream(p1) --[[ stream | Line: 2 ]]
	local v1 = 0
	local v2 = 1
	local v3 = 1

	local function peek() --[[ peek | Line: 8 | Upvalues: p1 (copy), v1 (ref) ]]
		return string.sub(p1, v1 + 1, v1 + 1)
	end

	local function v() --[[ next | Line: 12 | Upvalues: p1 (copy), v1 (ref), v2 (ref), v3 (ref) ]]
		local v4 = string.sub(p1, v1 + 1, v1 + 1)

		v1 = v1 + 1

		if v4 == "\n" then
			v2 = v2 + 1
			v3 = 1
		else
			v3 = v3 + 1
		end

		return v4
	end

	local function eof() --[[ eof | Line: 22 | Upvalues: p1 (copy), v1 (ref) ]]
		return string.sub(p1, v1 + 1, v1 + 1) == ""
	end

	local function position() --[[ position | Line: 26 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
		return {
			pos = v1,
			line = v2,
			col = v3
		}
	end

	return {
		peek = peek,
		next = v,
		eof = eof,
		croak = function(p1) --[[ croak | Line: 34 | Upvalues: v2 (ref), v3 (ref) ]]
			error(("%* (%*:%*)"):format(p1, v2, v3), 0)
		end,
		pos = position
	}
end

local v1 = ("0123456789"):split("")
local v2 = ("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ_"):split("")
local v3 = ("[]{}(),;.:"):split("")
local t = {
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
}
local t2 = { "true", "false" }

local function lex(p1) --[[ lex | Line: 81 | Upvalues: stream (copy), v1 (copy), v2 (copy), v3 (copy), t (copy), t2 (copy) ]]
	local v12 = stream(p1)

	local function is_whitespace(p1) --[[ is_whitespace | Line: 85 ]]
		return string.match(p1, "%s") and true or false
	end

	local function is_digit(p1) --[[ is_digit | Line: 89 | Upvalues: v1 (ref) ]]
		return table.find(v1, p1) and true or false
	end

	local function is_identifier(p1) --[[ is_identifier | Line: 93 | Upvalues: v2 (ref), v1 (ref) ]]
		return table.find(v2, p1) and true or false or (table.find(v1, p1) and true or false)
	end

	local function is_start_identifier(p1) --[[ is_start_identifier | Line: 97 | Upvalues: v2 (ref) ]]
		return table.find(v2, p1) and true or false
	end

	local function is_op_char(p1) --[[ is_op_char | Line: 101 ]]
		return p1 == "="
	end

	local function is_punc(p1) --[[ is_punc | Line: 105 | Upvalues: v3 (ref) ]]
		return table.find(v3, p1) and true or false
	end

	local function read_while(p1) --[[ read_while | Line: 109 | Upvalues: v12 (copy) ]]
		local v1 = ""

		while v12.eof() == false and p1(v12.peek()) do
			v1 = v1 .. v12.next()
		end

		return v1
	end

	local function skip_comment() --[[ skip_comment | Line: 117 | Upvalues: read_while (copy) ]]
		read_while(function(p13) --[[ Line: 118 ]]
			return p13 ~= "\n"
		end)
	end

	local function skip_whitespace() --[[ skip_whitespace | Line: 121 | Upvalues: read_while (copy), is_whitespace (copy) ]]
		read_while(is_whitespace)
	end

	local function read_string() --[[ read_string | Line: 125 | Upvalues: v12 (copy), t (ref) ]]
		local v1 = v12.next()
		local v2 = false
		local v3 = ""

		while v12.eof() == false and (v12.peek() ~= v1 or v2) do
			local v4 = v12.next()

			if v4 == "\\" then
				v2 = true
			end

			if v2 then
				v2 = false
				v3 = v3 .. (t[v4] or v12.croak((("cannot escape %*"):format(v4))))
			else
				v3 = v3 .. v4
			end
		end

		if v12.peek() == v1 then
			v12.next()

			return {
				type = "string",
				s = v3
			}
		end

		v12.croak("unterminated string")
		v12.next()

		return {
			type = "string",
			s = v3
		}
	end

	local function read_number() --[[ read_number | Line: 152 | Upvalues: v12 (copy), read_while (copy), v1 (ref) ]]
		local v13

		if v12.peek() == "-" then
			v12.next()
			v13 = -1
		else
			v13 = 1
		end

		local v2 = read_while(function(p1) --[[ Line: 156 | Upvalues: v1 (ref) ]]
			return table.find(v1, p1) and true or false or (if p1 == "." then true else p1 == "e")
		end)
		local v3 = tonumber(v2)

		if v3 then
			return {
				type = "number",
				s = assert(v3) * v13
			}
		end

		v12.croak((("could not read %* as number"):format(v2)))

		return {
			type = "number",
			s = assert(v3) * v13
		}
	end

	local function read_identifier() --[[ read_identifier | Line: 169 | Upvalues: read_while (copy), is_identifier (copy), t2 (ref) ]]
		local v1 = read_while(is_identifier)

		if table.find(t2, v1) then
			return {
				type = "keyword",
				s = v1
			}
		end

		return {
			type = "identifier",
			s = v1
		}
	end

	local function v22() --[[ read_next | Line: 179 | Upvalues: read_while (copy), is_whitespace (copy), v12 (copy), v22 (copy), read_string (copy), v1 (ref), read_number (copy), v2 (ref), read_identifier (copy), v3 (ref) ]]
		read_while(is_whitespace)

		local v13 = v12.peek()

		if v13 == "#" then
			read_while(function(p13) --[[ Line: 118 ]]
				return p13 ~= "\n"
			end)

			return v22()
		end

		if v13 == "\"" or v13 == "\'" then
			return read_string()
		end

		if table.find(v1, v13) then
			return read_number()
		end

		if table.find(v2, v13) then
			return read_identifier()
		end

		if v13 == "=" then
			return {
				type = "operator",
				s = v12.next()
			}
		end

		if table.find(v3, v13) then
			return {
				type = "symbol",
				s = v12.next()
			}
		end

		if v13 == "-" then
			return read_number()
		end

		v12.croak((("cannot lex \"%*\" %*"):format(v13, (string.byte(v13)))))
		error("fail")
	end

	local t3 = {}

	local function v() --[[ next | Line: 202 | Upvalues: t3 (copy), v22 (copy), read_while (copy), is_whitespace (copy) ]]
		local v1 = table.remove(t3, 1)

		if v1 == nil then
			v1 = v22()
		end

		read_while(is_whitespace)

		return v1
	end

	return {
		peek = function(p1) --[[ peek | Line: 209 | Upvalues: t3 (copy), v22 (copy) ]]
			local v1 = p1 or 1

			while #t3 < v1 do
				table.insert(t3, v22())
			end

			return t3[v1]
		end,
		next = v,
		eof = v12.eof,
		croak = v12.croak,
		pos = v12.pos
	}
end

local function parse(p1) --[[ parse | Line: 299 | Upvalues: lex (copy) ]]
	local v1 = lex(p1)
	local v2 = nil

	local function set_node(p1) --[[ set_node | Line: 305 | Upvalues: v2 (ref) ]]
		v2 = p1
	end

	local function pop_node() --[[ pop_node | Line: 309 | Upvalues: v2 (ref), v1 (copy) ]]
		local v12 = v2

		v2 = nil

		if v12 ~= nil then
			return v12
		end

		v1.croak("no available node")
		error("")
	end

	local function is_symbol(p1) --[[ is_symbol | Line: 319 | Upvalues: v1 (copy) ]]
		local v12 = v1.peek()

		return if v12.type == "symbol" then v12.s == p1 else false
	end

	local function is_op(p1) --[[ is_op | Line: 324 | Upvalues: v1 (copy) ]]
		local v12 = v1.peek()

		return if v12.type == "operator" then v12.s == p1 else false
	end

	local function is_keyword(p1) --[[ is_keyword | Line: 329 | Upvalues: v1 (copy) ]]
		local v12 = v1.peek()

		return if v12.type == "keyword" then v12.s == p1 else false
	end

	local function skip_symbol(p1) --[[ skip_symbol | Line: 334 | Upvalues: v1 (copy) ]]
		local v12 = v1.peek()

		if if v12.type == "symbol" then if v12.s == p1 then true else false else false then
			v1.next()
		else
			v1.croak((("expecting symbol: \"%*\" got \"%*\""):format(p1, v1.peek(1).s)))
			error("")
		end
	end

	local function skip_operator(p1) --[[ skip_operator | Line: 343 | Upvalues: v1 (copy) ]]
		local v12 = v1.peek()

		if if v12.type == "operator" then if v12.s == p1 then true else false else false then
			v1.next()
		else
			v1.croak((("expecting op: \"%*\" got \"%*\""):format(p1, v1.peek().s)))
			error("")
		end
	end

	local function delimited(p1, p2, p3, p4) --[[ delimited | Line: 352 | Upvalues: skip_symbol (copy), v1 (copy), v2 (ref) ]]
		skip_symbol(p1)

		local t = {}
		local v12 = true

		while not v1.eof() do
			local v22 = v1.peek()

			if if v22.type == "symbol" then if v22.s == p2 then true else false else false then
				break
			end

			if v12 then
				v12 = false
			elseif typeof(p3) == "string" then
				skip_symbol(p3)
			elseif typeof(p3) == "function" then
				p3()
			end

			local v4 = v1.peek()

			if if v4.type == "symbol" then if v4.s == p2 then true else false else false then
				break
			end

			p4()

			local v6 = v2

			v2 = nil

			if v6 == nil then
				v1.croak("no available node")
				error("")
			end

			table.insert(t, v6)
		end

		skip_symbol(p2)

		return t
	end

	local v3 = nil
	local v4 = nil

	local function parse_table() --[[ parse_table | Line: 380 | Upvalues: delimited (copy), v1 (copy), skip_symbol (copy), v4 (ref), v2 (ref), v3 (ref) ]]
		v2 = {
			type = "table",
			value = delimited("{", "}", ",", function() --[[ Line: 381 | Upvalues: v1 (ref), skip_symbol (ref), v4 (ref), v2 (ref), v3 (ref) ]]
				local v12 = v1.peek()

				if if v12.type == "symbol" then v12.s == "[" else false then
					skip_symbol("[")
					v4()
					skip_symbol("]")

					local v32 = v2

					v2 = nil

					if v32 == nil then
						v1.croak("no available node")
						error("")
					end

					local v42 = v1.peek()

					if if v42.type == "operator" then v42.s == "=" else false then
						v1.next()
					else
						v1.croak((("expecting op: \"=\" got \"%*\""):format(v1.peek().s)))
						error("")
					end

					v4()

					local v7 = v2

					v2 = nil

					if v7 == nil then
						v1.croak("no available node")
						error("")
					end

					v2 = {
						type = "assign",
						key = v32,
						value = v7
					}
				else
					if v1.peek(2).type ~= "operator" or v1.peek(2).s ~= "=" then
						v4()

						return
					end

					v3("string")

					local v8 = v2

					v2 = nil

					if v8 == nil then
						v1.croak("no available node")
						error("")
					end

					local v9 = v1.peek()

					if if v9.type == "operator" then v9.s == "=" else false then
						v1.next()
					else
						v1.croak((("expecting op: \"=\" got \"%*\""):format(v1.peek().s)))
						error("")
					end

					v4()

					local v122 = v2

					v2 = nil

					if v122 == nil then
						v1.croak("no available node")
						error("")
					end

					v2 = {
						type = "assign",
						key = v8,
						value = v122
					}
				end
			end)
		}
	end

	local function parse_functioncall(p1) --[[ parse_functioncall | Line: 431 | Upvalues: v2 (ref), v1 (copy), delimited (copy), v4 (ref) ]]
		local v12 = v2

		v2 = nil

		if v12 == nil then
			v1.croak("no available node")
			error("")
		end

		local v22 = delimited("(", ")", ",", function() --[[ Line: 433 | Upvalues: v4 (ref) ]]
			v4()
		end)
		local t = {}

		t.type = if p1 then "methodcall" else "functioncall"
		t.value = v12
		t.args = v22
		v2 = t
	end

	local function parse_index() --[[ parse_index | Line: 444 | Upvalues: v1 (copy), v2 (ref), skip_symbol (copy), v3 (ref), v4 (ref), parse_functioncall (ref) ]]
		local v12 = v1.peek()

		if if v12.type == "symbol" then v12.s == "." else false then
			local v32 = v2

			v2 = nil

			if v32 == nil then
				v1.croak("no available node")
				error("")
			end

			skip_symbol(".")
			v3("string")

			local v42 = v2

			v2 = nil

			if v42 ~= nil then
				v2 = {
					type = "index",
					value = v32,
					key = v42
				}

				return
			end

			v1.croak("no available node")
			error("")
		end

		local v5 = v1.peek()

		if if v5.type == "symbol" then v5.s == "[" else false then
			local v7 = v2

			v2 = nil

			if v7 == nil then
				v1.croak("no available node")
				error("")
			end

			skip_symbol("[")
			v4()
			skip_symbol("]")

			local v8 = v2

			v2 = nil

			if v8 ~= nil then
				v2 = {
					type = "index",
					value = v7,
					key = v8
				}

				return
			end

			v1.croak("no available node")
			error("")
		end

		local v9 = v1.peek()

		if not (if v9.type == "symbol" then v9.s == ":" else false) then
			v1.croak((("expected index or function call, got %*"):format(v1.peek().s)))

			return
		end

		local v11 = v2

		v2 = nil

		if v11 == nil then
			v1.croak("no available node")
			error("")
		end

		skip_symbol(":")
		v3("string")

		local v122 = v2

		v2 = nil

		if v122 ~= nil then
			v2 = {
				type = "index",
				value = v11,
				key = v122
			}
			parse_functioncall(true)

			return
		end

		v1.croak("no available node")
		error("")
	end

	v3 = function(p1) --[[ parse_identifier | Line: 492 | Upvalues: v1 (copy), v2 (ref) ]]
		local v12 = v1.next()

		if v12 == nil then
			v1.croak("expected identifier, got eof")
			error("")
		end

		if v12.type == "identifier" then
			v2 = {
				type = p1,
				value = v12.s
			}
		else
			v1.croak((("expected identifier, got %*"):format(v12.type)))
		end
	end
	v4 = function() --[[ parse_expression | Line: 506 | Upvalues: v1 (copy), v3 (ref), parse_functioncall (ref), parse_index (ref), v2 (ref), parse_table (ref) ]]
		local v12 = v1.peek()

		if v12.type == "identifier" then
			v3("variable")

			repeat
				if v1.eof() ~= false then
					break
				end

				local v22 = v1.peek()

				if not (if v22.type == "symbol" then v22.s == "." else false) then
					local v4 = v1.peek()

					if not (if v4.type == "symbol" then v4.s == "[" else false) then
						local v6 = v1.peek()

						if not (if v6.type == "symbol" then v6.s == "(" else false) then
							local v8 = v1.peek()

							if not (if v8.type == "symbol" then v8.s == ":" else false) then
								break
							end
						end
					end
				end

				if v1.eof() then
					break
				end

				local v10 = v1.peek()

				if if v10.type == "symbol" then v10.s == "(" else false then
					parse_functioncall(false)

					continue
				end

				parse_index()
			until v1.eof()
		else
			if v12.type == "string" then
				local t = {
					type = "string"
				}

				t.value = assert(v1.next()).s
				v2 = t

				return
			end

			if v12.type == "number" then
				local t = {
					type = "number"
				}

				t.value = assert(v1.next()).s
				v2 = t

				return
			end

			local v14 = v1.peek()

			if if v14.type == "keyword" then v14.s == "true" else false then
				v2 = {
					type = "boolean",
					value = true
				}
				v1.next()

				return
			end

			local v16 = v1.peek()

			if if v16.type == "keyword" then v16.s == "false" else false then
				v2 = {
					type = "boolean",
					value = false
				}
				v1.next()

				return
			end

			local v18 = v1.peek()

			if if v18.type == "symbol" then v18.s == "{" else false then
				parse_table()

				return
			end

			v1.croak((("expected expression, got %*\" \"%*\""):format(v12.type, v12.s)))
		end
	end
	v4()

	local v5 = v2

	v2 = nil

	if v5 ~= nil then
		return v5
	end

	v1.croak("no available node")
	error("")
end

local t3 = {}
local t4 = {
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
	OverlapParams = function(p1) --[[ OverlapParams | Line: 573 ]]
		local v1 = OverlapParams.new()

		for v2, v3 in p1 do
			v1[v2] = v3
		end

		return v1
	end,
	RaycastParams = function(p1) --[[ RaycastParams | Line: 580 ]]
		local v1 = RaycastParams.new()

		for v2, v3 in p1 do
			v1[v2] = v3
		end

		return v1
	end,
	game = game,
	workspace = workspace
}

local function v4(p1) --[[ compile | Line: 593 | Upvalues: t4 (copy), v4 (copy), t3 (copy) ]]
	if p1.type == "number" then
		return p1.value
	end

	if p1.type == "string" then
		return p1.value
	end

	if p1.type == "boolean" then
		return p1.value
	end

	if p1.type == "variable" then
		return t4[p1.value]
	end

	if p1.type == "index" then
		return v4(p1.value)[v4(p1.key)]
	end

	if p1.type == "functioncall" then
		for i = 1, #p1.args do
			t3[i] = v4(p1.args[i])
		end

		return v4(p1.value)(unpack(t3, 1, #p1.args))
	end

	if p1.type == "methodcall" then
		for j = 1, #p1.args do
			t3[j] = v4(p1.args[j])
		end

		local v42 = v4(p1.value)

		return v42(v42, unpack(t3, 1, #p1.args))
	end

	if p1.type == "table" then
		local count = 0
		local t = {}

		for v7, v8 in p1.value do
			if v8.type == "assign" then
				t[v4(v8.key)] = v4(v8.value)

				continue
			end

			t[count + 1] = v4(v8)
			count = count + 1
		end

		return t
	end

	if p1.type ~= "assign" then
		return nil
	end

	error("bad ast, you cannot generate this")
end

local v5 = buffer.create(1024)
local v6 = 0
local v7 = 0
local v8 = true
local v9 = 0
local v10 = buffer.create(1024)
local t5 = {}

local function prealloc(p1) --[[ prealloc | Line: 650 | Upvalues: v5 (ref), v6 (ref) ]]
	local v1 = buffer.len(v5)

	if not (v1 <= v6 + p1) then
		return
	end

	local sum = v1 + v1 / 2

	while sum <= v6 + p1 do
		sum = sum + sum / 2
	end

	local v2 = buffer.create(sum)

	buffer.copy(v2, 0, v5, 0, v6)
	v5 = v2
end

local function write_str(p1) --[[ write_str | Line: 665 | Upvalues: v5 (ref), v6 (ref), v9 (ref) ]]
	local v1 = buffer.len(v5)

	if v1 <= v6 + #p1 then
		local sum = v1 + v1 / 2

		while sum <= v6 + #p1 do
			sum = sum + sum / 2
		end

		local v2 = buffer.create(sum)

		buffer.copy(v2, 0, v5, 0, v6)
		v5 = v2
	end

	buffer.writestring(v5, v6, p1, #p1)
	v6 = v6 + #p1
	v9 = v9 + #p1
end

local function write_low_prec_float(p1) --[[ write_low_prec_float | Line: 684 | Upvalues: write_str (copy), v9 (ref) ]]
	local v1 = string.format("%.7g", p1)

	write_str(v1)
	v9 = v9 + #v1
end

local function char(p1) --[[ char | Line: 690 ]]
	return string.byte(p1)
end

local function write_char(p1) --[[ write_char | Line: 694 | Upvalues: v5 (ref), v6 (ref), v9 (ref) ]]
	local v1 = buffer.len(v5)

	if v1 <= v6 + 1 then
		local sum = v1 + v1 / 2

		while sum <= v6 + 1 do
			sum = sum + sum / 2
		end

		local v2 = buffer.create(sum)

		buffer.copy(v2, 0, v5, 0, v6)
		v5 = v2
	end

	buffer.writeu8(v5, v6, p1)
	v9 = v9 + 1
	v6 = v6 + 1
end

local function display_string(p1) --[[ display_string | Line: 715 | Upvalues: prealloc (copy), write_str (copy) ]]
	local v1 = string.format("%q", p1)

	prealloc(#v1)
	write_str(v1)
end

local function write_line() --[[ write_line | Line: 721 | Upvalues: v8 (ref), write_char (copy), write_str (copy), v7 (ref) ]]
	if v8 then
		write_char(10)
		write_str(string.rep("\t", v7))
	else
		write_char(32)
	end
end

local v11 = nil
local v12 = false

local function to_path(p1, ...) --[[ to_path | Line: 733 | Upvalues: v12 (ref), v6 (ref), v7 (ref), v5 (ref), v10 (copy), v11 (ref) ]]
	local v1 = v12

	v12 = true
	v12 = v1

	if p1 then
		local t = {}
		local v2 = select("#", ...)
		local v3 = v6
		local v4 = v7
		local v52 = v5

		v5 = v10

		for i = v2, 2, -1 do
			v6 = 0
			v7 = 0
			v11(select(i, ...))
			t[v2 - i] = buffer.readstring(v10, 0, v6)
		end

		v6 = v3
		v7 = v4
		v5 = v52

		return ("new(%*)"):format((table.concat(t, ", ")))
	end

	local t = {}
	local v62 = select("#", ...)
	local v72 = v6
	local v8 = v7
	local v9 = v5

	v5 = v10

	for j = v62, 1, -1 do
		v6 = 0
		v7 = 0
		v11(select(j, ...))
		t[v62 - j + 1] = ("[%*]"):format((buffer.readstring(v10, 0, v6)))
	end

	v6 = v72
	v7 = v8
	v5 = v9
	table.insert(t, 1, "old")

	return table.concat(t)
end

v11 = function(p1, ...) --[[ display | Line: 790 | Upvalues: v6 (ref), write_str (copy), prealloc (copy), t5 (copy), v7 (ref), write_char (copy), v8 (ref), v12 (ref), v11 (ref), to_path (copy), v9 (ref) ]]
	if v6 > 8192 then
		return
	end

	if type(p1) == "number" then
		write_str((tostring(p1)))

		return
	end

	if type(p1) == "string" then
		local v1 = string.format("%q", p1)

		prealloc(#v1)
		write_str(v1)

		return
	end

	if type(p1) == "boolean" then
		if p1 == true then
			write_str("true")
		else
			write_str("false")
		end
	elseif type(p1) == "table" and not t5[p1] then
		t5[p1] = true
		v7 = v7 + 1
		write_char(123)

		for v2, v3 in p1 do
			if v8 then
				write_char(10)
				write_str(string.rep("\t", v7))
			else
				write_char(32)
			end

			if type(v2) == "string" and string.match(v2, "^[a-zA-Z_][a-zA-Z0-9_]*$") then
				write_str(v2)
			else
				write_char(91)

				local v4 = v12

				v12 = true
				v11(v2)
				v12 = v4
				write_char(93)
			end

			write_char(32)
			write_char(61)
			write_char(32)
			v11(v3, v2, ...)
			write_char(44)
		end

		v7 = v7 - 1

		if v8 then
			write_char(10)
			write_str(string.rep("\t", v7))
		else
			write_char(32)
		end

		write_char(125)
	elseif type(p1) == "table" and t5[p1] then
		if v12 then
			write_str("*cannot display table due to cyclic dependency*")
		else
			write_str(to_path(true, ...))
		end
	else
		if type(p1) == "nil" then
			write_str("nil")

			return
		end

		if typeof(p1) == "BrickColor" then
			write_str("BrickColor.new(")
			write_str(p1.Name)
			write_char(41)

			return
		end

		if typeof(p1) == "CFrame" then
			if p1.Rotation == CFrame.new() then
				write_str("CFrame.new(")
				v11(p1.X)
				write_str(", ")
				v11(p1.Y)
				write_str(", ")
				v11(p1.Z)
				write_char(41)
			else
				write_str("CFrame.fromMatrix(")
				v11(p1.Position)
				write_str(",\n")
				v11(p1.XVector)
				write_str(",\n")
				v11(p1.YVector)
				write_str(",\n")
				v11(p1.ZVector)
				write_str(",\n")
			end
		else
			if typeof(p1) == "EnumItem" then
				write_str((tostring(p1)))

				return
			end

			if typeof(p1) == "Enum" then
				write_str("Enum.")
				write_str((tostring(p1)))

				return
			end

			if typeof(p1) == "Enums" then
				write_str("Enum")

				return
			end

			if typeof(p1) == "Color3" then
				write_str("Color3.fromHex(")

				local v62 = string.format("%q", (p1:ToHex()))

				prealloc(#v62)
				write_str(v62)
				write_char(41)

				return
			end

			if typeof(p1) == "Vector3" then
				write_str("Vector3.new(")
				write_str((tostring(p1)))
				write_char(41)

				return
			end

			if typeof(p1) == "Vector2" then
				write_str("Vector2.new(")
				write_str((tostring(p1)))
				write_char(41)

				return
			end

			if typeof(p1) == "NumberSequence" then
				write_str("NumberSequence.new(")

				if #p1.Keypoints == 2 then
					local v82 = string.format("%.7g", p1.Keypoints[1].Value)

					write_str(v82)
					v9 = v9 + #v82
					write_str(", ")

					local v10 = string.format("%.7g", p1.Keypoints[2].Value)

					write_str(v10)
					v9 = v9 + #v10
				else
					v11(p1.Keypoints)
				end

				write_char(41)
			elseif typeof(p1) == "NumberSequenceKeypoint" then
				write_str("NumberSequenceKeypoint.new(")

				local v112 = string.format("%.7g", p1.Time)

				write_str(v112)
				v9 = v9 + #v112
				write_str(", ")

				local v13 = string.format("%.7g", p1.Value)

				write_str(v13)
				v9 = v9 + #v13

				if not (p1.Envelope > 0) then
					write_char(41)

					return
				end

				write_str(", ")

				local v14 = string.format("%.7g", p1.Envelope)

				write_str(v14)
				v9 = v9 + #v14
				write_char(41)
			elseif typeof(p1) == "NumberRange" then
				write_str("NumberRange.new(")

				local v15 = string.format("%.7g", p1.Min)

				write_str(v15)
				v9 = v9 + #v15

				if p1.Min == p1.Max then
					write_char(41)

					return
				end

				write_str(", ")

				local v16 = string.format("%.7g", p1.Max)

				write_str(v16)
				v9 = v9 + #v16
				write_char(41)
			elseif typeof(p1) == "ColorSequence" then
				write_str("ColorSequence.new(")

				if #p1.Keypoints == 2 then
					v11(p1.Keypoints[1].Value)
					write_str(", ")
					v11(p1.Keypoints[2].Value)
				else
					v11(p1.Keypoints)
				end

				write_char(41)
			else
				if typeof(p1) == "ColorSequenceKeypoint" then
					write_str("ColorSequenceKeypoint.new(")

					local v17 = string.format("%.7g", p1.Time)

					write_str(v17)
					v9 = v9 + #v17
					write_str(", ")
					v11(p1.Value)
					write_char(41)

					return
				end

				if typeof(p1) == "RaycastResult" then
					v11({
						Instance = p1.Instance,
						Material = p1.Material,
						Normal = p1.Normal,
						Position = p1.Position,
						Distance = p1.Distance
					})

					return
				end

				if typeof(p1) == "Region3" then
					local Position = p1.CFrame.Position
					local Size = p1.Size

					write_str("Region3.new(")
					v11(Position - Size / 2)
					write_str(", ")
					v11(Position + Size / 2)
					write_char(41)

					return
				end

				if typeof(p1) == "Rect" then
					write_str("Rect.new(")

					local v18 = string.format("%.7g", p1.Min.X)

					write_str(v18)
					v9 = v9 + #v18
					write_str(", ")

					local v19 = string.format("%.7g", p1.Min.Y)

					write_str(v19)
					v9 = v9 + #v19
					write_str(", ")

					local v20 = string.format("%.7g", p1.Max.X)

					write_str(v20)
					v9 = v9 + #v20
					write_str(", ")

					local v21 = string.format("%.7g", p1.Max.Y)

					write_str(v21)
					v9 = v9 + #v21
					write_char(41)

					return
				end

				if typeof(p1) == "OverlapParams" then
					write_str("OverlapParams(")
					v11({
						CollisionGroup = p1.CollisionGroup,
						FilterType = p1.FilterType,
						MaxParts = p1.MaxParts,
						RespectCanCollide = p1.RespectCanCollide
					})
					write_char(41)

					return
				end

				if typeof(p1) == "RaycastParams" then
					write_str("RaycastParams(")
					v11({
						CollisionGroup = p1.CollisionGroup,
						FilterType = p1.FilterType,
						RespectCanCollide = p1.RespectCanCollide
					})
					write_char(41)

					return
				end

				if typeof(p1) == "Instance" and not v12 then
					write_str(to_path(false, ...))

					return
				end

				if typeof(p1) == "Instance" and v12 then
					write_str(p1:GetFullName())
				else
					write_str(to_path(false, ...))
				end
			end
		end
	end
end

local function f13(p1, p2, p3) --[[ Line: 982 | Upvalues: v8 (ref), v6 (ref), v7 (ref), t5 (copy), v12 (ref), v11 (ref), v5 (ref) ]]
	v8 = if p2 == nil then true else p2
	v6 = 0
	v7 = 0
	table.clear(t5)

	if not p3 then
		v11(p1)
		v12 = false

		return buffer.readstring(v5, 0, v6)
	end

	v12 = true
	v11(p1)
	v12 = false

	return buffer.readstring(v5, 0, v6)
end

return {
	parse = parse,
	compile = function(p1, p2) --[[ compile | Line: 999 | Upvalues: t4 (copy), v4 (copy) ]]
		setmetatable(t4, {
			__index = p2 or nil
		})

		local t = {
			symbol = "new"
		}
		local v2 = false

		function t4.new(...) --[[ Line: 1004 | Upvalues: v2 (ref), t (copy) ]]
			v2 = true

			return setmetatable({
				we_left_something = true,
				...
			}, t)
		end

		local v3 = v4(p1)

		local function find(p1) --[[ find | Line: 1012 | Upvalues: v3 (copy) ]]
			local v1 = v3

			for i, v in ipairs(p1) do
				v1 = v1[v]

				if v1 == nil then
					return nil
				end
			end

			return v1
		end

		local t2 = {}

		local function v42(p1) --[[ recurse | Line: 1023 | Upvalues: t (copy), v3 (copy), t2 (copy), v42 (copy) ]]
			for k, v in pairs(p1) do
				if typeof(v) == "table" and getmetatable(v) == t then
					local v1 = v3
					local v2 = v1

					for i, v4 in ipairs(v) do
						v1 = v1[v4]

						if v1 == nil then
							v2 = nil

							break
						end
					end

					p1[k] = v2

					continue
				end

				if (typeof(v) ~= "table" or not t2[v]) and typeof(v) == "table" then
					t2[v] = true
					v42(v)
				end
			end
		end

		if v2 and typeof(v3) == "table" then
			v42(v3)
		end

		return v3
	end,
	output = f13
}