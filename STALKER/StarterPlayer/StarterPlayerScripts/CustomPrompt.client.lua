-- Decompiled with Potassium's decompiler.

local Buttons = require(script:WaitForChild("Buttons"));
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
game:GetService("UserInputService");
local ProximityPromptService = game:GetService("ProximityPromptService");
game:GetService("TextService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local u1 = nil;
local CollectionService = game:GetService("CollectionService");
local u2 = setmetatable({}, {
    __mode = "k"
});

local function lootFolders() -- Line: 51
    local v3 = {};
    local Lootables = workspace:FindFirstChild("Lootables");

    if Lootables then
        table.insert(v3, Lootables);
    end;

    local SPH_Workspace = workspace:FindFirstChild("SPH_Workspace");
    local v4 = SPH_Workspace and SPH_Workspace:FindFirstChild("Drops") or workspace:FindFirstChild("Drops");

    if v4 then
        table.insert(v3, v4);
    end;

    return v3;
end;

local function shouldOcclude(p5) -- Line: 61
    -- upvalues: CollectionService (copy), lootFolders (copy)
    local Parent = p5.Parent;

    if not (Parent and Parent:IsA("BasePart")) then
        return false;
    end;

    if CollectionService:HasTag(Parent, "Storage") then
        return true;
    end;

    for _, v in ipairs((lootFolders())) do
        if Parent:IsDescendantOf(v) then
            return true;
        end;
    end;

    return false;
end;

local function isFoliage(p6) -- Line: 72
    -- upvalues: CollectionService (copy)
    while p6 and p6 ~= workspace do
        if CollectionService:HasTag(p6, "Foliage") then
            return true;
        end;

        p6 = p6.Parent;
    end;

    return false;
end;

local function isRealOccluder(p7) -- Line: 81
    -- upvalues: isFoliage (copy)
    if isFoliage(p7) then
        return false;
    end;

    if p7.Transparency < 0.5 then
        return true;
    end;

    local Parent = p7.Parent;
    local v8;

    if Parent == nil then
        v8 = false;
    else
        v8 = Parent.Name == "CollisionsFixed";
    end;

    return v8;
end;

local function clearLine(p9, p10, p11) -- Line: 89
    -- upvalues: isFoliage (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
    RaycastParams_new_ret.FilterDescendantsInstances = p11;
    RaycastParams_new_ret.IgnoreWater = true;
    local v12 = nil;

    for i = 1, 8 do
        local v13 = workspace:Raycast(p9, p10 - p9, RaycastParams_new_ret);

        if not v13 then
            return true;
        end;

        local Instance2 = v13.Instance;
        local v14;

        if isFoliage(Instance2) then
            v14 = false;
        elseif Instance2.Transparency < 0.5 then
            v14 = true;
        else
            local Parent = Instance2.Parent;

            if Parent == nil then
                v14 = false;
            else
                v14 = Parent.Name == "CollisionsFixed";
            end;
        end;

        if v14 then
            return false;
        end;

        local v15;

        if v12 then
            v15 = i;
        else
            v15 = i;
            v12 = {};

            for _, v in ipairs(p11) do
                table.insert(v12, v);
            end;
        end;

        table.insert(v12, v13.Instance);
        RaycastParams_new_ret.FilterDescendantsInstances = v12;
    end;

    return true;
end;

local function promptVisible(p16) -- Line: 109
    -- upvalues: LocalPlayer (copy), lootFolders (copy), clearLine (copy)
    local Parent = p16.Parent;

    if not (Parent and (Parent:IsA("BasePart") and Parent:IsDescendantOf(workspace))) then
        return true;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return true;
    end;

    local Position = workspace_CurrentCamera.CFrame.Position;
    local v17 = { Parent };
    local Character = LocalPlayer.Character;

    if Character then
        table.insert(v17, Character);
    end;

    for _, v in ipairs((lootFolders())) do
        table.insert(v17, v);
    end;

    if clearLine(Position, Parent.Position, v17) then
        return true;
    end;

    local CFrame = Parent.CFrame;
    local v18 = Parent.Size * 0.5;
    local v19 = {
        Vector3.new(v18.X + 0.4, 0, 0),
        Vector3.new(-v18.X - 0.4, 0, 0),
        Vector3.new(0, v18.Y + 0.4, 0),
        Vector3.new(0, -v18.Y - 0.4, 0),
        Vector3.new(0, 0, v18.Z + 0.4),
        (Vector3.new(0, 0, -v18.Z - 0.4))
    };

    for _, v in ipairs(v19) do
        if clearLine(Position, CFrame:PointToWorldSpace(v), v17) then
            return true;
        end;
    end;

    return false;
end;

local function watchOccluded(u20) -- Line: 140
    -- upvalues: u2 (copy), LocalPlayer (copy), promptVisible (copy)
    if u2[u20] then
        return;
    end;

    u2[u20] = true;
    task.spawn(function() -- Line: 143
        -- upvalues: u20 (copy), LocalPlayer (ref), promptVisible (ref), u2 (ref)
        local v21 = 0;

        while u20.Parent and u20.Enabled == false do
            task.wait(0.15);
            local Parent = u20.Parent;

            if not Parent then
                break;
            end;

            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            if Character == nil and true or (Character.Position - Parent.Position).Magnitude > u20.MaxActivationDistance + 5 then
                break;
            end;

            if promptVisible(u20) then
                v21 = v21 + 1;

                if v21 >= 2 then
                    break;
                end;
            else
                v21 = 0;
            end;
        end;

        if u20.Parent and u20.Enabled == false then
            u20.Enabled = true;
        end;

        u2[u20] = nil;
    end);
end;

local function getScreenGui() -- Line: 168
    -- upvalues: PlayerGui (copy)
    local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

    if ProximityPrompts == nil then
        ProximityPrompts = Instance.new("ScreenGui");
        ProximityPrompts.Name = "ProximityPrompts";
        ProximityPrompts.ResetOnSpawn = false;
        ProximityPrompts.Parent = PlayerGui;
    end;

    return ProximityPrompts;
end;

local function DisconnectFunction(p22) -- Line: 179
    if p22 then
        p22:Disconnect();
    end;
end;

local function Update_yScale(p23, p24, p25, p26, p27) -- Line: 183
    local v28 = p26 and p26.Parent and p26:FindFirstChild("Frame");

    if v28 then
        v28 = v28:FindFirstChild("ProgressBar");
    end;

    if not (p25 and v28) then
        if p27 then
            p27:Disconnect();
        end;

        return;
    end;

    local v29 = tick();
    local v30 = (math.clamp(v29, p23, p24) - p23) / p25.HoldDuration;
    v28.Size = UDim2.new(1, 0, v30, 0);

    if v30 >= 1 then
        v28.Size = UDim2.new(1, 0, 0, 0);

        if p27 then
            p27:Disconnect();
        end;
    end;
end;

local function GetStringFromKey(p31) -- Line: 205
    -- upvalues: Buttons (copy)
    for i, v in pairs(Buttons) do
        if v == p31 then
            return i;
        end;
    end;
end;

local function AnimatePromptIn(p32) -- Line: 213
    -- upvalues: TweenService (copy)
    orignalSize = p32.Frame.Size;
    p32.Frame.Size = UDim2.new(0, 0, 0, 0);
    p32.Frame.BackgroundTransparency = 1;
    TweenService:Create(p32.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        BackgroundTransparency = 0.25,
        Size = orignalSize
    }):Play();
end;

local function AnimatePromptOut(p33) -- Line: 225
    -- upvalues: TweenService (copy)
    local v34 = TweenService:Create(p33.Frame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, 0, 0, 0)
    });
    v34:Play();
    v34.Completed:Wait();
