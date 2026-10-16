-- Decompiled with Potassium's decompiler.

local Workspace = game:GetService("Workspace");
local v1 = {};
local u2 = {
    PlayerNameplate = true,
    SquadNametag = true,
    CustomBubbleChat = true,
    NPCDebugOverlay = true
};
local u3 = nil;
local u4 = nil;
local u5 = nil;

local function suppress(u6) -- Line: 35
    -- upvalues: u3 (ref), u4 (ref)
    if u3[u6] ~= nil then
        return;
    end;

    u3[u6] = u6.Enabled;

    if u6.Enabled then
        u6.Enabled = false;
    end;

    u4[u6] = u6:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 45
        -- upvalues: u6 (copy)
        if u6.Enabled then
            u6.Enabled = false;
        end;
    end);
end;

function v1.Enter(p7, p8) -- Line: 50
    -- upvalues: u3 (ref), u4 (ref), Workspace (copy), u2 (copy), suppress (copy), u5 (ref)
    u3 = {};
    u4 = {};

    for _, descendant in ipairs(Workspace:GetDescendants()) do
        if descendant:IsA("BillboardGui") and u2[descendant.Name] then
            suppress(descendant);
        end;
    end;

    u5 = Workspace.DescendantAdded:Connect(function(p9) -- Line: 58
        -- upvalues: u2 (ref), suppress (ref)
        if p9:IsA("BillboardGui") and u2[p9.Name] then
            suppress(p9);
        end;
    end);
end;

function v1.Exit(p10) -- Line: 63
    -- upvalues: u5 (ref), u4 (ref), u3 (ref)
    if u5 then
        u5:Disconnect();
        u5 = nil;
    end;

    if u4 then
        for _, v in pairs(u4) do
            pcall(function() -- Line: 68
                -- upvalues: v (copy)
                v:Disconnect();
            end);
        end;

        u4 = nil;
    end;

    if u3 then
        for i, v in pairs(u3) do
            if i.Parent then
                i.Enabled = v;
            end;
        end;

        u3 = nil;
    end;
end;

return v1;