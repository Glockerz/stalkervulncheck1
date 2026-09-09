-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Array = v1.Array
local Boolean = v1.Boolean
local Object = v1.Object
local console = require(script.Parent.Parent:WaitForChild("shared")).console
local inspect = v1.util.inspect

require(script.Parent.Parent:WaitForChild("shared"))

local isValidElementType = require(script.Parent.Parent:WaitForChild("shared")).isValidElementType
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local ReactSymbols = require(script.Parent.Parent:WaitForChild("shared")).ReactSymbols
local getIteratorFn = ReactSymbols.getIteratorFn
local REACT_FORWARD_REF_TYPE = ReactSymbols.REACT_FORWARD_REF_TYPE
local REACT_MEMO_TYPE = ReactSymbols.REACT_MEMO_TYPE
local REACT_FRAGMENT_TYPE = ReactSymbols.REACT_FRAGMENT_TYPE
local REACT_ELEMENT_TYPE = ReactSymbols.REACT_ELEMENT_TYPE
local warnAboutSpreadingKeyToJSX = require(script.Parent.Parent:WaitForChild("shared")).ReactFeatureFlags.warnAboutSpreadingKeyToJSX
local checkPropTypes = require(script.Parent.Parent:WaitForChild("shared")).checkPropTypes
local ReactCurrentOwner = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentOwner
local ReactElement = require(script.Parent:WaitForChild("ReactElement"))
local isValidElement = ReactElement.isValidElement
local createElement = ReactElement.createElement
local cloneElement = ReactElement.cloneElement
local jsxDEV = ReactElement.jsxDEV
local setExtraStackFrame = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactDebugCurrentFrame.setExtraStackFrame
local describeUnknownElementTypeFrameInDEV = require(script.Parent.Parent:WaitForChild("shared")).ReactComponentStackFrame.describeUnknownElementTypeFrameInDEV
local t = {}

local function setCurrentlyValidatingElement(p1) --[[ setCurrentlyValidatingElement | Line: 63 | Upvalues: describeUnknownElementTypeFrameInDEV (copy), setExtraStackFrame (copy) ]]
	if not _G.__DEV__ then
		return
	end

	if p1 then
		local _owner = p1._owner

		setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p1.type, p1._source, if _owner then _owner.type else nil)))
	else
		setExtraStackFrame(nil)
	end
end

local v2 = if _G.__DEV__ then false else nil

local function hasOwnProperty(p1, p2) --[[ hasOwnProperty | Line: 91 ]]
	return p1[p2] ~= nil
end

local function getDeclarationErrorAddendum() --[[ getDeclarationErrorAddendum | Line: 95 | Upvalues: ReactCurrentOwner (copy), getComponentName (copy) ]]
	if not ReactCurrentOwner.current then
		return ""
	end

	local v1 = getComponentName(ReactCurrentOwner.current.type)

	if v1 then
		return "\n\nCheck the render method of `" .. v1 .. "`."
	end

	return ""
end

local function getSourceInfoErrorAddendum(p1) --[[ getSourceInfoErrorAddendum | Line: 106 ]]
	if p1 == nil then
		return ""
	end

	return "\n\nCheck your code at " .. string.gsub(p1.fileName, "^.*[\\/]", "") .. ":" .. p1.lineNumber .. "."
end

local function getSourceInfoErrorAddendumForProps(p1) --[[ getSourceInfoErrorAddendumForProps | Line: 116 ]]
	if p1 == nil then
		return ""
	end

	local __source = p1.__source

	if __source == nil then
		return ""
	end

	return "\n\nCheck your code at " .. string.gsub(__source.fileName, "^.*[\\/]", "") .. ":" .. __source.lineNumber .. "."
end

local t2 = {}

