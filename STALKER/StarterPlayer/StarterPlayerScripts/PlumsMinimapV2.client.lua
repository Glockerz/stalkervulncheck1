-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local LocalPlayer = Players.LocalPlayer;
local Janitor = require(script.Internal.Janitor);
local TagName = script.GeneralSettings.TagName;
local u1 = {};

for _, child in script.Plugins:GetChildren() do
    if child:IsA("ModuleScript") then
        local v2 = require(child);

        if not v2.InitializationPriority then
            error(child:GetFullName() .. " does not have a InitializationPriority property");
        end;

        if v2.InitializeFrame and not v2.CleanupFrame then
            error(child:GetFullName() .. " has a InitializeFrame function but not a CleanupFrame function");
        end;

        table.insert(u1, v2);
    end;
end;

table.sort(u1, function(p3, p4) -- Line: 47
    return p3.InitializationPriority < p4.InitializationPriority;
end);
print(u1);
local u5 = {};

local function InstanceAdded(p6) -- Line: 54
    -- upvalues: LocalPlayer (copy), u5 (copy), Janitor (copy), u1 (copy)
    if not p6:IsA("GuiObject") then
        return;
    end;

    if not p6:IsDescendantOf(LocalPlayer) then
        return;
    end;

    u5[p6] = Janitor.new();
    local v7 = {
        Janitor = u5[p6]
    };

    for _, v in u1 do
        if v.InitializeFrame then
            v.InitializeFrame(p6, v7, u5[p6]);
        end;
    end;
end;

CollectionService:GetInstanceAddedSignal(TagName.Value):Connect(InstanceAdded);

local function InstanceRemoved(p8) -- Line: 74
    -- upvalues: u5 (copy), u1 (copy)
    if not p8:IsA("GuiObject") then
        return;
    end;

    if u5[p8] then
        u5[p8]:Destroy();
        u5[p8] = nil;
    end;

    for _, v in u1 do
        if v.CleanupFrame then
            v.CleanupFrame(p8);
        end;
    end;
end;

for _, v in CollectionService:GetTagged(TagName.Value) do
    InstanceAdded(v);
end;

CollectionService:GetInstanceRemovedSignal(TagName.Value):Connect(InstanceRemoved);