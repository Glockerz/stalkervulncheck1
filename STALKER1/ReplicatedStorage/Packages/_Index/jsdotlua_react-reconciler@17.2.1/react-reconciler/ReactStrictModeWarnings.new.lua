-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent:WaitForChild("ReactInternalTypes"))

local ReactCurrentFiber = require(script.Parent:WaitForChild("ReactCurrentFiber"))
local resetCurrentFiber = ReactCurrentFiber.resetCurrentFiber
local setCurrentFiber = ReactCurrentFiber.setCurrentFiber
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName
local StrictMode = require(script.Parent:WaitForChild("ReactTypeOfMode")).StrictMode
local t = {
	recordUnsafeLifecycleWarnings = function(p1, p2) --[[ recordUnsafeLifecycleWarnings | Line: 30 ]] end,
	flushPendingUnsafeLifecycleWarnings = function() --[[ flushPendingUnsafeLifecycleWarnings | Line: 31 ]] end,
	recordLegacyContextWarning = function(p1, p2) --[[ recordLegacyContextWarning | Line: 32 ]] end,
	flushLegacyContextWarning = function() --[[ flushLegacyContextWarning | Line: 33 ]] end,
	discardPendingWarnings = function() --[[ discardPendingWarnings | Line: 34 ]] end
}

