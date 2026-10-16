-- Decompiled with Potassium's decompiler.

local console = require(script.Parent.Parent:WaitForChild("shared")).console;
local u1 = {};

local function warnNoop(p2: any, p3: string) -- Line: 14
    -- upvalues: u1 (copy), console (copy)
    if _G.__DEV__ then
        local v4 = p2.__componentName or "ReactClass";
        local v5 = v4 .. "." .. p3;

        if u1[v5] then
            return;
        end;

        console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", p3, v4);
        u1[v5] = true;
    end;
end;

return {
    isMounted = function(p6) -- Line: 49, Name: isMounted
        return false;
    end,

    enqueueForceUpdate = function(p7, p8, p9) -- Line: 67, Name: enqueueForceUpdate
        -- upvalues: u1 (copy), console (copy)
        if _G.__DEV__ then
            local v10 = p7.__componentName or "ReactClass";
            local v11 = v10 .. ".forceUpdate";

            if u1[v11] then
                return;
            end;

            console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", "forceUpdate", v10);
            u1[v11] = true;
        end;
    end,

    enqueueReplaceState = function(p12, p13, p14, p15) -- Line: 83, Name: enqueueReplaceState
        -- upvalues: u1 (copy), console (copy)
        if _G.__DEV__ then
            local v16 = p12.__componentName or "ReactClass";
            local v17 = v16 .. ".replaceState";

            if u1[v17] then
                return;
            end;

            console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", "replaceState", v16);
            u1[v17] = true;
        end;
    end,

    enqueueSetState = function(p18, p19, p20, p21) -- Line: 98, Name: enqueueSetState
        -- upvalues: u1 (copy), console (copy)
        if _G.__DEV__ then
            local v22 = p18.__componentName or "ReactClass";
            local v23 = v22 .. ".setState";

            if u1[v23] then
                return;
            end;

            console.error("Can\'t call %s on a component that is not yet mounted. This is a no-op, but it might indicate a bug in your application. Instead, assign to `self.state` directly with the desired state in the %s component\'s `init` method.", "setState", v22);
            u1[v23] = true;
        end;
    end
};