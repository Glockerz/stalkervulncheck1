-- Decompiled with Potassium's decompiler.

local u1 = {
    modelDetectionMethod = nil,
    modelDetectionPath = nil,
    connections = {
        childAdded = nil,
        childRemoved = nil
    },
    parentingMethod = nil,
    glassMethod = nil,
    aimpartZOffset = 0.5,
    currentRootModel = nil,
    cleanupParts = {},
    interval = 0,
    timeout = 100
};
local _ = workspace.CurrentCamera;
local Activate = require(script.Parent:WaitForChild("Activate"));

function u1.init() -- Line: 22
    -- upvalues: u1 (copy)
    u1.update("Default");
end;

function u1.update(p2: string) -- Line: 26
    -- upvalues: u1 (copy)
    local v3 = require(script:FindFirstChild(p2));

    if u1.connections.childAdded then
        u1.connections.childAdded:Disconnect();
    end;

    if u1.connections.childRemoved then
        u1.connections.childRemoved:Disconnect();
    end;

    u1.modelDetectionPath = v3.modelDetectionPath();
    u1.modelDetectionMethod = v3.modelDetectionMethod;
    u1.parentingMethod = v3.parentingMethod;
    u1.aimpartZOffset = v3.aimpartZOffset;
    u1.connections.childAdded = u1.modelDetectionPath.ChildAdded:Connect(u1.onChildAdded);
    u1.connections.childRemoved = u1.modelDetectionPath.ChildRemoved:Connect(u1.onChildRemoved);
end;

function u1.onChildAdded(p4) -- Line: 46
    -- upvalues: u1 (copy), Activate (copy)
    local v5 = nil;

    for i = 1, u1.timeout do
        v5 = u1.modelDetectionMethod(p4);

        if v5 then
            break;
        end;

        task.wait(u1.interval);
        local _ = i;
    end;

    if v5 then
        u1.currentRootModel = p4;
        u1.cleanupParts = Activate.start(v5, u1);
    end;
end;

function u1.onChildRemoved(p6) -- Line: 65
    -- upvalues: u1 (copy)
    if p6 == u1.currentRootModel then
        for _, v in u1.cleanupParts do
            v:Destroy();
        end;

        u1.currentRootModel = nil;
    end;
end;

return u1;