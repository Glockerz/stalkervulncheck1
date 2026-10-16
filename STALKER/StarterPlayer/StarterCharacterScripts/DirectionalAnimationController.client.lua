-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = Players.LocalPlayer;
local script_Parent = script.Parent;
local States = require(ReplicatedStorage.Modules.DirectionalAnimation.States);
local Xanimator = require(ReplicatedStorage.Modules.DirectionalAnimation.Xanimator);
local Humanoid = script_Parent:WaitForChild("Humanoid", 10);

if not Humanoid then
    return;
end;

local u1 = Humanoid:FindFirstChildOfClass("Animator") or Humanoid:WaitForChild("Animator", 10);

if not u1 then
    return;
end;

local u2 = nil;
local u3 = nil;
local u4 = nil;

local function cleanup() -- Line: 23
    -- upvalues: u4 (ref), u3 (ref), u2 (ref)
    if u4 then
        u4:Disconnect();
        u4 = nil;
    end;

    if u3 then
        pcall(function() -- Line: 29
            -- upvalues: u3 (ref)
            u3:destroy();
        end);
        u3 = nil;
    end;

    if u2 then
        pcall(function() -- Line: 33
            -- upvalues: u2 (ref)
            u2:Destroy();
        end);
        u2 = nil;
    end;
end;

local ContentProvider = game:GetService("ContentProvider");
local AnimationManager = require(ReplicatedStorage.Modules.DirectionalAnimation.States.Modules.AnimationManager);
local u5 = {};

for _, v in pairs(AnimationManager.ANIMATION_IDS or {}) do
    if v and v ~= "" then
        local Animation = Instance.new("Animation");
        Animation.AnimationId = v;
        table.insert(u5, Animation);
    end;
end;

if #u5 > 0 then
    pcall(function() -- Line: 58
        -- upvalues: ContentProvider (copy), u5 (copy)
        ContentProvider:PreloadAsync(u5);
    end);
end;

local v6 = false;

for i = 1, 5 do
    task.wait((i - 1) * 0.5 + 0.5);

    if not script_Parent.Parent then
        return;
    end;

    local success, result = pcall(function() -- Line: 69
        -- upvalues: u2 (ref), Xanimator (copy), u1 (copy), u3 (ref), States (copy), script_Parent (copy)
        u2 = Xanimator.new(u1);
        u3 = States.new(script_Parent, u2);
        u3:loadAnimations();
    end);

    if success then
        v6 = true;
        break;
    end;

    warn("[DirAnim] Init attempt", i, "failed:", result);
    cleanup();
    local _ = i;
end;

if not v6 then
    warn("[DirAnim] Failed after", 5, "attempts");

    return;
end;

u4 = RunService.PreAnimation:Connect(function(u7) -- Line: 89
    -- upvalues: u3 (ref), u2 (ref), script_Parent (copy)
    if not (u3 and (u2 and script_Parent.Parent)) then
        return;
    end;

    pcall(function() -- Line: 91
        -- upvalues: u2 (ref), u7 (copy)
        u2:Update(u7);
    end);
    pcall(function() -- Line: 92
        -- upvalues: u3 (ref), u7 (copy)
        u3:update(u7);
    end);
end);
script.Destroying:Connect(cleanup);
print("[DirAnim] Initialized");