-- Decompiled with Potassium's decompiler.

local CollectionService = game:GetService("CollectionService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Butchering = require(ReplicatedStorage:WaitForChild("Butchering"));
local ItemDatabase = require(ReplicatedStorage:WaitForChild("ItemDatabase"));

if not require(ReplicatedStorage:WaitForChild("PlaceConfig")).HasMutants then
    return;
end;

local Remotes = ReplicatedStorage:WaitForChild("Remotes");
local ButcherCorpse = Remotes:WaitForChild("ButcherCorpse");
local u1 = {
    flesh = "Flesh",
    boar = "Boar",
    blinddog = "Blind Dog"
};
local u2 = false;

local function dbFromId(p3) -- Line: 85
    -- upvalues: ItemDatabase (copy)
    if type(p3) == "string" and p3 ~= "" then
        return ItemDatabase.GetItemData(p3);
    end;

    return nil;
end;

local u4 = nil;

local function setHasTool(p5) -- Line: 92
    -- upvalues: u2 (ref), u4 (ref)
    local v6 = p5 and true or false;

    if v6 == u2 then
        return;
    end;

    u2 = v6;

    if u4 then
        u4();
    end;
end;

Remotes:WaitForChild("LoadEquipment").OnClientEvent:Connect(function(p7) -- Line: 101
    -- upvalues: ItemDatabase (copy), Butchering (copy), u2 (ref), u4 (ref)
    if type(p7) ~= "table" then
        return;
    end;

    local Melee = p7.Melee;
    local v8;

    if type(Melee) == "table" then
        local ID = Melee.ID;
        local v9;

        if type(ID) == "string" and ID ~= "" then
            v9 = ItemDatabase.GetItemData(ID);
        else
            v9 = nil;
        end;

        v8 = v9 or nil;
    else
        v8 = nil;
    end;

    local v10 = Butchering.IsButcherTool(v8) and true or false;

    if v10 == u2 then
        return;
    end;

    u2 = v10;

    if u4 then
        u4();
    end;
end);
Remotes:WaitForChild("EquipAnimEvent").OnClientEvent:Connect(function(p11, p12, p13) -- Line: 113
    -- upvalues: u2 (ref), u4 (ref), Butchering (copy), dbFromId (copy)
    if p11 ~= "Melee" then
        return;
    end;

    if p12 == "unequip" then
        local v14 = false;

        if v14 == u2 then
            return;
        end;

        u2 = v14;

        if u4 then
            u4();
        end;
    else
        local v15 = Butchering.IsButcherTool(dbFromId(p13)) and true or false;

        if v15 == u2 then
            return;
        end;

        u2 = v15;

        if u4 then
            u4();
        end;
    end;
end);
Remotes:WaitForChild("RequestEquipment"):FireServer();
local u16 = {};

local function removePrompt(p17) -- Line: 145
    -- upvalues: u16 (copy)
    local v18 = u16[p17];

    if v18 then
        v18:Destroy();
        u16[p17] = nil;
    end;
end;

local function wantsPrompt(p19) -- Line: 153
    -- upvalues: u2 (ref), Butchering (copy)
    if not u2 then
        return false;
    end;

    if not p19:IsDescendantOf(workspace) then
        return false;
    end;

    if p19:GetAttribute(Butchering.CORPSE_ATTRIBUTE) == true then
        return Butchering.IsButcherable(p19:GetAttribute("MutantType"));
    end;

    return false;
end;

local function promptAnchor(p20) -- Line: 183
    local _Ragdoll = p20:FindFirstChild("_Ragdoll");

    if _Ragdoll then
        _Ragdoll = _Ragdoll:FindFirstChild("bip01_spine");
    end;

    if _Ragdoll and _Ragdoll:IsA("BasePart") then
        return _Ragdoll;
    end;

    return p20:FindFirstChild("HumanoidRootPart") or p20.PrimaryPart;
end;

local function refreshPrompt(u21) -- Line: 190
    -- upvalues: u2 (ref), Butchering (copy), u16 (copy), u1 (copy), ButcherCorpse (copy)
    local v22;

    if u2 and (u21:IsDescendantOf(workspace) and u21:GetAttribute(Butchering.CORPSE_ATTRIBUTE) == true) then
        v22 = Butchering.IsButcherable(u21:GetAttribute("MutantType"));
    else
        v22 = false;
    end;

    if not v22 then
        local v23 = u16[u21];

        if v23 then
            v23:Destroy();
            u16[u21] = nil;
        end;

        return;
    end;

    local _Ragdoll = u21:FindFirstChild("_Ragdoll");

    if _Ragdoll then
        _Ragdoll = _Ragdoll:FindFirstChild("bip01_spine");
    end;

    if not (_Ragdoll and _Ragdoll:IsA("BasePart")) then
        _Ragdoll = u21:FindFirstChild("HumanoidRootPart") or u21.PrimaryPart;
    end;

    if not _Ragdoll then
        return;
    end;

    local v24 = u16[u21];

    if v24 then
        if v24.Parent ~= _Ragdoll then
            v24.Parent = _Ragdoll;
        end;

        return;
    end;

    local Attribute = u21:GetAttribute("MutantType");
    local ProximityPrompt = Instance.new("ProximityPrompt");
    ProximityPrompt.Name = "ButcherPrompt";
    ProximityPrompt.ActionText = "Butcher";
    ProximityPrompt.ObjectText = u1[tostring(Attribute)] or "Mutant";
    ProximityPrompt.HoldDuration = Butchering.BUTCHER_TIME;
    ProximityPrompt.MaxActivationDistance = Butchering.PROMPT_DISTANCE;
    ProximityPrompt.RequiresLineOfSight = false;
    ProximityPrompt.KeyboardKeyCode = Enum.KeyCode.G;
    ProximityPrompt.ClickablePrompt = true;
    ProximityPrompt.Style = Enum.ProximityPromptStyle.Custom;
    ProximityPrompt.Parent = _Ragdoll;
    ProximityPrompt.Triggered:Connect(function() -- Line: 222
        -- upvalues: ButcherCorpse (ref), u21 (copy)
        ButcherCorpse:FireServer(u21);
    end);
    u16[u21] = ProximityPrompt;
end;

local u25 = {};

local function track(u26) -- Line: 237
    -- upvalues: u25 (copy), Butchering (copy), refreshPrompt (copy)
    if not u26:IsA("Model") then
        return;
    end;

    if not u25[u26] then
        u25[u26] = { u26:GetAttributeChangedSignal(Butchering.CORPSE_ATTRIBUTE):Connect(function() -- Line: 241
                -- upvalues: refreshPrompt (ref), u26 (copy)
                refreshPrompt(u26);
            end), u26.DescendantAdded:Connect(function(p27) -- Line: 244
                -- upvalues: refreshPrompt (ref), u26 (copy)
                if p27.Name == "bip01_spine" and (p27.Parent and p27.Parent.Name == "_Ragdoll") then
                    refreshPrompt(u26);
                end;
            end) };
    end;

    refreshPrompt(u26);
end;

local function untrack(p28) -- Line: 254
    -- upvalues: u16 (copy), u25 (copy)
    local v29 = u16[p28];

    if v29 then
        v29:Destroy();
        u16[p28] = nil;
    end;

    local v30 = u25[p28];

    if v30 then
        for _, v in ipairs(v30) do
            v:Disconnect();
        end;

        u25[p28] = nil;
    end;
end;

u4 = function() -- Line: 265
    -- upvalues: CollectionService (copy), refreshPrompt (copy)
    for _, v in ipairs(CollectionService:GetTagged("Mutant")) do
        refreshPrompt(v);
    end;
end;

for _, v in ipairs(CollectionService:GetTagged("Mutant")) do
    track(v);
end;

CollectionService:GetInstanceAddedSignal("Mutant"):Connect(track);
CollectionService:GetInstanceRemovedSignal("Mutant"):Connect(untrack);
local ProximityPromptService = game:GetService("ProximityPromptService");
local ButcherHold = Remotes:WaitForChild("ButcherHold");

local function corpseForPrompt(p31) -- Line: 295
    -- upvalues: u16 (copy)
    for i, v in pairs(u16) do
        if v == p31 then
            return i;
        end;
    end;

    return nil;
end;

ProximityPromptService.PromptButtonHoldBegan:Connect(function(p32) -- Line: 302
    -- upvalues: u16 (copy), ButcherHold (copy)
    local v33 = nil;

    for i, v in pairs(u16) do
        if v == p32 then
            v33 = i;
            break;
        end;
    end;

    if v33 then
        ButcherHold:FireServer(v33, true);
    end;
end);
ProximityPromptService.PromptButtonHoldEnded:Connect(function(p34) -- Line: 307
    -- upvalues: u16 (copy), ButcherHold (copy)
    local v35 = nil;

    for i, v in pairs(u16) do
        if v == p34 then
            v35 = i;
            break;
        end;
    end;

    if v35 then
        ButcherHold:FireServer(v35, false);
    end;
end);