local function getCurrentComponentErrorInfo(p1) --[[ getCurrentComponentErrorInfo | Line: 133 | Upvalues: ReactCurrentOwner (copy), getComponentName (copy), Boolean (copy) ]]
	local v1

	if ReactCurrentOwner.current then
		local v2 = getComponentName(ReactCurrentOwner.current.type)

		v1 = if v2 then "\n\nCheck the render method of `" .. v2 .. "`." else ""
	else
		v1 = ""
	end

	if not Boolean.toJSBoolean(v1) then
		local v3 = if typeof(p1) == "string" then p1 elseif typeof(p1) == "table" then p1.displayName or p1.name else nil

		if not v3 and typeof(p1) == "function" then
			local v4 = debug.info(p1, "n")

			v3 = if v4 == "" then nil else v4
		end

		if v3 then
			v1 = string.format("\n\nCheck the top-level render call using <%s>.", v3)
		end
	end

	return v1
end

local function validateExplicitKey(p1, p2, p3) --[[ validateExplicitKey | Line: 175 | Upvalues: getCurrentComponentErrorInfo (copy), t2 (copy), ReactCurrentOwner (copy), getComponentName (copy), describeUnknownElementTypeFrameInDEV (copy), setExtraStackFrame (copy), console (copy) ]]
	if p1._store == nil or p1._store.validated then
		return
	end

	p1._store.validated = true

	if (if p1.key == nil then false else true) ~= (if p3 == nil then false else true) then
		return
	end

	local v3 = getCurrentComponentErrorInfo(p2)

	if t2[v3] then
		return
	end

	t2[v3] = true

	local v4 = if p1 and (p1._owner and p1._owner ~= ReactCurrentOwner.current) then string.format(" It was passed a child from %s.", (tostring(getComponentName(p1._owner.type)))) else ""

	if not _G.__DEV__ then
		return
	end

	if _G.__DEV__ then
		if p1 then
			local _owner = p1._owner

			setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p1.type, p1._source, if _owner then _owner.type else nil)))
		else
			setExtraStackFrame(nil)
		end
	end

	if p1.key == nil or p3 == nil then
		console.error("Each child in a list should have a unique \"key\" prop.%s%s See https://reactjs.org/link/warning-keys for more information.", v3, v4)
	else
		console.error("Child element received a \"key\" prop (\"%s\") in addition to a key in the \"children\" table of its parent (\"%s\"). Please provide only one key definition. When both are present, the \"key\" prop will take precedence.%s%s See https://reactjs.org/link/warning-keys for more information.", tostring(p1.key), tostring(p3), v3, v4)
	end

	if not _G.__DEV__ then
		return
	end

	setExtraStackFrame(nil)
end

local function validateChildKeys(p1, p2) --[[ validateChildKeys | Line: 250 | Upvalues: Array (copy), isValidElement (copy), validateExplicitKey (copy), getIteratorFn (copy) ]]
	if typeof(p1) ~= "table" then
		return
	end

	if Array.isArray(p1) then
		for i = 1, #p1 do
			local v1 = p1[i]

			if isValidElement(v1) then
				validateExplicitKey(v1, p2)
			end
		end
	elseif isValidElement(p1) then
		if p1._store then
			p1._store.validated = true
		end
	else
		if not p1 then
			return
		end

		local v2 = getIteratorFn(p1)

		if typeof(v2) ~= "function" or v2 == p1.entries then
			return
		end

		local v3 = v2(p1)
		local v4 = v3.next()

		while not v4.done do
			if isValidElement(v4.value) then
				validateExplicitKey(v4.value, p2, v4.key)
			end

			v4 = v3.next()
		end
	end
end

local function validatePropTypes(p1) --[[ validatePropTypes | Line: 293 | Upvalues: getComponentName (copy), checkPropTypes (copy), v2 (ref), console (copy) ]]
	if not (_G.__DEV__ or _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__) then
		return
	end

	local v1 = p1.type

	if v1 == nil or typeof(v1) == "string" then
		return
	end

	if typeof(v1) == "function" then
		return
	end

	if typeof(v1) ~= "table" then
		return
	end

	local propTypes = v1.propTypes
	local validateProps = v1.validateProps

	if propTypes or validateProps then
		checkPropTypes(propTypes, validateProps, p1.props, "prop", getComponentName(v1), p1)
	elseif v1.PropTypes ~= nil and not v2 then
		v2 = true
		console.error("Component %s declared `PropTypes` instead of `propTypes`. Did you misspell the property assignment?", getComponentName(v1) or "Unknown")
	end

	if v1.getDefaultProps == nil then
		return
	end

	console.error("getDefaultProps is only used on classic React.createClass definitions. Use a static property named `defaultProps` instead.")
