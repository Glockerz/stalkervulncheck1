-- Decompiled with Potassium's decompiler.

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});

function v1.New(u3: userdata, u4: userdata) -- Line: 27
    -- upvalues: u2 (copy), ReplicatedStorage (copy), TweenService (copy)
    if u2[u3] then
        return u2[u3];
    end;

    local v5 = {};
    u2[u3] = v5;
    local u6 = {};
    local u7 = false;
    local Animations = ReplicatedStorage:WaitForChild("SPH_Assets"):WaitForChild("Animations");
    local u8 = nil;
    local u9 = nil;

    local function ensureTracks() -- Line: 38
        -- upvalues: u8 (ref), u7 (ref), u4 (copy), Animations (copy), u9 (ref)
        if u8 or (u7 or not u4.Parent) then
            return;
        end;

        local v10 = u4:FindFirstChildOfClass("Animator");

        if not v10 then
            v10 = Instance.new("Animator");
            v10.Parent = u4;
        end;

        local Crouch_Idle = Animations:FindFirstChild("Crouch_Idle");
        local Crouch_Move = Animations:FindFirstChild("Crouch_Move");

        if Crouch_Idle then
            u8 = v10:LoadAnimation(Crouch_Idle);
            u8.Priority = Enum.AnimationPriority.Idle;
            u8.Looped = true;
        end;

        if Crouch_Move then
            u9 = v10:LoadAnimation(Crouch_Move);
            u9.Priority = Enum.AnimationPriority.Movement;
            u9.Looped = true;
        end;
    end;

    local u11 = false;
    local u12 = 0;

    local function apply() -- Line: 59
        -- upvalues: u7 (ref), u11 (ref), ensureTracks (copy), u12 (ref), u8 (ref), u9 (ref)
        if u7 then
            return;
        end;

        if u11 then
            ensureTracks();
        end;

        local v13 = u11 and u12 > 0.5;
        local v14 = u11 and not v13;

        if u8 then
            if v14 and not u8.IsPlaying then
                u8:Play(0.2);
            end;

            if not v14 and u8.IsPlaying then
                u8:Stop(0.2);
            end;
        end;

        if u9 then
            if v13 and not u9.IsPlaying then
                u9:Play(0.2);
            end;

            if not v13 and u9.IsPlaying then
                u9:Stop(0.2);
            end;
        end;
    end;

    local AttributeChangedSignal = u3:GetAttributeChangedSignal("Stance");
    table.insert(u6, AttributeChangedSignal:Connect(function() -- Line: 74
        -- upvalues: u11 (ref), u3 (copy), apply (copy)
        u11 = u3:GetAttribute("Stance") == "Crouch";
        apply();
    end));
    table.insert(u6, u4.Running:Connect(function(p15) -- Line: 78
        -- upvalues: u12 (ref), apply (copy)
        u12 = p15;
        apply();
    end));
    local u16 = nil;

    local function leanC1(p17) -- Line: 87
        return CFrame.new(-p17 / 2, 0, 0) * CFrame.Angles(1.5707963267948966, math.rad(17 * p17) + 3.141592653589793, 0);
    end;

    function v5.SetLean(p18: number) -- Line: 90
        -- upvalues: u7 (ref), u3 (copy), u16 (ref), TweenService (ref)
        if u7 then
            return;
        end;

        u3:SetAttribute("Lean", p18);
        local HumanoidRootPart = u3:FindFirstChild("HumanoidRootPart");

        if HumanoidRootPart then
            HumanoidRootPart = HumanoidRootPart:FindFirstChild("RootJoint");
        end;

        if not HumanoidRootPart then
            return;
        end;

        if u16 then
            u16:Cancel();
        end;

        u16 = TweenService:Create(HumanoidRootPart, TweenInfo.new(0.35), {
            C1 = CFrame.new(-p18 / 2, 0, 0) * CFrame.Angles(1.5707963267948966, math.rad(17 * p18) + 3.141592653589793, 0)
        });
        u16:Play();
    end;

    function v5.Release() -- Line: 101
        -- upvalues: u7 (ref), u2 (ref), u3 (copy), u16 (ref), u6 (copy), u8 (ref), u9 (ref)
        if u7 then
            return;
        end;

        u7 = true;
        u2[u3] = nil;

        if u16 then
            pcall(function() -- Line: 105
                -- upvalues: u16 (ref)
                u16:Cancel();
            end);
            u16 = nil;
        end;

        for _, v in ipairs(u6) do
            pcall(function() -- Line: 106
                -- upvalues: v (copy)
                v:Disconnect();
            end);
        end;

        table.clear(u6);

        for _, v in ipairs({ u8, u9 }) do
            if v then
                pcall(function() -- Line: 109
                    -- upvalues: v (copy)
                    v:Stop(0);
                    v:Destroy();
                end);
            end;
        end;

        u8 = nil;
        u9 = nil;
    end;

    table.insert(u6, u3.Destroying:Connect(v5.Release));

    if u3:GetAttribute("Stance") == "Crouch" then
        u11 = true;
    else
        u11 = false;
    end;

    apply();

    return v5;
end;

return v1;