-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
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

local function stream(p1) --[[ stream | Line: 46 ]]
	local v1 = 0
	local v2 = 1
	local v3 = 1

	local function peek() --[[ peek | Line: 52 | Upvalues: p1 (copy), v1 (ref) ]]
		return string.sub(p1, v1 + 1, v1 + 1)
	end

	local function v() --[[ next | Line: 56 | Upvalues: p1 (copy), v1 (ref), v2 (ref), v3 (ref) ]]
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

	local function eof() --[[ eof | Line: 66 | Upvalues: p1 (copy), v1 (ref) ]]
		return string.sub(p1, v1 + 1, v1 + 1) == ""
	end

	local function position() --[[ position | Line: 70 | Upvalues: v1 (ref), v2 (ref), v3 (ref) ]]
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
		croak = function(p1) --[[ croak | Line: 78 | Upvalues: v2 (ref), v3 (ref) ]]
			error(("%* (%*:%*)"):format(p1, v2, v3), 0)
		end,
		pos = position
	}
end

local function lex(p1) --[[ lex | Line: 92 | Upvalues: stream (copy), t (copy) ]]
	local v1 = stream(p1)

	local function is_whitespace(p1) --[[ is_whitespace | Line: 96 ]]
		return string.match(p1, "[\t ]") and true or false
	end

	local function is_digit(p1) --[[ is_digit | Line: 100 ]]
		return string.match(p1, "%d") and true or false
	end

	local function is_start_identifier(p1) --[[ is_start_identifier | Line: 104 ]]
		return string.match(p1, "[%a_]") and true or false
	end

	local function is_identifier(p1) --[[ is_identifier | Line: 108 ]]
		return string.match(p1, "[%a_:%.]") and true or false
	end

	local function is_op_char(p1) --[[ is_op_char | Line: 112 ]]
		return if p1 == "#" or (p1 == "!" or p1 == "*") then true else p1 == "$"
	end

	local function is_punc(p1) --[[ is_punc | Line: 116 ]]
		return string.match(p1, "[%(%);,]") and true or false
	end

	local function read_while(p1) --[[ read_while | Line: 120 | Upvalues: v1 (copy) ]]
		local v12 = ""

		while v1.eof() == false and p1(v1.peek()) do
			v12 = v12 .. v1.next()
		end

		return v12
	end

	local function skip_whitespace() --[[ skip_whitespace | Line: 128 | Upvalues: read_while (copy), is_whitespace (copy) ]]
		read_while(is_whitespace)
	end

	local function read_string() --[[ read_string | Line: 132 | Upvalues: v1 (copy), t (ref) ]]
		local v12 = v1.next()
		local v2 = v1.pos()
		local v3 = false
		local v4 = ""

		while v1.eof() == false and (v1.peek() ~= v12 or v3) do
			local v5 = v1.next()

			if v5 == "\\" then
				v3 = true
			end

			if v3 then
				v3 = false
				v4 = v4 .. (t[v5] or v1.croak((("cannot escape %*"):format(v5))))
			else
				v4 = v4 .. v5
			end
		end

		local v7 = v1.pos()

		if v1.peek() == v12 then
			v1.next()

			return {
				type = "string",
				s = v4,
				from = v2,
				to = v7
			}
		end

		v1.croak("unterminated string")
		v1.next()

		return {
			type = "string",
			s = v4,
			from = v2,
			to = v7
		}
	end

	local function read_number() --[[ read_number | Line: 162 | Upvalues: v1 (copy), read_while (copy) ]]
		local v12 = false
		local v2 = v1.pos()
		local v3 = read_while(function(p1) --[[ Line: 165 | Upvalues: v12 (ref) ]]
			if v12 and p1 == "." then
				return false
			end

			if p1 ~= "." then
				return string.match(p1, "%d") and true or false
			end

			v12 = true

			return string.match(p1, "%d") and true or false
		end)
		local v4 = v1.pos()
		local v5 = tonumber(v3)

		if v5 then
			return {
				type = "number",
				s = assert(v5),
				from = v2,
				to = v4
			}
		end

		v1.croak((("could not read %* as number"):format(v3)))

		return {
			type = "number",
			s = assert(v5),
			from = v2,
			to = v4
		}
	end

	local function read_identifier() --[[ read_identifier | Line: 181 | Upvalues: v1 (copy), read_while (copy), is_identifier (copy) ]]
		local v12 = v1.pos()

		return {
			type = "identifier",
			s = read_while(is_identifier),
			from = v12,
			to = v1.pos()
		}
	end

	local function read_next() --[[ read_next | Line: 193 | Upvalues: read_while (copy), is_whitespace (copy), v1 (copy), read_string (copy), read_number (copy), is_identifier (copy) ]]
		read_while(is_whitespace)

		if v1.eof() then
			return {
				type = "eof",
				s = "eof"
			}
		end

		local v12 = v1.peek()

		if v12 == "\"" or v12 == "\'" then
			return read_string()
		end

		if string.match(v12, "%d") then
			return read_number()
		end

		if string.match(v12, "[%a_]") then
			local v2 = v1.pos()

			return {
				type = "identifier",
				s = read_while(is_identifier),
				from = v2,
				to = v1.pos()
			}
		end

		if if v12 == "#" or (v12 == "!" or v12 == "*") then true elseif v12 == "$" then true else false then
			return {
				type = "operator",
				s = v1.next()
			}
		end

		if string.match(v12, "[%(%);,]") then
			return {
				type = "symbol",
				s = v1.next()
			}
		end

		v1.croak((("cannot lex %*"):format(v12)))
		error("fail")
	end

	local t2 = {}

	local function v() --[[ next | Line: 211 | Upvalues: t2 (copy), read_next (copy) ]]
		local v1 = table.remove(t2, 1)

		if v1 == nil then
			return read_next()
		end

		return v1
	end

	return {
		peek = function(p1) --[[ peek | Line: 216 | Upvalues: t2 (copy), read_next (copy) ]]
			local v1 = p1 or 1

			while #t2 < v1 do
				table.insert(t2, read_next())
			end

			return t2[v1]
		end,
		next = v,
		eof = function() --[[ eof | Line: 224 | Upvalues: t2 (copy), read_next (copy) ]]
			while #t2 < 1 do
				table.insert(t2, read_next())
			end

			return if t2[1].type == "eof" then true else false
		end,
		croak = v1.croak,
		pos = v1.pos
	}
