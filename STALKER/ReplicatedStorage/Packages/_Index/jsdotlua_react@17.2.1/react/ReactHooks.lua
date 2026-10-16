-- Decompiled with Potassium's decompiler.

local Array = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Array;
local console = require(script.Parent.Parent:WaitForChild("shared")).console;
require(script.Parent.Parent:WaitForChild("shared"));
require(script.Parent.Parent:WaitForChild("shared"));
local ReactCurrentDispatcher = require(script.Parent.Parent:WaitForChild("shared")).ReactSharedInternals.ReactCurrentDispatcher;

local function resolveDispatcher() -- Line: 44
    -- upvalues: ReactCurrentDispatcher (copy), console (copy)
    local current = ReactCurrentDispatcher.current;

    if _G.__DEV__ and current == nil then
        console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
    end;

    return current;
end;

return {
    useContext = function(p1, p2, ...) -- Line: 67, Name: useContext
        -- upvalues: ReactCurrentDispatcher (copy), console (copy), Array (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        if _G.__DEV__ then
            if p2 ~= nil then
                console.error("useContext() second argument is reserved for future use in React. Passing it is not supported. You passed: %s.%s", p2, typeof(p2) == "number" and Array.isArray({ ... }) and "\n\nDid you call Array.map(useContext)? Calling Hooks inside a loop is not supported. Learn more at https://reactjs.org/link/rules-of-hooks" or "");
            end;

            if p1._context ~= nil then
                local _context = p1._context;

                if _context.Consumer == p1 then
                    console.error("Calling useContext(Context.Consumer) is not supported, may cause bugs, and will be removed in a future major release. Did you mean to call useContext(Context) instead?");
                elseif _context.Provider == p1 then
                    console.error("Calling useContext(Context.Provider) is not supported. Did you mean to call useContext(Context) instead?");
                end;
            end;
        end;

        return current.useContext(p1, p2);
    end,

    useState = function(p3, ...) -- Line: 108, Name: useState
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useState(p3, ...);
    end,

    useReducer = function(p4: function, p5: any, p6: function?) -- Line: 117, Name: useReducer
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useReducer(p4, p5, p6);
    end,

    useRef = function(p7) -- Line: 128, Name: useRef
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useRef(p7);
    end,

    useBinding = function(p8) -- Line: 135, Name: useBinding
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useBinding(p8);
    end,

    useEffect = function(p9: function, p10: any) -- Line: 147, Name: useEffect
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useEffect(p9, p10);
    end,

    useLayoutEffect = function(p11: function, p12: any) -- Line: 157, Name: useLayoutEffect
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useLayoutEffect(p11, p12);
    end,

    useCallback = function(p13, p14) -- Line: 167, Name: useCallback
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useCallback(p13, p14);
    end,

    useMemo = function(p15: function, p16: any) -- Line: 173, Name: useMemo
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useMemo(p15, p16);
    end,

    useImperativeHandle = function(p17: any, p18: function, p19: any) -- Line: 179, Name: useImperativeHandle
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useImperativeHandle(p17, p18, p19);
    end,

    useDebugValue = function(p20: any, p21: function?) -- Line: 189, Name: useDebugValue
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        if not _G.__DEV__ then
            return nil;
        end;

        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useDebugValue(p20, p21);
    end,

    emptyObject = {},

    useOpaqueIdentifier = function() -- Line: 214
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useOpaqueIdentifier();
    end,

    useMutableSource = function(p22, p23, p24) -- Line: 220
        -- upvalues: ReactCurrentDispatcher (copy), console (copy)
        local current = ReactCurrentDispatcher.current;

        if _G.__DEV__ and current == nil then
            console.error("Invalid hook call. Hooks can only be called inside of the body of a function component. This could happen for one of the following reasons:\n1. You might have mismatching versions of React and the renderer (such as React DOM)\n2. You might be breaking the Rules of Hooks\n3. You might have more than one copy of React in the same app\nSee https://reactjs.org/link/invalid-hook-call for tips about how to debug and fix this problem.");
        end;

        return current.useMutableSource(p22, p23, p24);
    end
};