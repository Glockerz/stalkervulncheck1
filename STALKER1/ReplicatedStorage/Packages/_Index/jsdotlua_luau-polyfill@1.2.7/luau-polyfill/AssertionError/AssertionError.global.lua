-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local collections = require(script.Parent.Parent.Parent:WaitForChild("collections"))
local Array = collections.Array
local Object = collections.Object
local boolean = require(script.Parent.Parent.Parent:WaitForChild("boolean"))
local string = require(script.Parent.Parent.Parent:WaitForChild("string"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local inspect = collections.inspect
local Error = require(script.Parent.Parent:WaitForChild("Error"))
local v1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"))
local t = {
	stderr = {
		isTTY = false,
		columns = 0,
		hasColors = function(...) --[[ hasColors | Line: 45 ]]
			return true
		end
	}
}

function ErrorCaptureStackTrace(p1, ...) --[[ ErrorCaptureStackTrace | Line: 52 | Upvalues: Error (copy) ]]
	Error.captureStackTrace(p1, ...)
end

local function removeColors(p1) --[[ removeColors | Line: 57 ]]
	return p1
end

local v2 = ""
local v3 = ""
local v4 = ""
local v5 = ""
local t2 = {
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
}

local function copyError(p1) --[[ copyError | Line: 85 | Upvalues: Object (copy) ]]
	local t = {}

	for v1, v2 in Object.keys(p1) do
		t[v2] = p1[v2]
	end

	t.message = p1.message

	return t
end

local function inspectValue(p1) --[[ inspectValue | Line: 96 | Upvalues: inspect (copy) ]]
	return inspect(p1, {
		compact = false,
		customInspect = false,
		depth = 1000,
		maxArrayLength = (1 / 0),
		showHidden = false,
		showProxy = false,
		sorted = true,
		getters = true
	})
end

local function createErrDiff(p1, p2, p3) --[[ createErrDiff | Line: 111 | Upvalues: inspect (copy), string (copy), boolean (copy), t2 (copy), t (copy), v2 (ref), v5 (ref), Array (copy), v3 (ref), v4 (ref) ]]
	local v1 = ""
	local v22 = ""
	local v32 = ""
	local v42 = false
	local v52 = inspect(p1, {
		compact = false,
		customInspect = false,
		depth = 1000,
		maxArrayLength = (1 / 0),
		showHidden = false,
		showProxy = false,
		sorted = true,
		getters = true
	})
	local v6 = string.split(v52, "\n")
	local v7 = string.split(inspect(p2, {
		compact = false,
		customInspect = false,
		depth = 1000,
		maxArrayLength = (1 / 0),
		showHidden = false,
		showProxy = false,
		sorted = true,
		getters = true
	}), "\n")
	local count = 0
	local v8 = ""

	if p3 == "strictEqual" and (typeof(p1) == "table" and (p1 ~= nil and (typeof(p2) == "table" and p2 ~= nil)) or typeof(p1) == "function" and typeof(p2) == "function") then
		p3 = "strictEqualObject"
	end

	if #v6 == 1 and (#v7 == 1 and v6[1] ~= v7[1]) then
		local v9 = v6[1]
		local v10 = v7[1]
		local v12 = string.len(v9) + string.len(v10)

		if v12 <= 12 then
			if (typeof(p1) ~= "table" or p1 == nil) and ((typeof(p2) ~= "table" or p2 == nil) and (p1 ~= 0 or p2 ~= 0)) then
				return ("%s\n\n"):format(t2[p3]) .. ("%s !== %s\n"):format(v6[1], v7[1])
			end
		elseif p3 ~= "strictEqualObject" and v12 < (if t.stderr.isTTY then t.stderr.columns else 80) then
			while string.sub(v9, count + 1, count + 1) == string.sub(v10, count + 1, count + 1) do
				count = count + 1
			end

			if count > 2 then
				v8, count = ("\n  %s^"):format(string.rep(" ", count)), 0
			end
		end
	end

	local v15 = v6[#v6]
	local v16 = v7[#v7]
	local v18, v19, v20, v21, sum, count2, v222, v23, v24, v25, v26, v27, v28, v29, v30, v31, v322

	while v15 == v16 do
		local v17

		v17 = count + 1

		if count < 3 then
			v32 = ("\n  %s%s"):format(v15, v32)
		else
			v1 = v15
		end

		table.remove(v6)
		table.remove(v7)

		if #v6 == 0 or #v7 == 0 then
			v18 = math.max(#v6, #v7)

			if v18 == 0 then
				v19 = string.split(v52, "\n")

				if #v19 > 50 then
					v19[47] = ("%s...%s"):format(v2, v5)

					while #v19 > 47 do
						table.remove(v19)
					end
				end

				return ("%s\n\n"):format("Values have same structure but are not reference-equal:") .. ("%s\n"):format(Array.join(v19, "\n"))
			end

			if v17 >= 5 then
				v20 = ("\n%s...%s%s"):format(v2, v5, v32)
				v32 = v20
				v42 = true
			end

			if v1 ~= "" then
				v21 = ("\n  %s%s"):format(v1, v32)
				v1 = ""
				v32 = v21
			end

			sum = 0
			count2 = 0
			v222 = t2[p3] .. ("\n%s+ actual%s %s- expected%s"):format(v3, v5, v4, v5)
			v23 = (" %s...%s Lines skipped"):format(v2, v5)
			v24 = ("%s+%s"):format(v3, v5)

			if #v6 < v18 then
				v25 = ("%s-%s"):format(v4, v5)
				v24 = v25
				v26 = #v6
				v27 = v7
			else
				v26 = #v7
				v27 = v6
			end

			for i = 1, v18 do
				if v26 < i then
					if count2 > 2 then
						if count2 > 3 then
							if count2 > 4 and count2 == 5 then
								v22 = v22 .. ("\n  %s"):format(v27[i - 3])
								sum = sum + 1
							elseif count2 > 4 then
								v22 = v22 .. ("\n%s...%s"):format(v2, v5)
								v42 = true
							end

							v22 = v22 .. ("\n  %s"):format(v27[i - 2])
							sum = sum + 1
						end

						v22 = v22 .. ("\n  %s"):format(v27[i - 1])
						sum = sum + 1
					end

					count2 = 0

					if v27 == v6 then
						v22 = v22 .. ("\n%s %s"):format(v24, v27[i])
					else
						v1 = v1 .. ("\n%s %s"):format(v24, v27[i])
					end

					sum = sum + 1
				else
					v28 = v7[i]
					v29 = v6[i]
					v30 = if v29 == v28 then false else not boolean.toJSBoolean(string.endsWith(v29, ",")) or (if string.slice(v29, 0, -1) == v28 then false else true)

					if v30 and (string.endsWith(v28, ",") and string.slice(v28, 0, -1) == v29) then
						v30 = false
						v29 = v29 .. ","
					end

					if v30 then
						if count2 > 2 then
							if count2 > 3 then
								if count2 > 4 and count2 == 5 then
									v22 = v22 .. ("\n  %s"):format(v6[i - 3])
									sum = sum + 1
								elseif count2 > 4 then
									v22 = v22 .. ("\n%s...%s"):format(v2, v5)
									v42 = true
								end

								v22 = v22 .. ("\n  %s"):format(v6[i - 2])
								sum = sum + 1
							end

							v22 = v22 .. ("\n  %s"):format(v6[i - 1])
							sum = sum + 1
						end

						v22 = v22 .. ("\n%s+%s %s"):format(v3, v5, v29)
						v1 = v1 .. ("\n%s-%s %s"):format(v4, v5, v28)
						count2 = 0
						sum = sum + 2
					else
						v22 = v22 .. v1
						v1 = ""
						count2 = count2 + 1

						if count2 <= 2 then
							v22 = v22 .. ("\n  %s"):format(v29)
							sum = sum + 1
						end
					end
				end

				if sum > 50 and i < v18 - 2 then
					return ("%s%s\n%s\n%s...%s%s\n"):format(v222, v23, v22, v2, v5, v1) .. ("%s...%s"):format(v2, v5)
				end
			end

			v31 = "%s%s\n%s%s%s%s"
			v322 = if v42 then v23 else ""

			return v31:format(v222, v322, v22, v1, v32, v8)
		end

		v15 = v6[#v6]
		v16 = v7[#v7]
		count = v17
	end

	v18 = math.max(#v6, #v7)

	if v18 == 0 then
		v19 = string.split(v52, "\n")

		if #v19 > 50 then
			v19[47] = ("%s...%s"):format(v2, v5)

			while #v19 > 47 do
				table.remove(v19)
			end
		end

		return ("%s\n\n"):format("Values have same structure but are not reference-equal:") .. ("%s\n"):format(Array.join(v19, "\n"))
	end

	if count >= 5 then
		v20 = ("\n%s...%s%s"):format(v2, v5, v32)
		v32 = v20
		v42 = true
	end

	if v1 ~= "" then
		v21 = ("\n  %s%s"):format(v1, v32)
		v1 = ""
		v32 = v21
	end

	sum = 0
	count2 = 0
	v222 = t2[p3] .. ("\n%s+ actual%s %s- expected%s"):format(v3, v5, v4, v5)
	v23 = (" %s...%s Lines skipped"):format(v2, v5)
	v24 = ("%s+%s"):format(v3, v5)

	if #v6 < v18 then
		v25 = ("%s-%s"):format(v4, v5)
		v24 = v25
		v26 = #v6
		v27 = v7
	else
		v26 = #v7
		v27 = v6
	end

	for i = 1, v18 do
		if v26 < i then
			if count2 > 2 then
				if count2 > 3 then
					if count2 > 4 and count2 == 5 then
						v22 = v22 .. ("\n  %s"):format(v27[i - 3])
						sum = sum + 1
					elseif count2 > 4 then
						v22 = v22 .. ("\n%s...%s"):format(v2, v5)
						v42 = true
					end

					v22 = v22 .. ("\n  %s"):format(v27[i - 2])
					sum = sum + 1
				end

				v22 = v22 .. ("\n  %s"):format(v27[i - 1])
				sum = sum + 1
			end

			count2 = 0

			if v27 == v6 then
				v22 = v22 .. ("\n%s %s"):format(v24, v27[i])
			else
				v1 = v1 .. ("\n%s %s"):format(v24, v27[i])
			end

			sum = sum + 1
		else
			v28 = v7[i]
			v29 = v6[i]
			v30 = if v29 == v28 then false else not boolean.toJSBoolean(string.endsWith(v29, ",")) or (if string.slice(v29, 0, -1) == v28 then false else true)

			if v30 and (string.endsWith(v28, ",") and string.slice(v28, 0, -1) == v29) then
				v30 = false
				v29 = v29 .. ","
			end

			if v30 then
				if count2 > 2 then
					if count2 > 3 then
						if count2 > 4 and count2 == 5 then
							v22 = v22 .. ("\n  %s"):format(v6[i - 3])
							sum = sum + 1
						elseif count2 > 4 then
							v22 = v22 .. ("\n%s...%s"):format(v2, v5)
							v42 = true
						end

						v22 = v22 .. ("\n  %s"):format(v6[i - 2])
						sum = sum + 1
					end

					v22 = v22 .. ("\n  %s"):format(v6[i - 1])
					sum = sum + 1
				end

				v22 = v22 .. ("\n%s+%s %s"):format(v3, v5, v29)
				v1 = v1 .. ("\n%s-%s %s"):format(v4, v5, v28)
				count2 = 0
				sum = sum + 2
			else
				v22 = v22 .. v1
				v1 = ""
				count2 = count2 + 1

				if count2 <= 2 then
					v22 = v22 .. ("\n  %s"):format(v29)
					sum = sum + 1
				end
			end
		end

		if sum > 50 and i < v18 - 2 then
			return ("%s%s\n%s\n%s...%s%s\n"):format(v222, v23, v22, v2, v5, v1) .. ("%s...%s"):format(v2, v5)
		end
	end

	v31 = "%s%s\n%s%s%s%s"
	v322 = if v42 then v23 else ""

	return v31:format(v222, v322, v22, v1, v32, v8)
end

local v6 = setmetatable({}, {
	__index = Error
})

v6.__index = v6
function v6.__tostring(p1) --[[ Line: 391 ]]
	return p1:toString()
end
function v6.new(p1) --[[ new | Line: 404 | Upvalues: Error (copy), v6 (copy), t (copy), v2 (ref), v3 (ref), v5 (ref), v4 (ref), Array (copy), Object (copy), v1 (copy), createErrDiff (copy), t2 (copy), string (copy), inspect (copy), boolean (copy) ]]
	local message = p1.message
	local operator = p1.operator
	local stackStartFn = p1.stackStartFn
	local actual = p1.actual
	local expected = p1.expected
	local v12

	if message == nil then
		if t.stderr.isTTY then
			if t.stderr:hasColors() then
				v2 = "\27[34m"
				v3 = "\27[32m"
				v5 = "\27[39m"
				v4 = "\27[31m"
			else
				v2 = ""
				v3 = ""
				v5 = ""
				v4 = ""
			end
		end

		if typeof(actual) == "table" and (actual ~= nil and (typeof(expected) == "table" and (expected ~= nil and (Array.indexOf(Object.keys(actual), "stack") ~= -1 and (v1(actual, Error) and (Array.indexOf(Object.keys(expected), "stack") ~= -1 and v1(expected, Error))))))) then
			v22 = actual
			v32 = {}

			for v42, v52 in Object.keys(actual) do
				v32[v52] = v22[v52]
			end

			v32.message = v22.message

			local v62, v7

			v62 = expected
			v7 = {}
			actual = v32

			for v8, v9 in Object.keys(expected) do
				v7[v9] = v62[v9]
			end

			v7.message = v62.message
			expected = v7
		end

		if operator == "deepStrictEqual" or operator == "strictEqual" then
			v12 = setmetatable(Error.new(createErrDiff(actual, expected, operator)), v6)
		elseif operator == "notDeepStrictEqual" or operator == "notStrictEqual" then
			local v13 = t2[operator]
			local v14 = string.split(inspect(actual, {
				compact = false,
				customInspect = false,
				depth = 1000,
				maxArrayLength = (1 / 0),
				showHidden = false,
				showProxy = false,
				sorted = true,
				getters = true
			}), "\n")

			if operator == "notStrictEqual" and (typeof(actual) == "table" and actual ~= nil or typeof(actual) == "function") then
				v13 = "Expected \"actual\" not to be reference-equal to \"expected\":"
			end

			if #v14 > 50 then
				v14[47] = ("%s...%s"):format(v2, v5)

				while #v14 > 47 do
					table.remove(v14)
				end
			end

			v12 = if #v14 == 1 then setmetatable(Error.new(("%s%s%s"):format(v13, if string.len(v14[1]) > 5 then "\n\n" else " ", v14[1])), v6) else setmetatable(Error.new(("%s\n\n%s\n"):format(v13, Array.join(v14, "\n"))), v6)
		else
			local v25 = inspect(actual, {
				compact = false,
				customInspect = false,
				depth = 1000,
				maxArrayLength = (1 / 0),
				showHidden = false,
				showProxy = false,
				sorted = true,
				getters = true
			})
			local v26 = inspect(expected, {
				compact = false,
				customInspect = false,
				depth = 1000,
				maxArrayLength = (1 / 0),
				showHidden = false,
				showProxy = false,
				sorted = true,
				getters = true
			})
			local v27 = t2[tostring(operator)]

			if operator == "notDeepEqual" and v25 == v26 then
				local v28 = ("%s\n\n%s"):format(v27, v25)

				v12 = setmetatable(Error.new(if string.len(v28) > 1024 then ("%s..."):format(string.slice(v28, 0, 1021)) else v28), v6)
			else
				v34 = v25
				v35 = v26

				if string.len(v34) > 512 then
					v34 = ("%s..."):format(string.slice(v34, 0, 509))
				end

				if string.len(v35) > 512 then
					v35 = ("%s..."):format(string.slice(v35, 0, 509))
				end

				if operator == "deepEqual" then
					v34 = ("%s\n\n%s\n\nshould loosely deep-equal\n\n"):format(v27, v34)
				else
					local v39 = t2[("%sUnequal"):format((tostring(operator)))]

					if boolean.toJSBoolean(v39) then
						v34 = ("%s\n\n%s\n\nshould not loosely deep-equal\n\n"):format(v39, v34)
					else
						v35 = (" %s %s"):format(tostring(operator), v35)
					end
				end

				v12 = setmetatable(Error.new(("%s%s"):format(v34, v35)), v6)
			end
		end
	else
		v12 = setmetatable(Error.new((tostring(message))), v6)
	end

	v12.generatedMessage = not boolean.toJSBoolean(message)
	v12.name = "AssertionError [ERR_ASSERTION]"
	v12.code = "ERR_ASSERTION"
	v12.actual = actual
	v12.expected = expected
	v12.operator = operator

	local v48 = ErrorCaptureStackTrace

	v48(v12, if stackStartFn then stackStartFn else v6.new)
	v12.name = "AssertionError"

	return v12
end
function v6.toString(p1) --[[ toString | Line: 573 ]]
	return ("%s [%s]: %s"):format(p1.name, p1.code, p1.message)
end
v6.name = "AssertionError"

return {
	AssertionError = v6
}