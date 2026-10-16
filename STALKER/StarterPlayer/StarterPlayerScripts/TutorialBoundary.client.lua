-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Workspace = game:GetService("Workspace");
local LocalPlayer = Players.LocalPlayer;
local success, result = pcall(function() -- Line: 36
    -- upvalues: ReplicatedStorage (copy)
    return require(ReplicatedStorage:WaitForChild("TaskController", 10));
end);

if not success then
    result = nil;
end;

local function showToast(u1) -- Line: 42
    -- upvalues: result (ref)
    if result and type(result.ShowToast) == "function" then
        pcall(function() -- Line: 44
            -- upvalues: result (ref), u1 (copy)
            result:ShowToast(u1);
        end);
    end;
end;

local function isPhase1() -- Line: 51
    -- upvalues: LocalPlayer (copy)
    local v2;

    if LocalPlayer:GetAttribute("_TutorialPending") == true then
        v2 = LocalPlayer:GetAttribute("_StarterPackGranted") ~= true;
    else
        v2 = false;
    end;

    return v2;
end;

local u3 = nil;
local u4 = {};
local u5 = 0;

local function onWallTouched(p6) -- Line: 63
    -- upvalues: LocalPlayer (copy), u5 (ref), result (ref)
    local v7;

    if LocalPlayer:GetAttribute("_TutorialPending") == true then
        v7 = LocalPlayer:GetAttribute("_StarterPackGranted") ~= true;
    else
        v7 = false;
    end;

    if not v7 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    if not p6:IsDescendantOf(Character) then
        return;
    end;

    local os_clock_ret = os.clock();

    if os_clock_ret - u5 < 3 then
        return;
    end;

    u5 = os_clock_ret;

    if result and type(result.ShowToast) == "function" then
        local u8 = "Talk to Crow before you get anywhere else in the Zone.";
        pcall(function() -- Line: 44
            -- upvalues: result (ref), u8 (copy)
            result:ShowToast(u8);
        end);
    end;
end;

local function applyToPart(p9, p10) -- Line: 80
    -- upvalues: u4 (copy), onWallTouched (copy)
    if not p9:IsA("BasePart") then
        return;
    end;

    p9.CanCollide = p10;
    p9.CanQuery = false;
    p9.CanTouch = true;

    if not u4[p9] then
        u4[p9] = true;
        p9.Touched:Connect(onWallTouched);
    end;
end;

local function applyAll() -- Line: 92
    -- upvalues: u3 (ref), LocalPlayer (copy), u4 (copy), onWallTouched (copy)
    if not u3 then
        return;
    end;

    local v11;

    if LocalPlayer:GetAttribute("_TutorialPending") == true then
        v11 = LocalPlayer:GetAttribute("_StarterPackGranted") ~= true;
    else
        v11 = false;
    end;

    for _, descendant in ipairs(u3:GetDescendants()) do
        if descendant:IsA("BasePart") then
            if descendant:IsA("BasePart") then
                descendant.CanCollide = v11;
                descendant.CanQuery = false;
                descendant.CanTouch = true;

                if not u4[descendant] then
                    u4[descendant] = true;
                    descendant.Touched:Connect(onWallTouched);
                end;
            end;
        end;
    end;
end;

task.spawn(function() -- Line: 105
    -- upvalues: Workspace (copy), u3 (ref), applyAll (copy), LocalPlayer (copy), u4 (copy), onWallTouched (copy)
    local MapEssentials = Workspace:WaitForChild("MapEssentials", 30);

    if not MapEssentials then
        warn("[TutorialBoundary] MapEssentials never appeared; boundary inactive");

        return;
    end;

    u3 = MapEssentials:WaitForChild("TutorialInvisibleWalls", 30);

    if not u3 then
        warn("[TutorialBoundary] TutorialInvisibleWalls never appeared; boundary inactive");

        return;
    end;

    applyAll();
    u3.DescendantAdded:Connect(function(p12) -- Line: 122
        -- upvalues: LocalPlayer (ref), u4 (ref), onWallTouched (ref)
        if p12:IsA("BasePart") then
            local v13;

            if LocalPlayer:GetAttribute("_TutorialPending") == true then
                v13 = LocalPlayer:GetAttribute("_StarterPackGranted") ~= true;
            else
                v13 = false;
            end;

            if not p12:IsA("BasePart") then
                return;
            end;

            p12.CanCollide = v13;
            p12.CanQuery = false;
            p12.CanTouch = true;

            if not u4[p12] then
                u4[p12] = true;
                p12.Touched:Connect(onWallTouched);
            end;
        end;
    end);
    LocalPlayer:GetAttributeChangedSignal("_StarterPackGranted"):Connect(applyAll);
    LocalPlayer:GetAttributeChangedSignal("_TutorialPending"):Connect(applyAll);
    local v14 = print;
    local string_format = string.format;
    local v15;

    if LocalPlayer:GetAttribute("_TutorialPending") == true then
        v15 = LocalPlayer:GetAttribute("_StarterPackGranted") ~= true;
    else
        v15 = false;
    end;

    v14(string_format("[TutorialBoundary] bound (phase1=%s)", (tostring(v15))));
end);