end

return function(p1) --[[ parse | Line: 269 | Upvalues: lex (copy) ]]
	local v1 = lex(p1)
	local v2 = false
	local v3 = true
	local v4 = false
	local t = {}
	local v5 = false
	local t2 = {}

	while true do
		local v6 = v1.peek()

		if v6.type == "eof" then
			break
		end

		if v2 or v6.type == "number" then
			if v2 then
				if v6.type ~= "number" then
					v1.croak("expected number")
					error("")
				end
			else
				v1.croak("expected $")
			end

			local t3 = {
				type = "Component",
				query = v3,
				exclude = v4
			}
			local t4 = {
				type = "Entity"
			}
			local s = v1.next().s

			t4.entity = tonumber(s)
			t3.value = t4
			table.insert(t, t3)

			if not v5 then
				v3 = true
			end

			if not v5 then
				v4 = false
			end

			v2 = false

			if v1.peek().type == "symbol" or v1.peek().type == "eof" then
				continue
			end

			v1.croak("expected symbol or eof after identifier")
		else
			if v6.type == "operator" then
				if v6.s == "#" then
					if v5 then
						v1.croak("cannot tag inside relationship")
					end

					v1.next()
					v3 = false
				else
					if v6.s == "!" then
						if v5 then
							v1.croak("cannot exclude in relationship")
						end

						v1.next()
						v3 = false
						v4 = true

						continue
					end

					if v6.s == "$" then
						v1.next()
						v2 = true

						continue
					end

					if v6.s == "*" then
						if not v5 then
							v1.croak("cannot use wildcards outside relationship")
						end

						table.insert(t, {
							type = "Wildcard",
							name = "*"
						})
						v1.next()
					else
						continue
					end
				end

				continue
			end

			if v6.type == "symbol" then
				if v6.s == "(" then
					if v5 == true then
						v1.croak("relationship within relationship")
					end

					v1.next()
					v5 = true
				else
					if v6.s == ")" then
						if v5 == false then
							v1.croak("missing (")
						end

						if #t == 2 then
							local v7 = table.remove(t)
							local v8 = table.remove(t)

							if v8.type == "Wildcard" and v7.type == "Wildcard" then
								v1.croak("both components are wildcards")
							end

							v1.next()
							v3 = true
							v4 = false
							t = {
								{
									type = "Relationship",
									query = v3,
									exclude = v4,
									left = v8,
									right = v7
								}
							}
							v5 = false
						else
							v1.croak((("expected 2 components, got %*"):format(#t)))
						end

						continue
					end

					if v6.s == "," or v6.s == ";" then
						if v5 then
							v1.next()

							continue
						end

						local v9 = table.remove(t)

						if v9 == nil then
							v1.croak("no component provided")
							error("")
						end

						table.insert(t2, v9)
						v1.next()
						v3 = true
						v4 = false
					else
						continue
					end
				end

				continue
			end

			if v6.type == "identifier" then
				table.insert(t, {
					type = "Component",
					query = v3,
					exclude = v4,
					value = {
						type = "Name",
						name = v1.next().s
					}
				})

				if not v5 then
					v3 = true
				end

				if not v5 then
					v4 = false
				end

				if v1.peek().type == "symbol" or v1.peek().type == "eof" then
					continue
				end

				v1.croak("expected symbol or eof after identifier")

				continue
			end

			if v6.type == "string" then
				table.insert(t, {
					type = "Component",
					query = v3,
					exclude = v4,
					value = {
						type = "Name",
						name = v1.next().s
					}
				})

				if not v5 then
					v3 = true
				end

				if not v5 then
					v4 = false
				end

				if v1.peek().type == "symbol" or v1.peek().type == "eof" then
					continue
				end

				v1.croak("expected symbol or eof after string")
			else
				continue
			end
		end
	end

	table.insert(t2, (table.remove(t)))

	return t2
end