end

local function validateFragmentProps(p1) --[[ validateFragmentProps | Line: 343 | Upvalues: Object (copy), describeUnknownElementTypeFrameInDEV (copy), setExtraStackFrame (copy), console (copy) ]]
	if not _G.__DEV__ then
		return
	end

	local v1 = Object.keys(p1.props)

	for i = 1, #v1 do
		local v2 = v1[i]

		if v2 ~= "children" and v2 ~= "key" then
			if _G.__DEV__ then
				if p1 then
					local _owner = p1._owner

					setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p1.type, p1._source, if _owner then _owner.type else nil)))
				else
					setExtraStackFrame(nil)
				end
			end

			console.error("Invalid prop `%s` supplied to `React.Fragment`. React.Fragment can only have `key` and `children` props.", v2)

			if _G.__DEV__ then
				setExtraStackFrame(nil)
			end

			break
		end
	end

	if p1.ref == nil then
		return
	end

	if _G.__DEV__ then
		if p1 then
			local _owner = p1._owner

			setExtraStackFrame((describeUnknownElementTypeFrameInDEV(p1.type, p1._source, if _owner then _owner.type else nil)))
		else
			setExtraStackFrame(nil)
		end
	end

	console.error("Invalid attribute `ref` supplied to `React.Fragment`.")

	if not _G.__DEV__ then
		return
	end

	setExtraStackFrame(nil)
end

local function jsxWithValidation(p1, p2, p3, p4, p5, p6) --[[ jsxWithValidation | Line: 369 | Upvalues: isValidElementType (copy), Object (copy), ReactCurrentOwner (copy), getComponentName (copy), Array (copy), REACT_ELEMENT_TYPE (copy), inspect (copy), console (copy), jsxDEV (copy), validateChildKeys (copy), warnAboutSpreadingKeyToJSX (copy), REACT_FRAGMENT_TYPE (copy), validateFragmentProps (copy), validatePropTypes (copy) ]]
	local v1 = isValidElementType(p1)

	if not v1 then
		local v2 = ""

		if p1 == nil or typeof(p1) == "table" and #Object.keys(p1) == 0 then
			v2 = v2 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports."
		end

		local v3 = if p5 == nil then "" else "\n\nCheck your code at " .. string.gsub(p5.fileName, "^.*[\\/]", "") .. ":" .. p5.lineNumber .. "."
		local v4

		if v3 then
			v4 = v2 .. v3
		else
			local v5, v6

			if ReactCurrentOwner.current then
				local v7 = getComponentName(ReactCurrentOwner.current.type)

				if v7 then
					v5 = v2
					v6 = "\n\nCheck the render method of `" .. v7 .. "`."
				else
					v5 = v2
					v6 = ""
				end
			else
				v5 = v2
				v6 = ""
			end

			v4 = v5 .. v6
		end

		local v8

		if p1 == nil then
			v8 = "nil"
		elseif Array.isArray(p1) then
			v8 = "array"
		elseif typeof(p1) == "table" and p1["$$typeof"] == REACT_ELEMENT_TYPE then
			v8, v4 = string.format("<%s />", getComponentName(p1.type) or "Unknown"), v4 .. " Did you accidentally export a JSX literal or Element instead of a component?"
		else
			local v10 = typeof(p1)

			v4 = v4 .. "\n" .. inspect(p1)
			v8 = v10
		end

		if _G.__DEV__ then
			console.error("React.jsx: type is invalid -- expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s", v8, v4)
		end
	end

	local v11 = jsxDEV(p1, p2, p3, p5, p6)

	if v11 == nil then
		return v11
	end

	if v1 then
		local children = p2.children

		if children ~= nil and p4 then
			if Array.isArray(children) then
				for i = 1, #children do
					validateChildKeys(children[i], p1)
				end

				Object.freeze(children)
			elseif _G.__DEV__ then
				console.error("React.jsx: Static children should always be an array. You are likely explicitly calling React.jsxs or React.jsxDEV. Use the Babel transform instead.")
			end
		elseif children ~= nil then
			validateChildKeys(children, p1)
		end
	end

	if _G.__DEV__ and warnAboutSpreadingKeyToJSX and p2.key ~= nil then
		console.error("React.jsx: Spreading a key to JSX is a deprecated pattern. Explicitly pass a key after spreading props in your JSX call. E.g. <%s {...props} key={key} />", getComponentName(p1) or "ComponentName")
	end

	if p1 == REACT_FRAGMENT_TYPE then
		validateFragmentProps(v11)
	else
		validatePropTypes(v11)
	end

	return v11
