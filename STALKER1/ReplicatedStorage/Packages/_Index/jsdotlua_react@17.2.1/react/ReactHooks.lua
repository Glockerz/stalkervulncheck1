-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Array = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Array
local console = require(script.Parent.Parent:WaitForChild("shared")).console

require(script.Parent.Parent:WaitForChild("shared"))
require(script.Parent.Parent:WaitForChild("shared"))

local ReactCurrentDispatcher = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentDispatcher

local function resolveDispatcher() --[[ resolveDispatcher | Line: 44 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
	local current = ReactCurrentDispatcher.current

	if _G.__DEV__ and current == nil then
		console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
	end

	return current
end

return {
	useContext = function(p1, p2, ...) --[[ useContext | Line: 67 | Upvalues: ReactCurrentDispatcher (copy), console (copy), Array (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		local v1

		if _G.__DEV__ then
			if p2 == nil then
				v1 = current
			else
				local v4, v5

				if typeof(p2) == "number" and Array.isArray({ ... }) then
					v4 = p2
					v5 = "\n\nDid you call Array.map(useContext)? Calling Hooks inside a loop is not supported. Learn more at https://reactjs.org/link/rules-of-hooks"
					v1 = current
				else
					v4 = p2
					v5 = ""
					v1 = current
				end

				console.error("useContext() second argument is reserved for future use in React. Passing it is not supported. You passed: %s.%s", v4, v5)
			end

			if p1._context ~= nil then
				local _context = p1._context

				if _context.Consumer == p1 then
					console.error("Calling useContext(Context.Consumer) is not supported, may cause bugs, and will be removed in a future major release. Did you mean to call useContext(Context) instead?")
				elseif _context.Provider == p1 then
					console.error("Calling useContext(Context.Provider) is not supported. Did you mean to call useContext(Context) instead?")
				end
			end
		else
			v1 = current
		end

		return v1.useContext(p1, p2)
	end,
	useState = function(p1, ...) --[[ useState | Line: 108 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useState(p1, ...)
	end,
	useReducer = function(p1, p2, p3) --[[ useReducer | Line: 117 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useReducer(p1, p2, p3)
	end,
	useRef = function(p1) --[[ useRef | Line: 128 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useRef(p1)
	end,
	useBinding = function(p1) --[[ useBinding | Line: 135 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useBinding(p1)
	end,
	useEffect = function(p1, p2) --[[ useEffect | Line: 147 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useEffect(p1, p2)
	end,
	useLayoutEffect = function(p1, p2) --[[ useLayoutEffect | Line: 157 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useLayoutEffect(p1, p2)
	end,
	useCallback = function(p1, p2) --[[ useCallback | Line: 167 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useCallback(p1, p2)
	end,
	useMemo = function(p1, p2) --[[ useMemo | Line: 173 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useMemo(p1, p2)
	end,
	useImperativeHandle = function(p1, p2, p3) --[[ useImperativeHandle | Line: 179 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useImperativeHandle(p1, p2, p3)
	end,
	useDebugValue = function(p1, p2) --[[ useDebugValue | Line: 189 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		if not _G.__DEV__ then
			return nil
		end

		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useDebugValue(p1, p2)
	end,
	emptyObject = {},
	useOpaqueIdentifier = function() --[[ Line: 214 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useOpaqueIdentifier()
	end,
	useMutableSource = function(p1, p2, p3) --[[ Line: 220 | Upvalues: ReactCurrentDispatcher (copy), console (copy) ]]
		local current = ReactCurrentDispatcher.current

		if _G.__DEV__ and current == nil then
			console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.")
		end

		return current.useMutableSource(p1, p2, p3)
	end
}