end;

local function CreatePrompt(u35, p36, p37) -- Line: 234
    -- upvalues: Buttons (copy), shouldOcclude (copy), promptVisible (copy), AnimatePromptIn (copy), u2 (copy), LocalPlayer (copy), TweenService (copy), RunService (copy), Update_yScale (copy), AnimatePromptOut (copy)
    local u38 = script:WaitForChild("Prompt"):Clone();
    u38.Enabled = true;
    u38.Adornee = u35.Parent;
    u38.Parent = p37;
    local ButtonText = u38.Frame.ButtonText;
    local KeyboardKeyCode = u35.KeyboardKeyCode;
    local v39 = nil;

    for i, v in pairs(Buttons) do
        if v == KeyboardKeyCode then
            v39 = i;
            break;
        end;
    end;

    ButtonText.Text = v39;
    u38.Frame.ActionText.Text = u35.ActionText;
    u38.Frame.ObjectText.Text = u35.ObjectText;
    local UIOffset = u35.UIOffset;

    if UIOffset.X ~= 0 or UIOffset.Y ~= 0 then
        u38.StudsOffset = u38.StudsOffset + Vector3.new(UIOffset.X / 50, -UIOffset.Y / 50, 0);
    end;

    local v40 = shouldOcclude(u35);

    if v40 and not promptVisible(u35) then
        u38.Enabled = false;
    end;

    AnimatePromptIn(u38);

    if v40 then
        task.spawn(function() -- Line: 262
            -- upvalues: u38 (copy), u35 (copy), promptVisible (ref), u2 (ref), LocalPlayer (ref)
            local v41 = nil;

            while u38.Parent and u35.Parent do
                if promptVisible(u35) then
                    v41 = nil;

                    if not u38.Enabled then
                        u38.Enabled = true;
                    end;
                else
                    v41 = v41 or os.clock();

                    if os.clock() - v41 >= 0.25 then
                        u35.Enabled = false;
                        local u42 = u35;

                        if u2[u42] then
                            return;
                        end;

                        u2[u42] = true;
                        task.spawn(function() -- Line: 143
                            -- upvalues: u42 (copy), LocalPlayer (ref), promptVisible (ref), u2 (ref)
                            local v43 = 0;

                            while u42.Parent and u42.Enabled == false do
                                task.wait(0.15);
                                local Parent = u42.Parent;

                                if not Parent then
                                    break;
                                end;

                                local Character = LocalPlayer.Character;

                                if Character then
                                    Character = Character:FindFirstChild("HumanoidRootPart");
                                end;

                                if Character == nil and true or (Character.Position - Parent.Position).Magnitude > u42.MaxActivationDistance + 5 then
                                    break;
                                end;

                                if promptVisible(u42) then
                                    v43 = v43 + 1;

                                    if v43 >= 2 then
                                        break;
                                    end;
                                else
                                    v43 = 0;
                                end;
                            end;

                            if u42.Parent and u42.Enabled == false then
                                u42.Enabled = true;
                            end;

                            u2[u42] = nil;
                        end);

                        return;
                    end;
                end;

                task.wait(0.15);
            end;
        end);
    end;

    local v44;

    if u35:GetAttribute("Highlight_Enabled") == true then
        local Attribute = u35:GetAttribute("Highlight_BackgroundColor");
        local Attribute2 = u35:GetAttribute("Highlight_BorderColor");
        local Attribute3 = u35:GetAttribute("Highlight_BackgroundTransparency");
        local Attribute4 = u35:GetAttribute("Highlight_BorderTransparency");
        local Highlight = u35:FindFirstChild("Highlight");
        v44 = Instance.new("Highlight");
        v44.Name = u35.Name;
        v44.FillColor = Attribute;
        v44.FillTransparency = Attribute3;
        v44.OutlineColor = Attribute2;
        v44.OutlineTransparency = Attribute4;
        v44.Adornee = Highlight and Highlight.Value or u35.Parent;
        v44.Parent = u35;
        v44.Enabled = true;
    else
        v44 = nil;
    end;

    local v45 = u35.Triggered:Connect(function() -- Line: 302
        -- upvalues: u35 (copy), TweenService (ref), u38 (copy)
        if u35.HoldDuration == 0 then
            return;
        end;

        TweenService:Create(u38.Frame, TweenInfo.new(0.25), {
            BackgroundColor3 = Color3.new(0, 0, 0)
        }):Play();
    end);
    local v52 = u35.PromptButtonHoldBegan:Connect(function() -- Line: 307
        -- upvalues: u35 (copy), RunService (ref), Update_yScale (ref), u38 (copy), TweenService (ref)
        local u46 = tick();
        local u47 = u46 + u35.HoldDuration;
        local u48 = nil;
        u48 = RunService.RenderStepped:Connect(function() -- Line: 312
            -- upvalues: Update_yScale (ref), u46 (copy), u47 (copy), u35 (ref), u38 (ref), u48 (ref)
            Update_yScale(u46, u47, u35, u38, u48);
        end);
        local u49 = nil;
        u49 = u35.PromptButtonHoldEnded:Connect(function() -- Line: 317
            -- upvalues: u48 (ref), u49 (ref), TweenService (ref), u38 (ref)
            local v50 = u48;

            if v50 then
                v50:Disconnect();
            end;

            local v51 = u49;

            if v51 then
                v51:Disconnect();
            end;

            TweenService:Create(u38.Frame.ProgressBar, TweenInfo.new(0.25), {
                BackgroundTransparency = 1
            }):Play();
            task.wait(0.25);

            if u38 and u38:FindFirstChild("Frame") then
                u38.Frame.ProgressBar.BackgroundTransparency = 0.5;
                u38.Frame.ProgressBar.Size = UDim2.new(1, 0, 0, 0);
            end;
        end);
    end);
    local v59 = u38.TextButton.MouseButton1Down:Connect(function() -- Line: 331
        -- upvalues: u35 (copy), RunService (ref), Update_yScale (ref), u38 (copy)
        u35:InputHoldBegin();
        local u53 = tick();
        local u54 = u53 + u35.HoldDuration;
        local u55 = nil;
        u55 = RunService.RenderStepped:Connect(function() -- Line: 338
            -- upvalues: Update_yScale (ref), u53 (copy), u54 (copy), u35 (ref), u38 (ref), u55 (ref)
            Update_yScale(u53, u54, u35, u38, u55);
        end);
        local u56 = nil;
        u56 = u38.TextButton.MouseButton1Up:Connect(function() -- Line: 343
            -- upvalues: u35 (ref), u38 (ref), u55 (ref), u56 (ref)
            u35:InputHoldEnd();
            u38.Frame.ProgressBar.Size = UDim2.new(1, 0, 0, 0);
            local v57 = u55;

            if v57 then
                v57:Disconnect();
            end;

            local v58 = u56;

            if v58 then
                v58:Disconnect();
            end;
        end);
    end);
    u35.PromptHidden:Wait();
    AnimatePromptOut(u38);
    u38:Destroy();

    if v44 then
        v44:Destroy();
    end;

    if v45 then
        v45:Disconnect();
    end;

    if v52 then
        v52:Disconnect();
    end;

    if v59 then
        v59:Disconnect();
    end;