if _G.__DEV__ then
	local function f1(p1) --[[ Line: 53 ]]
		local t = {}

		for v1, v2 in p1 do
			table.insert(t, v1)
		end

		table.sort(t)

		return table.concat(t, ", ")
	end

	local t2 = {}
	local t3 = {}
	local t4 = {}
	local t5 = {}
	local t6 = {}
	local t7 = {}
	local t8 = {}

	function t.recordUnsafeLifecycleWarnings(p1, p2) --[[ Line: 73 | Upvalues: t8 (copy), t2 (copy), StrictMode (copy), t3 (copy), t4 (copy), t5 (copy), t6 (copy), t7 (copy) ]]
		if t8[p1.type] then
			return
		end

		if typeof(p2.componentWillMount) == "function" then
			table.insert(t2, p1)
		end

		if bit32.band(p1.mode, StrictMode) ~= 0 and typeof(p2.UNSAFE_componentWillMount) == "function" then
			table.insert(t3, p1)
		end

		if typeof(p2.componentWillReceiveProps) == "function" then
			table.insert(t4, p1)
		end

		if bit32.band(p1.mode, StrictMode) ~= 0 and typeof(p2.UNSAFE_componentWillReceiveProps) == "function" then
			table.insert(t5, p1)
		end

		if typeof(p2.componentWillUpdate) == "function" then
			table.insert(t6, p1)
		end

		if bit32.band(p1.mode, StrictMode) == 0 then
			return
		end

		if typeof(p2.UNSAFE_componentWillUpdate) ~= "function" then
			return
		end

		table.insert(t7, p1)
	end
	function t.flushPendingUnsafeLifecycleWarnings() --[[ Line: 126 | Upvalues: t2 (copy), getComponentName (copy), t8 (copy), t3 (copy), t4 (copy), t5 (copy), t6 (copy), t7 (copy), f1 (copy), console (copy) ]]
		local t = {}

		if #t2 > 0 then
			for v1, v2 in t2 do
				t[getComponentName(v2.type) or "Component"] = true
				t8[v2.type] = true
			end

			table.clear(t2)
		end

		local t9 = {}

		if #t3 > 0 then
			for v3, v4 in t3 do
				t9[getComponentName(v4.type) or "Component"] = true
				t8[v4.type] = true
			end

			table.clear(t3)
		end

		local t10 = {}

		if #t4 > 0 then
			for v5, v6 in t4 do
				t10[getComponentName(v6.type) or "Component"] = true
				t8[v6.type] = true
			end

			table.clear(t4)
		end

		local t11 = {}

		if #t5 > 0 then
			for v7, v8 in t5 do
				t11[getComponentName(v8.type) or "Component"] = true
				t8[v8.type] = true
			end

			table.clear(t5)
		end

		local t12 = {}

		if #t6 > 0 then
			for v9, v10 in t6 do
				t12[getComponentName(v10.type) or "Component"] = true
				t8[v10.type] = true
			end

			table.clear(t6)
		end

		local t13 = {}

		if #t7 > 0 then
			for v11, v12 in t7 do
				t13[getComponentName(v12.type) or "Component"] = true
				t8[v12.type] = true
			end

			table.clear(t7)
		end

		if next(t9) ~= nil then
			console.error("Using UNSAFE_componentWillMount in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move code with side effects to componentDidMount, and set initial state in the constructor.\n\nPlease update the following components: %s", (f1(t9)))
		end

		if next(t11) ~= nil then
			console.error("Using UNSAFE_componentWillReceiveProps in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* If you\'re updating state whenever props change, refactor your code to use memoization techniques or move it to static getDerivedStateFromProps. Learn more at: https://reactjs.org/link/derived-state\n\nPlease update the following components: %s", (f1(t11)))
		end

		if next(t13) ~= nil then
			console.error("Using UNSAFE_componentWillUpdate in strict mode is not recommended and may indicate bugs in your code. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n\nPlease update the following components: %s", (f1(t13)))
		end

		if next(t) ~= nil then
			console.warn("componentWillMount has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move code with side effects to componentDidMount, and set initial state in the constructor.\n* Rename componentWillMount to UNSAFE_componentWillMount to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s", (f1(t)))
		end

		if next(t10) ~= nil then
			console.warn("componentWillReceiveProps has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* If you\'re updating state whenever props change, refactor your code to use memoization techniques or move it to static getDerivedStateFromProps. Learn more at: https://reactjs.org/link/derived-state\n* Rename componentWillReceiveProps to UNSAFE_componentWillReceiveProps to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s", (f1(t10)))
		end

		if next(t12) == nil then
			return
		end

		console.warn("componentWillUpdate has been renamed, and is not recommended for use. See https://reactjs.org/link/unsafe-component-lifecycles for details.\n\n* Move data fetching code or side effects to componentDidUpdate.\n* Rename componentWillUpdate to UNSAFE_componentWillUpdate to suppress this warning in non-strict mode. In React 18.x, only the UNSAFE_ name will work.\n\nPlease update the following components: %s", (f1(t12)))
	end

	local t9 = {}
	local t10 = {}

	function t.recordLegacyContextWarning(p1, p2) --[[ Line: 300 | Upvalues: StrictMode (copy), console (copy), t10 (copy), t9 (copy) ]]
		local v1, v2 = p1, nil

		while v1 ~= nil do
			if bit32.band(v1.mode, StrictMode) ~= 0 then
				v2 = v1
			end

			v1 = v1.return_
		end

		if v2 == nil then
			console.error("Expected to find a StrictMode component in a strict mode tree. This error is likely caused by a bug in React. Please file an issue.")

			return
		end

		if t10[p1.type] then
			return
		end

		local v4 = t9[v2]

		if typeof(p1.type) == "function" then
			return
		end

		if p1.type.contextTypes == nil and p1.type.childContextTypes == nil then
			if p2 == nil then
				return
			end

			if typeof(p2.getChildContext) ~= "function" then
				return
			end
		end

		if v4 == nil then
			v4 = {}
			t9[v2] = v4
		end

		table.insert(v4, p1)
	end
	function t.flushLegacyContextWarning() --[[ Line: 339 | Upvalues: t9 (copy), getComponentName (copy), t10 (copy), f1 (copy), setCurrentFiber (copy), console (copy), resetCurrentFiber (copy) ]]
		for v1, v2 in t9 do
			if #v2 == 0 then
				break
			end

			local v3 = v2[1]
			local t = {}

			for v4, v5 in v2 do
				t[getComponentName(v5.type) or "Component"] = true
				t10[v5.type] = true
			end

			local v6 = f1(t)
			local ok, result = pcall(function() --[[ Line: 354 | Upvalues: setCurrentFiber (ref), v3 (copy), console (ref), v6 (copy) ]]
				setCurrentFiber(v3)
				console.error("Legacy context API has been detected within a strict-mode tree.\n\nThe old API will be supported in all 16.x releases, but applications using it should migrate to the new version.\n\nPlease update the following components: %s\n\nLearn more about this warning here: https://reactjs.org/link/legacy-context", v6)
			end)

			resetCurrentFiber()

			if not ok then
				error(result)
			end
		end
	end
	function t.discardPendingWarnings() --[[ Line: 377 | Upvalues: t2 (copy), t3 (copy), t4 (copy), t5 (copy), t6 (copy), t7 (copy), t9 (copy) ]]
		table.clear(t2)
		table.clear(t3)
		table.clear(t4)
		table.clear(t5)
		table.clear(t6)
		table.clear(t7)
		table.clear(t9)
	end
end

return t