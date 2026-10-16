-- Decompiled with Potassium's decompiler.

local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"));
local Error = v1.Error;
local inspect = v1.util.inspect;
local getComponentName = require(script.Parent:WaitForChild("getComponentName"));
local v2 = {};

local function isValidFiber(p3) -- Line: 33
    local v4;

    if p3.tag == nil or (p3.subtreeFlags == nil or p3.lanes == nil) then
        v4 = false;
    else
        v4 = p3.childLanes ~= nil;
    end;

    return v4;
end;

function v2.remove(p5) -- Line: 40
    p5._reactInternals = nil;
end;

function v2.get(p6) -- Line: 44
    -- upvalues: Error (copy), getComponentName (copy), inspect (copy)
    local _reactInternals = p6._reactInternals;
    local v7;

    if _reactInternals.tag == nil or (_reactInternals.subtreeFlags == nil or _reactInternals.lanes == nil) then
        v7 = false;
    else
        v7 = _reactInternals.childLanes ~= nil;
    end;

    if v7 then
        if _reactInternals.alternate ~= nil then
            local alternate = _reactInternals.alternate;
            local v8;

            if alternate.tag == nil or (alternate.subtreeFlags == nil or alternate.lanes == nil) then
                v8 = false;
            else
                v8 = alternate.childLanes ~= nil;
            end;

            if not v8 then
                error(Error.new("invalid alternate fiber (" .. (getComponentName(p6) or "UNNAMED alternate") .. ") in " .. (getComponentName(p6) or "UNNAMED Component") .. " during get from ReactInstanceMap! " .. inspect(_reactInternals.alternate)));
            end;
        end;

        return _reactInternals;
    end;

    error(Error.new("invalid fiber in " .. (getComponentName(p6) or "UNNAMED Component") .. " during get from ReactInstanceMap! " .. inspect(_reactInternals)));

    return _reactInternals;
end;

function v2.has(p9) -- Line: 74
    return p9._reactInternals ~= nil;
end;

function v2.set(p10, p11) -- Line: 78
    -- upvalues: getComponentName (copy), inspect (copy), Error (copy)
    local v12 = p11;

    while p11 ~= nil do
        local v13;

        if p11.tag == nil or (p11.subtreeFlags == nil or p11.lanes == nil) then
            v13 = false;
        else
            v13 = p11.childLanes ~= nil;
        end;

        if v13 then
            if p11.alternate ~= nil then
                local alternate = p11.alternate;
                local v14;

                if alternate.tag == nil or (alternate.subtreeFlags == nil or alternate.lanes == nil) then
                    v14 = false;
                else
                    v14 = alternate.childLanes ~= nil;
                end;

                if not v14 then
                    local v15 = "invalid alternate fiber (" .. (getComponentName(p10) or "UNNAMED alternate") .. ") in " .. (getComponentName(p10) or "UNNAMED Component") .. " being set in ReactInstanceMap! " .. inspect(p11.alternate) .. "\n";

                    if v12 ~= p11 then
                        v15 = v15 .. " (from original fiber " .. (getComponentName(p10) or "UNNAMED Component") .. ")";
                    end;

                    error(Error.new(v15));
                end;
            end;
        else
            local v16 = "invalid fiber in " .. (getComponentName(p10) or "UNNAMED Component") .. " being set in ReactInstanceMap! " .. inspect(p11) .. "\n";

            if v12 ~= p11 then
                v16 = v16 .. " (from original fiber " .. (getComponentName(p10) or "UNNAMED Component") .. ")";
            end;

            error(Error.new(v16));
        end;

        p11 = p11.return_;
    end;

    p10._reactInternals = v12;
end;

return v2;