end;

local function onSit(p60) -- Line: 362
    -- upvalues: ProximityPromptService (copy)
    ProximityPromptService.Enabled = not p60;
end;

local function onLoad() -- Line: 366
    -- upvalues: ProximityPromptService (copy), u1 (ref), LocalPlayer (copy), onSit (copy), PlayerGui (copy), CreatePrompt (copy)
    ProximityPromptService.PromptShown:Connect(function(p61, p62) -- Line: 367
        -- upvalues: u1 (ref), LocalPlayer (ref), onSit (ref), PlayerGui (ref), CreatePrompt (ref)
        if p61.Style == Enum.ProximityPromptStyle.Default or p61:FindFirstChild("SPH_PromptConfig") then
            return;
        end;

        if not u1 and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
            u1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit);
        end;

        local ProximityPrompts = PlayerGui:FindFirstChild("ProximityPrompts");

        if ProximityPrompts == nil then
            ProximityPrompts = Instance.new("ScreenGui");
            ProximityPrompts.Name = "ProximityPrompts";
            ProximityPrompts.ResetOnSpawn = false;
            ProximityPrompts.Parent = PlayerGui;
        end;

        CreatePrompt(p61, p62, ProximityPrompts);
    end);
    task.wait(5);

    if not u1 and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
        u1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit);
    end;
end;

LocalPlayer.CharacterAdded:Connect(function() -- Line: 383
    -- upvalues: LocalPlayer (copy), u1 (ref), onSit (copy), ProximityPromptService (copy)
    local v63 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid");

    if not v63 then
        warn("CustomPrompt - No Humanoid Found for " .. LocalPlayer.Name .. "\'s character!");

        return;
    end;

    u1 = v63.Seated:Connect(onSit);
    ProximityPromptService.Enabled = true;
    task.wait(10);

    if not u1 and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
        u1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit);
    end;
end);
LocalPlayer.CharacterAppearanceLoaded:Connect(function() -- Line: 396
    -- upvalues: u1 (ref), LocalPlayer (copy), onSit (copy)
    if not u1 and (LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")) then
        u1 = LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid").Seated:Connect(onSit);
    end;
end);
onLoad();