end

t.jsxWithValidation = jsxWithValidation
function t.jsxWithValidationStatic(p1, p2, p3) --[[ Line: 491 | Upvalues: jsxWithValidation (copy) ]]
	return jsxWithValidation(p1, p2, p3, true)
end
function t.jsxWithValidationDynamic(p1, p2, p3) --[[ Line: 495 | Upvalues: jsxWithValidation (copy) ]]
	return jsxWithValidation(p1, p2, p3, false)
end
function t.createElementWithValidation(p1, p2, ...) --[[ createElementWithValidation | Line: 500 | Upvalues: isValidElementType (copy), Object (copy), ReactCurrentOwner (copy), getComponentName (copy), Array (copy), REACT_ELEMENT_TYPE (copy), inspect (copy), console (copy), createElement (copy), validateChildKeys (copy), REACT_FRAGMENT_TYPE (copy), validateFragmentProps (copy), validatePropTypes (copy) ]]
	local v1 = isValidElementType(p1)

	if not v1 then
		local v2 = ""

		if p1 == nil or typeof(p1) == "table" and #Object.keys(p1) == 0 then
			v2 = v2 .. " You likely forgot to export your component from the file it\'s defined in, or you might have mixed up default and named imports."
		end

		local v3

		if p2 == nil then
			v3 = ""
		else
			local __source = p2.__source

			v3 = if __source == nil then "" else "\n\nCheck your code at " .. string.gsub(__source.fileName, "^.*[\\/]", "") .. ":" .. __source.lineNumber .. "."
		end

		local v4

		if v3 then
			v4 = v2 .. v3
		else
			local v5, v6

			if ReactCurrentOwner.current then
				local v7 = getComponentName(ReactCurrentOwner.current.type)

				if v7 then
					v5 = v2
					v6 = "\n\nCheck the render method of `" .. v7 .. "`."
				else
					v5 = v2
					v6 = ""
				end
			else
				v5 = v2
				v6 = ""
			end

			v4 = v5 .. v6
		end

		local v8

		if p1 == nil then
			v8 = "nil"
		elseif Array.isArray(p1) then
			v8 = "array"
		elseif p1 == nil or (typeof(p1) ~= "table" or p1["$$typeof"] ~= REACT_ELEMENT_TYPE) then
			local v9 = typeof(p1)

			if p1 ~= nil then
				v4 = v4 .. "\n" .. inspect(p1)
			end

			v8 = v9
		else
			v8, v4 = string.format("<%s />", getComponentName(p1.type) or "Unknown"), v4 .. " Did you accidentally export a JSX literal or Element instead of a component?"
		end

		if _G.__DEV__ then
			console.error("React.createElement: type is invalid -- expected a string (for built-in components) or a class/function (for composite components) but got: %s.%s", v8, v4)
		end
	end

	local v11 = createElement(p1, p2, ...)

	if v11 == nil then
		return v11
	end

	if v1 then
		for i = 1, select("#", ...) do
			validateChildKeys(select(i, ...), p1)
		end
	end

	if p1 == REACT_FRAGMENT_TYPE then
		validateFragmentProps(v11)
	else
		validatePropTypes(v11)
	end

	return v11
end
function t.cloneElementWithValidation(p1, p2, ...) --[[ Line: 633 | Upvalues: cloneElement (copy), validateChildKeys (copy), validatePropTypes (copy) ]]
	local t = { p1, p2, ... }
	local v1 = cloneElement(p1, p2, ...)

	for i = 3, #t do
		validateChildKeys(t[i], v1.type)
	end

	validatePropTypes(v1)

	return v1
end

return t