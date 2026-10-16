-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local inspect = v1.util.inspect;
local setTimeout = v1.setTimeout;
local shared = require(script.Parent.Parent:WaitForChild("shared"));
local console = shared.console;
local errorToString = shared.errorToString;
require(script.Parent:WaitForChild("ReactInternalTypes"));
require(script.Parent:WaitForChild("ReactCapturedValue"));
local showErrorDialog = require(script.Parent:WaitForChild("ReactFiberErrorDialog")).showErrorDialog;
local ClassComponent = require(script.Parent:WaitForChild("ReactWorkTags")).ClassComponent;
local getComponentName = require(script.Parent.Parent:WaitForChild("shared")).getComponentName;

return {
    logCapturedError = function(u2, u3) -- Line: 32
        -- upvalues: showErrorDialog (copy), ClassComponent (copy), console (copy), getComponentName (copy), inspect (copy), setTimeout (copy), errorToString (copy)
        local success, result = pcall(function() -- Line: 33
            -- upvalues: showErrorDialog (ref), u2 (copy), u3 (copy), ClassComponent (ref), console (ref), getComponentName (ref), inspect (ref)
            if showErrorDialog(u2, u3) == false then
                return nil;
            end;

            local value = u3.value;

            if _G.__DEV__ then
                local source = u3.source;
                local v4 = u3.stack or "";

                if value ~= nil and value._suppressLogging then
                    if u2.tag == ClassComponent then
                        return;
                    end;

                    console.error(value);
                end;

                local v5;

                if source == nil then
                    v5 = nil;
                else
                    v5 = getComponentName(source.type);
                end;

                local v6 = not v5 and "The above error occurred in one of your React components:" or "The above error occurred in the <" .. tostring(v5) .. "> component:";
                local v7 = getComponentName(u2.type);
                console.error(v6 .. "\n" .. v4 .. "\n\n" .. (not v7 and "Consider adding an error boundary to your tree to customize error handling behavior.\nVisit https://reactjs.org/link/error-boundaries to learn more about error boundaries." or "React will try to recreate this component tree from scratch " .. "using the error boundary you provided, " .. v7 .. "."));
            else
                console.error(inspect(value));
            end;

            return nil;
        end);

        if not success then
            warn("failed to error with error: " .. inspect(result));
            setTimeout(function() -- Line: 124
                -- upvalues: errorToString (ref), result (copy)
                error(errorToString(result));
            end);
        end;
    end
};