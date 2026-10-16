-- Decompiled with Potassium's decompiler.

local Object = require(script.Parent.Parent.Parent:WaitForChild("luau-polyfill")).Object;
local RobloxComponentProps = require(script.Parent:WaitForChild("roblox"):WaitForChild("RobloxComponentProps"));
require(script.Parent:WaitForChild("ReactRobloxHostTypes.roblox"));

return {
    setInitialProperties = RobloxComponentProps.setInitialProperties,

    diffProperties = function(p1: any, p2: string, p3: table, p4: table, p5: any) -- Line: 31, Name: diffProperties
        -- upvalues: Object (copy)
        local v6 = nil;

        for i, _ in p3 do
            if p4[i] == nil then
                v6 = v6 or table.create(2);
                table.insert(v6, i);
                table.insert(v6, Object.None);
            end;
        end;

        for i, v in p4 do
            local v7;

            if p3 == nil then
                v7 = nil;
            else
                v7 = p3[i];
            end;

            if v ~= v7 then
                v6 = v6 or table.create(2);
                table.insert(v6, i);
                table.insert(v6, v);
            end;
        end;

        return v6;
    end,

    updateProperties = RobloxComponentProps.updateProperties,
    cleanupHostComponent = RobloxComponentProps.cleanupHostComponent
};