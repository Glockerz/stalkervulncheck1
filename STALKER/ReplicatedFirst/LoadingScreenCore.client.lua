-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local TweenService = game:GetService("TweenService");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ContextActionService = game:GetService("ContextActionService");
local u1 = {
    "Wear a gas mask AND a decent suit before entering high radiation zones.",
    "Bleed kills faster than bullets. Carry Field Dressings.",
    "Equipped vests, backpacks, and belts add internal grid space to your inventory.",
    "Tab opens your inventory. Drag items to rearrange them.",
    "Empty mags can be repacked from AmmoPack boxes.",
    "F talks to nearby NPCs. P opens your PDA.",
    "Iodine Pills flush absorbed radiation. Carry some before heading into hot zones.",
    "Anti-Rad Vials give 50%% rad resistance for 3 minutes.",
    "Your radiation chip turns red at 40 rad. That\'s when you start taking damage.",
    "Running low on money? Look for Crow, he\'s always in need of work getting done.",
    "Squad task sharing is combat only, task like fetching or delivery are solo only.",
    "L toggles your headlamp. Useful inside dark interiors and basements.",
    "Keys 1-4 draw/holster Primary, Secondary, Sidearm, and Melee.",
    "F1-F4 are quick-use slots for consumables drag from inventory to assign.",
    "Compass: red = enemy, yellow = quest turn-in, green = squadmate, orange = stalker.",
    "Camp markers point to the camp\'s center. Enemies spawn as you get closer.",
    "Hidden stashes hold the best loot... and the worst surroundings.",
    "Intact armor blocks bleeding. Once durability is gone, hits punch through.",
    "Magazines are physical items. Loading a new mag swaps the rounds in your weapon.",
    "Watch your weight, overloaded stalkers run slower and tire faster."
};
local u2 = true;
ReplicatedFirst:RemoveDefaultLoadingScreen();
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, false);
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
local PlayerGui = Players.LocalPlayer:WaitForChild("PlayerGui");
local u3 = script:WaitForChild("LoadingGui"):Clone();
u3.Parent = PlayerGui;
local TipLabel = u3.CanvasGroup:FindFirstChild("TipLabel");

local function pickRandomTip(p4) -- Line: 48
    -- upvalues: u1 (copy)
    local v5 = {};

    for _, v in ipairs(u1) do
        if v ~= p4 then
            table.insert(v5, v);
        end;
    end;

    if #v5 == 0 then
        return u1[1];
    end;

    return v5[math.random(1, #v5)];
end;

if TipLabel then
    local u6 = pickRandomTip();
    TipLabel.Text = "TIP: " .. u6;
    task.spawn(function() -- Line: 60
        -- upvalues: u2 (ref), pickRandomTip (copy), u6 (ref), TweenService (copy), TipLabel (copy)
        while u2 do
            task.wait(4);

            if not u2 then
                break;
            end;

            local v7 = pickRandomTip(u6);
            TweenService:Create(TipLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
                TextTransparency = 1
            }):Play();
            task.wait(0.35);

            if not u2 then
                break;
            end;

            TipLabel.Text = "TIP: " .. v7;
            u6 = v7;
            TweenService:Create(TipLabel, TweenInfo.new(0.3, Enum.EasingStyle.Sine), {
                TextTransparency = 0
            }):Play();
        end;
    end);
end;

local u8 = 0;
local math_round = math.round;
local Descendants = game:GetDescendants();

local function CompleteLoading() -- Line: 79
    -- upvalues: u2 (ref), ContextActionService (copy), StarterGui (copy), u3 (copy), u8 (ref), TweenService (copy)
    if not u2 then
        return;
    end;

    u2 = false;
    pcall(function() -- Line: 92
        -- upvalues: ContextActionService (ref)
        ContextActionService:UnbindAction("SkipLoading");
    end);
    task.wait(0.2);
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
    local v9 = u3 and u3.Parent and u3:FindFirstChild("CanvasGroup");

    if not v9 then
        if u3 then
            u3:Destroy();
        end;

        return;
    end;

    v9.BarFrame.Bar:TweenSize(UDim2.new(u8 / 100, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.2);
    TweenService:Create(v9, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        GroupColor3 = Color3.fromRGB(0, 0, 0)
    }):Play();
    task.wait(0.6);
    TweenService:Create(v9, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
        GroupTransparency = 0.5
    }):Play();
    task.wait(0.6);

    if u3 then
        u3:Destroy();
    end;
end;

ContextActionService:BindAction("SkipLoading", function(p10, p11, p12) -- Line: 114, Name: HandleAction
    -- upvalues: CompleteLoading (copy), ContextActionService (copy)
    if p10 == "SkipLoading" and p11 == Enum.UserInputState.Begin then
        CompleteLoading();
        print("SKIPPING LOADINGSCREEN");
        ContextActionService:UnbindAction("SkipLoading");
    end;
end, true, Enum.KeyCode.Space);
local v13 = tick();
local u14 = 0;
local u15 = false;
task.spawn(function() -- Line: 137
    -- upvalues: ContentProvider (copy), Descendants (copy), u14 (ref), u8 (ref), math_round (copy), u3 (copy), u15 (ref)
    pcall(function() -- Line: 138
        -- upvalues: ContentProvider (ref), Descendants (ref), u14 (ref), u8 (ref), math_round (ref), u3 (ref)
        ContentProvider:PreloadAsync(Descendants, function(p16, p17) -- Line: 139
            -- upvalues: u14 (ref), u8 (ref), Descendants (ref), math_round (ref), u3 (ref)
            u14 = u14 + 1;
            u8 = math_round(u14 / #Descendants * 100);

            if u3 and u3.Parent then
                u3.CanvasGroup.PercentLabel.Text = u8 .. "%";
                u3.CanvasGroup.BarFrame.Bar.Size = UDim2.new(u8 / 100, 0, 1, 0);
            end;
        end);
    end);
    u15 = true;
end);
local v18 = 0;

while not u15 and v18 < 45 do
    task.wait(0.1);
    v18 = v18 + 0.1;
end;

if not u15 then
    warn(string.format("[LoadingScreen] Asset preload timed out after %ds (%d/%d loaded). Proceeding anyway.", 45, u14, #Descendants));
end;

u8 = 100;

if u3 and u3.Parent then
    u3.CanvasGroup.PercentLabel.Text = "100%";
    u3.CanvasGroup.BarFrame.Bar.Size = UDim2.new(1, 0, 1, 0);
end;

local v19 = 12 - (tick() - v13);

if v19 > 0 and (u3 and u3.Parent) then
    local LoadingLabel = u3.CanvasGroup:FindFirstChild("LoadingLabel");

    if LoadingLabel then
        LoadingLabel.Text = "DEPLOYING TO ZONE...";
    end;

    task.wait(v19);
end;

CompleteLoading();