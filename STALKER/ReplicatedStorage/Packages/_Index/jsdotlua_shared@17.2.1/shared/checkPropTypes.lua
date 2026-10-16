-- Decompiled with Potassium's decompiler.

local Error = require(script.Parent.Parent:WaitForChild("luau-polyfill")).Error;
local console = require(script.Parent:WaitForChild("console"));
local u1 = {};
local describeUnknownElementTypeFrameInDEV = require(script.Parent:WaitForChild("ReactComponentStackFrame")).describeUnknownElementTypeFrameInDEV;
local ReactSharedInternals = require(script.Parent:WaitForChild("ReactSharedInternals"));
local describeError = require(script.Parent:WaitForChild("ErrorHandling.roblox")).describeError;
local ReactDebugCurrentFrame = ReactSharedInternals.ReactDebugCurrentFrame;

local function setCurrentlyValidatingElement(p2) -- Line: 32
    -- upvalues: describeUnknownElementTypeFrameInDEV (copy), ReactDebugCurrentFrame (copy)
    if _G.__DEV__ then
        if p2 then
            local _owner = p2._owner;
            local v3;

            if _owner == nil then
                v3 = nil;
            else
                v3 = _owner.type;
            end;

            local v4 = describeUnknownElementTypeFrameInDEV(p2.type, p2._source, v3);
            ReactDebugCurrentFrame.setExtraStackFrame(v4);

            return;
        end;

        ReactDebugCurrentFrame.setExtraStackFrame(nil);
    end;
end;

return function(u5: any, p6: function?, u7: any, u8: string, u9: string?, p10: any) -- Line: 49, Name: checkPropTypes
    -- upvalues: console (copy), Error (copy), describeError (copy), describeUnknownElementTypeFrameInDEV (copy), ReactDebugCurrentFrame (copy), u1 (copy)
    if _G.__DEV__ or _G.__DISABLE_ALL_WARNINGS_EXCEPT_PROP_VALIDATION__ then
        if u5 and p6 then
            console.warn("You\'ve defined both propTypes and validateProps on " .. (u9 or "a component"));
        end;

        if p6 then
            if typeof(p6) == "function" then
                local v11, v12 = p6(u7);

                if not v11 then
                    local string_format_ret = string.format("validateProps failed on a %s type in %s: %s", u8, u9 or "<UNKNOWN Component>", (tostring(v12 or "<Validator function did not supply a message>")));
                    error(string_format_ret);
                end;
            else
                console.error(("validateProps must be a function, but it is a %s.\nCheck the definition of the component %q."):format(typeof(p6), u9 or ""));
            end;
        end;

        if u5 then
            local v13 = typeof(u5) == "table";
            assert(v13, "propTypes needs to be a table");

            for i, _ in u5 do
                local _, v15 = xpcall(function() -- Line: 113
                    -- upvalues: u5 (copy), i (copy), Error (ref), u9 (copy), u8 (copy), u7 (copy)
                    if typeof(u5[i]) ~= "function" then
                        local v14 = Error.new((u9 or "React class") .. ": " .. u8 .. " type `" .. i .. "` is invalid; " .. "it must be a function, usually from the `prop-types` package, but received `" .. typeof(u5[i]) .. "`.This often happens because of typos such as `PropTypes.function` instead of `PropTypes.func`.");
                        v14.name = "Invariant Violation";
                        error(v14);
                    end;

                    return u5[i](u7, i, u9, u8, nil, "SECRET_DO_NOT_PASS_THIS_OR_YOU_WILL_BE_FIRED");
                end, describeError);
                local v16 = typeof(v15) == "table";

                if v15 ~= nil and not v16 then
                    if _G.__DEV__ then
                        if p10 then
                            local _owner = p10._owner;
                            local v17;

                            if _owner == nil then
                                v17 = nil;
                            else
                                v17 = _owner.type;
                            end;

                            local v18 = describeUnknownElementTypeFrameInDEV(p10.type, p10._source, v17);
                            ReactDebugCurrentFrame.setExtraStackFrame(v18);
                        else
                            ReactDebugCurrentFrame.setExtraStackFrame(nil);
                        end;
                    end;

                    console.error(string.format("%s: type specification of %s `%s` is invalid; the type checker function must return `nil` or an `Error` but returned a %s. You may have forgotten to pass an argument to the type checker creator (arrayOf, instanceOf, objectOf, oneOf, oneOfType, and shape all require an argument).", u9 or "React class", u8, i, (typeof(v15))));

                    if _G.__DEV__ then
                        ReactDebugCurrentFrame.setExtraStackFrame(nil);
                    end;
                end;

                if v16 and u1[v15.message] == nil then
                    u1[tostring(v15.message)] = true;

                    if _G.__DEV__ then
                        if p10 then
                            local _owner = p10._owner;
                            local v19;

                            if _owner == nil then
                                v19 = nil;
                            else
                                v19 = _owner.type;
                            end;

                            local v20 = describeUnknownElementTypeFrameInDEV(p10.type, p10._source, v19);
                            ReactDebugCurrentFrame.setExtraStackFrame(v20);
                        else
                            ReactDebugCurrentFrame.setExtraStackFrame(nil);
                        end;
                    end;

                    console.warn(string.format("Failed %s type: %s", u8, (tostring(v15.message))));

                    if _G.__DEV__ then
                        ReactDebugCurrentFrame.setExtraStackFrame(nil);
                    end;
                end;
            end;
        end;
    end;
end;