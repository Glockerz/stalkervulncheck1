-- Decompiled with Potassium's decompiler.

require(script.Parent:WaitForChild("ReactInternalTypes"));
local v1 = require(script.Parent:WaitForChild("ReactFiberStack.new"));
local ReactFiberHostConfig = require(script.Parent:WaitForChild("ReactFiberHostConfig"));
local getChildHostContext = ReactFiberHostConfig.getChildHostContext;
local getRootHostContext = ReactFiberHostConfig.getRootHostContext;
local createCursor = v1.createCursor;
local push = v1.push;
local pop = v1.pop;
local u2 = {};
local u3 = createCursor(u2);
local u4 = createCursor(u2);
local u5 = createCursor(u2);

function requiredContext(p6)
    return p6;
end;

function getRootHostContainer()
    -- upvalues: u5 (copy)
    return u5.current;
end;

function pushHostContainer(p7, p8)
    -- upvalues: push (copy), u5 (copy), u4 (copy), u3 (copy), u2 (copy), getRootHostContext (copy), pop (copy)
    push(u5, p8, p7);
    push(u4, p7, p7);
    push(u3, u2, p7);
    local v9 = getRootHostContext(p8);
    pop(u3, p7);
    push(u3, v9, p7);
end;

function popHostContainer(p10)
    -- upvalues: pop (copy), u3 (copy), u4 (copy), u5 (copy)
    pop(u3, p10);
    pop(u4, p10);
    pop(u5, p10);
end;

function getHostContext()
    -- upvalues: u3 (copy)
    return u3.current;
end;

function pushHostContext(p11)
    -- upvalues: u5 (copy), u3 (copy), getChildHostContext (copy), push (copy), u4 (copy)
    local v12 = requiredContext(u5.current);
    local v13 = requiredContext(u3.current);
    local v14 = getChildHostContext(v13, p11.type, v12);

    if v13 == v14 then
        return;
    end;

    push(u4, p11, p11);
    push(u3, v14, p11);
end;

function popHostContext(p15)
    -- upvalues: u4 (copy), pop (copy), u3 (copy)
    if u4.current ~= p15 then
        return;
    end;

    pop(u3, p15);
    pop(u4, p15);
end;

return {
    getHostContext = getHostContext,
    getRootHostContainer = getRootHostContainer,
    popHostContainer = popHostContainer,
    popHostContext = popHostContext,
    pushHostContainer = pushHostContainer,
    pushHostContext = pushHostContext
};