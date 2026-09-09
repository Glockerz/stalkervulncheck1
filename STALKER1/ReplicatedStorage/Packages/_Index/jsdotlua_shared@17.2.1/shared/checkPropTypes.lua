-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Error = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Error
local console = require(script.Parent:WaitForChild("console"))
local t = {}
local describeUnknownElementTypeFrameInDEV = require(script.Parent:WaitForChild("ReactComponentStackFrame")).describeUnknownElementTypeFrameInDEV
local ReactSharedInternals = require(script.Parent:WaitForChild("ReactSharedInternals"))
local describeError = require(script.Parent:WaitForChild("ErrorHandling.roblox")).describeError
local ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame

local function setCurrentlyValidatingElement(p1) --[[ setCurrentlyValidatingElement | Line: 32 | Upvalues: describeUnknownElementTypeFrameInDEV (copy), ReactDebugCurrentFrame (copy) ]]
	if not _G.__DEV__ then
		return
	end

	if p1 then
		local _owner = p1._owner

		ReactDebugCurrentFrame.setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p1.type, p1._source, if _owner == nil then nil else _owner.type)))
	else
		ReactDebugCurrentFrame.setExtraStackFrame(nil)
	end
end

return function(p1, p2, p3, p4, p5, p6) --[[ checkPropTypes | Line: 49 | Upvalues: console (copy), Error (copy), describeError (copy), describeUnknownElementTypeFrameInDEV (copy), ReactDebugCurrentFrame (copy), t (copy) ]]
	if not (_G.__DEV__ or _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) then
		return
	end

	if p1 and p2 then
		console.warn("You\'ve defined both propTypes and validateProps on " .. (p5 or "a component"))
	end

	if p2 and typeof(p2) == "function" then
		local v1, v2 = p2(p3)

		if not v1 then
			error((string.format("validateProps failed on a %s type in %s: %s", p4, p5 or "<UNKNOWN Component>", (tostring(v2 or "<Validator function did not supply a message>")))))
		end
	elseif p2 then
		console.error(("validateProps must be a function, but it is a %s.\nCheck the definition of the component %q."):format(typeof(p2), p5 or ""))
	end

	if not p1 then
		return
	end

	assert(if typeof(p1) == "table" then true else false, "propTypes needs to be a table")

	for v5, v6 in p1 do
		local _, result = xpcall(function() --[[ Line: 113 | Upvalues: p1 (copy), v5 (copy), Error (ref), p5 (copy), p4 (copy), p3 (copy) ]]
			if typeof(p1[v5]) == "function" then
				return p1[v5](p3, v5, p5, p4, nil, "SECRET_DO_NOT_PASS_THIS_OR_YOU_WILL_BE_FIRED")
			end

			local v7 = Error.new((p5 or "React class") .. ": " .. p4 .. " type `" .. v5 .. "` is invalid; " .. "it must be a function, usually from the `prop-types` package, but received `" .. typeof(p1[v5]) .. "`.This often happens because of typos such as `PropTypes.function` instead of `PropTypes.func`.")

			v7.name = "Invariant Violation"
			error(v7)
		end, describeError)
		local v7 = if typeof(result) == "table" then true else false

		if result ~= nil and not v7 then
			if _G.__DEV__ then
				if p6 then
					local _owner = p6._owner

					ReactDebugCurrentFrame.setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p6.type, p6._source, if _owner == nil then nil else _owner.type)))
				else
					ReactDebugCurrentFrame.setExtraStackFrame(nil)
				end
			end

			console.error(string.format("%s: type specification of %s `%s` is invalid; the type checker function must return `nil` or an `Error` but returned a %s. You may have forgotten to pass an argument to the type checker creator (arrayOf, instanceOf, objectOf, oneOf, oneOfType, and shape all require an argument).", p5 or "React class", p4, v5, (typeof(result))))

			if _G.__DEV__ then
				ReactDebugCurrentFrame.setExtraStackFrame(nil)
			end
		end

		if v7 and t[result.message] == nil then
			t[tostring(result.message)] = true

			if _G.__DEV__ then
				if p6 then
					local _owner = p6._owner

					ReactDebugCurrentFrame.setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p6.type, p6._source, if _owner == nil then nil else _owner.type)))
				else
					ReactDebugCurrentFrame.setExtraStackFrame(nil)
				end
			end

			console.warn(string.format("Failed %s type: %s", p4, (tostring(result.message))))

			if _G.__DEV__ then
				ReactDebugCurrentFrame.setExtraStackFrame(nil)
			end
		end
	end
end