-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StarterGui = game:GetService("StarterGui");
local UserInputService = game:GetService("UserInputService");
local GridPack = require(ReplicatedStorage.GridPack.GridPack);
local ItemDatabase = require(ReplicatedStorage.ItemDatabase);
local InventoryWire = require(ReplicatedStorage:WaitForChild("InventoryWire"));
local PlaceConfig = require(ReplicatedStorage:WaitForChild("PlaceConfig"));
local ItemIconStyle = require(ReplicatedStorage:WaitForChild("ItemIconStyle"));
local WeaponCondition = require(ReplicatedStorage:WaitForChild("WeaponCondition"));
local UniformCondition = require(ReplicatedStorage:WaitForChild("UniformCondition"));
local ArmorPlates = require(ReplicatedStorage:WaitForChild("ArmorPlates"));
local ConditionValue = require(ReplicatedStorage:WaitForChild("ConditionValue"));
local HelmetCondition = require(ReplicatedStorage:WaitForChild("HelmetCondition"));
local MaskCondition = require(ReplicatedStorage:WaitForChild("MaskCondition"));
local u1 = {
    INDENT = "   ",
    Lock = require(ReplicatedStorage:WaitForChild("UniformGearLock")),
    ORDER = { "BodyGear", "BeltGear" },
    LABEL = {
        BodyGear = "Vest",
        BeltGear = "Belt"
    },
    COLOR = Color3.fromRGB(140, 200, 235)
};
local InventorySounds = ReplicatedStorage:WaitForChild("InventorySounds");

local function pickSound(p2, p3) -- Line: 44
    if not p2 then
        return nil;
    end;

    local v4 = p2:FindFirstChild(p3);

    if not v4 then
        return nil;
    end;

    if v4:IsA("Sound") then
        if v4.SoundId == "" or not v4 then
            v4 = nil;
        end;

        return v4;
    end;

    if not v4:IsA("Folder") then
        return nil;
    end;

    local v5 = {};

    for _, child in ipairs(v4:GetChildren()) do
        if child:IsA("Sound") and child.SoundId ~= "" then
            v5[#v5 + 1] = child;
        end;
    end;

    if #v5 == 0 then
        return nil;
    end;

    return v5[math.random(#v5)];
end;

local function dbgCartGhost(...) -- Line: 113
end;

local u6 = {};
local BindableEvent = Instance.new("BindableEvent");
u6.InventorySettled = BindableEvent.Event;
u6.IsUsingItem = false;

function u6.PlaySound(p7, p8, p9) -- Line: 146
    -- upvalues: InventorySounds (copy), pickSound (copy), Players (copy)
    local v10 = InventorySounds:FindFirstChild(p8);

    if not v10 then
        return;
    end;

    local v11 = pickSound(v10, p9) or pickSound(v10, "General");

    if not v11 then
        return;
    end;

    local u12 = v11:Clone();
    u12.Parent = Players.LocalPlayer.PlayerGui;
    u12:Play();
    u12.Ended:Connect(function() -- Line: 156
        -- upvalues: u12 (copy)
        u12:Destroy();
    end);
end;

function u6.StyleGridContainer(p13, p14) -- Line: 162
    if not (p14 and p14.GuiElement) then
        return;
    end;

    local GuiElement = p14.GuiElement;

    if not GuiElement:IsA("CanvasGroup") then
        return;
    end;

    GuiElement.GroupTransparency = 0.3;
    local v15 = GuiElement:FindFirstChildOfClass("UIGradient");

    if v15 then
        v15:Destroy();
    end;

    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(215, 207, 255));
    UIGradient.Parent = GuiElement;
end;

local ScaleTypeFor = ItemIconStyle.ScaleTypeFor;

local function cumulativeUIScale(p16) -- Line: 189
    local v17 = 1;

    while p16 and not p16:IsA("LayerCollector") do
        local v18 = p16:FindFirstChildOfClass("UIScale");

        if v18 then
            v17 = v17 * v18.Scale;
        end;

        p16 = p16.Parent;
    end;

    return v17 <= 0 and 1 or v17;
end;

local function gridScreenToLocal(p19, p20) -- Line: 217
    -- upvalues: cumulativeUIScale (copy)
    if p19 then
        p19 = p19.GuiElement;
    end;

    if not p19 then
        return p20;
    end;

    local v21 = cumulativeUIScale(p19);

    if v21 == 1 then
        return p20;
    end;

    local AbsolutePosition = p19.AbsolutePosition;

    return AbsolutePosition + (p20 - AbsolutePosition) / v21;
end;

local Color3_fromRGB_ret = Color3.fromRGB(48, 48, 48);

local function buildGridLines(u22, u23) -- Line: 270
    -- upvalues: Color3_fromRGB_ret (copy), cumulativeUIScale (copy)
    local Parent = u22.Parent;

    if not (Parent and (u23 and (u23.X >= 1 and u23.Y >= 1))) then
        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "__GridLines";
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.Active = false;
    Frame.ZIndex = u22.ZIndex;
    Frame.Visible = u22.Visible;
    Frame.AnchorPoint = u22.AnchorPoint;
    Frame.Position = u22.Position;
    Frame.Size = u22.Size;
    Frame.Parent = Parent;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3_fromRGB_ret;
    UIStroke.Parent = Frame;
    local u24 = {};
    local u25 = {};

    local function applyMetrics() -- Line: 295
        -- upvalues: u22 (copy), UIStroke (copy), cumulativeUIScale (ref), Parent (copy), u24 (copy), u23 (copy), u25 (copy)
        local AbsoluteSize = u22.AbsoluteSize;

        if AbsoluteSize.X <= 0 or AbsoluteSize.Y <= 0 then
            return;
        end;

        local v26 = 1 / AbsoluteSize.X;
        local v27 = 1 / AbsoluteSize.Y;
        UIStroke.Thickness = 1 / cumulativeUIScale(Parent);

        for i, v in ipairs(u24) do
            v.Size = UDim2.fromScale(v26, 1);
            v.Position = UDim2.fromScale(i / u23.X - v26 / 2, 0);
        end;

        for i, v in ipairs(u25) do
            v.Size = UDim2.fromScale(1, v27);
            v.Position = UDim2.fromScale(0, i / u23.Y - v27 / 2);
        end;
    end;

    local function newLine(p28) -- Line: 311
        -- upvalues: Color3_fromRGB_ret (ref), Frame (copy)
        local Frame2 = Instance.new("Frame");
        Frame2.BackgroundColor3 = Color3_fromRGB_ret;
        Frame2.BorderSizePixel = 0;
        Frame2.Active = false;
        Frame2.Parent = Frame;
        table.insert(p28, Frame2);
    end;

    for i = 1, u23.X - 1 do
        local Frame2 = Instance.new("Frame");
        Frame2.BackgroundColor3 = Color3_fromRGB_ret;
        Frame2.BorderSizePixel = 0;
        Frame2.Active = false;
        Frame2.Parent = Frame;
        table.insert(u24, Frame2);
        local _ = i;
    end;

    for i = 1, u23.Y - 1 do
        local Frame2 = Instance.new("Frame");
        Frame2.BackgroundColor3 = Color3_fromRGB_ret;
        Frame2.BorderSizePixel = 0;
        Frame2.Active = false;
        Frame2.Parent = Frame;
        table.insert(u25, Frame2);
        local _ = i;
    end;

    local function mirrorAspect() -- Line: 322
        -- upvalues: u22 (copy), Frame (copy)
        local v29 = u22:FindFirstChildOfClass("UIAspectRatioConstraint");
        local v30 = Frame:FindFirstChildOfClass("UIAspectRatioConstraint");

        if v29 and not v30 then
            v30 = Instance.new("UIAspectRatioConstraint");
            v30.Parent = Frame;
        elseif not v29 then
            if v30 then
                v30:Destroy();
            end;

            return;
        end;

        v30.AspectRatio = v29.AspectRatio;
        v30.AspectType = v29.AspectType;
        v30.DominantAxis = v29.DominantAxis;
    end;

    applyMetrics();
    mirrorAspect();
    u22.ChildAdded:Connect(mirrorAspect);
    u22.ChildRemoved:Connect(mirrorAspect);
    u22:GetPropertyChangedSignal("AbsoluteSize"):Connect(applyMetrics);
    u22:GetPropertyChangedSignal("Size"):Connect(function() -- Line: 342
        -- upvalues: Frame (copy), u22 (copy)
        Frame.Size = u22.Size;
    end);
    u22:GetPropertyChangedSignal("Position"):Connect(function() -- Line: 345
        -- upvalues: Frame (copy), u22 (copy)
        Frame.Position = u22.Position;
    end);
    u22:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 348
        -- upvalues: Frame (copy), u22 (copy)
        Frame.Visible = u22.Visible;
    end);
    u22.Destroying:Connect(function() -- Line: 351
        -- upvalues: Frame (copy)
        Frame:Destroy();
    end);
end;

function u6.PatchGridForOversizedItems(p31, p32) -- Line: 357
    -- upvalues: cumulativeUIScale (copy)
    local GetItemManagerPositionFromAbsolutePosition = p32.GetItemManagerPositionFromAbsolutePosition;

    function p32.GetItemManagerPositionFromAbsolutePosition(p33, p34, p35, p36) -- Line: 360
        -- upvalues: cumulativeUIScale (ref), GetItemManagerPositionFromAbsolutePosition (copy)
        local v37 = (p36 == 1 or (p36 == 3 or p36 == 90)) and true or p36 == 270;

        if p33.GridSize.X - (v37 and p35.Y or p35.X) >= 0 and p33.GridSize.Y - (v37 and p35.X or p35.Y) >= 0 then
            return GetItemManagerPositionFromAbsolutePosition(p33, p34, p35, p36);
        end;

        local SizeScale = p33:GetSizeScale();
        local Offset = p33:GetOffset(p36);
        local v38;

        if p33 then
            v38 = p33.GuiElement;
        else
            v38 = p33;
        end;

        if v38 then
            local v39 = cumulativeUIScale(v38);

            if v39 ~= 1 then
                local AbsolutePosition = v38.AbsolutePosition;
                p34 = AbsolutePosition + (p34 - AbsolutePosition) / v39;
            end;
        end;

        local math_floor_ret = math.floor((p34.X - Offset.X) / SizeScale.X + 0.5);
        local math_floor_ret2 = math.floor((p34.Y - Offset.Y) / SizeScale.Y + 0.5);
        local math_max_ret = math.max(0, p33.GridSize.X - 1);
        local math_clamp_ret = math.clamp(math_floor_ret, 0, math_max_ret);
        local math_max_ret2 = math.max(0, p33.GridSize.Y - 1);
        local math_clamp_ret2 = math.clamp(math_floor_ret2, 0, math_max_ret2);

        return Vector2.new(math_clamp_ret, math_clamp_ret2);
    end;
end;

function u6._patchGridPackDragScaling(p40) -- Line: 414
    -- upvalues: ReplicatedStorage (copy), cumulativeUIScale (copy), buildGridLines (copy), UserInputService (copy)
    if p40._gridPackDragPatched then
        return;
    end;

    local GridPack2 = ReplicatedStorage:FindFirstChild("GridPack");
    local v41 = GridPack2 and GridPack2:FindFirstChild("GridPack") and GridPack2.GridPack:FindFirstChild("Item");

    if not v41 then
        warn("[InventoryController] GridPack drag patch skipped: Item module not found");

        return;
    end;

    local success, result = pcall(require, v41);

    if not success or type(result) ~= "table" then
        warn("[InventoryController] GridPack drag patch skipped: " .. tostring(result));

        return;
    end;

    p40._gridPackDragPatched = true;
    local ItemManager = GridPack2.GridPack:FindFirstChild("ItemManager");

    if ItemManager then
        ItemManager = ItemManager:FindFirstChild("Grid");
    end;

    local success2, result2 = pcall(require, ItemManager);

    if success2 and type(result2) == "table" then
        local GetItemManagerPositionFromAbsolutePosition = result2.GetItemManagerPositionFromAbsolutePosition;

        function result2.GetItemManagerPositionFromAbsolutePosition(p42, p43, p44, p45) -- Line: 443
            -- upvalues: GetItemManagerPositionFromAbsolutePosition (copy), cumulativeUIScale (ref)
            local v46;

            if p42 then
                v46 = p42.GuiElement;
            else
                v46 = p42;
            end;

            if v46 then
                local v47 = cumulativeUIScale(v46);

                if v47 ~= 1 then
                    local AbsolutePosition = v46.AbsolutePosition;
                    p43 = AbsolutePosition + (p43 - AbsolutePosition) / v47;
                end;
            end;

            return GetItemManagerPositionFromAbsolutePosition(p42, p43, p44, p45);
        end;

        local _createGuiElement = result2._createGuiElement;

        function result2._createGuiElement(p48, p49) -- Line: 451
            -- upvalues: _createGuiElement (copy), buildGridLines (ref)
            local v50, v51 = _createGuiElement(p48, p49);
            local success3, result3 = pcall(buildGridLines, v50, p49.GridSize);

            if not success3 then
                warn("[InventoryController] grid lines skipped: " .. tostring(result3));
            end;

            return v50, v51;
        end;
    else
        warn("[InventoryController] GridPack hit-test patch skipped: Grid module unavailable");
    end;

    function result._updateDraggingPosition(u52) -- Line: 463
        -- upvalues: cumulativeUIScale (ref), UserInputService (ref)
        local AbsolutePosition = u52.ItemManager.GuiElement.Parent.AbsolutePosition;
        local v53 = cumulativeUIScale(u52.ItemElement.Parent);
        local MouseLocation = UserInputService:GetMouseLocation();

        if not u52._dragAnchored then
            u52._dragAnchored = true;
            u52._dragAnchorMouse = MouseLocation;
            u52._dragAnchorElement = u52.ItemElement.AbsolutePosition;

            if u52._draggingTrove then
                u52._draggingTrove:Add(function() -- Line: 488
                    -- upvalues: u52 (copy)
                    u52._dragAnchored = false;
                end);
            end;
        end;

        local v54 = u52._dragAnchorElement + (MouseLocation - u52._dragAnchorMouse);
        u52.ItemElement.Position = UDim2.fromOffset((v54.X - AbsolutePosition.X) / v53, (v54.Y - AbsolutePosition.Y) / v53);

        if not u52._highlight then
            return;
        end;

        local v55 = u52.HoveringItemManager or u52.ItemManager;
        local ItemManagerPositionFromAbsolutePosition = v55:GetItemManagerPositionFromAbsolutePosition(u52.ItemElement.AbsolutePosition, u52.Size, u52.PotentialRotation);
        u52._highlight.Position = ItemManagerPositionFromAbsolutePosition;

        if v55:IsColliding(u52, { u52 }, ItemManagerPositionFromAbsolutePosition, u52.PotentialRotation) == true then
            u52._highlight.Color = Color3.new(1, 0, 0);

            return;
        end;

        u52._highlight.Color = Color3.new(0, 0.666667, 0);
    end;
end;

local function offsetToScale(p56, p57, p58) -- Line: 520
    local Size = p56.Size;
    local Position = p56.Position;
    p56.Size = UDim2.fromScale(Size.X.Scale + Size.X.Offset / p57, Size.Y.Scale + Size.Y.Offset / p58);
    p56.Position = UDim2.fromScale(Position.X.Scale + Position.X.Offset / p57, Position.Y.Scale + Position.Y.Offset / p58);
end;

function u6._convertReadoutsToScale(p59, p60) -- Line: 551
    -- upvalues: offsetToScale (copy)
    local v61 = p60:FindFirstChildOfClass("UIAspectRatioConstraint");

    if not v61 then
        return;
    end;

    local v62 = 1080 * v61.AspectRatio;

    for _, v in ipairs({ { "InventoryFrame", "WeightDisplay" }, { "InventoryFrame", "RoubleDisplay" }, { "CharacterFrame", "RadDisplay" }, { "CharacterFrame", "ArmorProtection" } }) do
        local v63 = p60:FindFirstChild(v[1]);
        local v64;

        if v63 then
            v64 = v63:FindFirstChild(v[2]);
        else
            v64 = v63;
        end;

        if v64 then
            local Offset = v64.Size.X.Offset;
            local Offset2 = v64.Size.Y.Offset;

            if Offset > 0 and Offset2 > 0 then
                for _, child in ipairs(v64:GetChildren()) do
                    if child:IsA("GuiObject") then
                        offsetToScale(child, Offset, Offset2);
                    end;
                end;

                offsetToScale(v64, v63.Size.X.Scale * v62, v63.Size.Y.Scale * 1080);
            end;
        end;
    end;

    local InventoryFrame = p60:FindFirstChild("InventoryFrame");

    if InventoryFrame then
        InventoryFrame = InventoryFrame:FindFirstChild("RoubleDisplay");
    end;

    if InventoryFrame then
        InventoryFrame = InventoryFrame:FindFirstChild("DropButton");
    end;

    if InventoryFrame and (InventoryFrame:IsA("TextButton") and not InventoryFrame.TextScaled) then
        local v65 = InventoryFrame:FindFirstChildOfClass("UITextSizeConstraint") or Instance.new("UITextSizeConstraint");
        v65.MaxTextSize = InventoryFrame.TextSize;
        v65.Parent = InventoryFrame;
        InventoryFrame.TextScaled = true;
    end;
end;

function u6.ApplyResolutionScale(u66) -- Line: 605
    if not u66.ResScale then
        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    local math_clamp_ret = math.clamp(workspace_CurrentCamera.ViewportSize.Y / 1080, 0.85, 1);
    u66.ResScale.Scale = math_clamp_ret;

    if u66.InvScroll then
        task.defer(function() -- Line: 615
            -- upvalues: u66 (copy)
            u66:UpdateInventoryCanvas();
        end);
    end;
end;

function u6.UpdateInventoryCanvas(p67) -- Line: 625
    local InvScroll = p67.InvScroll;
    local InvContent = p67.InvContent;

    if not (InvScroll and InvContent) then
        return;
    end;

    local RunService = game:GetService("RunService");
    RunService.Heartbeat:Wait();
    RunService.Heartbeat:Wait();
    local Y = InvContent.AbsolutePosition.Y;
    local Y2 = InvScroll.AbsoluteWindowSize.Y;
    local u68 = Y2;

    local function consider(p69) -- Line: 638
        -- upvalues: Y (copy), u68 (ref)
        local v70 = p69 - Y;

        if u68 < v70 then
            u68 = v70;
        end;
    end;

    if p67.BackpackSectionFrame then
        local v71 = p67.BackpackSectionFrame.AbsolutePosition.Y + p67.BackpackSectionFrame.AbsoluteSize.Y - Y;

        if u68 < v71 then
            u68 = v71;
        end;
    end;

    if p67.MainInventory and p67.MainInventory.GuiElement then
        local GuiElement = p67.MainInventory.GuiElement;
        local GridSize = p67.MainInventory.GridSize;
        local Y3 = GuiElement.AbsolutePosition.Y;
        local v72 = Y3 + GuiElement.AbsoluteSize.Y - Y;

        if u68 < v72 then
            u68 = v72;
        end;

        if GridSize and (GridSize.X > 0 and GuiElement.AbsoluteSize.X > 0) then
            local v73 = Y3 + GuiElement.AbsoluteSize.X / GridSize.X * GridSize.Y - Y;

            if u68 < v73 then
                u68 = v73;
            end;
        end;
    end;

    local v74 = math.max(0, u68 + 40 - Y2) / math.max(p67.ResScale and p67.ResScale.Scale or 1, 0.001);
    InvScroll.CanvasSize = UDim2.new(0, 0, 1, v74);
end;

local u75 = {
    pockets = "Pockets",
    rig = "ChestRig",
    belt = "BattleBelt",
    backpack = "Backpack",
    stash = "Stash"
};

function u6._scCheckComposite(u76, u77, u78, u79) -- Line: 704
    -- upvalues: Players (copy), u75 (copy)
    u76._scLatestOp = u77;
    task.delay(0.8, function() -- Line: 706
        -- upvalues: u76 (copy), u77 (copy), Players (ref), u79 (copy), u75 (ref), u78 (copy)
        if u76._scLatestOp ~= u77 then
            return;
        end;

        local UserId = Players.LocalPlayer.UserId;
        local u80 = 0;
        local u81 = {};
        local u82 = 0;
        local u83 = {};

        local function drop(p84, p85) -- Line: 711
            -- upvalues: u81 (copy), u79 (ref), u75 (ref), u82 (ref), u83 (copy)
            table.insert(u81, p84 .. "=" .. p85);
            local v86 = u79 and u79[u75[p84]];

            if v86 then
                u82 = u82 + v86;
                table.insert(u83, string.format("%s(%d)", p84, v86));
            end;
        end;

        local function count(p87, p88, p89) -- Line: 722
            -- upvalues: u81 (copy), u79 (ref), u75 (ref), u82 (ref), u83 (copy), u80 (ref)
            if not p87 then
                table.insert(u81, p88 .. "=nil");
                local v90 = u79 and u79[u75[p88]];

                if v90 then
                    u82 = u82 + v90;
                    table.insert(u83, string.format("%s(%d)", p88, v90));
                end;

                return;
            end;

            local v91 = p87.Metadata and p87.Metadata.TiedInstance;

            if not p89 or v91 == p89 then
                local v92 = 0;

                for _, v in pairs(p87.Items or {}) do
                    if v and (v.Metadata and v.Metadata.ID) then
                        v92 = v92 + 1;
                    end;
                end;

                u80 = u80 + v92;
                table.insert(u81, p88 .. "=" .. v92);

                return;
            end;

            local v93 = p88 .. "=" .. "<showing " .. tostring(v91) .. ">";
            table.insert(u81, v93);
            local v94 = u79 and u79[u75[p88]];

            if v94 then
                u82 = u82 + v94;
                table.insert(u83, string.format("%s(%d)", p88, v94));
            end;
        end;

        count(u76.LocalInventory, "pockets");
        count(u76.ChestRigInventory, "rig");
        count(u76.BattleBeltInventory, "belt");
        count(u76.MainInventory, "backpack");
        count(u76.StorageInventory, "stash", "Stash_" .. UserId);
        local v95 = u78 - u82;

        if #u83 > 0 then
            local v96 = "[not rendered, excluded from both sides: " .. table.concat(u83, " ") .. "]";
            table.insert(u81, v96);
        elseif not u79 then
            table.insert(u81, "[no per-container data -- comparison is blind]");
        end;

        local table_concat_ret = table.concat(u81, " ");

        if u80 ~= v95 then
            warn(string.format("[SCTRACE op=%s] COMPOSITE_MISMATCH client sees %d, server had %d (short %d) | %s", tostring(u77), u80, v95, v95 - u80, table_concat_ret));
        end;
    end);
end;

function u6.Init(u97) -- Line: 765
    -- upvalues: StarterGui (copy), Players (copy), ReplicatedStorage (copy), GridPack (copy), UserInputService (copy), pickSound (copy), BindableEvent (copy), ItemDatabase (copy), ArmorPlates (copy), InventorySounds (copy)
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    local InventoryGui = Players.LocalPlayer.PlayerGui:WaitForChild("InventoryGui");
    u97.CurrentStoragePart = nil;
    local InventoryFrame = InventoryGui.MainFrame.InventoryFrame;
    local ContainerFrame = InventoryGui.MainFrame.ContainerFrame;
    local CharacterFrame = InventoryGui.MainFrame.CharacterFrame;
    local Frame = InventoryFrame.PocketsFrame.Frame;
    local BackpackFrame = InventoryFrame.BackpackFrame;
    local Frame2 = InventoryFrame.BackpackFrame.Frame;
    local ChestRigFrame = InventoryFrame.ChestRigFrame;
    local Frame3 = InventoryFrame.ChestRigFrame.Frame;
    u97.ChestRigPattern = InventoryFrame.ChestRigFrame.Pattern;
    local BattleBeltFrame = InventoryFrame.BattleBeltFrame;
    local Frame4 = InventoryFrame.BattleBeltFrame.Frame;
    u97.BattleBeltGridFrame = Frame4;
    local HeadGearFrame = CharacterFrame.HeadGearFrame;
    local NightOpticalFrame = CharacterFrame.NightOpticalFrame;
    local FaceWearFrame = CharacterFrame.FaceWearFrame;
    local EyeWearFrame = CharacterFrame.EyeWearFrame;
    local BodyGearFrame = CharacterFrame.BodyGearFrame;
    local PrimaryFrame = CharacterFrame.PrimaryFrame;
    local SecondaryFrame = CharacterFrame.SecondaryFrame;
    local SidearmFrame = CharacterFrame.SidearmFrame;
    local MeleeFrame = CharacterFrame.MeleeFrame;
    u97.PrimaryFrame = PrimaryFrame;
    u97.SecondaryFrame = SecondaryFrame;
    u97.SidearmFrame = SidearmFrame;
    u97.MeleeFrame = MeleeFrame;
    local UniformFrame = CharacterFrame.UniformFrame;
    local Frame5 = ContainerFrame.CrateFrame.Frame;
    local TextLabel = ContainerFrame.CrateFrame.Title.TextLabel;
    u97.BackpackGridFrame = Frame2;
    u97.ChestRigGridFrame = Frame3;
    u97.CrateGridFrame = Frame5;
    u97.CrateTitleLabel = TextLabel;
    u97.BackpackSectionFrame = BackpackFrame;
    local StashScroll = ContainerFrame:FindFirstChild("StashScroll");

    if StashScroll then
        StashScroll:Destroy();
    end;

    u97._stashScroll = nil;
    local MainFrame = InventoryGui.MainFrame;
    local ResScale = MainFrame:FindFirstChild("ResScale");

    if ResScale then
        ResScale:Destroy();
    end;

    local UIScale = Instance.new("UIScale");
    UIScale.Name = "ResScale";
    UIScale.Scale = 1;
    UIScale.Parent = MainFrame;
    u97.ResScale = UIScale;
    u97:_convertReadoutsToScale(MainFrame);
    u97:_patchGridPackDragScaling();
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if u97._viewportConn then
        u97._viewportConn:Disconnect();
    end;

    if workspace_CurrentCamera then
        u97._viewportConn = workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 834
            -- upvalues: u97 (copy)
            u97:ApplyResolutionScale();
        end);
    end;

    if u97._camSwapConn then
        u97._camSwapConn:Disconnect();
    end;

    u97._camSwapConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line: 839
        -- upvalues: u97 (copy)
        local workspace_CurrentCamera2 = workspace.CurrentCamera;

        if not workspace_CurrentCamera2 then
            return;
        end;

        if u97._viewportConn then
            u97._viewportConn:Disconnect();
        end;

        u97._viewportConn = workspace_CurrentCamera2:GetPropertyChangedSignal("ViewportSize"):Connect(function() -- Line: 843
            -- upvalues: u97 (ref)
            u97:ApplyResolutionScale();
        end);
        u97:ApplyResolutionScale();
    end);
    u97:ApplyResolutionScale();
    local InvScroll = InventoryFrame:FindFirstChild("InvScroll");

    if InvScroll then
        InvScroll:Destroy();
    end;

    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "InvScroll";
    ScrollingFrame.Size = UDim2.fromScale(1, 1);
    ScrollingFrame.Position = UDim2.fromScale(0, 0);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.ScrollBarThickness = 6;
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 1, 0);
    ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.None;
    ScrollingFrame.Active = true;
    ScrollingFrame.Parent = InventoryFrame;
    u97.InvScroll = ScrollingFrame;
    local Frame6 = Instance.new("Frame");
    Frame6.Name = "InvContent";
    Frame6.BackgroundTransparency = 1;
    Frame6.BorderSizePixel = 0;
    Frame6.Position = UDim2.fromOffset(0, 0);
    Frame6.Parent = ScrollingFrame;
    u97.InvContent = Frame6;

    local function syncInvContentSize() -- Line: 882
        -- upvalues: ScrollingFrame (copy), u97 (copy), Frame6 (copy)
        local AbsoluteWindowSize = ScrollingFrame.AbsoluteWindowSize;
        local v98 = u97.ResScale and u97.ResScale.Scale or 1;

        if AbsoluteWindowSize.X > 0 and (AbsoluteWindowSize.Y > 0 and v98 > 0) then
            Frame6.Size = UDim2.fromOffset(AbsoluteWindowSize.X / v98, AbsoluteWindowSize.Y / v98);
        end;
    end;

    local AbsoluteWindowSize = ScrollingFrame.AbsoluteWindowSize;
    local v99 = u97.ResScale and (u97.ResScale.Scale or 1) or 1;

    if AbsoluteWindowSize.X > 0 and (AbsoluteWindowSize.Y > 0 and v99 > 0) then
        Frame6.Size = UDim2.fromOffset(AbsoluteWindowSize.X / v99, AbsoluteWindowSize.Y / v99);
    end;

    if u97._invContentConn then
        u97._invContentConn:Disconnect();
    end;

    u97._invContentConn = ScrollingFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 891
        -- upvalues: ScrollingFrame (copy), u97 (copy), Frame6 (copy)
        local AbsoluteWindowSize2 = ScrollingFrame.AbsoluteWindowSize;
        local v100 = u97.ResScale and u97.ResScale.Scale or 1;

        if AbsoluteWindowSize2.X > 0 and (AbsoluteWindowSize2.Y > 0 and v100 > 0) then
            Frame6.Size = UDim2.fromOffset(AbsoluteWindowSize2.X / v100, AbsoluteWindowSize2.Y / v100);
        end;

        u97:UpdateInventoryCanvas();
    end);
    local v101 = {
        ChestRigFrame,
        BattleBeltFrame,
        InventoryFrame:FindFirstChild("PocketsFrame"),
        BackpackFrame
    };

    for _, v in ipairs(v101) do
        if v and v.Parent then
            v.Parent = Frame6;
        end;
    end;

    u97.BackpackAuthoredSize = BackpackFrame.Size;
    local u102 = ReplicatedStorage.Remotes.GetLocalInventory:InvokeServer();
    local Vector2_new_ret = Vector2.new(4, 1);
    u97.LocalInventory = GridPack.createGrid({
        Visible = true,
        SlotAspectRatio = 1,
        Parent = Frame,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = Vector2_new_ret,
        Size = UDim2.fromScale(Vector2_new_ret.X, Vector2_new_ret.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = u102.TiedInstance
        }
    });
    u97:PatchGridForOversizedItems(u97.LocalInventory);
    u97:StyleGridContainer(u97.LocalInventory);
    u97.LocalInventory.IsColliding = u97:CreateGridIsColliding();
    u97.MainInventory = GridPack.createGrid({
        Visible = false,
        SlotAspectRatio = 1,
        Parent = Frame2,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = Vector2.new(1, 1),
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = "BackpackInternal_" .. Players.LocalPlayer.UserId
        }
    });
    u97:PatchGridForOversizedItems(u97.MainInventory);
    u97:StyleGridContainer(u97.MainInventory);
    u97.MainInventory.IsColliding = u97:CreateGridIsColliding();
    u97.ChestRigInventory = GridPack.createGrid({
        Visible = false,
        SlotAspectRatio = 1,
        Parent = Frame3,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = Vector2.new(1, 1),
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = "ChestRigInternal_" .. Players.LocalPlayer.UserId
        }
    });

    if u97.ChestRigInventory.GuiElement then
        u97.ChestRigInventory.GuiElement.Visible = false;
        u97.ChestRigInventory.GuiElement.Size = UDim2.new(0, 0, 0, 0);
    end;

    u97:PatchGridForOversizedItems(u97.ChestRigInventory);
    u97:StyleGridContainer(u97.ChestRigInventory);
    u97.ChestRigInventory.IsColliding = u97:CreateGridIsColliding();
    u97.BattleBeltInventory = GridPack.createGrid({
        Visible = false,
        SlotAspectRatio = 1,
        Parent = Frame4,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = Vector2.new(1, 1),
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = "BattleBeltInternal_" .. Players.LocalPlayer.UserId
        }
    });

    if u97.BattleBeltInventory.GuiElement then
        u97.BattleBeltInventory.GuiElement.Visible = false;
        u97.BattleBeltInventory.GuiElement.Size = UDim2.new(0, 0, 0, 0);
    end;

    u97:PatchGridForOversizedItems(u97.BattleBeltInventory);
    u97:StyleGridContainer(u97.BattleBeltInventory);
    u97.BattleBeltInventory.IsColliding = u97:CreateGridIsColliding();
    u97.HeadSlot = u97:CreateEquipmentSlot(HeadGearFrame, "HeadGear");
    u97.FaceWearSlot = u97:CreateEquipmentSlot(FaceWearFrame, "FaceWear");
    u97.EyeWearSlot = u97:CreateEquipmentSlot(EyeWearFrame, "EyeWear");
    u97.BodySlot = u97:CreateEquipmentSlot(BodyGearFrame, "BodyGear");
    u97.BeltGearSlot = u97:CreateEquipmentSlot(BattleBeltFrame, "BeltGear");
    u97.PrimarySlot = u97:CreateEquipmentSlot(PrimaryFrame, "Primary");
    u97.SecondarySlot = u97:CreateEquipmentSlot(SecondaryFrame, "Secondary");
    u97.SidearmSlot = u97:CreateEquipmentSlot(SidearmFrame, "Sidearm");
    u97.MeleeSlot = u97:CreateEquipmentSlot(MeleeFrame, "Melee");
    u97.UniformSlot = u97:CreateEquipmentSlot(UniformFrame, "Uniform");
    u97.BackpackSlot = u97:CreateEquipmentSlot(BackpackFrame, "Backpack");
    u97.NightOpticalSlot = u97:CreateEquipmentSlot(NightOpticalFrame, "NightOptical");
    u97.StorageInventory = GridPack.createGrid({
        Visible = false,
        SlotAspectRatio = 1,
        Parent = Frame5,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = Vector2.new(1, 1),
        Size = UDim2.fromScale(1, 1),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = nil
        }
    });
    u97:PatchGridForOversizedItems(u97.StorageInventory);
    u97.StorageInventory.IsColliding = u97:CreateGridIsColliding();
    u97.TransferLink = GridPack.createTransferLink({});
    u97.LocalInventory:ConnectTransferLink(u97.TransferLink);
    u97.MainInventory:ConnectTransferLink(u97.TransferLink);
    u97.ChestRigInventory:ConnectTransferLink(u97.TransferLink);
    u97.BattleBeltInventory:ConnectTransferLink(u97.TransferLink);
    u97.StorageInventory:ConnectTransferLink(u97.TransferLink);
    u97.HeadSlot:ConnectTransferLink(u97.TransferLink);
    u97.FaceWearSlot:ConnectTransferLink(u97.TransferLink);
    u97.EyeWearSlot:ConnectTransferLink(u97.TransferLink);
    u97.BodySlot:ConnectTransferLink(u97.TransferLink);
    u97.BeltGearSlot:ConnectTransferLink(u97.TransferLink);
    u97.PrimarySlot:ConnectTransferLink(u97.TransferLink);
    u97.SecondarySlot:ConnectTransferLink(u97.TransferLink);
    u97.SidearmSlot:ConnectTransferLink(u97.TransferLink);
    u97.MeleeSlot:ConnectTransferLink(u97.TransferLink);
    u97.UniformSlot:ConnectTransferLink(u97.TransferLink);
    u97.BackpackSlot:ConnectTransferLink(u97.TransferLink);
    u97.NightOpticalSlot:ConnectTransferLink(u97.TransferLink);
    local RunService = game:GetService("RunService");
    local Color3_fromRGB_ret2 = Color3.fromRGB(140, 230, 110);
    local Color3_fromRGB_ret3 = Color3.fromRGB(230, 90, 90);

    local function ensureStroke(p103) -- Line: 1059
        -- upvalues: Color3_fromRGB_ret2 (copy)
        local DragHighlight = p103:FindFirstChild("DragHighlight");

        if not DragHighlight then
            DragHighlight = Instance.new("UIStroke");
            DragHighlight.Name = "DragHighlight";
            DragHighlight.Color = Color3_fromRGB_ret2;
            DragHighlight.Thickness = 3;
            DragHighlight.Transparency = 1;
            DragHighlight.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
            DragHighlight.Parent = p103;
        end;

        return DragHighlight;
    end;

    local function findDragging() -- Line: 1073
        -- upvalues: u97 (copy)
        local TransferLink = u97.TransferLink;

        if not (TransferLink and TransferLink.ConnectedItemManagers) then
            return nil, nil;
        end;

        for _, v in ipairs(TransferLink.ConnectedItemManagers) do
            local Items = v.Items;

            if Items then
                for _, v2 in pairs(Items) do
                    if v2.IsDragging and v2.Metadata then
                        return v2.Metadata.ItemType, v2;
                    end;
                end;
            end;
        end;

        return nil, nil;
    end;

    local u104 = 0;
    u97._equipSlotHintConn = RunService.RenderStepped:Connect(function(p105) -- Line: 1090
        -- upvalues: InventoryGui (copy), u97 (copy), u104 (ref), findDragging (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
        if InventoryGui and not InventoryGui.Enabled then
            return;
        end;

        local TransferLink = u97.TransferLink;

        if not (TransferLink and TransferLink.ConnectedItemManagers) then
            return;
        end;

        u104 = u104 + p105;
        local v106 = (math.sin(u104 * 1.5 * 3.141592653589793 * 2) + 1) * 0.5 * -0.55 + 0.55;
        local v107, _ = findDragging();

        for _, v in ipairs(TransferLink.ConnectedItemManagers) do
            local Metadata = v.Metadata;
            local GuiElement = v.GuiElement;

            if not (Metadata and Metadata.IsBarterChip) and (Metadata and (Metadata.AcceptsType and (GuiElement and GuiElement.Visible))) then
                local AcceptsType = Metadata.AcceptsType;
                local v108;

                if v107 then
                    if AcceptsType == v107 then
                        v108 = true;
                    elseif AcceptsType == "Secondary" then
                        v108 = v107 == "Primary";
                    else
                        v108 = false;
                    end;
                else
                    v108 = false;
                end;

                local v109 = v.Item ~= nil;
                local DragHighlight = GuiElement:FindFirstChild("DragHighlight");

                if not DragHighlight then
                    DragHighlight = Instance.new("UIStroke");
                    DragHighlight.Name = "DragHighlight";
                    DragHighlight.Color = Color3_fromRGB_ret2;
                    DragHighlight.Thickness = 3;
                    DragHighlight.Transparency = 1;
                    DragHighlight.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
                    DragHighlight.Parent = GuiElement;
                end;

                if v108 and not v109 then
                    DragHighlight.Color = Color3_fromRGB_ret2;
                    DragHighlight.Transparency = v106;
                elseif v108 and v109 then
                    DragHighlight.Color = Color3_fromRGB_ret3;
                    DragHighlight.Transparency = v106;
                else
                    DragHighlight.Transparency = 1;
                end;
            end;
        end;
    end);
    task.defer(function() -- Line: 1138
        -- upvalues: u97 (copy), u102 (copy)
        u97:LoadInventory(u97.LocalInventory, u102);
    end);
    local u110 = nil;
    ReplicatedStorage.Remotes.StorageInventoryOpened.OnClientEvent:Connect(function(p111) -- Line: 1151
        -- upvalues: ReplicatedStorage (ref), u97 (copy), TextLabel (copy), GridPack (ref), InventoryGui (copy), Players (ref), UserInputService (ref), u110 (ref)
        local v112;

        if p111 then
            v112 = p111.TiedInstance;
        else
            v112 = p111;
        end;

        if type(v112) == "string" then
            local v113 = require(ReplicatedStorage:WaitForChild("OpenableContainer")).GetOpen()[v112];

            if v113 and v113.Grid then
                u97:LoadInventory(v113.Grid, p111);

                return;
            end;
        end;

        if p111 and (p111.TiedInstance and (type(p111.TiedInstance) == "string" and p111.TiedInstance:sub(1, 5) == "Sell_")) then
            if u97.SellPanelGrid then
                u97:LoadInventory(u97.SellPanelGrid, p111);
                u97:RefreshSellPanelTotal();
            end;

            if u97.StorageInventory then
                u97:ClearGridPackInventory(u97.StorageInventory);

                if u97.StorageInventory.GuiElement then
                    u97.StorageInventory.GuiElement:Destroy();
                end;

                u97.StorageInventory = nil;
                u97.CurrentStoragePart = nil;
            end;

            if u97._expansionPanel then
                u97._expansionPanel.Visible = false;
            end;

            return;
        end;

        u97:StopVicinityRefresh();

        if u97._expansionPanel then
            u97._expansionPanel.Visible = false;
        end;

        if u97.StorageInventory then
            u97:ClearGridPackInventory(u97.StorageInventory);

            if u97.StorageInventory.GuiElement then
                u97.StorageInventory.GuiElement:Destroy();
            end;

            u97.StorageInventory = nil;
        end;

        for _, child in pairs(u97.CrateGridFrame:GetChildren()) do
            if child:IsA("CanvasGroup") then
                child:Destroy();
            end;
        end;

        local v114 = p111.GridSize or Vector2.new(4, 4);
        TextLabel.Text = string.upper(p111.StorageName or "CRATE");
        print(v114, "Creating new storage grid");
        u97.StorageInventory = GridPack.createGrid({
            Visible = true,
            SlotAspectRatio = 1,
            Parent = u97.CrateGridFrame,
            Assets = {
                Slot = game.ReplicatedStorage.GridPack.Slot
            },
            GridSize = v114,
            Size = UDim2.fromScale(v114.X, v114.Y),
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Metadata = {
                TiedInstance = p111.TiedInstance
            }
        });
        u97:PatchGridForOversizedItems(u97.StorageInventory);
        u97.StorageInventory.IsColliding = u97:CreateGridIsColliding();
        u97.StorageInventory:ConnectTransferLink(u97.TransferLink);
        InventoryGui.Enabled = true;
        game.Lighting.InventoryBlur.Enabled = true;
        u97.CurrentStoragePart = p111.TiedInstance;
        require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Disable();
        u97._savedCameraMode = Players.LocalPlayer.CameraMode;
        Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic;
        UserInputService.MouseIconEnabled = true;

        if u97._mouseUnlockConn then
            u97._mouseUnlockConn:Disconnect();
        end;

        u97._mouseUnlockConn = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 1278
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);
        u97:LoadInventory(u97.StorageInventory, p111);
        u110(p111.TiedInstance);
        local TiedInstance = p111.TiedInstance;

        if typeof(TiedInstance) == "Instance" and TiedInstance:IsA("BasePart") then
            task.spawn(function() -- Line: 1318
                -- upvalues: u97 (ref), TiedInstance (copy), Players (ref)
                while u97.CurrentStoragePart == TiedInstance do
                    if not TiedInstance.Parent then
                        u97:CloseStorage();

                        return;
                    end;

                    local Character = Players.LocalPlayer.Character;

                    if Character then
                        Character = Character:FindFirstChild("HumanoidRootPart");
                    end;

                    if Character and (Character.Position - TiedInstance.Position).Magnitude > 10 then
                        u97:CloseStorage();

                        return;
                    end;

                    task.wait(0.5);
                end;
            end);
        end;
    end);

    local function getLootingSoundFolder() -- Line: 1342
        -- upvalues: ReplicatedStorage (ref)
        local InventorySounds2 = ReplicatedStorage:FindFirstChild("InventorySounds");

        if InventorySounds2 then
            InventorySounds2 = InventorySounds2:FindFirstChild("Looting");
        end;

        return InventorySounds2;
    end;

    local function playRandomSound(p115) -- Line: 1350
        -- upvalues: ReplicatedStorage (ref), pickSound (ref)
        local InventorySounds2 = ReplicatedStorage:FindFirstChild("InventorySounds");

        if InventorySounds2 then
            InventorySounds2 = InventorySounds2:FindFirstChild("Looting");
        end;

        if not InventorySounds2 then
            return;
        end;

        local v116 = pickSound(InventorySounds2, p115);

        if not v116 then
            local v117 = {};

            for _, child in ipairs(InventorySounds2:GetChildren()) do
                if child:IsA("Sound") and (child.Name:find("^" .. p115) and child.SoundId ~= "") then
                    v117[#v117 + 1] = child;
                end;
            end;

            if #v117 == 0 then
                return;
            end;

            v116 = v117[math.random(#v117)];
        end;

        local u118 = v116:Clone();
        u118.Parent = game:GetService("SoundService");
        u118:Play();
        task.delay(8, function() -- Line: 1367
            -- upvalues: u118 (copy)
            if u118 and u118.Parent then
                u118:Destroy();
            end;
        end);
        u118.Ended:Connect(function() -- Line: 1368
            -- upvalues: u118 (copy)
            if u118 and u118.Parent then
                u118:Destroy();
            end;
        end);
    end;

    u97._crateSearchSoundToken = 0;

    u110 = function(u119) -- Line: 1374
        -- upvalues: u97 (copy), playRandomSound (copy)
        local v120 = u97;
        v120._crateSearchSoundToken = v120._crateSearchSoundToken + 1;
        local _crateSearchSoundToken = u97._crateSearchSoundToken;
        task.spawn(function() -- Line: 1377
            -- upvalues: _crateSearchSoundToken (copy), u97 (ref), u119 (copy), playRandomSound (ref)
            while _crateSearchSoundToken == u97._crateSearchSoundToken and (u97.StorageInventory and u97.CurrentStoragePart == u119) do
                local v121 = false;

                for _, descendant in ipairs(u97.CrateGridFrame:GetDescendants()) do
                    if descendant.Name == "SilhouetteOverlay" then
                        v121 = true;
                        break;
                    end;
                end;

                if not v121 then
                    break;
                end;

                playRandomSound("Searching");
                task.wait(0.6 + math.random() * 0.4);
            end;
        end);
    end;

    ReplicatedStorage.Remotes.StorageItemRevealed.OnClientEvent:Connect(function(p122) -- Line: 1400
        -- upvalues: u97 (copy), playRandomSound (copy)
        if not (p122 and p122.TiedInstance) then
            return;
        end;

        if not u97.StorageInventory or u97.CurrentStoragePart ~= p122.TiedInstance then
            return;
        end;

        local v123 = {};

        for i, v in pairs(p122.Items) do
            if v.Revealed == true then
                v123[i] = true;
            end;
        end;

        local v124 = 0;

        for _, descendant in ipairs(u97.CrateGridFrame:GetDescendants()) do
            if descendant:IsA("CanvasGroup") and v123[descendant:GetAttribute("ItemIndex")] then
                local SilhouetteOverlay = descendant:FindFirstChild("SilhouetteOverlay");

                if SilhouetteOverlay then
                    SilhouetteOverlay:Destroy();
                    v124 = v124 + 1;
                end;
            end;
        end;

        if v124 > 0 then
            playRandomSound("Reveal");
        end;
    end);
    local u125 = false;
    ReplicatedStorage.Remotes.LoadEquipment.OnClientEvent:Connect(function(p126) -- Line: 1419
        -- upvalues: u97 (copy), u125 (ref), PrimaryFrame (copy), SecondaryFrame (copy), SidearmFrame (copy), ReplicatedStorage (ref), BindableEvent (ref)
        u97._receivedEquipment = true;
        local u127 = (u97._equipEpoch or 0) + 1;
        u97._equipEpoch = u127;

        local function _eqStale(p128) -- Line: 1451
            -- upvalues: u97 (ref), u127 (copy)
            return u97._equipEpoch ~= u127;
        end;

        if not u125 then
            u125 = true;
            task.wait(1);
            game:GetService("RunService").RenderStepped:Wait();

            if u97._equipEpoch ~= u127 then
                return;
            end;
        end;

        if p126.IsReconcile then
            local v129 = true;
            local v130 = nil;

            for i, v in pairs({
                Head = u97.HeadSlot,
                FaceWear = u97.FaceWearSlot,
                EyeWear = u97.EyeWearSlot,
                BeltGear = u97.BeltGearSlot,
                Body = u97.BodySlot,
                Backpack = u97.BackpackSlot,
                Primary = u97.PrimarySlot,
                Secondary = u97.SecondarySlot,
                Sidearm = u97.SidearmSlot,
                Melee = u97.MeleeSlot,
                Uniform = u97.UniformSlot,
                NightOptical = u97.NightOpticalSlot
            }) do
                local v131;

                if v then
                    v131 = v.Item;
                else
                    v131 = v;
                end;

                local v132 = v131 and v131.ItemElement and v131.ItemElement.Parent ~= nil and (v131.Metadata and v131.Metadata.ID) or nil;
                local v133 = p126[i];
                local v134 = v133 and v133.ID or nil;

                if v132 ~= v134 then
                    v130 = string.format("%s: showing %s, server says %s", i, tostring(v132), (tostring(v134)));
                    v129 = false;
                    break;
                end;
            end;

            if v129 then
                return;
            end;

            warn("[FACEDIAG] equipment reconcile repainting, " .. tostring(v130));
        end;

        local function clearSingleSlot(u135) -- Line: 1509
            if not u135 then
                return;
            end;

            local Item = u135.Item;

            if Item then
                pcall(function() -- Line: 1513
                    -- upvalues: u135 (copy)
                    u135:RemoveItem();
                end);
                pcall(function() -- Line: 1514
                    -- upvalues: Item (copy)
                    Item:Destroy();
                end);
            end;

            if u135.GuiElement then
                for _, child in pairs(u135.GuiElement:GetChildren()) do
                    if child:IsA("CanvasGroup") then
                        child:Destroy();
                    end;
                end;
            end;
        end;

        if p126.Head and u97.HeadSlot then
            u97:LoadInventory(u97.HeadSlot, {
                Items = { p126.Head },
                TiedInstance = u97.HeadSlot.Metadata.TiedInstance
            });
        else
            clearSingleSlot(u97.HeadSlot);
        end;

        if p126.FaceWear and u97.FaceWearSlot then
            u97:LoadInventory(u97.FaceWearSlot, {
                Items = { p126.FaceWear },
                TiedInstance = u97.FaceWearSlot.Metadata.TiedInstance
            });
        else
            if u97.FaceWearSlot and u97.FaceWearSlot.Item then
                print("[FACEDIAG] client clearing a POPULATED FaceWear slot: LoadEquipment arrived with FaceWear = nil");
            end;

            clearSingleSlot(u97.FaceWearSlot);
        end;

        if p126.EyeWear and u97.EyeWearSlot then
            u97:LoadInventory(u97.EyeWearSlot, {
                Items = { p126.EyeWear },
                TiedInstance = u97.EyeWearSlot.Metadata.TiedInstance
            });
        else
            clearSingleSlot(u97.EyeWearSlot);
        end;

        if p126.NightOptical and u97.NightOpticalSlot then
            u97:LoadInventory(u97.NightOpticalSlot, {
                Items = { p126.NightOptical },
                TiedInstance = u97.NightOpticalSlot.Metadata.TiedInstance
            });
        else
            clearSingleSlot(u97.NightOpticalSlot);
        end;

        if p126.Primary and u97.PrimarySlot then
            u97:LoadInventory(u97.PrimarySlot, {
                Items = { p126.Primary },
                TiedInstance = u97.PrimarySlot.Metadata.TiedInstance
            });
            task.delay(0.5, function() -- Line: 1576
                -- upvalues: u97 (ref), PrimaryFrame (ref)
                u97:UpdateWeaponSlotDisplay(u97.PrimarySlot, PrimaryFrame);
            end);
        else
            clearSingleSlot(u97.PrimarySlot);

            if u97.PrimarySlot and PrimaryFrame then
                u97:UpdateWeaponSlotDisplay(u97.PrimarySlot, PrimaryFrame);
            end;
        end;

        if p126.Secondary and u97.SecondarySlot then
            u97:LoadInventory(u97.SecondarySlot, {
                Items = { p126.Secondary },
                TiedInstance = u97.SecondarySlot.Metadata.TiedInstance
            });
            task.delay(0.5, function() -- Line: 1593
                -- upvalues: u97 (ref), SecondaryFrame (ref)
                u97:UpdateWeaponSlotDisplay(u97.SecondarySlot, SecondaryFrame);
            end);
        else
            clearSingleSlot(u97.SecondarySlot);

            if u97.SecondarySlot and SecondaryFrame then
                u97:UpdateWeaponSlotDisplay(u97.SecondarySlot, SecondaryFrame);
            end;
        end;

        if p126.Sidearm and u97.SidearmSlot then
            u97:LoadInventory(u97.SidearmSlot, {
                Items = { p126.Sidearm },
                TiedInstance = u97.SidearmSlot.Metadata.TiedInstance
            });
            task.delay(0.5, function() -- Line: 1609
                -- upvalues: u97 (ref), SidearmFrame (ref)
                u97:UpdateWeaponSlotDisplay(u97.SidearmSlot, SidearmFrame);
            end);
        else
            clearSingleSlot(u97.SidearmSlot);

            if u97.SidearmSlot and SidearmFrame then
                u97:UpdateWeaponSlotDisplay(u97.SidearmSlot, SidearmFrame);
            end;
        end;

        if p126.Melee and u97.MeleeSlot then
            u97:LoadInventory(u97.MeleeSlot, {
                Items = { p126.Melee },
                TiedInstance = u97.MeleeSlot.Metadata.TiedInstance
            });
        else
            clearSingleSlot(u97.MeleeSlot);
        end;

        u97:StartWeaponAmmoWatcher();
        u97:RepositionInventorySections();

        if p126.Uniform and u97.UniformSlot then
            u97:LoadInventory(u97.UniformSlot, {
                Items = { p126.Uniform },
                TiedInstance = u97.UniformSlot.Metadata.TiedInstance
            });
        else
            clearSingleSlot(u97.UniformSlot);
        end;

        if p126.BeltGear and u97.BeltGearSlot then
            u97:LoadInventory(u97.BeltGearSlot, {
                Items = { p126.BeltGear },
                TiedInstance = u97.BeltGearSlot.Metadata.TiedInstance
            });
            u97:UpdateBattleBeltGridSize(p126.BeltGear.ID);
            task.wait(0.1);

            if u97._equipEpoch ~= u127 then
                return;
            end;

            if u97.BattleBeltInventory and p126.BattleBeltContents ~= nil then
                u97:LoadInventory(u97.BattleBeltInventory, {
                    Items = p126.BattleBeltContents,
                    TiedInstance = u97.BattleBeltInventory.Metadata.TiedInstance
                });
            end;
        else
            u97:UpdateBattleBeltGridSize(nil);
        end;

        if p126.Body and u97.BodySlot then
            u97:LoadInventory(u97.BodySlot, {
                Items = { p126.Body },
                TiedInstance = u97.BodySlot.Metadata.TiedInstance
            });
            u97:UpdateChestRigGridSize(p126.Body.ID);
            task.wait(0.1);

            if u97._equipEpoch ~= u127 then
                return;
            end;

            if u97.ChestRigInventory and p126.ChestRigContents ~= nil then
                u97:LoadInventory(u97.ChestRigInventory, {
                    Items = p126.ChestRigContents,
                    TiedInstance = u97.ChestRigInventory.Metadata.TiedInstance
                });
            end;
        else
            u97:UpdateChestRigGridSize(nil);
        end;

        if p126.Backpack and u97.BackpackSlot then
            u97:LoadInventory(u97.BackpackSlot, {
                Items = { p126.Backpack },
                TiedInstance = u97.BackpackSlot.Metadata.TiedInstance
            });
            u97:UpdateBackpackGridSize(p126.Backpack.ID);
            task.wait(0.1);

            if u97._equipEpoch ~= u127 then
                return;
            end;

            if u97.MainInventory and p126.BackpackContents ~= nil then
                u97:LoadInventory(u97.MainInventory, {
                    Items = p126.BackpackContents,
                    TiedInstance = u97.MainInventory.Metadata.TiedInstance
                });
            end;
        else
            clearSingleSlot(u97.BackpackSlot);
            u97:UpdateBackpackGridSize(nil);
        end;

        if not (p126.Body and u97.BodySlot) then
            clearSingleSlot(u97.BodySlot);
        end;

        if not (p126.BeltGear and u97.BeltGearSlot) then
            clearSingleSlot(u97.BeltGearSlot);
        end;

        if not (p126.Head or (p126.FaceWear or p126.EyeWear) or (p126.Primary or p126.Secondary or (p126.Sidearm or p126.Melee) or (p126.Uniform or p126.Body or (p126.BeltGear or p126.Backpack)))) and u97.LocalInventory then
            pcall(function() -- Line: 1734
                -- upvalues: ReplicatedStorage (ref), u97 (ref), u127 (copy)
                local v136 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer();

                if u97._equipEpoch ~= u127 then
                    return;
                end;

                if v136 and v136.Pockets then
                    u97:LoadInventory(u97.LocalInventory, v136.Pockets);
                end;
            end);
        end;

        if u97._equipEpoch == u127 then
            BindableEvent:Fire();
        end;
    end);
    ReplicatedStorage.Remotes.UpdateChestRigContents.OnClientEvent:Connect(function(p137) -- Line: 1755
        -- upvalues: u97 (copy)
        task.wait(0.1);

        if u97.ChestRigInventory then
            u97:LoadInventory(u97.ChestRigInventory, {
                Items = p137,
                TiedInstance = u97.ChestRigInventory.Metadata.TiedInstance
            });
        end;
    end);
    ReplicatedStorage.Remotes.UpdateBattleBeltContents.OnClientEvent:Connect(function(p138) -- Line: 1771
        -- upvalues: u97 (copy)
        task.wait(0.1);

        if not u97.BattleBeltInventory then
            warn("[UpdateBattleBeltContents] BattleBeltInventory not found");

            return;
        end;

        pcall(function() -- Line: 1774
            -- upvalues: u97 (ref)
            u97:EnsureBattleBeltGridSized();
        end);
        u97:LoadInventory(u97.BattleBeltInventory, {
            Items = p138,
            TiedInstance = u97.BattleBeltInventory.Metadata.TiedInstance
        });
    end);
    ReplicatedStorage.Remotes.UpdateBackpackContents.OnClientEvent:Connect(function(p139) -- Line: 1785
        -- upvalues: u97 (copy)
        task.wait(0.1);

        if not u97.MainInventory then
            warn("[UpdateBackpackContents] MainInventory not found");

            return;
        end;

        print("[UpdateBackpackContents] Reloading backpack contents:", p139);
        u97:LoadInventory(u97.MainInventory, {
            Items = p139,
            TiedInstance = u97.MainInventory.Metadata.TiedInstance
        });
    end);
    InventoryGui:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1800
        -- upvalues: InventoryGui (copy), Players (ref)
        if not InventoryGui.Enabled then
            pcall(function() -- Line: 1802
                -- upvalues: Players (ref)
                require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Enable();
            end);
        end;
    end);
    ReplicatedStorage.Remotes.ItemDropped.OnClientEvent:Connect(function(p140, p141) -- Line: 1810
        -- upvalues: u97 (copy), ReplicatedStorage (ref)
        for _, v in ipairs({
            {
                name = "HeadGear",
                slot = u97.HeadSlot
            },
            {
                name = "FaceWear",
                slot = u97.FaceWearSlot
            },
            {
                name = "EyeWear",
                slot = u97.EyeWearSlot
            },
            {
                name = "BodyGear",
                slot = u97.BodySlot
            },
            {
                name = "BeltGear",
                slot = u97.BeltGearSlot
            },
            {
                name = "Primary",
                slot = u97.PrimarySlot
            },
            {
                name = "Secondary",
                slot = u97.SecondarySlot
            },
            {
                name = "Sidearm",
                slot = u97.SidearmSlot
            },
            {
                name = "Melee",
                slot = u97.MeleeSlot
            },
            {
                name = "Uniform",
                slot = u97.UniformSlot
            },
            {
                name = "Backpack",
                slot = u97.BackpackSlot
            },
            {
                name = "NightOptical",
                slot = u97.NightOpticalSlot
            }
        }) do
            if v.slot and (v.slot.Metadata and v.slot.Metadata.TiedInstance == p140) then
                if v.slot.Item then
                    pcall(function() -- Line: 1830
                        -- upvalues: v (copy)
                        v.slot:RemoveItem();
                    end);
                end;

                if v.name == "Backpack" then
                    u97:UpdateBackpackGridSize(nil);

                    return;
                end;

                if v.name == "BodyGear" then
                    u97:UpdateChestRigGridSize(nil);

                    return;
                end;

                if v.name == "BeltGear" then
                    u97:UpdateBattleBeltGridSize(nil);

                    return;
                end;

                if v.name == "Primary" then
                    u97:UpdateWeaponSlotDisplay(u97.PrimarySlot, u97.PrimaryFrame);

                    return;
                end;

                if v.name == "Secondary" then
                    u97:UpdateWeaponSlotDisplay(u97.SecondarySlot, u97.SecondaryFrame);

                    return;
                end;

                if v.name == "Sidearm" then
                    u97:UpdateWeaponSlotDisplay(u97.SidearmSlot, u97.SidearmFrame);
                end;

                return;
            end;
        end;

        u97._refreshEpoch = (u97._refreshEpoch or 0) + 1;
        local _refreshEpoch = u97._refreshEpoch;
        local v142 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer();

        if u97._refreshEpoch ~= _refreshEpoch then
            return;
        end;

        if v142 then
            if v142.Pockets and u97.LocalInventory then
                u97:LoadInventory(u97.LocalInventory, v142.Pockets);
            end;

            if v142.ChestRig and (u97.ChestRigInventory and (u97.ChestRigInventory.GuiElement and u97.ChestRigInventory.GuiElement.Visible)) then
                u97:LoadInventory(u97.ChestRigInventory, v142.ChestRig);
            end;

            if v142.BattleBelt and (u97.BattleBeltInventory and (u97.BattleBeltInventory.GuiElement and u97.BattleBeltInventory.GuiElement.Visible)) then
                u97:LoadInventory(u97.BattleBeltInventory, v142.BattleBelt);
            end;

            if v142.Backpack and (u97.MainInventory and (u97.MainInventory.GuiElement and u97.MainInventory.GuiElement.Visible)) then
                u97:LoadInventory(u97.MainInventory, v142.Backpack);
            end;
        end;

        if type(p140) == "string" and (p140:sub(1, 6) == "Stash_" and (u97.SafezoneTier == "Full" and u97.SafezoneViewMode == "stash")) then
            u97:LoadVicinity();
        end;
    end);

    function u97.OpenInventoryUI(u143) -- Line: 1894
        -- upvalues: InventoryGui (copy), Players (ref), UserInputService (ref), ReplicatedStorage (ref)
        if InventoryGui.Enabled then
            return;
        end;

        InventoryGui.Enabled = true;
        game.Lighting.InventoryBlur.Enabled = true;
        local v144 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("CustomShiftLock");
        local v145 = v144 and v144:FindFirstChild("SmoothShiftLock") and v144.SmoothShiftLock:FindFirstChild("ToggleShiftLock");
        u143._shiftLockWasEnabled = Players.LocalPlayer:GetAttribute("ShiftLockEnabled") == true;

        if u143._shiftLockWasEnabled and v145 then
            v145:Fire(false);
        end;

        require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Disable();
        u143._savedCameraMode = Players.LocalPlayer.CameraMode;
        Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic;
        u143._mouseUnlockConn = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 1917
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);

        if not u143.CurrentStoragePart then
            u143:LoadVicinity();
        end;

        pcall(function() -- Line: 1936
            -- upvalues: ReplicatedStorage (ref)
            ReplicatedStorage.Remotes:WaitForChild("RequestEquipment", 5):FireServer();
        end);
        u143._weightPolling = true;
        task.spawn(function() -- Line: 1941
            -- upvalues: u143 (copy), ReplicatedStorage (ref)
            while u143._weightPolling do
                pcall(function() -- Line: 1943
                    -- upvalues: ReplicatedStorage (ref)
                    local v146, v147 = ReplicatedStorage.Remotes.GetWeight:InvokeServer();

                    if v146 then
                        updateWeightDisplay(v146, v147);
                    end;
                end);
                task.wait(0.5);
            end;
        end);
    end;

    function u97.CloseStoragePanel(p148) -- Line: 1963
        p148:StopVicinityRefresh();

        if p148.StorageInventory then
            p148:ClearGridPackInventory(p148.StorageInventory);

            if p148.StorageInventory.GuiElement then
                p148.StorageInventory.GuiElement:Destroy();
            end;

            p148.StorageInventory = nil;
        end;

        p148.CurrentStoragePart = nil;

        if p148._expansionPanel then
            p148._expansionPanel.Visible = false;
        end;
    end;

    function u97.CloseInventoryUI(p149) -- Line: 1978
        -- upvalues: InventoryGui (copy), Players (ref), UserInputService (ref), ReplicatedStorage (ref)
        if not InventoryGui.Enabled then
            return;
        end;

        InventoryGui.Enabled = false;
        game.Lighting.InventoryBlur.Enabled = false;
        local v150 = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("CustomShiftLock");
        local v151 = v150 and v150:FindFirstChild("SmoothShiftLock") and v150.SmoothShiftLock:FindFirstChild("ToggleShiftLock");

        if p149._shiftLockWasEnabled and v151 then
            v151:Fire(true);
        end;

        p149._shiftLockWasEnabled = nil;
        require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Enable();

        if p149._mouseUnlockConn then
            p149._mouseUnlockConn:Disconnect();
            p149._mouseUnlockConn = nil;
        end;

        if p149._savedCameraMode then
            Players.LocalPlayer.CameraMode = p149._savedCameraMode;
        end;

        UserInputService.MouseIconEnabled = false;
        p149._weightPolling = false;
        require(ReplicatedStorage:WaitForChild("OpenableContainer")).CloseAll();
        p149:CloseStorage();
        p149:StopVicinityRefresh();
        p149:HideContextMenu();
        p149:HideDetailsPanel();
        p149:HideNotePanel();
        ReplicatedStorage.Remotes.CancelRepack:FireServer();
    end;

    UserInputService.InputBegan:Connect(function(p152, p153) -- Line: 2024
        -- upvalues: ReplicatedStorage (ref), InventoryGui (copy), u97 (copy)
        if not p153 and p152.KeyCode == Enum.KeyCode.Tab then
            local success, result = pcall(require, ReplicatedStorage:WaitForChild("TraderController"));

            if success and (result and result.IsOpen) then
                return;
            end;

            if InventoryGui.Enabled then
                u97:CloseInventoryUI();

                return;
            end;

            u97:OpenInventoryUI();
        end;
    end);

    function u97._pruneTransferLink(p154) -- Line: 2041
        local TransferLink = p154.TransferLink;

        if not (TransferLink and TransferLink.ConnectedItemManagers) then
            return;
        end;

        for i = #TransferLink.ConnectedItemManagers, 1, -1 do
            local v155 = TransferLink.ConnectedItemManagers[i];
            local v156;

            if v155 then
                v156 = v155.GuiElement;
            else
                v156 = v155;
            end;

            local v157;

            if v155 and (v156 == nil or v156.Parent ~= nil) then
                v157 = i;
            else
                table.remove(TransferLink.ConnectedItemManagers, i);

                if v155 and v155.ConnectedTransferLinks then
                    local table_find_ret = table.find(v155.ConnectedTransferLinks, TransferLink);

                    if table_find_ret then
                        table.remove(v155.ConnectedTransferLinks, table_find_ret);
                        v157 = i;
                    else
                        v157 = i;
                    end;
                else
                    v157 = i;
                end;
            end;
        end;
    end;

    local function isPlayerGridTied(p158) -- Line: 2064
        -- upvalues: Players (ref)
        if p158 == Players.LocalPlayer then
            return true;
        end;

        if type(p158) ~= "string" then
            return false;
        end;

        local v159 = tostring(Players.LocalPlayer.UserId);

        return (p158 == "ChestRigInternal_" .. v159 or p158 == "BattleBeltInternal_" .. v159) and true or p158 == "BackpackInternal_" .. v159;
    end;

    UserInputService.InputBegan:Connect(function(p160, p161) -- Line: 2072
        -- upvalues: UserInputService (ref), Players (ref), u97 (copy), ReplicatedStorage (ref)
        if p160.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return;
        end;

        if not (UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) or UserInputService:IsKeyDown(Enum.KeyCode.RightShift)) then
            return;
        end;

        local InventoryGui2 = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

        if not (InventoryGui2 and InventoryGui2.Enabled) then
            return;
        end;

        local TransferLink = u97.TransferLink;

        if not (TransferLink and TransferLink.ConnectedItemManagers) then
            return;
        end;

        u97:_pruneTransferLink();
        local GuiService = game:GetService("GuiService");
        local v162 = UserInputService:GetMouseLocation() - GuiService:GetGuiInset();

        for _, v in ipairs(TransferLink.ConnectedItemManagers) do
            local GuiElement = v.GuiElement;

            if GuiElement and GuiElement.Parent then
                local u163 = v.Metadata and v.Metadata.TiedInstance;

                if u163 and v.Items then
                    local v164;

                    if u163 == Players.LocalPlayer then
                        v164 = true;
                    elseif type(u163) == "string" then
                        local v165 = tostring(Players.LocalPlayer.UserId);
                        v164 = (u163 == "ChestRigInternal_" .. v165 or u163 == "BattleBeltInternal_" .. v165) and true or u163 == "BackpackInternal_" .. v165;
                    else
                        v164 = false;
                    end;

                    local v166;

                    if type(u163) == "string" then
                        v166 = u163:sub(1, 5) == "Sell_";
                    else
                        v166 = false;
                    end;

                    if not v166 then
                        local u167 = v;

                        for _, v2 in pairs(v.Items) do
                            if v2 and (v2.ItemElement and (v2.ItemElement.Parent and (v2.Metadata and v2.Metadata.ItemIndex))) then
                                local AbsolutePosition = v2.ItemElement.AbsolutePosition;
                                local AbsoluteSize = v2.ItemElement.AbsoluteSize;

                                if v162.X >= AbsolutePosition.X and (v162.X <= AbsolutePosition.X + AbsoluteSize.X and (v162.Y >= AbsolutePosition.Y and v162.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
                                    pcall(function() -- Line: 2115
                                        -- upvalues: v2 (copy)
                                        if v2._draggingTrove and v2._draggingTrove.Clean then
                                            v2._draggingTrove:Clean();
                                        end;

                                        if v2.ItemElement then
                                            game:GetService("TweenService"):Create(v2.ItemElement, TweenInfo.new(0), {
                                                GroupTransparency = 0
                                            }):Play();
                                            v2.ItemElement.ZIndex = math.max(1, v2.ItemElement.ZIndex - 1);
                                        end;

                                        v2.IsDragging = false;
                                        v2.IsDraggable = true;
                                    end);
                                    local u168 = nil;

                                    if v164 then
                                        if u97.StorageInventory and (u97.StorageInventory.Metadata and u97.StorageInventory.Metadata.TiedInstance) then
                                            u168 = u97.StorageInventory.Metadata.TiedInstance;
                                        end;

                                        if not u168 then
                                            return;
                                        end;

                                        if type(u168) == "string" and u168:sub(1, 9) == "Vicinity_" then
                                            local DropItem = ReplicatedStorage.Remotes:FindFirstChild("DropItem");

                                            if DropItem then
                                                DropItem:FireServer(v2.Metadata.ItemIndex, u163, v2.Metadata.ID);
                                                u97:PlaySound("Move", v2.Metadata.ItemType or "General");
                                            end;

                                            return;
                                        end;
                                    end;

                                    local QuickTakeItem = ReplicatedStorage.Remotes:FindFirstChild("QuickTakeItem");

                                    if QuickTakeItem then
                                        local v169, v170, v171 = pcall(function() -- Line: 2154
                                            -- upvalues: QuickTakeItem (copy), u163 (copy), v2 (copy), u168 (ref)
                                            return QuickTakeItem:InvokeServer(u163, v2.Metadata.ItemIndex, u168);
                                        end);

                                        if v169 and v170 then
                                            u97:PlaySound("Move", v2.Metadata.ItemType or "General");

                                            if type(u163) == "string" and u163:sub(1, 16) == "OpenedContainer_" then
                                                pcall(function() -- Line: 2163
                                                    -- upvalues: u167 (copy), v2 (copy)
                                                    u167:RemoveItem(v2);
                                                end);
                                            end;
                                        elseif v169 and not v170 then
                                            u97:ShowToast(v171 == "no room" and "No space" or (v171 and tostring(v171) or "Move failed"));
                                        end;
                                    end;

                                    return;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end);
    local CloseNestedContainer = ReplicatedStorage.Remotes:FindFirstChild("CloseNestedContainer");

    if CloseNestedContainer then
        CloseNestedContainer.OnClientEvent:Connect(function(p172) -- Line: 2187
            -- upvalues: ReplicatedStorage (ref)
            require(ReplicatedStorage:WaitForChild("OpenableContainer")).Close(p172);
        end);
    end;

    ReplicatedStorage.Remotes.RefreshInventory.OnClientEvent:Connect(function(p173, p174, p175) -- Line: 2194
        -- upvalues: u97 (copy), Players (ref), ReplicatedStorage (ref), BindableEvent (ref)
        u97._scOpId = p173 or u97._scOpId;

        if p173 and p174 then
            u97:_scCheckComposite(p173, p174, p175);
        end;

        u97._refreshEpoch = (u97._refreshEpoch or 0) + 1;
        local _refreshEpoch = u97._refreshEpoch;
        u97:_pruneTransferLink();
        local InventoryGui2 = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

        if InventoryGui2 and not u97._autoFillPreview then
            for _, descendant in ipairs(InventoryGui2:GetDescendants()) do
                if descendant.Name == "BarterGhostOverlay" then
                    pcall(function() -- Line: 2226
                        -- upvalues: descendant (copy)
                        descendant:Destroy();
                    end);
                end;
            end;
        end;

        local v176 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer();

        if u97._refreshEpoch ~= _refreshEpoch then
            return;
        end;

        if not v176 then
            return;
        end;

        if v176.Pockets and u97.LocalInventory then
            u97:LoadInventory(u97.LocalInventory, v176.Pockets);
        end;

        if v176.ChestRig and u97.ChestRigInventory then
            u97:LoadInventory(u97.ChestRigInventory, v176.ChestRig);
        end;

        if v176.BattleBelt and u97.BattleBeltInventory then
            u97:LoadInventory(u97.BattleBeltInventory, v176.BattleBelt);
        end;

        if v176.Backpack and u97.MainInventory then
            u97:LoadInventory(u97.MainInventory, v176.Backpack);
        end;

        task.spawn(function() -- Line: 2254
            -- upvalues: ReplicatedStorage (ref)
            pcall(function() -- Line: 2255
                -- upvalues: ReplicatedStorage (ref)
                local v177, v178 = ReplicatedStorage.Remotes.GetWeight:InvokeServer();

                if v177 then
                    updateWeightDisplay(v177, v178);
                end;
            end);
        end);
        u97:_refreshExpansionPanel();
        BindableEvent:Fire();
    end);
    local StashResized = ReplicatedStorage.Remotes:FindFirstChild("StashResized");

    if StashResized then
        StashResized.OnClientEvent:Connect(function() -- Line: 2280
            -- upvalues: u97 (copy)
            if u97.SafezoneTier == "Full" and u97.SafezoneViewMode == "stash" then
                u97:LoadVicinity();
            end;

            u97:_refreshExpansionPanel();
        end);
    end;

    local function updateRadDisplay() -- Line: 2289
        -- upvalues: Players (ref), ReplicatedStorage (ref)
        local InventoryGui2 = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

        if not InventoryGui2 then
            return;
        end;

        local CharacterFrame2 = InventoryGui2.MainFrame:FindFirstChild("CharacterFrame");

        if not CharacterFrame2 then
            return;
        end;

        local RadDisplay = CharacterFrame2:FindFirstChild("RadDisplay");

        if not RadDisplay then
            return;
        end;

        local RadLabel = RadDisplay:FindFirstChild("RadLabel");

        if not RadLabel then
            return;
        end;

        local GetRadProtection = ReplicatedStorage.Remotes:FindFirstChild("GetRadProtection");

        if not GetRadProtection then
            return;
        end;

        local success, result = pcall(function() -- Line: 2302
            -- upvalues: GetRadProtection (copy)
            return GetRadProtection:InvokeServer();
        end);

        if not success or type(result) ~= "number" then
            return;
        end;

        local math_floor_ret = math.floor(result * 100);
        RadLabel.Text = "Rad Protection: " .. math_floor_ret .. "%";

        if math_floor_ret >= 60 then
            RadLabel.TextColor3 = Color3.fromRGB(100, 255, 100);

            return;
        end;

        if math_floor_ret >= 30 then
            RadLabel.TextColor3 = Color3.fromRGB(200, 255, 150);

            return;
        end;

        RadLabel.TextColor3 = Color3.fromRGB(200, 200, 200);
    end;

    local function updateArmorDisplay() -- Line: 2318
        -- upvalues: Players (ref), ItemDatabase (ref), ArmorPlates (ref), ReplicatedStorage (ref), u97 (copy)
        local InventoryGui2 = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

        if not InventoryGui2 then
            return;
        end;

        local CharacterFrame2 = InventoryGui2.MainFrame:FindFirstChild("CharacterFrame");

        if not CharacterFrame2 then
            return;
        end;

        local ArmorProtection = CharacterFrame2:FindFirstChild("ArmorProtection");

        if not ArmorProtection then
            return;
        end;

        local RadLabel = ArmorProtection:FindFirstChild("RadLabel");

        if not RadLabel then
            return;
        end;

        local function slotDur(p179, u180) -- Line: 2328
            -- upvalues: ItemDatabase (ref), ArmorPlates (ref), ReplicatedStorage (ref)
            if not (p179 and (p179.Item and p179.Item.Metadata)) then
                return 0, 0;
            end;

            local ItemData = ItemDatabase.GetItemData(p179.Item.Metadata.ID);

            if not ItemData then
                return 0, 0;
            end;

            local v181 = ArmorPlates.Layer(p179.Item, ItemData, ItemDatabase);

            if v181 then
                local GetArmorDurability = ReplicatedStorage.Remotes:FindFirstChild("GetArmorDurability");

                if GetArmorDurability then
                    local success, result = pcall(function() -- Line: 2340
                        -- upvalues: GetArmorDurability (copy), u180 (copy)
                        return GetArmorDurability:InvokeServer(u180);
                    end);

                    if success and result ~= nil then
                        return result, v181.maxCond;
                    end;
                end;

                return v181.cond, v181.maxCond;
            end;

            if not ItemData.ArmorMaxDurability then
                return 0, 0;
            end;

            local GetArmorDurability = ReplicatedStorage.Remotes:FindFirstChild("GetArmorDurability");

            if GetArmorDurability then
                local success, result = pcall(function() -- Line: 2353
                    -- upvalues: GetArmorDurability (copy), u180 (copy)
                    return GetArmorDurability:InvokeServer(u180);
                end);

                if success and result ~= nil then
                    return result, ItemData.ArmorMaxDurability;
                end;
            end;

            return 0, ItemData.ArmorMaxDurability;
        end;

        local v182, v183 = slotDur(u97.BodySlot, "Body");
        local v184, v185 = slotDur(u97.HeadSlot, "Head");
        local v186 = v182 + v184;
        local v187 = v183 + v185;
        RadLabel.Text = string.format("Durability: %d / %d", math.floor(v186), v187);
        local v188 = v187 > 0 and v186 / v187 or 0;

        if v188 > 0.6 then
            RadLabel.TextColor3 = Color3.fromRGB(100, 255, 100);

            return;
        end;

        if v188 > 0.3 then
            RadLabel.TextColor3 = Color3.fromRGB(255, 220, 80);

            return;
        end;

        RadLabel.TextColor3 = Color3.fromRGB(200, 200, 200);
    end;

    local function u191(p189, p190) -- Line: 2375
        -- upvalues: Players (ref), updateRadDisplay (copy), updateArmorDisplay (copy)
        local InventoryGui2 = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

        if not InventoryGui2 then
            return;
        end;

        local InventoryFrame2 = InventoryGui2.MainFrame:FindFirstChild("InventoryFrame");

        if not InventoryFrame2 then
            return;
        end;

        local WeightDisplay = InventoryFrame2:FindFirstChild("WeightDisplay");

        if not WeightDisplay then
            return;
        end;

        updateRadDisplay();
        updateArmorDisplay();
        local WeightLabel = WeightDisplay:FindFirstChild("WeightLabel");

        if WeightLabel then
            WeightLabel.Text = string.format("%.1f / %.1f kg", p189, p190);

            if p190 * 1.2 <= p189 then
                WeightLabel.TextColor3 = Color3.fromRGB(255, 40, 40);
            elseif p190 <= p189 then
                WeightLabel.TextColor3 = Color3.fromRGB(255, 70, 70);
            elseif p190 * 0.8 <= p189 then
                WeightLabel.TextColor3 = Color3.fromRGB(255, 200, 50);
            else
                WeightLabel.TextColor3 = Color3.fromRGB(200, 200, 200);
            end;
        end;

        local WeightIcon = WeightDisplay:FindFirstChild("WeightIcon");

        if WeightIcon then
            WeightIcon.ImageColor3 = WeightLabel.TextColor3;
        end;
    end;

    ReplicatedStorage.Remotes.WeightSync.OnClientEvent:Connect(u191);

    function u97._refreshWeight() -- Line: 2409
        -- upvalues: ReplicatedStorage (ref), u191 (copy)
        task.spawn(function() -- Line: 2410
            -- upvalues: ReplicatedStorage (ref), u191 (ref)
            local GetWeight = ReplicatedStorage.Remotes:FindFirstChild("GetWeight");

            if not GetWeight then
                return;
            end;

            local v192, v193, v194 = pcall(GetWeight.InvokeServer, GetWeight);

            if v192 and v193 then
                u191(v193, v194);
            end;
        end);
    end;

    ReplicatedStorage.Remotes.RepackProgress.OnClientEvent:Connect(function(p195, p196, p197, p198, p199, p200, p201) -- Line: 2422
        -- upvalues: InventorySounds (ref), Players (ref), ItemDatabase (ref), u97 (copy)
        local MagazineLoading = InventorySounds:FindFirstChild("MagazineLoading");

        if MagazineLoading then
            local Children = MagazineLoading:GetChildren();

            if #Children > 0 then
                local v202 = Children[math.random(#Children)];

                if v202:IsA("Sound") then
                    local u203 = v202:Clone();
                    u203.PlaybackSpeed = 0.9 + math.random() * 0.2;
                    u203.Parent = Players.LocalPlayer.PlayerGui;
                    u203:Play();
                    u203.Ended:Connect(function() -- Line: 2434
                        -- upvalues: u203 (copy)
                        u203:Destroy();
                    end);
                end;
            end;
        end;

        local function updateItemLabel(p204, p205, p206) -- Line: 2440
            -- upvalues: ItemDatabase (ref)
            if not (p204 and p204.Items) then
                return;
            end;

            for _, v in pairs(p204.Items) do
                if v and (v.Metadata and (v.Metadata.ItemIndex == p205 and v.ItemElement)) then
                    local RoundCount = v.ItemElement:FindFirstChild("RoundCount");

                    if RoundCount then
                        RoundCount.Text = tostring(p206);
                        RoundCount.TextColor3 = p206 > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 80, 80);
                    end;

                    v.Metadata.CurrentRounds = p206;
                    local ItemData = ItemDatabase.GetItemData(v.Metadata.ID);

                    if ItemData then
                        v.ItemElement.BackgroundColor3 = p206 > 0 and ItemData.BackgroundColor or Color3.fromRGB(120, 30, 30);
                    end;
                end;
            end;
        end;

        local v207 = {};
        local v208 = {
            grid = u97.LocalInventory,
            tied = Players.LocalPlayer
        };
        local v209 = {
            grid = u97.ChestRigInventory,
            tied = "ChestRigInternal_" .. Players.LocalPlayer.UserId
        };
        local v210 = {
            grid = u97.BattleBeltInventory,
            tied = "BattleBeltInternal_" .. Players.LocalPlayer.UserId
        };
        local v211 = {
            grid = u97.MainInventory,
            tied = "BackpackInternal_" .. Players.LocalPlayer.UserId
        };
        local v212 = {
            grid = u97.StorageInventory
        };
        v212.tied = u97.StorageInventory and u97.StorageInventory.Metadata and u97.StorageInventory.Metadata.TiedInstance;
        v207[1], v207[2], v207[3], v207[4], v207[5] = v208, v209, v210, v211, v212;

        for _, v in ipairs(v207) do
            if v.grid and v.tied then
                if v.tied == p199 then
                    updateItemLabel(v.grid, p198, p197);
                end;

                if v.tied == p201 then
                    updateItemLabel(v.grid, p200, p195);
                end;
            end;
        end;
    end);
    ReplicatedStorage.Remotes.OpenBodyLootUI.OnClientEvent:Connect(function(p213) -- Line: 2480
        -- upvalues: u97 (copy)
        u97:OpenBodyLoot(p213);
    end);
    ReplicatedStorage.Remotes.BodyRemoved.OnClientEvent:Connect(function(p214) -- Line: 2486
        -- upvalues: ReplicatedStorage (ref), u97 (copy)
        require(ReplicatedStorage:WaitForChild("OpenableContainer")).Close(p214);

        if u97.CurrentBodyTied == p214 then
            u97.CurrentBodyTied = nil;
            u97:CloseStorage();
        end;
    end);
    ReplicatedStorage.Remotes.TraderError.OnClientEvent:Connect(function(p215) -- Line: 2498
        -- upvalues: u97 (copy)
        u97:ShowToast((tostring(p215)));
    end);
    ReplicatedStorage.Remotes.EquipSlotChanged.OnClientEvent:Connect(function(p216, p217) -- Line: 2504
        -- upvalues: u97 (copy)
        local u218 = ({
            Head = u97.HeadSlot,
            FaceWear = u97.FaceWearSlot,
            EyeWear = u97.EyeWearSlot,
            BeltGear = u97.BeltGearSlot,
            Body = u97.BodySlot,
            Primary = u97.PrimarySlot,
            Secondary = u97.SecondarySlot,
            Sidearm = u97.SidearmSlot,
            Melee = u97.MeleeSlot,
            Uniform = u97.UniformSlot,
            Backpack = u97.BackpackSlot,
            NightOptical = u97.NightOpticalSlot
        })[p216];

        if not u218 then
            return;
        end;

        if p217 then
            local v219 = {
                Items = { p217 }
            };
            v219.TiedInstance = u218.Metadata and u218.Metadata.TiedInstance;
            u97:LoadInventory(u218, v219);
        elseif u218.Item then
            pcall(function() -- Line: 2522
                -- upvalues: u218 (copy)
                u218:RemoveItem();
            end);
            pcall(function() -- Line: 2523
                -- upvalues: u218 (copy)
                u218.Item:Destroy();
            end);
        end;

        if p216 == "Body" then
            if p217 then
                p217 = p217.ID;
            end;

            u97:UpdateChestRigGridSize(p217);

            return;
        end;

        if p216 ~= "Backpack" then
            if p216 == "BeltGear" then
                if p217 then
                    p217 = p217.ID;
                end;

                u97:UpdateBattleBeltGridSize(p217);
            end;

            return;
        end;

        if p217 then
            p217 = p217.ID;
        end;

        u97:UpdateBackpackGridSize(p217);
    end);
    UserInputService.MouseIconEnabled = false;
    Players.LocalPlayer.CharacterAdded:Connect(function() -- Line: 2543
        -- upvalues: UserInputService (ref)
        UserInputService.MouseIconEnabled = false;
    end);

    if not u97._receivedEquipment then
        ReplicatedStorage.Remotes:WaitForChild("RequestEquipment"):FireServer();
    end;

    u97.SafezoneTier = nil;
    u97.SafezoneViewMode = "stash";
    u97:_buildSafezoneTabs();
    u97:_buildExpandButton();

    local function applySafezoneTier(p220) -- Line: 2567
        -- upvalues: u97 (copy), Players (ref)
        local v221 = u97.SafezoneTier == "Full";
        u97.SafezoneTier = (p220 == "Full" or p220 == "TraderOnly") and p220 and p220 or nil;

        if u97.SafezoneTier == "Full" and not v221 then
            u97.SafezoneViewMode = "stash";
        end;

        u97:_refreshSafezoneTabs();
        u97:_refreshExpandButton();
        local InventoryGui2 = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

        if InventoryGui2 and InventoryGui2.Enabled then
            u97:LoadVicinity();
        end;
    end;

    local SafezoneChanged = ReplicatedStorage.Remotes:WaitForChild("SafezoneChanged", 5);

    if SafezoneChanged then
        SafezoneChanged.OnClientEvent:Connect(applySafezoneTier);
    end;

    task.spawn(function() -- Line: 2596
        -- upvalues: ReplicatedStorage (ref), u97 (copy), applySafezoneTier (copy)
        local u222 = ReplicatedStorage.Remotes:FindFirstChild("GetSafezoneTier") or ReplicatedStorage.Remotes:WaitForChild("GetSafezoneTier", 10);

        if not u222 then
            warn("[InventoryController] GetSafezoneTier missing; initial safezone sync skipped");

            return;
        end;

        local success, result = pcall(function() -- Line: 2603
            -- upvalues: u222 (copy)
            return u222:InvokeServer();
        end);

        if success then
            if u97.SafezoneTier == nil then
                applySafezoneTier(result);
            end;

            return;
        end;

        warn("[InventoryController] GetSafezoneTier failed: " .. tostring(result));
    end);
end;

function u6._buildSafezoneTabs(u223) -- Line: 2620
    -- upvalues: Players (copy)
    local ContainerFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InventoryGui").MainFrame:WaitForChild("ContainerFrame");
    local Title = ContainerFrame:WaitForChild("Title");

    if ContainerFrame:FindFirstChild("SafezoneTabs") then
        u223.SafezoneTabs = ContainerFrame.SafezoneTabs;
        u223:_refreshSafezoneTabs();

        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "SafezoneTabs";
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.AnchorPoint = Title.AnchorPoint;
    Frame.Size = UDim2.fromScale(Title.Size.X.Scale * 1.5, Title.Size.Y.Scale);
    Frame.Position = UDim2.new(Title.Position.X.Scale + Title.Size.X.Scale + 0.012, 0, Title.Position.Y.Scale, 0);
    Frame.Visible = false;
    Frame.Parent = ContainerFrame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.Padding = UDim.new(0, 6);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Parent = Frame;

    local function makeTab(p224, p225, p226) -- Line: 2655
        -- upvalues: Frame (copy), Title (copy)
        local TextButton = Instance.new("TextButton");
        TextButton.Name = p224;
        TextButton.AutoButtonColor = false;
        TextButton.LayoutOrder = p226;
        TextButton.Size = UDim2.fromScale(0.46, 1);
        TextButton.BackgroundColor3 = Color3.new(1, 1, 1);
        TextButton.BackgroundTransparency = 0;
        TextButton.BorderSizePixel = 0;
        TextButton.Text = "";
        TextButton.Parent = Frame;
        local v227 = Title:FindFirstChildOfClass("UIGradient");

        if v227 then
            v227:Clone().Parent = TextButton;
        end;

        local v228 = Title:FindFirstChildOfClass("UIStroke");

        if v228 then
            v228:Clone().Parent = TextButton;
        end;

        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "TextLabel";
        TextLabel.AnchorPoint = Vector2.new(0, 0.5);
        TextLabel.Position = UDim2.fromScale(0.04, 0.5);
        TextLabel.Size = UDim2.fromScale(0.96, 0.8);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = p225;
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
        TextLabel.TextSize = 14;
        TextLabel.TextColor3 = Color3.fromRGB(197, 197, 197);
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Parent = TextButton;

        return TextButton;
    end;

    local v229 = makeTab("StashTab", "STASH", 1);
    local v230 = makeTab("VicinityTab", "VICINITY", 2);
    v229.MouseButton1Click:Connect(function() -- Line: 2692
        -- upvalues: u223 (copy)
        if u223.SafezoneTier ~= "Full" then
            return;
        end;

        if u223.SafezoneViewMode == "stash" then
            return;
        end;

        u223.SafezoneViewMode = "stash";
        u223:_refreshSafezoneTabs();
        u223:_refreshExpandButton();
        u223:LoadVicinity();
    end);
    v230.MouseButton1Click:Connect(function() -- Line: 2700
        -- upvalues: u223 (copy)
        if u223.SafezoneTier ~= "Full" then
            return;
        end;

        if u223.SafezoneViewMode == "vicinity" then
            return;
        end;

        u223.SafezoneViewMode = "vicinity";
        u223:_refreshSafezoneTabs();
        u223:_refreshExpandButton();
        u223:LoadVicinity();
    end);
    u223.SafezoneTabs = Frame;
    u223._stashTab = v229;
    u223._vicinityTab = v230;
    u223:_refreshSafezoneTabs();
end;

function u6._refreshSafezoneTabs(p231) -- Line: 2718
    local SafezoneTabs = p231.SafezoneTabs;

    if not SafezoneTabs then
        return;
    end;

    local v232 = p231.SafezoneTier == "Full";
    SafezoneTabs.Visible = v232;

    if not v232 then
        return;
    end;

    local v233 = p231.SafezoneViewMode or "stash";

    local function applyState(p234, p235) -- Line: 2725
        p234.BackgroundTransparency = p235 and 0 or 0.45;
        local TextLabel = p234:FindFirstChild("TextLabel");

        if TextLabel then
            TextLabel.TextTransparency = p235 and 0 or 0.3;
        end;
    end;

    if p231._stashTab then
        local _stashTab = p231._stashTab;
        local v236 = v233 == "stash";
        _stashTab.BackgroundTransparency = v236 and 0 or 0.45;
        local TextLabel = _stashTab:FindFirstChild("TextLabel");

        if TextLabel then
            TextLabel.TextTransparency = v236 and 0 or 0.3;
        end;
    end;

    if p231._vicinityTab then
        local _vicinityTab = p231._vicinityTab;
        local v237 = v233 == "vicinity";
        _vicinityTab.BackgroundTransparency = v237 and 0 or 0.45;
        local TextLabel = _vicinityTab:FindFirstChild("TextLabel");

        if TextLabel then
            TextLabel.TextTransparency = v237 and 0 or 0.3;
        end;
    end;
end;

function u6._buildExpandButton(p238) -- Line: 2753
    p238:_buildStashExpansionPanel();
end;

function u6._buildStashExpansionPanel(u239) -- Line: 2758
    -- upvalues: Players (copy), ReplicatedStorage (copy)
    local ContainerFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InventoryGui").MainFrame:WaitForChild("ContainerFrame");

    if ContainerFrame:FindFirstChild("StashExpansionPanel") then
        u239._expansionPanel = ContainerFrame.StashExpansionPanel;
        u239:_refreshExpansionPanel();

        return;
    end;

    require(ReplicatedStorage:WaitForChild("ItemDatabase"));
    local Frame = Instance.new("Frame");
    Frame.Name = "StashExpansionPanel";
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.new(0.5, 0, 1, -10);
    Frame.Size = UDim2.new(0.93, 0, 0, 46);
    Frame.BackgroundColor3 = Color3.fromRGB(17, 18, 16);
    Frame.BorderSizePixel = 0;
    Frame.Visible = false;
    Frame.ZIndex = 5;
    Frame.Parent = ContainerFrame;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(48, 48, 48);
    UIStroke.Thickness = 1;
    UIStroke.Parent = Frame;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0, 10);
    UIPadding.PaddingBottom = UDim.new(0, 10);
    UIPadding.PaddingLeft = UDim.new(0, 16);
    UIPadding.PaddingRight = UDim.new(0, 16);
    UIPadding.Parent = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "TitleRow";
    Frame2.BackgroundTransparency = 1;
    Frame2.Size = UDim2.new(1, 0, 0, 26);
    Frame2.ZIndex = 6;
    Frame2.Parent = Frame;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel.Position = UDim2.new(0, 0, 0.5, 0);
    ImageLabel.Size = UDim2.fromOffset(24, 24);
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://0";
    ImageLabel.ImageColor3 = Color3.fromRGB(170, 170, 170);
    ImageLabel.ZIndex = 6;
    ImageLabel.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel.Position = UDim2.new(0, 32, 0.5, 0);
    TextLabel.Size = UDim2.new(0.5, 0, 1, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "STASH EXPANSION";
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel.TextSize = 18;
    TextLabel.TextColor3 = Color3.fromRGB(210, 210, 210);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.ZIndex = 6;
    TextLabel.Parent = Frame2;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Name = "SizeIndicator";
    TextLabel2.AnchorPoint = Vector2.new(1, 0.5);
    TextLabel2.Position = UDim2.new(1, -32, 0.5, 0);
    TextLabel2.Size = UDim2.new(0.55, -32, 1, 0);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.Text = "";
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = Color3.fromRGB(170, 180, 170);
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
    TextLabel2.RichText = true;
    TextLabel2.ZIndex = 6;
    TextLabel2.Parent = Frame2;
    u239._expansionSizeIndicator = TextLabel2;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "CollapseButton";
    TextButton.AnchorPoint = Vector2.new(1, 0.5);
    TextButton.Position = UDim2.new(1, 0, 0.5, 0);
    TextButton.Size = UDim2.fromOffset(28, 22);
    TextButton.BackgroundColor3 = Color3.fromRGB(40, 42, 38);
    TextButton.BorderSizePixel = 0;
    TextButton.AutoButtonColor = true;
    TextButton.Text = "+";
    TextButton.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextButton.TextSize = 14;
    TextButton.TextColor3 = Color3.fromRGB(200, 200, 200);
    TextButton.ZIndex = 7;
    TextButton.Parent = Frame2;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(80, 80, 80);
    UIStroke2.Thickness = 1;
    UIStroke2.Parent = TextButton;
    TextButton.MouseButton1Click:Connect(function() -- Line: 2863
        -- upvalues: u239 (copy)
        u239:_toggleExpansionPopout();
    end);
    u239._expansionCollapseBtn = TextButton;
    u239._expansionTitleRow = Frame2;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "ContentScroll";
    ScrollingFrame.Position = UDim2.new(0, 0, 0, 26);
    ScrollingFrame.Size = UDim2.new(1, 0, 1, -26);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(140, 140, 140);
    ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
    ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 290);
    ScrollingFrame.ClipsDescendants = true;
    ScrollingFrame.Visible = false;
    ScrollingFrame.ZIndex = 5;
    ScrollingFrame.Parent = Frame;
    u239._expansionContentScroll = ScrollingFrame;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Position = UDim2.new(0, 0, 0, 8);
    TextLabel3.Size = UDim2.new(1, 0, 0, 36);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.Text = "Increase your stash capacity by completing a barter upgrade.\nBarter upgrades reset on wipes. Permanent account upgrades persist forever.";
    TextLabel3.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
    TextLabel3.TextSize = 13;
    TextLabel3.TextColor3 = Color3.fromRGB(150, 150, 150);
    TextLabel3.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel3.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel3.TextWrapped = true;
    TextLabel3.ZIndex = 6;
    TextLabel3.Parent = ScrollingFrame;
    local TextLabel4 = Instance.new("TextLabel");
    TextLabel4.Position = UDim2.new(0, 0, 0, 50);
    TextLabel4.Size = UDim2.new(1, 0, 0, 16);
    TextLabel4.BackgroundTransparency = 1;
    TextLabel4.Text = "REQUIRES (BARTER)";
    TextLabel4.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel4.TextSize = 12;
    TextLabel4.TextColor3 = Color3.fromRGB(130, 130, 130);
    TextLabel4.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel4.ZIndex = 6;
    TextLabel4.Parent = ScrollingFrame;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "MaterialsRow";
    Frame3.BackgroundTransparency = 1;
    Frame3.Position = UDim2.new(0, 0, 0, 70);
    Frame3.Size = UDim2.new(1, 0, 0, 90);
    Frame3.ZIndex = 6;
    Frame3.Parent = ScrollingFrame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.FillDirection = Enum.FillDirection.Horizontal;
    UIListLayout.Padding = UDim.new(0, 8);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center;
    UIListLayout.Parent = Frame3;
    local UIPadding2 = Instance.new("UIPadding");
    UIPadding2.PaddingLeft = UDim.new(0, 1);
    UIPadding2.PaddingRight = UDim.new(0, 1);
    UIPadding2.Parent = Frame3;
    u239._expansionMatsRow = Frame3;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Name = "AutoFillButton";
    TextButton2.AnchorPoint = Vector2.new(1, 0);
    TextButton2.Position = UDim2.new(1, 0, 0, 44);
    TextButton2.Size = UDim2.fromOffset(140, 24);
    TextButton2.BackgroundColor3 = Color3.fromRGB(40, 50, 40);
    TextButton2.BorderSizePixel = 0;
    TextButton2.AutoButtonColor = true;
    TextButton2.Text = "AUTO-FILL";
    TextButton2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextButton2.TextSize = 14;
    TextButton2.TextColor3 = Color3.fromRGB(190, 220, 190);
    TextButton2.ZIndex = 7;
    TextButton2.Parent = ScrollingFrame;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3.fromRGB(80, 110, 80);
    UIStroke3.Thickness = 1;
    UIStroke3.Parent = TextButton2;
    TextButton2.MouseButton1Click:Connect(function() -- Line: 2965
        -- upvalues: u239 (copy)
        u239:_onAutoFillBarterClicked();
    end);
    u239._autoFillBtn = TextButton2;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "PreviewActionRow";
    Frame4.Position = UDim2.new(0, 0, 0, 170);
    Frame4.Size = UDim2.new(1, 0, 0, 42);
    Frame4.BackgroundTransparency = 1;
    Frame4.ZIndex = 7;
    Frame4.Visible = false;
    Frame4.Parent = ScrollingFrame;
    local TextButton3 = Instance.new("TextButton");
    TextButton3.Name = "CancelPreviewButton";
    TextButton3.AnchorPoint = Vector2.new(0, 0);
    TextButton3.Position = UDim2.new(0, 0, 0, 0);
    TextButton3.Size = UDim2.new(0.48, 0, 1, 0);
    TextButton3.BackgroundColor3 = Color3.fromRGB(50, 30, 30);
    TextButton3.BorderSizePixel = 0;
    TextButton3.AutoButtonColor = true;
    TextButton3.Text = "CANCEL";
    TextButton3.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextButton3.TextSize = 16;
    TextButton3.TextColor3 = Color3.fromRGB(220, 180, 180);
    TextButton3.ZIndex = 8;
    TextButton3.Parent = Frame4;
    local UIStroke4 = Instance.new("UIStroke");
    UIStroke4.Color = Color3.fromRGB(150, 70, 70);
    UIStroke4.Thickness = 1;
    UIStroke4.Parent = TextButton3;
    TextButton3.MouseButton1Click:Connect(function() -- Line: 3000
        -- upvalues: u239 (copy)
        u239:_exitAutoFillPreview(false);
    end);
    local TextButton4 = Instance.new("TextButton");
    TextButton4.Name = "ConfirmPreviewButton";
    TextButton4.AnchorPoint = Vector2.new(1, 0);
    TextButton4.Position = UDim2.new(1, 0, 0, 0);
    TextButton4.Size = UDim2.new(0.48, 0, 1, 0);
    TextButton4.BackgroundColor3 = Color3.fromRGB(46, 110, 46);
    TextButton4.BorderSizePixel = 0;
    TextButton4.AutoButtonColor = true;
    TextButton4.Text = "CONFIRM";
    TextButton4.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextButton4.TextSize = 16;
    TextButton4.TextColor3 = Color3.fromRGB(220, 255, 220);
    TextButton4.ZIndex = 8;
    TextButton4.Parent = Frame4;
    local UIStroke5 = Instance.new("UIStroke");
    UIStroke5.Color = Color3.fromRGB(140, 240, 140);
    UIStroke5.Thickness = 2;
    UIStroke5.Parent = TextButton4;
    TextButton4.MouseButton1Click:Connect(function() -- Line: 3022
        -- upvalues: u239 (copy)
        u239:_exitAutoFillPreview(true);
    end);
    u239._previewActionRow = Frame4;
    u239._cancelPreviewBtn = TextButton3;
    u239._confirmPreviewBtn = TextButton4;
    local TextButton5 = Instance.new("TextButton");
    TextButton5.Name = "BarterButton";
    TextButton5.Position = UDim2.new(0, 0, 0, 170);
    TextButton5.Size = UDim2.new(1, 0, 0, 42);
    TextButton5.BackgroundColor3 = Color3.fromRGB(32, 33, 30);
    TextButton5.BorderSizePixel = 0;
    TextButton5.AutoButtonColor = false;
    TextButton5.Text = "";
    TextButton5.ZIndex = 6;
    TextButton5.Parent = ScrollingFrame;
    local UIStroke6 = Instance.new("UIStroke");
    UIStroke6.Color = Color3.fromRGB(48, 48, 48);
    UIStroke6.Thickness = 1;
    UIStroke6.Parent = TextButton5;
    local TextLabel5 = Instance.new("TextLabel");
    TextLabel5.Name = "LockIcon";
    TextLabel5.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel5.Position = UDim2.new(0, 16, 0.5, 0);
    TextLabel5.Size = UDim2.fromOffset(22, 22);
    TextLabel5.BackgroundTransparency = 1;
    TextLabel5.Text = utf8.char(128274);
    TextLabel5.TextSize = 16;
    TextLabel5.TextColor3 = Color3.fromRGB(140, 140, 140);
    TextLabel5.ZIndex = 7;
    TextLabel5.Parent = TextButton5;
    local TextLabel6 = Instance.new("TextLabel");
    TextLabel6.Name = "Main";
    TextLabel6.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel6.Position = UDim2.new(0.5, 0, 0, 5);
    TextLabel6.Size = UDim2.new(0.9, 0, 0, 21);
    TextLabel6.BackgroundTransparency = 1;
    TextLabel6.Text = "EXPAND WITH BARTER";
    TextLabel6.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel6.TextSize = 17;
    TextLabel6.TextColor3 = Color3.fromRGB(180, 180, 180);
    TextLabel6.ZIndex = 7;
    TextLabel6.Parent = TextButton5;
    local TextLabel7 = Instance.new("TextLabel");
    TextLabel7.Name = "Sub";
    TextLabel7.AnchorPoint = Vector2.new(0.5, 1);
    TextLabel7.Position = UDim2.new(0.5, 0, 1, -4);
    TextLabel7.Size = UDim2.new(0.9, 0, 0, 14);
    TextLabel7.BackgroundTransparency = 1;
    TextLabel7.Text = "Complete all requirements to unlock";
    TextLabel7.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
    TextLabel7.TextSize = 12;
    TextLabel7.TextColor3 = Color3.fromRGB(120, 120, 120);
    TextLabel7.ZIndex = 7;
    TextLabel7.Parent = TextButton5;
    TextButton5.MouseButton1Click:Connect(function() -- Line: 3086
        -- upvalues: u239 (copy)
        if not u239._barterButtonReady then
            return;
        end;

        u239:_onBarterExpandClicked();
    end);
    u239._barterButton = TextButton5;
    local Frame5 = Instance.new("Frame");
    Frame5.Position = UDim2.new(0, 0, 0, 220);
    Frame5.Size = UDim2.new(1, 0, 0, 16);
    Frame5.BackgroundTransparency = 1;
    Frame5.ZIndex = 6;
    Frame5.Parent = ScrollingFrame;
    local TextLabel8 = Instance.new("TextLabel");
    TextLabel8.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel8.Position = UDim2.fromScale(0.5, 0.5);
    TextLabel8.Size = UDim2.fromOffset(50, 16);
    TextLabel8.BackgroundTransparency = 1;
    TextLabel8.Text = "OR";
    TextLabel8.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextLabel8.TextSize = 13;
    TextLabel8.TextColor3 = Color3.fromRGB(140, 140, 140);
    TextLabel8.ZIndex = 7;
    TextLabel8.Parent = Frame5;
    local TextButton6 = Instance.new("TextButton");
    TextButton6.Name = "PremiumButton";
    TextButton6.Position = UDim2.new(0, 0, 0, 240);
    TextButton6.Size = UDim2.new(1, 0, 0, 46);
    TextButton6.BackgroundColor3 = Color3.fromRGB(45, 38, 18);
    TextButton6.BorderSizePixel = 0;
    TextButton6.AutoButtonColor = true;
    TextButton6.Text = "";
    TextButton6.ZIndex = 6;
    TextButton6.Parent = ScrollingFrame;
    local UIStroke7 = Instance.new("UIStroke");
    UIStroke7.Color = Color3.fromRGB(170, 130, 60);
    UIStroke7.Thickness = 1.5;
    UIStroke7.Parent = TextButton6;
    local ImageLabel2 = Instance.new("ImageLabel");
    ImageLabel2.AnchorPoint = Vector2.new(0, 0.5);
    ImageLabel2.Position = UDim2.new(0, 14, 0.5, 0);
    ImageLabel2.Size = UDim2.fromOffset(26, 26);
    ImageLabel2.BackgroundTransparency = 1;
    ImageLabel2.Image = "rbxasset://textures/ui/common/robux.png";
    ImageLabel2.ImageColor3 = Color3.fromRGB(255, 204, 80);
    ImageLabel2.ZIndex = 7;
    ImageLabel2.Parent = TextButton6;
    local TextLabel9 = Instance.new("TextLabel");
    TextLabel9.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel9.Position = UDim2.new(0.5, 0, 0, 6);
    TextLabel9.Size = UDim2.new(0.9, 0, 0, 22);
    TextLabel9.BackgroundTransparency = 1;
    TextLabel9.Text = "PERMANENT UPGRADE";
    TextLabel9.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel9.TextSize = 18;
    TextLabel9.TextColor3 = Color3.fromRGB(230, 200, 130);
    TextLabel9.ZIndex = 7;
    TextLabel9.Parent = TextButton6;
    local TextLabel10 = Instance.new("TextLabel");
    TextLabel10.AnchorPoint = Vector2.new(0.5, 1);
    TextLabel10.Position = UDim2.new(0.5, 0, 1, -5);
    TextLabel10.Size = UDim2.new(0.9, 0, 0, 14);
    TextLabel10.BackgroundTransparency = 1;
    TextLabel10.Text = "UNLOCK WITH ROBUX";
    TextLabel10.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
    TextLabel10.TextSize = 12;
    TextLabel10.TextColor3 = Color3.fromRGB(180, 160, 120);
    TextLabel10.ZIndex = 7;
    TextLabel10.Parent = TextButton6;
    TextButton6.MouseButton1Click:Connect(function() -- Line: 3163
        -- upvalues: u239 (copy)
        u239:_onPremiumUpgradeClicked();
    end);
    u239._expansionPanel = Frame;
    u239._expansionPremiumBtn = TextButton6;
    u239:_refreshExpansionPanel();
end;

function u6._onAutoFillBarterClicked(p240) -- Line: 3176
    -- upvalues: ReplicatedStorage (copy)
    if p240._autoFillPreview then
        p240:_exitAutoFillPreview(true);

        return;
    end;

    local success, result = pcall(function() -- Line: 3183
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.BarterAutoFillPreview:InvokeServer();
    end);

    if not (success and result) then
        return;
    end;

    if not (result.items and #result.items > 0 or result.currency and #result.currency > 0) then
        return;
    end;

    p240:_enterAutoFillPreview(result);
end;

function u6._findItemByTiedAndIdx(p241, p242, p243) -- Line: 3201
    -- upvalues: Players (copy)
    local TransferLink = p241.TransferLink;

    if not (TransferLink and TransferLink.ConnectedItemManagers) then
        return nil;
    end;

    local v244 = tostring(Players.LocalPlayer.UserId);

    for _, v in ipairs(TransferLink.ConnectedItemManagers) do
        local v245 = v.Metadata and v.Metadata.TiedInstance;
        local v246;

        if typeof(v245) == "Instance" then
            v246 = tostring(Players.LocalPlayer.UserId);
        else
            v246 = v245;
        end;

        if (v246 == p242 or p242 == v244 and typeof(v245) == "Instance") and v.Items then
            for _, v2 in pairs(v.Items) do
                if v2.Metadata and v2.Metadata.ItemIndex == p243 then
                    return v2;
                end;
            end;
        end;
    end;

    return nil;
end;

function u6._buildItemGhostOverlay(p247, p248) -- Line: 3230
    if not (p248 and p248.ItemElement) then
        return nil;
    end;

    local BarterGhostOverlay = p248.ItemElement:FindFirstChild("BarterGhostOverlay");

    if BarterGhostOverlay then
        BarterGhostOverlay:Destroy();
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "BarterGhostOverlay";
    Frame.Active = false;
    Frame.AnchorPoint = Vector2.new(0, 0);
    Frame.Position = UDim2.fromScale(0, 0);
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(46, 110, 46);
    Frame.BackgroundTransparency = 0.45;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 50;
    Frame.Parent = p248.ItemElement;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(140, 240, 140);
    UIStroke.Thickness = 2;
    UIStroke.Parent = Frame;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "Check";
    TextLabel.AnchorPoint = Vector2.new(1, 0);
    TextLabel.Position = UDim2.new(1, -3, 0, 2);
    TextLabel.Size = UDim2.fromOffset(18, 18);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = utf8.char(10003);
    TextLabel.TextColor3 = Color3.fromRGB(220, 255, 220);
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel.TextSize = 18;
    TextLabel.ZIndex = 51;
    TextLabel.Parent = Frame;

    return Frame;
end;

function u6._updateChipProjectedQty(p249, p250, p251, p252, p253) -- Line: 3267
    local _expansionMatsRow = p249._expansionMatsRow;

    if not _expansionMatsRow then
        return;
    end;

    local v254 = _expansionMatsRow:FindFirstChild(p250 .. "Chip");

    if not v254 then
        return;
    end;

    local QuantityLabel = v254:FindFirstChild("QuantityLabel");

    if not QuantityLabel then
        return;
    end;

    if p252 > 0 then
        QuantityLabel.RichText = true;
        QuantityLabel.Text = string.format("%s + <font color=\"rgb(140,240,140)\">%s</font> / %s", p249:_formatBarterQty(p251), p249:_formatBarterQty(p252), p249:_formatBarterQty(p253));

        return;
    end;

    QuantityLabel.RichText = false;
    QuantityLabel.Text = string.format("%s / %s", p249:_formatBarterQty(p251), p249:_formatBarterQty(p253));
end;

function u6._setAutoFillButtonsForPreview(p255, p256) -- Line: 3289
    if p255._autoFillBtn then
        p255._autoFillBtn.Visible = not p256;
    end;

    if p255._barterButton then
        p255._barterButton.Visible = not p256;
    end;

    if p255._previewActionRow then
        p255._previewActionRow.Visible = p256;
    end;
end;

function u6._enterAutoFillPreview(u257, p258) -- Line: 3295
    -- upvalues: ReplicatedStorage (copy)
    local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"));
    local success, result = pcall(function() -- Line: 3299
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer();
    end);
    local v259, v260;

    if success and result then
        v259 = (result.PremiumTier or 0) + (result.BarterTier or 0);
        v260 = result.BarterContribution or {};
    else
        v259 = 0;
        v260 = {};
    end;

    local v261 = StashTierConfig.GetBarterRequirements(v259) or {};
    local v262 = {};

    for _, v in ipairs(v261) do
        v262[v.id] = v.quantity;
    end;

    local v263 = {};
    local v264 = {};

    for i = 1, #(p258.items or {}) do
        v263[i] = true;
        local _ = i;
    end;

    for i = 1, #(p258.currency or {}) do
        v264[i] = true;
        local _ = i;
    end;

    u257._autoFillPreview = p258;
    u257._autoFillSelectedItems = v263;
    u257._autoFillSelectedCurrency = v264;
    u257._autoFillGhosts = {};
    u257._autoFillCurrentPool = v260;
    u257._autoFillQuotaById = v262;
    local v265 = {};

    for i, v in ipairs(p258.items) do
        local v266 = u257:_findItemByTiedAndIdx(v.tied, v.idx);
        local v267 = v266 and u257:_buildItemGhostOverlay(v266);

        if v267 then
            u257._autoFillGhosts[i] = v267;
        end;

        v265[v.itemId] = (v265[v.itemId] or 0) + 1;
    end;

    for _, v in ipairs(p258.currency) do
        v265[v.itemId] = (v265[v.itemId] or 0) + (v.amount or 0);
    end;

    for _, v in ipairs(v261) do
        u257:_updateChipProjectedQty(v.id, v260[v.id] or 0, v265[v.id] or 0, v.quantity);
    end;

    u257:_setAutoFillButtonsForPreview(true);
    local UserInputService2 = game:GetService("UserInputService");
    local GuiInset = game:GetService("GuiService"):GetGuiInset();

    if u257._previewInputConn then
        u257._previewInputConn:Disconnect();
    end;

    u257._previewInputConn = UserInputService2.InputBegan:Connect(function(p268, p269) -- Line: 3353
        -- upvalues: u257 (copy), UserInputService2 (copy), GuiInset (copy)
        if p268.UserInputType ~= Enum.UserInputType.MouseButton2 then
            return;
        end;

        if not u257._autoFillPreview then
            return;
        end;

        local v270 = UserInputService2:GetMouseLocation() - GuiInset;

        for i, v in pairs(u257._autoFillGhosts) do
            if v.Parent then
                local AbsolutePosition = v.AbsolutePosition;
                local AbsoluteSize = v.AbsoluteSize;

                if v270.X >= AbsolutePosition.X and (v270.X <= AbsolutePosition.X + AbsoluteSize.X and (v270.Y >= AbsolutePosition.Y and v270.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
                    u257:_togglePreviewItemEntry(i, false);

                    return;
                end;
            end;
        end;
    end);
end;

function u6._recomputeProjectionsAndRepaint(p271) -- Line: 3371
    local _autoFillPreview = p271._autoFillPreview;

    if not _autoFillPreview then
        return;
    end;

    local v272 = {};

    for i, v in ipairs(_autoFillPreview.items or {}) do
        if p271._autoFillSelectedItems[i] then
            v272[v.itemId] = (v272[v.itemId] or 0) + 1;
        end;
    end;

    for i, v in ipairs(_autoFillPreview.currency or {}) do
        if p271._autoFillSelectedCurrency[i] then
            v272[v.itemId] = (v272[v.itemId] or 0) + (v.amount or 0);
        end;
    end;

    for i, v in pairs(p271._autoFillQuotaById or {}) do
        p271:_updateChipProjectedQty(i, (p271._autoFillCurrentPool or {})[i] or 0, v272[i] or 0, v);
    end;
end;

function u6._togglePreviewItemEntry(p273, p274, p275) -- Line: 3390
    if not p273._autoFillPreview then
        return;
    end;

    if p273._autoFillSelectedItems[p274] == p275 then
        return;
    end;

    p273._autoFillSelectedItems[p274] = p275;

    if p275 then
        local v276 = p273._autoFillPreview.items[p274];

        if v276 then
            local v277 = p273:_findItemByTiedAndIdx(v276.tied, v276.idx);
            local v278 = v277 and p273:_buildItemGhostOverlay(v277);

            if v278 then
                p273._autoFillGhosts[p274] = v278;
            end;
        end;
    else
        local v279 = p273._autoFillGhosts[p274];

        if v279 then
            v279:Destroy();
        end;

        p273._autoFillGhosts[p274] = nil;
    end;

    p273:_recomputeProjectionsAndRepaint();
    p273:PlaySound("Move", "General");
end;

function u6._onRoubleChipClicked(p280, p281) -- Line: 3416
    -- upvalues: ReplicatedStorage (copy)
    if p280._autoFillPreview then
        return;
    end;

    if p280._roubleDialogOpen then
        return;
    end;

    local success, result = pcall(function() -- Line: 3419
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer();
    end);

    if not (success and result) then
        return;
    end;

    local v282 = p281.quantity - ((result.BarterContribution or {})[p281.id] or 0);

    if v282 <= 0 then
        return;
    end;

    local success2, result2 = pcall(function() -- Line: 3427
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.RequestBalance:InvokeServer();
    end);
    local v283 = not (success2 and (type(result2) == "number" and result2)) and 0 or result2;
    local math_min_ret = math.min(v282, v283);

    if math_min_ret <= 0 then
        p280:_showRoubleDialog({
            insufficient = true,
            need = v282,
            balance = v283,
            req = p281
        });

        return;
    end;

    p280:_showRoubleDialog({
        amount = math_min_ret,
        need = v282,
        balance = v283,
        req = p281
    });
end;

function u6._showRoubleDialog(u284, u285) -- Line: 3441
    -- upvalues: ReplicatedStorage (copy)
    local _expansionPanel = u284._expansionPanel;

    if not (_expansionPanel and _expansionPanel.Parent) then
        return;
    end;

    if u284._roubleDialog then
        u284._roubleDialog:Destroy();
    end;

    u284._roubleDialogOpen = true;
    local Parent = _expansionPanel.Parent;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "RoubleDialogScrim";
    TextButton.Size = UDim2.fromScale(1, 1);
    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    TextButton.BackgroundTransparency = 0.4;
    TextButton.BorderSizePixel = 0;
    TextButton.Text = "";
    TextButton.AutoButtonColor = false;
    TextButton.ZIndex = 50;
    TextButton.Parent = Parent;
    u284._roubleDialog = TextButton;
    local Frame = Instance.new("Frame");
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.Position = UDim2.fromScale(0.5, 0.5);
    Frame.Size = UDim2.fromOffset(360, 160);
    Frame.BackgroundColor3 = Color3.fromRGB(28, 30, 27);
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 51;
    Frame.Parent = TextButton;
    local UIStroke = Instance.new("UIStroke");
    UIStroke.Color = Color3.fromRGB(120, 160, 120);
    UIStroke.Thickness = 1.5;
    UIStroke.Parent = Frame;
    local utf8_char_ret = utf8.char(8381);
    local TextLabel = Instance.new("TextLabel");
    TextLabel.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel.Position = UDim2.new(0.5, 0, 0, 12);
    TextLabel.Size = UDim2.new(1, -20, 0, 22);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel.TextSize = 18;
    TextLabel.TextColor3 = Color3.fromRGB(220, 230, 220);
    TextLabel.Text = u285.insufficient and "INSUFFICIENT FUNDS" or "CONTRIBUTE ROUBLES";
    TextLabel.ZIndex = 52;
    TextLabel.Parent = Frame;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel2.Position = UDim2.new(0.5, 0, 0, 42);
    TextLabel2.Size = UDim2.new(1, -24, 0, 58);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
    TextLabel2.TextSize = 14;
    TextLabel2.TextColor3 = Color3.fromRGB(190, 190, 190);
    TextLabel2.TextWrapped = true;
    TextLabel2.RichText = true;
    TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
    TextLabel2.ZIndex = 52;
    TextLabel2.Parent = Frame;

    if u285.insufficient then
        TextLabel2.Text = string.format("You need <font color=\'rgb(220,180,180)\'>%s %s</font> more, but your balance is <font color=\'rgb(220,180,180)\'>%s %s</font>.", u284:_formatBarterQty(u285.need), utf8_char_ret, u284:_formatBarterQty(u285.balance), utf8_char_ret);
    else
        TextLabel2.Text = string.format("Contribute <font color=\'rgb(140,220,140)\'>%s %s</font> from your balance? <font color=\'rgb(220,180,180)\'>You can\'t get it back.</font>", u284:_formatBarterQty(u285.amount), utf8_char_ret);
    end;

    local function closeDialog() -- Line: 3508
        -- upvalues: u284 (copy)
        if u284._roubleDialog then
            u284._roubleDialog:Destroy();
        end;

        u284._roubleDialog = nil;
        u284._roubleDialogOpen = false;
    end;

    if u285.insufficient then
        local TextButton2 = Instance.new("TextButton");
        TextButton2.AnchorPoint = Vector2.new(0.5, 1);
        TextButton2.Position = UDim2.new(0.5, 0, 1, -12);
        TextButton2.Size = UDim2.fromOffset(100, 30);
        TextButton2.BackgroundColor3 = Color3.fromRGB(40, 40, 40);
        TextButton2.BorderSizePixel = 0;
        TextButton2.AutoButtonColor = true;
        TextButton2.Text = "CLOSE";
        TextButton2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
        TextButton2.TextSize = 14;
        TextButton2.TextColor3 = Color3.fromRGB(200, 200, 200);
        TextButton2.ZIndex = 52;
        TextButton2.Parent = Frame;
        TextButton2.MouseButton1Click:Connect(closeDialog);
        TextButton.MouseButton1Click:Connect(closeDialog);

        return;
    end;

    local TextButton2 = Instance.new("TextButton");
    TextButton2.AnchorPoint = Vector2.new(0, 1);
    TextButton2.Position = UDim2.new(0, 16, 1, -12);
    TextButton2.Size = UDim2.new(0.45, -8, 0, 32);
    TextButton2.BackgroundColor3 = Color3.fromRGB(50, 30, 30);
    TextButton2.BorderSizePixel = 0;
    TextButton2.AutoButtonColor = true;
    TextButton2.Text = "CANCEL";
    TextButton2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextButton2.TextSize = 14;
    TextButton2.TextColor3 = Color3.fromRGB(220, 180, 180);
    TextButton2.ZIndex = 52;
    TextButton2.Parent = Frame;
    local UIStroke2 = Instance.new("UIStroke");
    UIStroke2.Color = Color3.fromRGB(150, 70, 70);
    UIStroke2.Thickness = 1;
    UIStroke2.Parent = TextButton2;
    local TextButton3 = Instance.new("TextButton");
    TextButton3.AnchorPoint = Vector2.new(1, 1);
    TextButton3.Position = UDim2.new(1, -16, 1, -12);
    TextButton3.Size = UDim2.new(0.45, -8, 0, 32);
    TextButton3.BackgroundColor3 = Color3.fromRGB(46, 110, 46);
    TextButton3.BorderSizePixel = 0;
    TextButton3.AutoButtonColor = true;
    TextButton3.Text = string.format("CONTRIBUTE %s %s", u284:_formatBarterQty(u285.amount), utf8_char_ret);
    TextButton3.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
    TextButton3.TextSize = 14;
    TextButton3.TextColor3 = Color3.fromRGB(220, 255, 220);
    TextButton3.ZIndex = 52;
    TextButton3.Parent = Frame;
    local UIStroke3 = Instance.new("UIStroke");
    UIStroke3.Color = Color3.fromRGB(140, 240, 140);
    UIStroke3.Thickness = 2;
    UIStroke3.Parent = TextButton3;
    TextButton2.MouseButton1Click:Connect(closeDialog);
    TextButton.MouseButton1Click:Connect(closeDialog);
    TextButton3.MouseButton1Click:Connect(function() -- Line: 3571
        -- upvalues: u284 (copy), u285 (copy), ReplicatedStorage (ref)
        if u284._roubleDialog then
            u284._roubleDialog:Destroy();
        end;

        u284._roubleDialog = nil;
        u284._roubleDialogOpen = false;
        local u286 = {
            items = {},
            currency = {
                {
                    itemId = u285.req.id,
                    amount = u285.amount
                }
            }
        };
        local success, _ = pcall(function() -- Line: 3574
            -- upvalues: ReplicatedStorage (ref), u286 (copy)
            return ReplicatedStorage.Remotes.BarterAutoFillCommit:InvokeServer(u286);
        end);

        if success then
            u284:PlaySound("Move", "General");
            u284:_refreshExpansionPanel();
        end;
    end);
end;

function u6._exitAutoFillPreview(p287, p288) -- Line: 3584
    -- upvalues: ReplicatedStorage (copy)
    if not p287._autoFillPreview then
        return;
    end;

    for _, v in pairs(p287._autoFillGhosts or {}) do
        if v and v.Parent then
            v:Destroy();
        end;
    end;

    p287._autoFillGhosts = nil;

    if p287._previewInputConn then
        p287._previewInputConn:Disconnect();
        p287._previewInputConn = nil;
    end;

    p287:_setAutoFillButtonsForPreview(false);

    if not p288 then
        p287._autoFillPreview = nil;
        p287._autoFillSelectedItems = nil;
        p287._autoFillSelectedCurrency = nil;
        p287._autoFillCurrentPool = nil;
        p287._autoFillQuotaById = nil;
        p287:_refreshExpansionPanel();

        return;
    end;

    local u289 = {
        items = {},
        currency = {}
    };

    for i, v in ipairs(p287._autoFillPreview.items or {}) do
        if p287._autoFillSelectedItems[i] then
            table.insert(u289.items, v);
        end;
    end;

    for i, v in ipairs(p287._autoFillPreview.currency or {}) do
        if p287._autoFillSelectedCurrency[i] then
            table.insert(u289.currency, v);
        end;
    end;

    local v290 = #u289.items > 0 and true or #u289.currency > 0;
    p287._autoFillPreview = nil;
    p287._autoFillSelectedItems = nil;
    p287._autoFillSelectedCurrency = nil;
    p287._autoFillCurrentPool = nil;
    p287._autoFillQuotaById = nil;

    if not v290 then
        p287:_refreshExpansionPanel();

        return;
    end;

    local success, _ = pcall(function() -- Line: 3619
        -- upvalues: ReplicatedStorage (ref), u289 (copy)
        return ReplicatedStorage.Remotes.BarterAutoFillCommit:InvokeServer(u289);
    end);

    if success then
        p287:LoadVicinity();

        return;
    end;

    p287:_refreshExpansionPanel();
end;

function u6._toggleExpansionPopout(p291) -- Line: 3648
    p291:_setExpansionPoppedOut(not p291._expansionPoppedOut);
end;

function u6._setExpansionPoppedOut(p292, p293) -- Line: 3652
    local _expansionPanel = p292._expansionPanel;

    if not _expansionPanel then
        return;
    end;

    local InventoryGui = game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");
    local v294 = InventoryGui and InventoryGui.MainFrame and InventoryGui.MainFrame:FindFirstChild("ContainerFrame");

    if not (InventoryGui and v294) then
        return;
    end;

    p292._expansionPoppedOut = p293;

    if p292._expansionContentScroll then
        p292._expansionContentScroll.Visible = p293;
    end;

    if p293 then
        p292._inlineSavedAnchor = _expansionPanel.AnchorPoint;
        p292._inlineSavedPosition = _expansionPanel.Position;
        p292._inlineSavedSize = _expansionPanel.Size;
        _expansionPanel.Parent = InventoryGui;
        _expansionPanel.AnchorPoint = Vector2.new(0, 0);
        _expansionPanel.Size = UDim2.fromOffset(420, 360);
        local _popoutLastPosition = p292._popoutLastPosition;

        if _popoutLastPosition then
            _expansionPanel.Position = _popoutLastPosition;
        else
            local AbsolutePosition = v294.AbsolutePosition;
            _expansionPanel.Position = UDim2.fromOffset(math.max(AbsolutePosition.X - 440, 20), AbsolutePosition.Y + 60);
        end;

        p292:_setAutoFillButtonsForPreview(p292._autoFillPreview ~= nil);
        p292:_attachPopoutDrag();

        if p292._expansionCollapseBtn then
            p292._expansionCollapseBtn.Text = "X";
        end;
    else
        p292:_detachPopoutDrag();
        _expansionPanel.Parent = v294;
        _expansionPanel.AnchorPoint = p292._inlineSavedAnchor or Vector2.new(0.5, 0);
        _expansionPanel.Size = UDim2.new(0.93, 0, 0, 46);

        if p292._expansionCollapseBtn then
            p292._expansionCollapseBtn.Text = "+";
        end;

        p292:_positionExpansionPanelBelowGrid();
    end;
end;

function u6._attachPopoutDrag(u295) -- Line: 3708
    local _expansionTitleRow = u295._expansionTitleRow;
    local _expansionPanel = u295._expansionPanel;

    if not (_expansionTitleRow and _expansionPanel) then
        return;
    end;

    local UserInputService2 = game:GetService("UserInputService");
    u295:_detachPopoutDrag();
    local u296 = false;
    local u297 = nil;
    local u298 = nil;
    u295._popoutDragBeganConn = _expansionTitleRow.InputBegan:Connect(function(p299) -- Line: 3718
        -- upvalues: UserInputService2 (copy), u295 (copy), u296 (ref), u297 (ref), u298 (ref), _expansionPanel (copy)
        if p299.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return;
        end;

        local MouseLocation = UserInputService2:GetMouseLocation();
        local _expansionCollapseBtn = u295._expansionCollapseBtn;

        if _expansionCollapseBtn then
            local AbsolutePosition = _expansionCollapseBtn.AbsolutePosition;
            local AbsoluteSize = _expansionCollapseBtn.AbsoluteSize;

            if MouseLocation.X >= AbsolutePosition.X and (MouseLocation.X <= AbsolutePosition.X + AbsoluteSize.X and (MouseLocation.Y >= AbsolutePosition.Y and MouseLocation.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
                return;
            end;
        end;

        u296 = true;
        u297 = MouseLocation;
        u298 = _expansionPanel.Position;
    end);
    u295._popoutDragMoveConn = UserInputService2.InputChanged:Connect(function(p300) -- Line: 3734
        -- upvalues: u296 (ref), UserInputService2 (copy), u297 (ref), _expansionPanel (copy), u298 (ref)
        if not u296 then
            return;
        end;

        if p300.UserInputType ~= Enum.UserInputType.MouseMovement then
            return;
        end;

        local v301 = UserInputService2:GetMouseLocation() - u297;
        _expansionPanel.Position = UDim2.new(u298.X.Scale, u298.X.Offset + v301.X, u298.Y.Scale, u298.Y.Offset + v301.Y);
    end);
    u295._popoutDragEndConn = UserInputService2.InputEnded:Connect(function(p302) -- Line: 3745
        -- upvalues: u296 (ref), u295 (copy), _expansionPanel (copy)
        if p302.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return;
        end;

        if u296 then
            u296 = false;
            u295._popoutLastPosition = _expansionPanel.Position;
        end;
    end);
end;

function u6._detachPopoutDrag(p303) -- Line: 3754
    for _, v in ipairs({ "_popoutDragBeganConn", "_popoutDragMoveConn", "_popoutDragEndConn" }) do
        if p303[v] then
            p303[v]:Disconnect();
            p303[v] = nil;
        end;
    end;
end;

function u6._autoCollapseIfNoRoom(p304) -- Line: 3765
end;

function u6._onBarterExpandClicked(p305) -- Line: 3768
    -- upvalues: ReplicatedStorage (copy)
    local success, result = pcall(function() -- Line: 3769
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.BarterExpand:InvokeServer();
    end);

    if success and (result and result.ok) then
    end;
end;

function u6._refreshExpansionSizeIndicator(u306) -- Line: 3782
    -- upvalues: ReplicatedStorage (copy)
    local _expansionSizeIndicator = u306._expansionSizeIndicator;

    if not (_expansionSizeIndicator or u306._expansionMatsRow) then
        return;
    end;

    local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"));
    task.spawn(function() -- Line: 3787
        -- upvalues: ReplicatedStorage (ref), StashTierConfig (copy), u306 (copy), _expansionSizeIndicator (copy)
        local success, result = pcall(function() -- Line: 3788
            -- upvalues: ReplicatedStorage (ref)
            return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer();
        end);
        local v307 = (success and result and (result.PremiumTier or 0) or 0) + (success and result and (result.BarterTier or 0) or 0);
        local v308 = success and result and result.GridSize or StashTierConfig.BASELINE;
        local v309 = StashTierConfig.TierLadder[v307 + 1];
        local v310 = success and result and (result.BarterContribution or {}) or {};

        if (StashTierConfig.MAX_TIER or 7) <= v307 then
            u306._stashAtMaxTier = true;

            if u306._expansionPoppedOut then
                u306:_setExpansionPoppedOut(false);
            end;

            if u306._expansionPanel then
                u306._expansionPanel.Visible = false;
            end;

            return;
        end;

        if success and result then
            local v311 = u306._stashAtMaxTier ~= false;
            u306._stashAtMaxTier = false;

            if v311 then
                u306:_refreshExpansionPanel();

                return;
            end;
        end;

        if _expansionSizeIndicator and _expansionSizeIndicator.Parent then
            local v312 = ("%dx%d"):format(v308.X, v308.Y);

            if v309 then
                _expansionSizeIndicator.Text = ("Current <font color=\'rgb(210,210,210)\'>%s</font>  →  Next <font color=\'rgb(140,220,140)\'>%s</font>"):format(v312, (("%dx%d"):format(v309.X, v309.Y)));
            else
                _expansionSizeIndicator.Text = ("Current <font color=\'rgb(210,210,210)\'>%s</font>  —  MAX TIER"):format(v312);
            end;
        end;

        u306:_renderBarterChips(v307, v310);
        u306:_refreshBarterButtonState(v307, v310);
    end);
end;

function u6._refreshBarterButtonState(p313, p314, p315) -- Line: 3840
    -- upvalues: ReplicatedStorage (copy)
    local _barterButton = p313._barterButton;

    if not _barterButton then
        return;
    end;

    local BarterRequirements = require(ReplicatedStorage:WaitForChild("StashTierConfig")).GetBarterRequirements(p314 or 0);
    local v316 = BarterRequirements and #BarterRequirements > 0 and true or false;

    if BarterRequirements then
        for _, v in ipairs(BarterRequirements) do
            if (p315[v.id] or 0) < v.quantity then
                v316 = false;
                break;
            end;
        end;
    end;

    local LockIcon = _barterButton:FindFirstChild("LockIcon");
    local Main = _barterButton:FindFirstChild("Main");
    local Sub = _barterButton:FindFirstChild("Sub");
    local v317 = _barterButton:FindFirstChildOfClass("UIStroke");

    if v316 then
        _barterButton.BackgroundColor3 = Color3.fromRGB(56, 80, 56);
        _barterButton.AutoButtonColor = true;

        if v317 then
            v317.Color = Color3.fromRGB(140, 200, 140);
        end;

        if LockIcon then
            LockIcon.Visible = false;
        end;

        if Main then
            Main.TextColor3 = Color3.fromRGB(230, 240, 230);
        end;

        if Sub then
            Sub.Text = "All requirements met -- click to upgrade";
            Sub.TextColor3 = Color3.fromRGB(170, 220, 170);
        end;
    else
        _barterButton.BackgroundColor3 = Color3.fromRGB(32, 33, 30);
        _barterButton.AutoButtonColor = false;

        if v317 then
            v317.Color = Color3.fromRGB(48, 48, 48);
        end;

        if LockIcon then
            LockIcon.Visible = true;
        end;

        if Main then
            Main.TextColor3 = Color3.fromRGB(180, 180, 180);
        end;

        if Sub then
            Sub.Text = "Complete all requirements to unlock";
            Sub.TextColor3 = Color3.fromRGB(120, 120, 120);
        end;
    end;

    p313._barterButtonReady = v316;
end;

function u6._renderBarterChips(u318, p319, p320) -- Line: 3882
    -- upvalues: ReplicatedStorage (copy), Players (copy), GridPack (copy), ItemIconStyle (copy)
    local _expansionMatsRow = u318._expansionMatsRow;

    if not _expansionMatsRow then
        return;
    end;

    local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"));
    local ItemDatabase2 = require(ReplicatedStorage:WaitForChild("ItemDatabase"));
    local BarterRequirements = StashTierConfig.GetBarterRequirements(p319 or 0);
    local v321 = p320 or {};

    for _, child in ipairs(_expansionMatsRow:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    if BarterRequirements then
        if u318._barterChipGrids then
            for _, v in ipairs(u318._barterChipGrids) do
                pcall(function() -- Line: 3916
                    -- upvalues: v (copy)
                    if v.GuiElement then
                        v.GuiElement:Destroy();
                    end;
                end);
            end;
        end;

        u318._barterChipGrids = {};
        u318:_ensureInvisibleSlotTemplate();
        local utf8_char_ret = utf8.char(8381);
        local UserId = Players.LocalPlayer.UserId;

        for i, v in ipairs(BarterRequirements) do
            local Frame = Instance.new("Frame");
            Frame.Name = v.id .. "Chip";
            Frame.LayoutOrder = i;
            Frame.Size = UDim2.new(0.2, -6.4, 1, 0);
            Frame.BackgroundColor3 = Color3.fromRGB(28, 30, 27);
            Frame.BorderSizePixel = 0;
            Frame.ZIndex = 6;
            Frame.Parent = _expansionMatsRow;
            local UIStroke = Instance.new("UIStroke");
            UIStroke.Color = Color3.fromRGB(48, 48, 48);
            UIStroke.Thickness = 1;
            UIStroke.Parent = Frame;
            local ItemData = ItemDatabase2.GetItemData(v.id);
            local v322 = ItemData and ItemData.Name or v.id;

            if not v.isCurrency then
                local v323 = GridPack.createSingleSlot({
                    Visible = true,
                    Parent = Frame,
                    Assets = {
                        Slot = u318._invisibleSlotTemplate
                    },
                    AnchorPoint = Vector2.new(0, 0),
                    Position = UDim2.fromScale(0, 0),
                    Size = UDim2.fromScale(1, 1)
                });
                v323.Metadata = {
                    IsBarterChip = true,
                    AcceptsType = "Barter",
                    TiedInstance = "BarterChip_" .. v.id .. "_" .. UserId,
                    BarterItemId = v.id
                };
                v323.MoveMiddleware = u318:CreateMoveMiddleware();
                v323:ConnectTransferLink(u318.TransferLink);

                if v323.GuiElement then
                    v323.GuiElement.ZIndex = 6;

                    if v323.GuiElement:IsA("CanvasGroup") then
                        v323.GuiElement.GroupTransparency = 1;
                        v323.GuiElement.BackgroundTransparency = 1;
                    end;
                end;

                Frame:SetAttribute("BarterChipItemId", v.id);
                Frame:SetAttribute("BarterChipBaseBG", "28,30,27");
                table.insert(u318._barterChipGrids, v323);
            end;

            local TextLabel = Instance.new("TextLabel");
            TextLabel.AnchorPoint = Vector2.new(0.5, 0);
            TextLabel.Position = UDim2.new(0.5, 0, 0, 5);
            TextLabel.Size = UDim2.new(1, -8, 0, 14);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Text = v322;
            TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
            TextLabel.TextSize = 13;
            TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180);
            TextLabel.ZIndex = 8;
            TextLabel.Parent = Frame;

            if v.isCurrency then
                local TextLabel2 = Instance.new("TextLabel");
                TextLabel2.AnchorPoint = Vector2.new(0.5, 0.5);
                TextLabel2.Position = UDim2.new(0.5, 0, 0.52, 0);
                TextLabel2.Size = UDim2.new(0.7, 0, 0.55, 0);
                TextLabel2.BackgroundTransparency = 1;
                TextLabel2.Text = utf8_char_ret;
                TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
                TextLabel2.TextSize = 32;
                TextLabel2.TextColor3 = Color3.fromRGB(140, 200, 140);
                TextLabel2.ZIndex = 8;
                TextLabel2.Parent = Frame;
                local TextButton = Instance.new("TextButton");
                TextButton.Name = "RoubleClickArea";
                TextButton.BackgroundTransparency = 1;
                TextButton.Text = "";
                TextButton.Size = UDim2.fromScale(1, 1);
                TextButton.ZIndex = 9;
                TextButton.Parent = Frame;
                TextButton.MouseButton1Click:Connect(function() -- Line: 4031
                    -- upvalues: u318 (copy), v (copy)
                    u318:_onRoubleChipClicked(v);
                end);
            else
                local ImageLabel = Instance.new("ImageLabel");
                ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
                ImageLabel.Position = UDim2.new(0.5, 0, 0.52, 0);
                ImageLabel.Size = UDim2.new(0, 38, 0, 38);
                ImageLabel.BackgroundTransparency = 1;
                ImageLabel.Image = ItemData and (ItemData.ImageID or "rbxassetid://0") or "rbxassetid://0";
                ImageLabel.ScaleType = ItemIconStyle.ScaleTypeFor(ItemData);
                ImageLabel.ZIndex = 8;
                ImageLabel.Parent = Frame;
            end;

            local v324 = v321[v.id] or 0;
            local v325 = v.quantity <= v324;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Name = "QuantityLabel";
            TextLabel2.AnchorPoint = Vector2.new(0.5, 1);
            TextLabel2.Position = UDim2.new(0.5, 0, 1, -5);
            TextLabel2.Size = UDim2.new(1, -6, 0, 15);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Text = ("%s / %s"):format(u318:_formatBarterQty(v324), u318:_formatBarterQty(v.quantity));
            TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Regular);
            TextLabel2.TextSize = 13;
            TextLabel2.TextColor3 = v325 and Color3.fromRGB(140, 220, 140) or Color3.fromRGB(160, 160, 160);
            TextLabel2.ZIndex = 8;
            TextLabel2.Parent = Frame;
        end;

        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = _expansionMatsRow;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(1, 1);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "MAX TIER REACHED";
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel.TextSize = 15;
    TextLabel.TextColor3 = Color3.fromRGB(180, 180, 180);
    TextLabel.Parent = Frame;
end;

function u6._startBarterHoverPoll(u326) -- Line: 4069
    if u326._chipHoverConn then
        return;
    end;

    local RunService = game:GetService("RunService");
    local u327 = {};
    local Color3_fromRGB_ret2 = Color3.fromRGB(46, 80, 46);
    local Color3_fromRGB_ret3 = Color3.fromRGB(120, 220, 120);
    local Color3_fromRGB_ret4 = Color3.fromRGB(80, 36, 36);
    local Color3_fromRGB_ret5 = Color3.fromRGB(220, 110, 110);
    local Color3_fromRGB_ret6 = Color3.fromRGB(28, 30, 27);
    local Color3_fromRGB_ret7 = Color3.fromRGB(48, 48, 48);

    local function findDraggingItemId() -- Line: 4087
        -- upvalues: u326 (copy)
        local TransferLink = u326.TransferLink;

        if not (TransferLink and TransferLink.ConnectedItemManagers) then
            return nil;
        end;

        for _, v in ipairs(TransferLink.ConnectedItemManagers) do
            local Items = v.Items;

            if Items then
                for _, v2 in pairs(Items) do
                    if v2.IsDragging and (v2.Metadata and v2.Metadata.ID) then
                        return v2.Metadata.ID;
                    end;
                end;
            end;
        end;

        return nil;
    end;

    u326._chipHoverConn = RunService.RenderStepped:Connect(function() -- Line: 4103
        -- upvalues: u326 (copy), findDraggingItemId (copy), u327 (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret4 (copy), Color3_fromRGB_ret6 (copy), Color3_fromRGB_ret3 (copy), Color3_fromRGB_ret5 (copy), Color3_fromRGB_ret7 (copy)
        local _barterChipGrids = u326._barterChipGrids;

        if not _barterChipGrids then
            return;
        end;

        local v328 = false;
        local v329 = nil;

        for _, v in ipairs(_barterChipGrids) do
            local v330 = v.GuiElement and v.GuiElement.Parent;

            if v330 and v330:IsA("Frame") then
                local v331 = v.Highlights and next(v.Highlights) ~= nil;
                local v332;

                if v331 then
                    if not v328 then
                        v329 = findDraggingItemId();
                        v328 = true;
                    end;

                    local v333 = v.Metadata and v.Metadata.BarterItemId;

                    if v329 and (v333 and v329 == v333) then
                        v332 = "match";
                    else
                        v332 = "mismatch";
                    end;
                else
                    v332 = "none";
                end;

                if v332 ~= u327[v] then
                    u327[v] = v332;

                    if v332 == "match" then
                        v330.BackgroundColor3 = Color3_fromRGB_ret2;
                    elseif v332 == "mismatch" then
                        v330.BackgroundColor3 = Color3_fromRGB_ret4;
                    else
                        v330.BackgroundColor3 = Color3_fromRGB_ret6;
                    end;

                    local v334 = v330:FindFirstChildOfClass("UIStroke");

                    if v334 then
                        if v332 == "match" then
                            v334.Color = Color3_fromRGB_ret3;
                            v334.Thickness = 2;
                        elseif v332 == "mismatch" then
                            v334.Color = Color3_fromRGB_ret5;
                            v334.Thickness = 2;
                        else
                            v334.Color = Color3_fromRGB_ret7;
                            v334.Thickness = 1;
                        end;
                    end;
                end;
            end;
        end;
    end);
end;

function u6._updateBarterChipCount(p335, p336, p337) -- Line: 4154
    -- upvalues: ReplicatedStorage (copy)
    local _expansionMatsRow = p335._expansionMatsRow;

    if not _expansionMatsRow then
        return;
    end;

    local v338 = _expansionMatsRow:FindFirstChild(p336 .. "Chip");

    if not v338 then
        return;
    end;

    local QuantityLabel = v338:FindFirstChild("QuantityLabel");

    if not QuantityLabel then
        return;
    end;

    local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"));
    local success, result = pcall(function() -- Line: 4163
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer();
    end);
    local BarterRequirements = StashTierConfig.GetBarterRequirements(not (success and result) and 0 or (result.PremiumTier or 0) + (result.BarterTier or 0));
    local v339 = 0;

    if BarterRequirements then
        for _, v in ipairs(BarterRequirements) do
            if v.id == p336 then
                v339 = v.quantity;
                break;
            end;
        end;
    end;

    QuantityLabel.Text = ("%s / %s"):format(p335:_formatBarterQty(p337), p335:_formatBarterQty(v339));
    QuantityLabel.TextColor3 = v339 <= p337 and Color3.fromRGB(140, 220, 140) or Color3.fromRGB(160, 160, 160);
end;

function u6._formatBarterQty(p340, p341) -- Line: 4182
    if type(p341) ~= "number" then
        return tostring(p341);
    end;

    if p341 >= 1000 then
        return tostring(p341):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end;

    return tostring(p341);
end;

function u6._refreshExpansionPanel(u342) -- Line: 4197
    if not u342._expansionPanel then
        return;
    end;

    local v343;

    if u342.SafezoneTier == "Full" and u342.SafezoneViewMode == "stash" then
        v343 = u342.CurrentStoragePart == nil;
    else
        v343 = false;
    end;

    local v344;

    if v343 then
        v344 = u342._stashAtMaxTier == false;
    else
        v344 = v343;
    end;

    u342._expansionPanel.Visible = v344;

    if v343 then
        u342:_refreshExpansionSizeIndicator();
    end;

    if v344 then
        u342:_startBarterHoverPoll();
        task.defer(function() -- Line: 4221
            -- upvalues: u342 (copy)
            u342:_autoCollapseIfNoRoom();
        end);
    elseif u342._chipHoverConn then
        u342._chipHoverConn:Disconnect();
        u342._chipHoverConn = nil;
    end;

    if u342._expansionPosLoop then
        u342._expansionPosLoop:Disconnect();
        u342._expansionPosLoop = nil;
    end;

    if u342._gridResizeConn then
        u342._gridResizeConn:Disconnect();
        u342._gridResizeConn = nil;
    end;

    if not v344 then
        return;
    end;

    local RunService = game:GetService("RunService");
    local os_clock_ret = os.clock();
    u342._expansionPosLoop = RunService.Heartbeat:Connect(function() -- Line: 4240
        -- upvalues: u342 (copy), os_clock_ret (copy)
        u342:_positionExpansionPanelBelowGrid();

        if os.clock() - os_clock_ret > 1 and u342._expansionPosLoop then
            u342._expansionPosLoop:Disconnect();
            u342._expansionPosLoop = nil;
        end;
    end);

    if u342.StorageInventory and u342.StorageInventory.GuiElement then
        u342._gridResizeConn = u342.StorageInventory.GuiElement:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 4250
            -- upvalues: u342 (copy)
            u342:_positionExpansionPanelBelowGrid();
            u342:_autoCollapseIfNoRoom();
        end);
    end;
end;

function u6._positionExpansionPanelBelowGrid(p345) -- Line: 4260
    local _expansionPanel = p345._expansionPanel;

    if not (_expansionPanel and (_expansionPanel.Visible and _expansionPanel.Parent)) then
        return;
    end;

    local v346 = p345.StorageInventory and p345.StorageInventory.GuiElement;

    if not v346 then
        local CrateGridFrame = p345.CrateGridFrame;

        if CrateGridFrame then
            for _, child in ipairs(CrateGridFrame:GetChildren()) do
                if child:IsA("CanvasGroup") then
                    v346 = child;
                    break;
                end;
            end;
        end;
    end;

    if not v346 then
        return;
    end;

    local Y = v346.AbsoluteSize.Y;

    if Y < 16 then
        return;
    end;

    local Parent = _expansionPanel.Parent;
    local Y2 = Parent.AbsolutePosition.Y;
    local Y3 = Parent.AbsoluteSize.Y;
    local _ = Y2 + Y3;

    if p345._expansionPoppedOut then
        return;
    end;

    local v347 = Y3 > 0 and (v346.AbsolutePosition.Y + Y + 12 - Y2) / Y3 or 0.5;
    _expansionPanel.AnchorPoint = Vector2.new(0.5, 0);
    _expansionPanel.Position = UDim2.new(0.5, 0, v347, 0);
end;

function u6._refreshExpandButton(p348) -- Line: 4296
    p348:_refreshExpansionPanel();
end;

function u6._onPremiumUpgradeClicked(p349) -- Line: 4305
    -- upvalues: ReplicatedStorage (copy), Players (copy)
    local StashTierConfig = require(ReplicatedStorage:WaitForChild("StashTierConfig"));
    local success, result = pcall(function() -- Line: 4307
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer();
    end);

    if (success and result and (result.PremiumTier or 0) or 0) + (success and (result and result.BarterTier) or 0) >= StashTierConfig.MAX_TOTAL_TIER then
        return;
    end;

    local u350 = StashTierConfig.PremiumStashDevProductId or 0;

    if u350 == 0 then
        warn("[InventoryController] PremiumStashDevProductId not configured yet -- create the DevProduct on Roblox and wire its ID into StashTierConfig.");

        return;
    end;

    local MarketplaceService = game:GetService("MarketplaceService");
    pcall(function() -- Line: 4321
        -- upvalues: MarketplaceService (copy), Players (ref), u350 (copy)
        MarketplaceService:PromptProductPurchase(Players.LocalPlayer, u350);
    end);
end;

function u6._MagStateText(p351, p352) -- Line: 4329
    if not p352 or p352 <= 0 then
        return "?", Color3.fromRGB(200, 200, 200);
    end;

    if p351 <= 0 then
        return "Empty", Color3.fromRGB(220, 80, 80);
    end;

    local v353 = p351 / p352;

    if v353 >= 0.75 then
        return "Full", Color3.fromRGB(120, 220, 120);
    end;

    if v353 < 0.25 then
        return "Low", Color3.fromRGB(255, 165, 50);
    end;

    return "Partial", Color3.fromRGB(230, 210, 110);
end;

function u6.UpdateWeaponSlotDisplay(p354, p355, p356) -- Line: 4338
    -- upvalues: ItemDatabase (copy), Players (copy), u6 (copy)
    if not (p355 and p356) then
        return;
    end;

    local WeaponInfoStrip = p356:FindFirstChild("WeaponInfoStrip");

    if WeaponInfoStrip then
        WeaponInfoStrip:Destroy();
    end;

    if not (p355.Item and p355.Item.Metadata) then
        return;
    end;

    local ItemData = ItemDatabase.GetItemData(p355.Item.Metadata.ID);

    if not (ItemData and ItemData.MagType) then
        return;
    end;

    local Character = Players.LocalPlayer.Character;
    local v357 = 0;
    local v358 = false;
    local v359 = false;

    if Character then
        local v360 = Character:FindFirstChild(ItemData.ToolName);

        if not v360 then
            local Backpack = Players.LocalPlayer:FindFirstChild("Backpack");

            if Backpack then
                v360 = Backpack:FindFirstChild(ItemData.ToolName);
            end;
        end;

        if v360 then
            v358 = true;
            v359 = not v360:GetAttribute("MagUnloaded");
            v357 = v360:GetAttribute("CurrentMagRounds") or 0;
            local Ammo = v360:FindFirstChild("Ammo");

            if Ammo then
                local MagAmmo = Ammo:FindFirstChild("MagAmmo");

                if MagAmmo then
                    v357 = MagAmmo.Value;
                end;
            end;
        end;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "WeaponInfoStrip";
    Frame.Size = UDim2.new(1, 0, 0, 18);
    Frame.Position = UDim2.new(0, 0, 1, 0);
    Frame.AnchorPoint = Vector2.new(0, 1);
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
    Frame.BackgroundTransparency = 0.5;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 10;
    Frame.Parent = p356;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "WeaponRoundsLabel";
    TextLabel.Size = UDim2.new(0, 70, 1, 0);
    TextLabel.Position = UDim2.new(0, 4, 0, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
    TextLabel.TextSize = 16;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.ZIndex = 11;
    TextLabel.Parent = Frame;

    if v359 and v357 > 0 then
        local v361, v362 = u6._MagStateText(v357, ItemData.magazineCapacity or ItemData.maxRounds);
        TextLabel.Text = v361;
        TextLabel.TextColor3 = v362;
        TextLabel.Visible = true;
    else
        TextLabel.Visible = false;
    end;

    if v358 then
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "WeaponLoadedLabel";
        TextLabel2.Size = UDim2.new(0, 90, 1, 0);
        TextLabel2.Position = UDim2.new(1, -4, 0, 0);
        TextLabel2.AnchorPoint = Vector2.new(1, 0);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
        TextLabel2.TextSize = 16;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
        TextLabel2.ZIndex = 11;
        TextLabel2.Parent = Frame;

        if not v359 then
            TextLabel2.Text = "Unloaded";
            TextLabel2.TextColor3 = Color3.fromRGB(170, 170, 170);

            return;
        end;

        if v357 > 0 then
            TextLabel2.Text = "Loaded";
            TextLabel2.TextColor3 = Color3.fromRGB(120, 200, 120);

            return;
        end;

        TextLabel2.Text = "Empty";
        TextLabel2.TextColor3 = Color3.fromRGB(220, 80, 80);
    end;
end;

function u6.StartWeaponAmmoWatcher(u363) -- Line: 4442
    -- upvalues: Players (copy)
    if u363._ammoWatcherRunning then
        return;
    end;

    u363._ammoWatcherRunning = true;
    task.spawn(function() -- Line: 4446
        -- upvalues: u363 (copy), Players (ref)
        while u363._ammoWatcherRunning do
            task.wait(0.5);
            local Character = Players.LocalPlayer.Character;

            if Character then
                if u363.PrimarySlot and u363.PrimarySlot.Item then
                    local v364 = Character and (Players.LocalPlayer.PlayerGui and Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")) and Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.CharacterFrame:FindFirstChild("PrimaryFrame");

                    if v364 then
                        u363:UpdateWeaponSlotDisplay(u363.PrimarySlot, v364);
                    end;
                end;

                if u363.SecondarySlot and u363.SecondarySlot.Item then
                    local v365 = Character and (Players.LocalPlayer.PlayerGui and Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")) and Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.CharacterFrame:FindFirstChild("SecondaryFrame");

                    if v365 then
                        u363:UpdateWeaponSlotDisplay(u363.SecondarySlot, v365);
                    end;
                end;

                if u363.SidearmSlot and u363.SidearmSlot.Item then
                    local v366 = Character and (Players.LocalPlayer.PlayerGui and Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui")) and Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.CharacterFrame:FindFirstChild("SidearmFrame");

                    if v366 then
                        u363:UpdateWeaponSlotDisplay(u363.SidearmSlot, v366);
                    end;
                end;
            end;
        end;
    end);
end;

function u6._setUIInputLock(p367, p368) -- Line: 4504
    -- upvalues: Players (copy)
    local LocalPlayer = Players.LocalPlayer;
    local v369 = p368 and true or false;
    LocalPlayer:SetAttribute("UIInputLocked", v369);

    if p367._uiLockToolConn then
        p367._uiLockToolConn:Disconnect();
        p367._uiLockToolConn = nil;
    end;

    if not v369 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if not Character then
        return;
    end;

    local v370 = Character:FindFirstChildOfClass("Humanoid");

    if v370 then
        v370:UnequipTools();
    end;

    p367._uiLockToolConn = Character.ChildAdded:Connect(function(p371) -- Line: 4522
        -- upvalues: LocalPlayer (copy), Character (copy)
        if not p371:IsA("Tool") then
            return;
        end;

        if LocalPlayer:GetAttribute("UIInputLocked") ~= true then
            return;
        end;

        task.defer(function() -- Line: 4525
            -- upvalues: LocalPlayer (ref), Character (ref)
            if LocalPlayer:GetAttribute("UIInputLocked") ~= true then
                return;
            end;

            local v372 = Character:FindFirstChildOfClass("Humanoid");

            if v372 then
                v372:UnequipTools();
            end;
        end);
    end);
end;

function u6.EnsureBackpackGridSized(p373) -- Line: 4533
    -- upvalues: ItemDatabase (copy)
    local v374 = p373.BackpackSlot and p373.BackpackSlot.Item;
    local v375 = v374 and v374.Metadata and v374.Metadata.ID;

    if not v375 then
        return false;
    end;

    local ItemData = ItemDatabase.GetItemData(v375);

    if ItemData then
        ItemData = ItemData.SlotSize;
    end;

    if not ItemData then
        return false;
    end;

    local v376 = p373.MainInventory and p373.MainInventory.GridSize;

    if v376 and (v376.X == ItemData.X and v376.Y == ItemData.Y) then
        return false;
    end;

    p373._loadedBackpackID = nil;
    p373:UpdateBackpackGridSize(v375);

    return true;
end;

function u6.EnsureChestRigGridSized(p377) -- Line: 4556
    -- upvalues: ItemDatabase (copy)
    local v378 = p377.BodySlot and p377.BodySlot.Item;
    local v379 = v378 and v378.Metadata and v378.Metadata.ID;

    if not v379 then
        return false;
    end;

    local ItemData = ItemDatabase.GetItemData(v379);

    if ItemData then
        ItemData = ItemData.SlotSize;
    end;

    if not ItemData then
        return false;
    end;

    local v380 = p377.ChestRigInventory and p377.ChestRigInventory.GridSize;

    if v380 and (v380.X == ItemData.X and v380.Y == ItemData.Y) then
        return false;
    end;

    p377._loadedBodyID = nil;
    p377:UpdateChestRigGridSize(v379);

    return true;
end;

function u6.EnsureBattleBeltGridSized(p381) -- Line: 4570
    -- upvalues: ItemDatabase (copy)
    local v382 = p381.BeltGearSlot and p381.BeltGearSlot.Item;
    local v383 = v382 and v382.Metadata and v382.Metadata.ID;

    if not v383 then
        return false;
    end;

    local ItemData = ItemDatabase.GetItemData(v383);

    if ItemData then
        ItemData = ItemData.SlotSize;
    end;

    if not ItemData then
        return false;
    end;

    local v384 = p381.BattleBeltInventory and p381.BattleBeltInventory.GridSize;

    if v384 and (v384.X == ItemData.X and v384.Y == ItemData.Y) then
        return false;
    end;

    p381._loadedBeltGearID = nil;
    p381:UpdateBattleBeltGridSize(v383);

    return true;
end;

function u6.UpdateBackpackGridSize(p385, p386) -- Line: 4586
    -- upvalues: ItemDatabase (copy), GridPack (copy), Players (copy)
    local v387;

    if p386 then
        v387 = ItemDatabase.GetItemData(p386);
    else
        v387 = p386;
    end;

    local v388 = v387 and v387.SlotSize or Vector2.new(0, 0);

    if p386 ~= nil and (p385._loadedBackpackID == p386 and p385.MainInventory) then
        return;
    end;

    p385._loadedBackpackID = p386;

    if p385.MainInventory then
        p385:ClearGridPackInventory(p385.MainInventory);

        if p385.MainInventory.GuiElement then
            p385.MainInventory.GuiElement:Destroy();
        end;

        p385.MainInventory = nil;
    end;

    if v388.X <= 0 or v388.Y <= 0 then
        print("Backpack internal grid hidden - no backpack equipped");
        p385:UpdateInventoryCanvas();
        p385:RepositionInventorySections();

        return;
    end;

    if p385.BackpackSectionFrame then
        p385.BackpackSectionFrame.ClipsDescendants = false;
    end;

    if p385.BackpackGridFrame then
        p385.BackpackGridFrame.ClipsDescendants = false;
    end;

    p385.MainInventory = GridPack.createGrid({
        Visible = true,
        SlotAspectRatio = 1,
        Parent = p385.BackpackGridFrame,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = v388,
        Size = UDim2.fromScale(v388.X, v388.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = "BackpackInternal_" .. Players.LocalPlayer.UserId,
            MaxItemWidth = v387 and v387.MaxItemWidth or nil
        }
    });
    p385:PatchGridForOversizedItems(p385.MainInventory);
    p385:StyleGridContainer(p385.MainInventory);
    p385.MainInventory.IsColliding = p385:CreateGridIsColliding();
    p385.MainInventory:ConnectTransferLink(p385.TransferLink);
    print(string.format("Backpack internal grid created - GridSize: %s", (tostring(v388))));
    p385:RepositionInventorySections();
    p385:UpdateInventoryCanvas();
end;

function u6.UpdateChestRigGridSize(p389, p390) -- Line: 4651
    -- upvalues: ItemDatabase (copy), ItemIconStyle (copy), GridPack (copy), Players (copy)
    local v391;

    if p390 then
        v391 = ItemDatabase.GetItemData(p390);
    else
        v391 = p390;
    end;

    local v392 = v391 and v391.SlotSize or Vector2.new(0, 0);

    if p390 ~= nil and (p389._loadedBodyID == p390 and p389.ChestRigInventory) then
        return;
    end;

    p389._loadedBodyID = p390;

    if p389.ChestRigInventory then
        p389:ClearGridPackInventory(p389.ChestRigInventory);

        if p389.ChestRigInventory.GuiElement then
            p389.ChestRigInventory.GuiElement:Destroy();
        end;

        p389.ChestRigInventory = nil;
    end;

    if v391 and v391.ImageID then
        p389.ChestRigPattern.Image = v391.ImageID;
        p389.ChestRigPattern.ImageTransparency = 0.15;
        p389.ChestRigPattern.ScaleType = ItemIconStyle.ScaleTypeFor(v391);
        p389.ChestRigPattern.Visible = true;
    else
        p389.ChestRigPattern.Visible = false;
    end;

    if v392.X <= 0 or v392.Y <= 0 then
        print("Chest rig internal grid hidden - no body gear equipped");
        p389:RepositionInventorySections();

        return;
    end;

    local createGrid = GridPack.createGrid;
    local v393 = {
        Visible = true,
        SlotAspectRatio = 1,
        Parent = p389.ChestRigGridFrame,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = v392,
        Size = UDim2.fromScale(v392.X, v392.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0)
    };
    local v394 = {
        TiedInstance = "ChestRigInternal_" .. Players.LocalPlayer.UserId
    };
    local v395;

    if v391 then
        v395 = v391.MaxItemWidth or nil;
    else
        v395 = nil;
    end;

    v394.MaxItemWidth = v395;
    v393.Metadata = v394;
    p389.ChestRigInventory = createGrid(v393);
    p389:PatchGridForOversizedItems(p389.ChestRigInventory);
    p389:StyleGridContainer(p389.ChestRigInventory);
    p389.ChestRigInventory.IsColliding = p389:CreateGridIsColliding();
    p389.ChestRigInventory:ConnectTransferLink(p389.TransferLink);

    if v391 and (v391.MaxItemWidth and p389.ChestRigInventory.GuiElement) then
        p389:AddPouchDividers(p389.ChestRigInventory, v392, v391.MaxItemWidth);
    end;

    print(string.format("Chest rig internal grid created - GridSize: %s", (tostring(v392))));
    p389:RepositionInventorySections();
end;

function u6.UpdateBattleBeltGridSize(p396, p397) -- Line: 4711
    -- upvalues: ItemDatabase (copy), GridPack (copy), Players (copy)
    local v398;

    if p397 then
        v398 = ItemDatabase.GetItemData(p397);
    else
        v398 = p397;
    end;

    local v399 = v398 and v398.SlotSize or Vector2.new(0, 0);

    if p397 ~= nil and (p396._loadedBeltGearID == p397 and p396.BattleBeltInventory) then
        return;
    end;

    p396._loadedBeltGearID = p397;

    if p396.BattleBeltInventory then
        p396:ClearGridPackInventory(p396.BattleBeltInventory);

        if p396.BattleBeltInventory.GuiElement then
            p396.BattleBeltInventory.GuiElement:Destroy();
        end;

        p396.BattleBeltInventory = nil;
    end;

    if v399.X <= 0 or v399.Y <= 0 then
        for _, child in pairs(p396.BattleBeltGridFrame:GetChildren()) do
            if child:IsA("CanvasGroup") then
                child:Destroy();
            end;
        end;

        print("Battle belt internal grid hidden - no belt gear equipped");
        p396:RepositionInventorySections();

        return;
    end;

    local createGrid = GridPack.createGrid;
    local v400 = {
        Visible = true,
        SlotAspectRatio = 1,
        Parent = p396.BattleBeltGridFrame,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = v399,
        Size = UDim2.fromScale(v399.X, v399.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0)
    };
    local v401 = {
        TiedInstance = "BattleBeltInternal_" .. Players.LocalPlayer.UserId
    };
    local v402;

    if v398 then
        v402 = v398.MaxItemWidth or nil;
    else
        v402 = nil;
    end;

    v401.MaxItemWidth = v402;
    v400.Metadata = v401;
    p396.BattleBeltInventory = createGrid(v400);
    p396:PatchGridForOversizedItems(p396.BattleBeltInventory);
    p396:StyleGridContainer(p396.BattleBeltInventory);
    p396.BattleBeltInventory.IsColliding = p396:CreateGridIsColliding();
    p396.BattleBeltInventory:ConnectTransferLink(p396.TransferLink);

    if v398 and (v398.MaxItemWidth and p396.BattleBeltInventory.GuiElement) then
        p396:AddPouchDividers(p396.BattleBeltInventory, v399, v398.MaxItemWidth);
    end;

    print(string.format("Battle belt internal grid created - GridSize: %s", (tostring(v399))));
    p396:RepositionInventorySections();
end;

function u6.RepositionInventorySections(p403) -- Line: 4767
end;

function u6._startLootAudio(u404) -- Line: 4777
    -- upvalues: ReplicatedStorage (copy), pickSound (copy), Players (copy)
    local InventorySounds2 = ReplicatedStorage:FindFirstChild("InventorySounds");
    local v405 = InventorySounds2 and InventorySounds2:FindFirstChild("Looting");
    local u406 = v405;

    if not u406 then
        return;
    end;

    local function playInside(p407) -- Line: 4783
        -- upvalues: pickSound (ref), u406 (ref), Players (ref)
        local v408 = pickSound(u406, p407);

        if not v408 then
            return;
        end;

        local u409 = v408:Clone();
        u409.Parent = Players.LocalPlayer.PlayerGui;
        u409:Play();
        u409.Ended:Once(function() -- Line: 4789
            -- upvalues: u409 (copy)
            u409:Destroy();
        end);
        task.delay(3, function() -- Line: 4790
            -- upvalues: u409 (copy)
            if u409.Parent then
                u409:Destroy();
            end;
        end);
    end;

    local u410 = {};

    for _, child in ipairs(u406:GetChildren()) do
        if child:IsA("Sound") and (child.Name:sub(1, 9) == "Searching" and child.SoundId ~= "") then
            table.insert(u410, child.Name);
        end;
    end;

    local function playRandomSearch() -- Line: 4799
        -- upvalues: u410 (copy), playInside (copy)
        if #u410 == 0 then
            return;
        end;

        playInside(u410[math.random(1, #u410)]);
    end;

    if #u410 ~= 0 then
        playInside(u410[math.random(1, #u410)]);
    end;

    u404._lootRummageActive = true;
    task.delay(0.7, function() -- Line: 4813
        -- upvalues: u404 (copy), playInside (copy)
        if not u404._lootRummageActive then
            return;
        end;

        local v411 = 0;

        if u404.StorageInventory and u404.StorageInventory.Items then
            for _ in pairs(u404.StorageInventory.Items) do
                v411 = v411 + 1;
            end;
        end;

        if v411 > 0 then
            playInside("Reveal");
        end;
    end);
    task.spawn(function() -- Line: 4822
        -- upvalues: u404 (copy), u410 (copy), playInside (copy)
        local v412 = 0;

        if u404.StorageInventory and u404.StorageInventory.Items then
            for _ in pairs(u404.StorageInventory.Items) do
                v412 = v412 + 1;
            end;
        end;

        local v413 = os.clock() + math.random(3, 5);

        while u404._lootRummageActive do
            task.wait(0.4);

            if not u404._lootRummageActive then
                break;
            end;

            local os_clock_ret = os.clock();
            local v414 = 0;

            if u404.StorageInventory and u404.StorageInventory.Items then
                for _ in pairs(u404.StorageInventory.Items) do
                    v414 = v414 + 1;
                end;
            end;

            if v414 < v412 then
                if #u410 ~= 0 then
                    playInside(u410[math.random(1, #u410)]);
                end;

                v413 = os_clock_ret + math.random(3, 5);
            end;

            if v413 <= os_clock_ret then
                if #u410 ~= 0 then
                    playInside(u410[math.random(1, #u410)]);
                end;

                v413 = os_clock_ret + math.random(3, 5);
            end;

            v412 = v414;
        end;
    end);
end;

function u6.CloseStorage(u415) -- Line: 4849
    -- upvalues: ReplicatedStorage (copy), Players (copy)
    u415._lootRummageActive = false;
    local OpenableContainer = require(ReplicatedStorage:WaitForChild("OpenableContainer"));
    local v416 = u415.StorageInventory and u415.StorageInventory.Metadata and u415.StorageInventory.Metadata.TiedInstance;
    OpenableContainer.CloseForParent(v416);

    if u415.CurrentBodyTied and u415.CurrentBodyTied ~= v416 then
        OpenableContainer.CloseForParent(u415.CurrentBodyTied);
    end;

    if u415.SellPanelFrame then
        pcall(function() -- Line: 4872
            -- upvalues: ReplicatedStorage (ref)
            ReplicatedStorage.Remotes.CloseTrader:FireServer();
        end);
        u415:DestroySellPanel();
        task.delay(0.15, function() -- Line: 4874
            -- upvalues: u415 (copy)
            u415:RefreshAllPlayerInventories();
        end);
    end;

    if u415.BuyCartFrame then
        u415:DestroyBuyCart();
    end;

    if u415.CartPanelFrame then
        u415:DestroyCartPanel();
    end;

    u415.CurrentTraderNPC = nil;
    u415.CurrentTraderProfile = nil;

    if u415.StorageInventory then
        u415.StorageInventory:SetVisibility(false);
        u415:ClearGridPackInventory(u415.StorageInventory);

        if u415.StorageInventory.Metadata then
            u415.StorageInventory.Metadata.TiedInstance = nil;
        end;
    end;

    local BodyScroll = u415.CrateGridFrame:FindFirstChild("BodyScroll");

    if BodyScroll then
        BodyScroll:Destroy();
    end;

    local v417 = u415.CurrentStoragePart ~= nil;
    u415.CurrentStoragePart = nil;

    if u415.CurrentBodyTied then
        ReplicatedStorage.Remotes.ReleaseBodyLock:FireServer(u415.CurrentBodyTied);
        u415.CurrentBodyTied = nil;
    end;

    pcall(function() -- Line: 4907
        -- upvalues: ReplicatedStorage (ref)
        ReplicatedStorage.Remotes.StorageInventoryClosed:FireServer();
    end);
    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if v417 and (InventoryGui and InventoryGui.Enabled) then
        u415:LoadVicinity();
    end;
end;

function u6.LoadVicinity(p418) -- Line: 4918
    -- upvalues: Players (copy), ReplicatedStorage (copy), GridPack (copy)
    local v419 = p418.SafezoneTier == "Full" and p418.SafezoneViewMode == "stash";
    Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.ContainerFrame.CrateFrame.Title.TextLabel.Text = v419 and "PERSONAL STASH" or "VICINITY";
    p418._vicinityEpoch = (p418._vicinityEpoch or 0) + 1;
    local _vicinityEpoch = p418._vicinityEpoch;
    os.clock();
    local v420 = nil;

    if v419 then
        local success, result = pcall(function() -- Line: 4969
            -- upvalues: ReplicatedStorage (ref)
            return ReplicatedStorage.Remotes.GetStashInventory:InvokeServer();
        end);

        if p418._vicinityEpoch ~= _vicinityEpoch then
            return;
        end;

        if success then
            v420 = result or v420;
        end;
    end;

    if not v420 then
        v420 = ReplicatedStorage.Remotes.GetVicinityItems:InvokeServer();

        if p418._vicinityEpoch ~= _vicinityEpoch then
            return;
        end;
    end;

    if not (v420 and v420.Items) then
        local v421 = v419 and "Stash_" .. Players.LocalPlayer.UserId or "Vicinity_" .. Players.LocalPlayer.UserId;
        local v422 = v419 and Vector2.new(4, 4) or Vector2.new(7, 12);
        v420 = {
            Items = {},
            GridSize = v422,
            TiedInstance = v421
        };
    end;

    if p418.StorageInventory and (p418.StorageInventory.Metadata and (p418.StorageInventory.Metadata.TiedInstance == v420.TiedInstance and (p418.StorageInventory.GridSize and (v420.GridSize and (p418.StorageInventory.GridSize.X == v420.GridSize.X and p418.StorageInventory.GridSize.Y == v420.GridSize.Y))))) then
        p418:LoadInventory(p418.StorageInventory, v420);

        if p418._expansionPanel and p418._expansionPanel.Visible then
            p418:_refreshExpansionPanel();
        end;

        return;
    end;

    if p418.StorageInventory then
        p418:ClearGridPackInventory(p418.StorageInventory);

        if p418.StorageInventory.GuiElement then
            p418.StorageInventory.GuiElement:Destroy();
        end;

        p418.StorageInventory = nil;
    end;

    for _, child in pairs(p418.CrateGridFrame:GetChildren()) do
        if child:IsA("CanvasGroup") then
            child:Destroy();
        end;
    end;

    local v423 = false;

    for _, v in pairs(v420.Items) do
        if v then
            v423 = true;
            break;
        end;
    end;

    if not v423 then
        local v424 = v420.GridSize or Vector2.new(7, 12);
        p418.StorageInventory = GridPack.createGrid({
            Visible = true,
            SlotAspectRatio = 1,
            Parent = p418.CrateGridFrame,
            Assets = {
                Slot = game.ReplicatedStorage.GridPack.Slot
            },
            GridSize = v424,
            Size = UDim2.fromScale(v424.X, v424.Y),
            AnchorPoint = Vector2.new(0, 0),
            Position = UDim2.new(0, 0, 0, 0),
            Metadata = {
                TiedInstance = v420.TiedInstance
            }
        });
        p418:PatchGridForOversizedItems(p418.StorageInventory);
        p418:StyleGridContainer(p418.StorageInventory);
        p418.StorageInventory.IsColliding = p418:CreateGridIsColliding();
        p418.StorageInventory:ConnectTransferLink(p418.TransferLink);

        if p418._expansionPanel and p418._expansionPanel.Visible then
            p418:_refreshExpansionPanel();
        end;

        return;
    end;

    local v425 = v420.GridSize or Vector2.new(4, 4);
    p418.StorageInventory = GridPack.createGrid({
        Visible = true,
        SlotAspectRatio = 1,
        Parent = p418.CrateGridFrame,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = v425,
        Size = UDim2.fromScale(v425.X, v425.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = v420.TiedInstance
        }
    });
    p418:PatchGridForOversizedItems(p418.StorageInventory);
    p418:StyleGridContainer(p418.StorageInventory);
    p418.StorageInventory.IsColliding = p418:CreateGridIsColliding();
    p418.StorageInventory:ConnectTransferLink(p418.TransferLink);
    p418:LoadInventory(p418.StorageInventory, v420);

    if p418._expansionPanel and p418._expansionPanel.Visible then
        p418:_refreshExpansionPanel();
    end;
end;

function u6.OpenBodyLoot(p426, p427) -- Line: 5130
    -- upvalues: ReplicatedStorage (copy), Players (copy), UserInputService (copy), GridPack (copy)
    local v428 = ReplicatedStorage.Remotes.LootBody:InvokeServer(p427);

    if not (v428 and v428.ok) then
        local v429 = v428 and v428.reason or "missing";

        if v429:sub(1, 10) == "locked_by:" then
            p426:ShowToast("Being looted by " .. v429:sub(11));

            return;
        end;

        if v429 == "insurance_hold" then
            p426:ShowToast("This body is not lootable yet");

            return;
        end;

        p426:ShowToast("Body is gone");

        return;
    end;

    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if InventoryGui and not InventoryGui.Enabled then
        InventoryGui.Enabled = true;
        local InventoryBlur = game.Lighting:FindFirstChild("InventoryBlur");

        if InventoryBlur then
            InventoryBlur.Enabled = true;
        end;

        require(Players.LocalPlayer.PlayerScripts:WaitForChild("PlayerModule")):GetControls():Disable();
        p426._savedCameraMode = Players.LocalPlayer.CameraMode;
        Players.LocalPlayer.CameraMode = Enum.CameraMode.Classic;

        if p426._mouseUnlockConn then
            p426._mouseUnlockConn:Disconnect();
            p426._mouseUnlockConn = nil;
        end;

        p426._mouseUnlockConn = game:GetService("RunService").RenderStepped:Connect(function() -- Line: 5162
            -- upvalues: UserInputService (ref)
            if UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default then
                UserInputService.MouseBehavior = Enum.MouseBehavior.Default;
            end;

            if not UserInputService.MouseIconEnabled then
                UserInputService.MouseIconEnabled = true;
            end;
        end);
    end;

    p426.CurrentStoragePart = p427;
    p426.CurrentBodyTied = v428.tiedInstance;
    Players.LocalPlayer.PlayerGui.InventoryGui.MainFrame.ContainerFrame.CrateFrame.Title.TextLabel.Text = string.upper(v428.victimName) .. "\'S BODY";

    if p426.StorageInventory then
        p426:ClearGridPackInventory(p426.StorageInventory);

        if p426.StorageInventory.GuiElement then
            p426.StorageInventory.GuiElement:Destroy();
        end;

        p426.StorageInventory = nil;
    end;

    for _, child in pairs(p426.CrateGridFrame:GetChildren()) do
        if child:IsA("CanvasGroup") then
            child:Destroy();
        end;
    end;

    local BodyScroll = p426.CrateGridFrame:FindFirstChild("BodyScroll");

    if BodyScroll then
        BodyScroll:Destroy();
    end;

    local gridSize = v428.gridSize;
    local CrateGridFrame = p426.CrateGridFrame;
    local UDim2_fromScale_ret = UDim2.fromScale(gridSize.X, gridSize.Y);

    if gridSize.Y > 10 then
        CrateGridFrame = Instance.new("ScrollingFrame");
        CrateGridFrame.Name = "BodyScroll";
        CrateGridFrame.BackgroundTransparency = 1;
        CrateGridFrame.BorderSizePixel = 0;
        CrateGridFrame.ClipsDescendants = true;
        CrateGridFrame.Active = true;
        CrateGridFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
        CrateGridFrame.ScrollBarThickness = 6;
        CrateGridFrame.ScrollBarImageTransparency = 0.4;
        CrateGridFrame.CanvasSize = UDim2.new();
        CrateGridFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        CrateGridFrame.Size = UDim2.fromScale(gridSize.X, 10);
        CrateGridFrame.Position = UDim2.new(0, 0, 0, 0);
        CrateGridFrame.Parent = p426.CrateGridFrame;
        UDim2_fromScale_ret = UDim2.fromScale(1, gridSize.Y / 10);
    end;

    p426.StorageInventory = GridPack.createGrid({
        Visible = true,
        SlotAspectRatio = 1,
        Parent = CrateGridFrame,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = v428.gridSize,
        Size = UDim2_fromScale_ret,
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = v428.tiedInstance
        }
    });
    p426:PatchGridForOversizedItems(p426.StorageInventory);
    p426:StyleGridContainer(p426.StorageInventory);
    p426.StorageInventory.IsColliding = p426:CreateGridIsColliding();
    p426.StorageInventory:ConnectTransferLink(p426.TransferLink);
    p426:LoadInventory(p426.StorageInventory, {
        Items = v428.items,
        GridSize = v428.gridSize,
        TiedInstance = v428.tiedInstance
    });
    p426:_startLootAudio();
end;

function u6.DestroyBuyCart(p430) -- Line: 5272
    if p430.BuyCartFrame then
        p430.BuyCartFrame:Destroy();
    end;

    p430.BuyCartFrame = nil;
    p430.BuyCartList = nil;
    p430.BuyCartTotalLabel = nil;
    p430.BuyCart = {};
    p430:_destroyCartGhosts();
end;

function u6._destroyCartGhosts(p431) -- Line: 5281
    for _, v in ipairs(p431.BuyCartGhosts or {}) do
        if v and (v.ghost and v.ghost.Parent) then
            v.ghost:Destroy();
        end;
    end;

    p431.BuyCartGhosts = {};
end;

function u6._predictCartGhostSlots(p432) -- Line: 5291
    -- upvalues: dbgCartGhost (copy), ItemDatabase (copy)
    local v433 = p432.BuyCart or {};

    if #v433 == 0 then
        return {};
    end;

    local v434 = {
        {
            name = "Pockets",
            g = p432.LocalInventory
        },
        {
            name = "ChestRig",
            g = p432.ChestRigInventory
        },
        {
            name = "Belt",
            g = p432.BattleBeltInventory
        },
        {
            name = "Backpack",
            g = p432.MainInventory
        }
    };
    local u435 = {};

    for _, v in ipairs(v434) do
        local g = v.g;

        if g and g.GridSize then
            u435[g] = {};

            if g.Items then
                local v436 = v;

                for i, v2 in pairs(g.Items) do
                    if v2 and v2.Metadata then
                        dbgCartGhost(string.format("[Ghost] %s tile[%s] id=%s pos=%s metadataPos=%s", v436.name, tostring(i), tostring(v2.Metadata.ID), tostring(v2.Position), (tostring(v2.Metadata.Position))));
                    end;

                    if v2 and (v2.Metadata and v2.Position) then
                        local ItemData = ItemDatabase.GetItemData(v2.Metadata.ID);

                        if ItemData and ItemData.Size then
                            local X = v2.Position.X;
                            local Y = v2.Position.Y;
                            local X2 = ItemData.Size.X;
                            local Y2 = ItemData.Size.Y;

                            if (v2.Rotation == 1 or (v2.Rotation == 3 or v2.Rotation == 90)) and true or v2.Rotation == 270 then
                                local v437 = X2;
                                X2 = Y2;
                                Y2 = v437;
                            end;

                            for i2 = 0, Y2 - 1 do
                                local v438 = i2;

                                for i3 = 0, X2 - 1 do
                                    u435[g][X + i3 .. "," .. Y + v438] = true;
                                    local _ = i3;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    local v439 = {
        HeadGear = p432.HeadSlot,
        FaceWear = p432.FaceWearSlot,
        EyeWear = p432.EyeWearSlot,
        BodyGear = p432.BodySlot,
        BeltGear = p432.BeltGearSlot,
        Primary = p432.PrimarySlot,
        Secondary = p432.SecondarySlot,
        Sidearm = p432.SidearmSlot,
        Melee = p432.MeleeSlot,
        Uniform = p432.UniformSlot,
        Backpack = p432.BackpackSlot,
        NightOptical = p432.NightOpticalSlot
    };
    local u440 = {};

    local function fitsAt(p441, p442, p443) -- Line: 5342
        -- upvalues: u435 (copy)
        if p442.X < 0 or p442.Y < 0 then
            return false;
        end;

        if p441.GridSize.X < p442.X + p443.X or p441.GridSize.Y < p442.Y + p443.Y then
            return false;
        end;

        for i = 0, p443.Y - 1 do
            local v444 = i;

            for i2 = 0, p443.X - 1 do
                if u435[p441][p442.X + i2 .. "," .. p442.Y + v444] then
                    return false;
                end;

                local _ = i2;
            end;
        end;

        return true;
    end;

    local function markOccupied(p445, p446, p447) -- Line: 5353
        -- upvalues: u435 (copy)
        for i = 0, p447.Y - 1 do
            local v448 = i;

            for i2 = 0, p447.X - 1 do
                u435[p445][p446.X + i2 .. "," .. p446.Y + v448] = true;
                local _ = i2;
            end;
        end;
    end;

    local v449 = {};

    for i, v in ipairs(v433) do
        local ItemData = ItemDatabase.GetItemData(v.itemID);

        if ItemData and ItemData.Size then
            local v450 = i;
            local v451 = v;

            for i2 = 1, v.qty or 1 do
                local v452 = false;
                local v453;

                if ItemData.ItemType == "StorageBox" then
                    v453 = i2;
                else
                    local v454 = v439[ItemData.ItemType];

                    local function _(p455) -- Line: 5374
                        -- upvalues: u440 (copy)
                        return p455 and not p455.Item and not u440[p455];
                    end;

                    if not (v454 and not v454.Item and not u440[v454]) and ItemData.ItemType == "Primary" then
                        v454 = v439.Secondary;
                    end;

                    if v454 and not v454.Item and not u440[v454] then
                        u440[v454] = true;
                        table.insert(v449, {
                            slot = v454,
                            dbInfo = ItemData,
                            cartIndex = v450
                        });
                        v452 = true;
                    end;

                    if not v452 and (({
                        Backpack = true,
                        BodyGear = true,
                        BeltGear = true
                    })[ItemData.ItemType] and (v454 and (v454.Item and not u440[v454]))) then
                        u440[v454] = true;
                        table.insert(v449, {
                            isSwap = true,
                            slot = v454,
                            dbInfo = ItemData,
                            cartIndex = v450
                        });
                        v452 = true;
                    end;

                    if v452 then
                        v453 = i2;
                    else
                        if v451.preferredGrid and (v451.preferredPos and (u435[v451.preferredGrid] and fitsAt(v451.preferredGrid, v451.preferredPos, ItemData.Size))) then
                            markOccupied(v451.preferredGrid, v451.preferredPos, ItemData.Size);
                            table.insert(v449, {
                                grid = v451.preferredGrid,
                                position = v451.preferredPos,
                                dbInfo = ItemData,
                                cartIndex = v450
                            });
                            v452 = true;
                        end;

                        if v452 then
                            v453 = i2;
                        else
                            v453 = i2;

                            for _, v2 in ipairs(v434) do
                                if v452 then
                                    break;
                                end;

                                local g = v2.g;

                                if g and (g.GridSize and u435[g]) then
                                    local X = g.GridSize.X;
                                    local Y = g.GridSize.Y;
                                    local v456 = ItemDatabase.WidthCapFor(ItemData, g.Metadata and g.Metadata.MaxItemWidth);
                                    local X2 = ItemData.Size.X;
                                    local Y2 = ItemData.Size.Y;
                                    local v457 = 0;
                                    local v458 = true;

                                    if v456 then
                                        if v456 < X2 and v456 < Y2 then
                                            local v459 = X2;
                                            X2 = Y2;
                                            Y2 = v459;
                                            v458 = false;
                                        elseif v456 < X2 then
                                            v457 = 1;
                                        else
                                            local v460 = X2;
                                            X2 = Y2;
                                            Y2 = v460;
                                        end;
                                    else
                                        local v461 = X2;
                                        X2 = Y2;
                                        Y2 = v461;
                                    end;

                                    if v458 then
                                        for i3 = 0, Y - 1 do
                                            if v452 then
                                                break;
                                            end;

                                            local v462 = i3;

                                            for i4 = 0, X - 1 do
                                                local v463;

                                                if i4 + Y2 <= X and v462 + X2 <= Y then
                                                    v463 = i4;
                                                    local v464 = true;

                                                    for i5 = 0, X2 - 1 do
                                                        local v465 = i5;

                                                        for i6 = 0, Y2 - 1 do
                                                            if u435[g][v463 + i6 .. "," .. v462 + v465] then
                                                                v464 = false;
                                                                break;
                                                            end;

                                                            local _ = i6;
                                                        end;

                                                        if not v464 then
                                                            break;
                                                        end;
                                                    end;

                                                    if v464 then
                                                        for i5 = 0, X2 - 1 do
                                                            local v466 = i5;

                                                            for i6 = 0, Y2 - 1 do
                                                                u435[g][v463 + i6 .. "," .. v462 + v466] = true;
                                                                local _ = i6;
                                                            end;
                                                        end;

                                                        local v467 = {
                                                            grid = g,
                                                            position = Vector2.new(v463, v462),
                                                            dbInfo = ItemData,
                                                            cartIndex = v450,
                                                            rotation = v457
                                                        };
                                                        table.insert(v449, v467);
                                                        v452 = true;
                                                    end;
                                                else
                                                    v463 = i4;
                                                end;
                                            end;
                                        end;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end;
            end;
        end;
    end;

    return v449;
end;

function u6.RefreshCartGhosts(u468) -- Line: 5469
    -- upvalues: ScaleTypeFor (copy)
    u468:_destroyCartGhosts();
    local v469 = u468:_predictCartGhostSlots();

    for _, v in ipairs(v469) do
        if v.slot then
            local GuiElement = v.slot.GuiElement;

            if GuiElement then
                GuiElement = GuiElement.Parent;
            end;

            if GuiElement then
                local TextButton = Instance.new("TextButton");
                TextButton.Name = "BuyGhost";
                TextButton.Text = "";
                TextButton.AutoButtonColor = false;
                TextButton.AnchorPoint = Vector2.new(0, 0);
                TextButton.Position = UDim2.new(0, 0, 0, 0);
                TextButton.Size = UDim2.new(1, 0, 1, 0);
                TextButton.BackgroundColor3 = v.isSwap and Color3.fromRGB(70, 150, 185) or Color3.fromRGB(255, 220, 130);
                TextButton.BackgroundTransparency = 0.4;
                TextButton.BorderSizePixel = 0;
                TextButton.ZIndex = 50;
                TextButton.Active = true;
                TextButton.Parent = GuiElement;
                local UIStroke = Instance.new("UIStroke");
                UIStroke.Color = v.isSwap and Color3.fromRGB(140, 210, 235) or Color3.fromRGB(240, 220, 130);
                UIStroke.Thickness = 2;
                UIStroke.Transparency = 0.1;
                UIStroke.Parent = TextButton;

                if v.dbInfo.ImageID and v.dbInfo.ImageID ~= "" then
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Size = UDim2.new(1, -4, 1, -4);
                    ImageLabel.Position = UDim2.new(0, 2, 0, 2);
                    ImageLabel.BackgroundTransparency = 1;
                    ImageLabel.Image = v.dbInfo.ImageID;
                    ImageLabel.ImageTransparency = 0.45;
                    ImageLabel.ScaleType = ScaleTypeFor(v.dbInfo);
                    ImageLabel.Active = false;
                    ImageLabel.ZIndex = 51;
                    ImageLabel.Parent = TextButton;
                end;

                if v.isSwap then
                    local ImageLabel = Instance.new("ImageLabel");
                    ImageLabel.Name = "SwapIcon";
                    ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5);
                    ImageLabel.Position = UDim2.fromScale(0.5, 0.5);
                    ImageLabel.Size = UDim2.fromScale(0.55, 0.55);
                    ImageLabel.BackgroundTransparency = 1;
                    ImageLabel.Image = "rbxassetid://136287433764119";
                    ImageLabel.ScaleType = Enum.ScaleType.Fit;
                    ImageLabel.Active = false;
                    ImageLabel.ZIndex = 52;
                    ImageLabel.Parent = TextButton;
                end;

                local cartIndex = v.cartIndex;
                TextButton.MouseButton2Click:Connect(function() -- Line: 5530
                    -- upvalues: u468 (copy), cartIndex (copy)
                    local v470 = u468.BuyCart and u468.BuyCart[cartIndex];

                    if not v470 then
                        return;
                    end;

                    if (v470.qty or 1) > 1 then
                        v470.qty = v470.qty - 1;
                    else
                        table.remove(u468.BuyCart, cartIndex);
                    end;

                    u468:RefreshBuyCartRender();
                end);
                u468.BuyCartGhosts = u468.BuyCartGhosts or {};
                table.insert(u468.BuyCartGhosts, {
                    ghost = TextButton,
                    slot = v.slot
                });
            end;
        else
            local GuiElement = v.grid.GuiElement;

            if GuiElement and GuiElement.AbsoluteSize.X > 0 then
                local X = v.dbInfo.Size.X;
                local Y = v.dbInfo.Size.Y;

                if v.rotation ~= 1 then
                    local v471 = X;
                    X = Y;
                    Y = v471;
                end;

                local v472 = GuiElement.AbsoluteSize.X / v.grid.GridSize.X;
                local v473 = GuiElement.AbsoluteSize.Y / v.grid.GridSize.Y;
                local v474 = v.position.X * v472;
                local v475 = v.position.Y * v473;
                local v476 = Y * v472;
                local v477 = X * v473;
                local Parent = GuiElement.Parent;

                if Parent then
                    local _ = Parent.AbsoluteSize;
                    local v478 = GuiElement.AbsolutePosition.X - Parent.AbsolutePosition.X;
                    local v479 = GuiElement.AbsolutePosition.Y - Parent.AbsolutePosition.Y;
                    local TextButton = Instance.new("TextButton");
                    TextButton.Name = "BuyGhost";
                    TextButton.Text = "";
                    TextButton.AutoButtonColor = false;
                    TextButton.AnchorPoint = Vector2.new(0, 0);
                    TextButton.Position = UDim2.fromOffset(v478 + v474, v479 + v475);
                    TextButton.Size = UDim2.fromOffset(v476, v477);
                    TextButton.BackgroundColor3 = Color3.fromRGB(255, 220, 130);
                    TextButton.BackgroundTransparency = 0.4;
                    TextButton.BorderSizePixel = 0;
                    TextButton.ZIndex = 50;
                    TextButton.Active = true;
                    TextButton.Parent = Parent;
                    local cartIndex = v.cartIndex;
                    TextButton.MouseButton2Click:Connect(function() -- Line: 5589
                        -- upvalues: u468 (copy), cartIndex (copy)
                        local v480 = u468.BuyCart and u468.BuyCart[cartIndex];

                        if not v480 then
                            return;
                        end;

                        if (v480.qty or 1) > 1 then
                            v480.qty = v480.qty - 1;
                        else
                            table.remove(u468.BuyCart, cartIndex);
                        end;

                        u468:RefreshBuyCartRender();
                    end);
                    local UIStroke = Instance.new("UIStroke");
                    UIStroke.Color = Color3.fromRGB(240, 220, 130);
                    UIStroke.Thickness = 2;
                    UIStroke.Transparency = 0.1;
                    UIStroke.Parent = TextButton;

                    if v.dbInfo.ImageID and v.dbInfo.ImageID ~= "" then
                        local ImageLabel = Instance.new("ImageLabel");
                        ImageLabel.Size = UDim2.new(1, -4, 1, -4);
                        ImageLabel.Position = UDim2.new(0, 2, 0, 2);
                        ImageLabel.BackgroundTransparency = 1;
                        ImageLabel.Image = v.dbInfo.ImageID;
                        ImageLabel.ImageTransparency = 0.45;
                        ImageLabel.ScaleType = ScaleTypeFor(v.dbInfo);
                        ImageLabel.Active = false;
                        ImageLabel.ZIndex = 51;
                        ImageLabel.Parent = TextButton;
                    end;

                    u468.BuyCartGhosts = u468.BuyCartGhosts or {};
                    table.insert(u468.BuyCartGhosts, {
                        ghost = TextButton,
                        grid = v.grid,
                        position = v.position,
                        size = v.dbInfo.Size
                    });
                end;
            end;
        end;
    end;
end;

function u6.DestroyCartPanel(p481) -- Line: 5632
    if p481.CartPanelFrame then
        p481.CartPanelFrame:Destroy();
    end;

    p481.CartPanelFrame = nil;
    p481.CartTabBuyContent = nil;
    p481.CartTabSellContent = nil;
    p481.CartTabBuyButton = nil;
    p481.CartTabSellButton = nil;
end;

function u6.SwitchCartTab(p482, p483) -- Line: 5641
    p482.ActiveCartTab = p483;

    if p482.CartTabBuyContent then
        p482.CartTabBuyContent.Visible = p483 == "Buy";
    end;

    if p482.CartTabSellContent then
        p482.CartTabSellContent.Visible = p483 == "Sell";
    end;

    local Color3_fromRGB_ret2 = Color3.fromRGB(60, 60, 60);
    local Color3_fromRGB_ret3 = Color3.fromRGB(28, 28, 28);

    if p482.CartTabBuyButton then
        p482.CartTabBuyButton.BackgroundColor3 = p483 == "Buy" and Color3_fromRGB_ret2 and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
    end;

    if p482.CartTabSellButton then
        p482.CartTabSellButton.BackgroundColor3 = p483 == "Sell" and Color3_fromRGB_ret2 and Color3_fromRGB_ret2 or Color3_fromRGB_ret3;
    end;
end;

function u6.CreateCartPanel(u484) -- Line: 5656
    -- upvalues: Players (copy)
    u484:DestroyCartPanel();
    local InventoryGui = Players.LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("InventoryGui");

    if not InventoryGui then
        return;
    end;

    local ContainerFrame = InventoryGui.MainFrame:FindFirstChild("ContainerFrame");

    if not ContainerFrame then
        return;
    end;

    local v485 = 60;

    if u484.CrateGridFrame then
        local AbsoluteSize = u484.CrateGridFrame.AbsoluteSize;

        if AbsoluteSize and (AbsoluteSize.X > 0 and AbsoluteSize.Y > 0) then
            v485 = math.min(AbsoluteSize.X, AbsoluteSize.Y);
        end;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "TraderCartPanel";
    Frame.AnchorPoint = Vector2.new(0.5, 1);
    Frame.Position = UDim2.new(0.5, 0, 1, 0);
    Frame.Size = UDim2.new(1, 0, 0, v485 * 3 + 28 + 40 + 16 + 28);
    Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
    Frame.BackgroundTransparency = 0.15;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 30;
    Frame.Parent = ContainerFrame;
    u484.CartPanelFrame = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Size = UDim2.new(1, 0, 0, 28);
    Frame2.BackgroundTransparency = 1;
    Frame2.ZIndex = 31;
    Frame2.Parent = Frame;
    local TextButton = Instance.new("TextButton");
    TextButton.Size = UDim2.new(0.5, 0, 1, 0);
    TextButton.Position = UDim2.new(0, 0, 0, 0);
    TextButton.BorderSizePixel = 0;
    TextButton.Text = "BUY";
    TextButton.TextColor3 = Color3.fromRGB(240, 220, 130);
    TextButton.Font = Enum.Font.GothamBold;
    TextButton.TextSize = 14;
    TextButton.AutoButtonColor = false;
    TextButton.ZIndex = 32;
    TextButton.Parent = Frame2;
    u484.CartTabBuyButton = TextButton;
    local TextButton2 = Instance.new("TextButton");
    TextButton2.Size = UDim2.new(0.5, 0, 1, 0);
    TextButton2.Position = UDim2.new(0.5, 0, 0, 0);
    TextButton2.BorderSizePixel = 0;
    TextButton2.Text = "SELL";
    TextButton2.TextColor3 = Color3.fromRGB(240, 220, 130);
    TextButton2.Font = Enum.Font.GothamBold;
    TextButton2.TextSize = 14;
    TextButton2.AutoButtonColor = false;
    TextButton2.ZIndex = 32;
    TextButton2.Parent = Frame2;
    u484.CartTabSellButton = TextButton2;
    TextButton.MouseButton1Click:Connect(function() -- Line: 5720
        -- upvalues: u484 (copy)
        u484:SwitchCartTab("Buy");
    end);
    TextButton2.MouseButton1Click:Connect(function() -- Line: 5721
        -- upvalues: u484 (copy)
        u484:SwitchCartTab("Sell");
    end);
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "BuyContent";
    Frame3.Position = UDim2.new(0, 0, 0, 28);
    Frame3.Size = UDim2.new(1, 0, 1, -28);
    Frame3.BackgroundTransparency = 1;
    Frame3.ZIndex = 31;
    Frame3.Parent = Frame;
    u484.CartTabBuyContent = Frame3;
    local Frame4 = Instance.new("Frame");
    Frame4.Name = "SellContent";
    Frame4.Position = UDim2.new(0, 0, 0, 28);
    Frame4.Size = UDim2.new(1, 0, 1, -28);
    Frame4.BackgroundTransparency = 1;
    Frame4.ZIndex = 31;
    Frame4.Parent = Frame;
    u484.CartTabSellContent = Frame4;
    u484:SwitchCartTab("Buy");
end;

function u6.RefreshBuyCartRender(u486) -- Line: 5745
    if not u486.BuyCartList then
        return;
    end;

    for _, child in ipairs(u486.BuyCartList:GetChildren()) do
        if child:IsA("GuiObject") then
            child:Destroy();
        end;
    end;

    local v487 = 0;

    for i, v in ipairs(u486.BuyCart or {}) do
        v487 = v487 + (v.price or 0) * (v.qty or 1);
        local Frame = Instance.new("Frame");
        Frame.Name = "CartRow_" .. i;
        Frame.Size = UDim2.new(1, -4, 0, 28);
        Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35);
        Frame.BackgroundTransparency = 0.2;
        Frame.BorderSizePixel = 0;
        Frame.LayoutOrder = i;
        Frame.ZIndex = 32;
        Frame.Parent = u486.BuyCartList;
        local ImageLabel = Instance.new("ImageLabel");
        ImageLabel.Size = UDim2.new(0, 24, 0, 24);
        ImageLabel.Position = UDim2.new(0, 2, 0.5, 0);
        ImageLabel.AnchorPoint = Vector2.new(0, 0.5);
        ImageLabel.BackgroundTransparency = 1;
        ImageLabel.Image = v.imageID or "";
        ImageLabel.ZIndex = 33;
        ImageLabel.Parent = Frame;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Size = UDim2.new(1, -120, 1, 0);
        TextLabel.Position = UDim2.new(0, 30, 0, 0);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Text = (v.name or v.itemID) .. (v.qty > 1 and (" x" .. v.qty or "") or "");
        TextLabel.TextColor3 = Color3.fromRGB(220, 220, 220);
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.Font = Enum.Font.RobotoMono;
        TextLabel.TextSize = 13;
        TextLabel.ZIndex = 33;
        TextLabel.Parent = Frame;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Size = UDim2.new(0, 80, 1, 0);
        TextLabel2.Position = UDim2.new(1, -110, 0, 0);
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Text = string.format("₽%d", (v.price or 0) * (v.qty or 1));
        TextLabel2.TextColor3 = Color3.fromRGB(240, 220, 130);
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
        TextLabel2.Font = Enum.Font.RobotoMono;
        TextLabel2.TextSize = 13;
        TextLabel2.ZIndex = 33;
        TextLabel2.Parent = Frame;
        local TextButton = Instance.new("TextButton");
        TextButton.Size = UDim2.new(0, 22, 1, -4);
        TextButton.Position = UDim2.new(1, -24, 0, 2);
        TextButton.BackgroundColor3 = Color3.fromRGB(80, 40, 40);
        TextButton.BorderSizePixel = 0;
        TextButton.Text = "X";
        TextButton.TextColor3 = Color3.fromRGB(255, 200, 200);
        TextButton.Font = Enum.Font.GothamBold;
        TextButton.TextSize = 14;
        TextButton.ZIndex = 34;
        TextButton.Parent = Frame;
        TextButton.MouseButton1Click:Connect(function() -- Line: 5808
            -- upvalues: u486 (copy), i (copy)
            table.remove(u486.BuyCart, i);
            u486:RefreshBuyCartRender();
        end);
    end;

    if u486.BuyCartTotalLabel then
        u486.BuyCartTotalLabel.Text = string.format("TOTAL: ₽%d", v487);
    end;

    local v488 = u486.BuyCartList:FindFirstChildOfClass("UIListLayout");

    if v488 and u486.BuyCartList:IsA("ScrollingFrame") then
        u486.BuyCartList.CanvasSize = UDim2.new(0, 0, 0, v488.AbsoluteContentSize.Y + 4);
    end;

    u486:RefreshCartGhosts();
end;

function u6.CreateBuyCartPanel(u489, u490, p491) -- Line: 5824
    -- upvalues: ReplicatedStorage (copy)
    u489:DestroyBuyCart();
    u489.BuyCart = {};
    local CartTabBuyContent = u489.CartTabBuyContent;

    if not CartTabBuyContent then
        return;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "TraderBuyCart";
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 30;
    Frame.Parent = CartTabBuyContent;
    u489.BuyCartFrame = Frame;
    local ScrollingFrame = Instance.new("ScrollingFrame");
    ScrollingFrame.Name = "CartList";
    ScrollingFrame.Position = UDim2.new(0, 4, 0, 4);
    ScrollingFrame.Size = UDim2.new(1, -8, 1, -48);
    ScrollingFrame.BackgroundTransparency = 1;
    ScrollingFrame.BorderSizePixel = 0;
    ScrollingFrame.ScrollBarThickness = 4;
    ScrollingFrame.ZIndex = 31;
    ScrollingFrame.Parent = Frame;
    local UIListLayout = Instance.new("UIListLayout");
    UIListLayout.Padding = UDim.new(0, 2);
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
    UIListLayout.Parent = ScrollingFrame;
    u489.BuyCartList = ScrollingFrame;
    local Frame2 = Instance.new("Frame");
    Frame2.AnchorPoint = Vector2.new(0, 1);
    Frame2.Position = UDim2.new(0, 0, 1, 0);
    Frame2.Size = UDim2.new(1, 0, 0, 40);
    Frame2.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame2.BorderSizePixel = 0;
    Frame2.ZIndex = 31;
    Frame2.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(35, 35, 35), Color3.fromRGB(20, 20, 20));
    UIGradient.Parent = Frame2;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel.Position = UDim2.new(0.02, 0, 0.5, 0);
    TextLabel.Size = UDim2.new(0.5, -8, 0, 24);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "TOTAL: ₽0";
    TextLabel.TextColor3 = Color3.fromRGB(240, 220, 130);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextSize = 16;
    TextLabel.ZIndex = 32;
    TextLabel.Parent = Frame2;
    u489.BuyCartTotalLabel = TextLabel;
    local TextButton = Instance.new("TextButton");
    TextButton.AnchorPoint = Vector2.new(1, 0.5);
    TextButton.Position = UDim2.new(0.98, 0, 0.5, 0);
    TextButton.Size = UDim2.new(0.35, 0, 0, 28);
    TextButton.BackgroundColor3 = Color3.fromRGB(100, 90, 60);
    TextButton.BorderSizePixel = 0;
    TextButton.TextColor3 = Color3.new(1, 1, 1);
    TextButton.Font = Enum.Font.GothamBold;
    TextButton.TextSize = 14;
    TextButton.Text = "CONFIRM";
    TextButton.AutoButtonColor = true;
    TextButton.ZIndex = 33;
    TextButton.Parent = Frame2;
    TextButton.MouseButton1Click:Connect(function() -- Line: 5895
        -- upvalues: u489 (copy), ReplicatedStorage (ref), u490 (copy)
        if not u489.BuyCart or #u489.BuyCart == 0 then
            return;
        end;

        local u492 = {};

        for i, v in ipairs(u489.BuyCart) do
            local v493 = {
                itemID = v.itemID,
                qty = v.qty or 1
            };

            if v.preferredGrid and (v.preferredPos and v.preferredGrid.Metadata) then
                v493.preferredTied = v.preferredGrid.Metadata.TiedInstance;
                v493.preferredPos = {
                    X = v.preferredPos.X,
                    Y = v.preferredPos.Y
                };
            end;

            u492[i] = v493;
        end;

        local success, result = pcall(function() -- Line: 5906
            -- upvalues: ReplicatedStorage (ref), u490 (ref), u492 (copy)
            return ReplicatedStorage.Remotes.BuyBulk:InvokeServer(u490, u492);
        end);

        if success and result then
            if (result.bought or 0) > 0 then
                u489:ShowToast(string.format("Bought %d items for ₽%d", result.bought, result.totalCost or 0));
                u489.BuyCart = {};
                u489:RefreshBuyCartRender();
                u489:RefreshAllPlayerInventories();
            end;

            return;
        end;

        u489:ShowToast("Buy failed");
    end);
end;

function u6.AddToBuyCart(p494, p495, p496, p497, p498) -- Line: 5922
    -- upvalues: ItemDatabase (copy)
    local ItemData = ItemDatabase.GetItemData(p495);

    if not ItemData then
        return;
    end;

    p494.BuyCart = p494.BuyCart or {};

    if not p497 then
        for _, v in ipairs(p494.BuyCart) do
            if v.itemID == p495 and (v.price == p496 and not v.preferredGrid) then
                v.qty = (v.qty or 1) + 1;
                p494:RefreshBuyCartRender();

                return;
            end;
        end;
    end;

    table.insert(p494.BuyCart, {
        qty = 1,
        itemID = p495,
        name = ItemData.Name,
        price = p496,
        imageID = ItemData.ImageID,
        preferredGrid = p497,
        preferredPos = p498
    });
    p494:RefreshBuyCartRender();
end;

function u6.DestroySellPanel(u499) -- Line: 5949
    if u499.SellPanelGrid then
        pcall(function() -- Line: 5951
            -- upvalues: u499 (copy)
            u499.SellPanelGrid:Destroy();
        end);
        u499.SellPanelGrid = nil;
    end;

    if u499.SellPanelFrame then
        u499.SellPanelFrame:Destroy();
        u499.SellPanelFrame = nil;
    end;

    u499.SellPanelTotalLabel = nil;
end;

function u6.RefreshSellPanelTotal(p500) -- Line: 5963
    -- upvalues: ItemDatabase (copy), ConditionValue (copy)
    if not p500.SellPanelTotalLabel then
        return;
    end;

    local v501 = 0;
    local CurrentTraderProfile = p500.CurrentTraderProfile;
    local v502 = CurrentTraderProfile and CurrentTraderProfile.BuybackMultiplier or 0.6;
    local v503 = p500.SellPanelPriceLookup or {};

    if p500.SellPanelGrid and p500.SellPanelGrid.Items then
        for _, v in pairs(p500.SellPanelGrid.Items) do
            if v and (v.Metadata and v.Metadata.ID) then
                local ID = v.Metadata.ID;
                local v504 = v503[ID];

                if not v504 then
                    local ItemData = ItemDatabase.GetItemData(ID);

                    if ItemData and ItemData.BaseSellValue then
                        v504 = ItemData.BaseSellValue;
                    end;
                end;

                if v504 then
                    local ItemData = ItemDatabase.GetItemData(ID);
                    local v505 = v504 * v502 * ConditionValue.Multiplier(v, ItemData, ItemDatabase);
                    v501 = v501 + math.floor(v505);
                end;
            end;
        end;
    end;

    p500.SellPanelTotalLabel.Text = string.format("TOTAL: ₽%d", v501);
end;

function u6.RefreshAllPlayerInventories(p506) -- Line: 5994
    -- upvalues: ReplicatedStorage (copy)
    p506._refreshEpoch = (p506._refreshEpoch or 0) + 1;
    local _refreshEpoch = p506._refreshEpoch;
    local v507 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer();

    if p506._refreshEpoch ~= _refreshEpoch then
        return;
    end;

    if not v507 then
        return;
    end;

    if v507.Pockets and p506.LocalInventory then
        p506:LoadInventory(p506.LocalInventory, v507.Pockets);
    end;

    if v507.ChestRig and p506.ChestRigInventory then
        p506:LoadInventory(p506.ChestRigInventory, v507.ChestRig);
    end;

    if v507.BattleBelt and p506.BattleBeltInventory then
        p506:LoadInventory(p506.BattleBeltInventory, v507.BattleBelt);
    end;

    if v507.Backpack and p506.MainInventory then
        p506:LoadInventory(p506.MainInventory, v507.Backpack);
    end;
end;

function u6.CreateSellPanel(u508, u509, p510, p511, p512, p513) -- Line: 6021
    -- upvalues: GridPack (copy), ReplicatedStorage (copy)
    u508:DestroySellPanel();
    u508.SellPanelPriceLookup = p511 or {};
    local v514 = 60;

    if u508.CrateGridFrame then
        local AbsoluteSize = u508.CrateGridFrame.AbsoluteSize;

        if AbsoluteSize and (AbsoluteSize.X > 0 and AbsoluteSize.Y > 0) then
            v514 = math.min(AbsoluteSize.X, AbsoluteSize.Y);
        end;
    end;

    local v515 = p513 or Vector2.new(8, 3);
    local CartTabSellContent = u508.CartTabSellContent;

    if not CartTabSellContent then
        return;
    end;

    local v516 = v515.X * v514;
    local _ = v515.Y * v514;
    local Frame = Instance.new("Frame");
    Frame.Name = "TraderSellPanel";
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.BorderSizePixel = 0;
    Frame.ZIndex = 30;
    Frame.Parent = CartTabSellContent;
    u508.SellPanelFrame = Frame;
    local Frame2 = Instance.new("Frame");
    Frame2.Name = "GridFrame";
    Frame2.Size = UDim2.fromOffset(v514, v514);
    Frame2.AnchorPoint = Vector2.new(0, 0);
    Frame2.Position = UDim2.new(0.5, -v516 / 2, 0, 4);
    Frame2.BackgroundTransparency = 1;
    Frame2.ZIndex = 31;
    Frame2.Parent = Frame;
    local v517 = GridPack.createGrid({
        Visible = true,
        SlotAspectRatio = 1,
        Parent = Frame2,
        Assets = {
            Slot = ReplicatedStorage.GridPack.Slot
        },
        GridSize = v515,
        Size = UDim2.fromScale(v515.X, v515.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = {
            TiedInstance = p512 or "SellPanel",
            TraderNPC = u509
        }
    });
    u508:PatchGridForOversizedItems(v517);
    u508:StyleGridContainer(v517);
    v517.IsColliding = u508:CreateGridIsColliding();
    v517:ConnectTransferLink(u508.TransferLink);
    v517.MoveMiddleware = u508:CreateMoveMiddleware();
    u508.SellPanelGrid = v517;
    local Frame3 = Instance.new("Frame");
    Frame3.Name = "Footer";
    Frame3.AnchorPoint = Vector2.new(0, 1);
    Frame3.Position = UDim2.new(0, 0, 1, 0);
    Frame3.Size = UDim2.new(1, 0, 0, 40);
    Frame3.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
    Frame3.BackgroundTransparency = 0;
    Frame3.BorderSizePixel = 0;
    Frame3.ZIndex = 31;
    Frame3.Parent = Frame;
    local UIGradient = Instance.new("UIGradient");
    UIGradient.Color = ColorSequence.new(Color3.fromRGB(35, 35, 35), Color3.fromRGB(20, 20, 20));
    UIGradient.Parent = Frame3;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = "TotalLabel";
    TextLabel.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel.Position = UDim2.new(0.02, 0, 0.5, 0);
    TextLabel.Size = UDim2.new(0.5, -8, 0, 24);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.Text = "TOTAL: ₽0";
    TextLabel.TextColor3 = Color3.fromRGB(240, 220, 130);
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextSize = 16;
    TextLabel.ZIndex = 32;
    TextLabel.Parent = Frame3;
    u508.SellPanelTotalLabel = TextLabel;
    local TextButton = Instance.new("TextButton");
    TextButton.Name = "SellButton";
    TextButton.AnchorPoint = Vector2.new(1, 0.5);
    TextButton.Position = UDim2.new(0.98, 0, 0.5, 0);
    TextButton.Size = UDim2.new(0.35, 0, 0, 28);
    TextButton.BackgroundColor3 = Color3.fromRGB(70, 100, 70);
    TextButton.BorderSizePixel = 0;
    TextButton.TextColor3 = Color3.new(1, 1, 1);
    TextButton.Font = Enum.Font.GothamBold;
    TextButton.TextSize = 14;
    TextButton.Text = "SELL";
    TextButton.AutoButtonColor = true;
    TextButton.ZIndex = 33;
    TextButton.Parent = Frame3;
    TextButton.MouseButton1Click:Connect(function() -- Line: 6132
        -- upvalues: ReplicatedStorage (ref), u509 (copy), u508 (copy)
        local success, result = pcall(function() -- Line: 6133
            -- upvalues: ReplicatedStorage (ref), u509 (ref)
            return ReplicatedStorage.Remotes.SellFinalize:InvokeServer(u509);
        end);

        if not (success and result) then
            u508:ShowToast("Sell failed");

            return;
        end;

        if (result.sold or 0) > 0 then
            u508:ShowToast(string.format("Sold %d items for ₽%d", result.sold, result.totalPayout or 0));
        end;

        u508:RefreshSellPanelTotal();
    end);
end;

function u6.ShowToast(p518, p519) -- Line: 6147
    warn("[Toast] " .. p519);
    require(game:GetService("ReplicatedStorage"):WaitForChild("ToastUI")).Show(p519, nil, "bottom-center");
end;

function u6.StartVicinityRefresh(u520) -- Line: 6154
    -- upvalues: Players (copy), ReplicatedStorage (copy), InventoryWire (copy)
    u520:StopVicinityRefresh();
    u520._vicinityRefreshing = true;
    task.spawn(function() -- Line: 6158
        -- upvalues: u520 (copy), Players (ref), ReplicatedStorage (ref), InventoryWire (ref)
        while true do
            local v521, v522, v523, v524, v525, v526, v527;

            while true do
                if not u520._vicinityRefreshing then
                    return;
                end;

                task.wait(1.5);

                if not u520._vicinityRefreshing or u520.CurrentStoragePart then
                    break;
                end;

                local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

                if not (InventoryGui and InventoryGui.Enabled) then
                    break;
                end;

                if not (u520.StorageInventory and u520.StorageInventory.Items) then
                    break;
                end;

                local v528 = false;

                for _, v in pairs(u520.StorageInventory.Items) do
                    if v and (v.ItemElement and v.ItemElement.Parent == InventoryGui) then
                        v528 = true;
                        break;
                    end;
                end;

                if not v528 then
                    v521 = ReplicatedStorage.Remotes.GetVicinityItems:InvokeServer();

                    if v521 then
                        v522 = {};

                        if u520.StorageInventory and u520.StorageInventory.Items then
                            for _, v in pairs(u520.StorageInventory.Items) do
                                if v and v.Metadata then
                                    v522[v.Metadata.ID .. "_" .. (v.Metadata.ItemIndex or 0)] = true;
                                end;
                            end;
                        end;

                        v523 = InventoryWire.DecodeItems(v521.Items or {});
                        v524 = {};
                        v525 = false;

                        for i, v in pairs(v523) do
                            if v then
                                v526 = v.ID .. "_" .. i;
                                v524[v526] = true;

                                if not v522[v526] then
                                    v525 = true;
                                end;
                            end;
                        end;

                        v527 = false;

                        for i in pairs(v522) do
                            if not v524[i] then
                                v527 = true;
                                break;
                            end;
                        end;

                        if v525 then
                            u520:LoadVicinity();
                        elseif v527 and (u520.StorageInventory and u520.StorageInventory.Items) then
                            for _, v in pairs(u520.StorageInventory.Items) do
                                if v and (v.Metadata and not v524[v.Metadata.ID .. "_" .. (v.Metadata.ItemIndex or 0)]) then
                                    pcall(function() -- Line: 6235
                                        -- upvalues: u520 (ref), v (copy)
                                        u520.StorageInventory:RemoveItem(v);
                                        v:Destroy();
                                    end);
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            v521 = ReplicatedStorage.Remotes.GetVicinityItems:InvokeServer();

            if v521 then
                v522 = {};

                if u520.StorageInventory and u520.StorageInventory.Items then
                    for _, v in pairs(u520.StorageInventory.Items) do
                        if v and v.Metadata then
                            v522[v.Metadata.ID .. "_" .. (v.Metadata.ItemIndex or 0)] = true;
                        end;
                    end;
                end;

                v523 = InventoryWire.DecodeItems(v521.Items or {});
                v524 = {};
                v525 = false;

                for i, v in pairs(v523) do
                    if v then
                        v526 = v.ID .. "_" .. i;
                        v524[v526] = true;

                        if not v522[v526] then
                            v525 = true;
                        end;
                    end;
                end;

                v527 = false;

                for i in pairs(v522) do
                    if not v524[i] then
                        v527 = true;
                        break;
                    end;
                end;

                if v525 then
                    u520:LoadVicinity();
                elseif v527 and (u520.StorageInventory and u520.StorageInventory.Items) then
                    for _, v in pairs(u520.StorageInventory.Items) do
                        if v and (v.Metadata and not v524[v.Metadata.ID .. "_" .. (v.Metadata.ItemIndex or 0)]) then
                            pcall(function() -- Line: 6235
                                -- upvalues: u520 (ref), v (copy)
                                u520.StorageInventory:RemoveItem(v);
                                v:Destroy();
                            end);
                        end;
                    end;
                end;
            end;
        end;
    end);
end;

function u6.StopVicinityRefresh(p529) -- Line: 6248
    p529._vicinityRefreshing = false;
end;

function u6.CreateEquipmentSlot(u530, p531, u532) -- Line: 6252
    -- upvalues: GridPack (copy), ReplicatedStorage (copy), Players (copy)
    local v533 = GridPack.createSingleSlot({
        Visible = true,
        Parent = p531,
        Assets = {
            Slot = ReplicatedStorage.GridPack.SingleSlot
        },
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Size = UDim2.fromScale(1, 1)
    });
    v533.Metadata = {
        AcceptsType = u532,
        TiedInstance = ({
            HeadGear = "HeadGear_" .. Players.LocalPlayer.UserId,
            FaceWear = "FaceWear_" .. Players.LocalPlayer.UserId,
            EyeWear = "EyeWear_" .. Players.LocalPlayer.UserId,
            BodyGear = "BodyGear_" .. Players.LocalPlayer.UserId,
            BeltGear = "BeltGear_" .. Players.LocalPlayer.UserId,
            Primary = "Primary_" .. Players.LocalPlayer.UserId,
            Secondary = "Secondary_" .. Players.LocalPlayer.UserId,
            Sidearm = "Sidearm_" .. Players.LocalPlayer.UserId,
            Melee = "Melee_" .. Players.LocalPlayer.UserId,
            Uniform = "Uniform_" .. Players.LocalPlayer.UserId,
            Backpack = "BackpackSlot_" .. Players.LocalPlayer.UserId,
            NightOptical = "NightOptical_" .. Players.LocalPlayer.UserId
        })[u532]
    };

    function v533.IsColliding(p534, p535, p536, p537) -- Line: 6281
        -- upvalues: u532 (copy), u530 (copy)
        if not (p534.GuiElement and p534.GuiElement.Visible) then
            return true;
        end;

        if (u532 == "Secondary" and "Primary" or u532) ~= p535.Metadata.ItemType then
            return true;
        end;

        if p534.Item and p534.Item ~= p535 then
            return true;
        end;

        for _, v in ipairs(u530.BuyCartGhosts or {}) do
            if v.slot == p534 then
                return true;
            end;
        end;

        return false;
    end;

    return v533;
end;

function u6._ensureInvisibleSlotTemplate(p538) -- Line: 6311
    if p538._invisibleSlotTemplate then
        return p538._invisibleSlotTemplate;
    end;

    local v539 = game.ReplicatedStorage.GridPack.SingleSlot:Clone();
    v539.BackgroundTransparency = 1;

    if v539:IsA("CanvasGroup") then
        v539.GroupTransparency = 1;
    end;

    for _, descendant in ipairs(v539:GetDescendants()) do
        if descendant:IsA("UIStroke") then
            descendant.Enabled = false;
        end;

        if descendant:IsA("Frame") or descendant:IsA("CanvasGroup") then
            descendant.BackgroundTransparency = 1;
        end;

        if descendant:IsA("CanvasGroup") then
            descendant.GroupTransparency = 1;
        end;

        if descendant:IsA("ImageLabel") then
            descendant.ImageTransparency = 1;
            descendant.BackgroundTransparency = 1;
        end;
    end;

    p538._invisibleSlotTemplate = v539;

    return v539;
end;

function u6.CreateTradeGrid(p540, p541, p542, p543) -- Line: 6339
    -- upvalues: Players (copy), GridPack (copy)
    local UserId = Players.LocalPlayer.UserId;
    local v544 = GridPack.createGrid({
        Visible = true,
        SlotAspectRatio = 1,
        Parent = p541,
        Assets = {
            Slot = game.ReplicatedStorage.GridPack.Slot
        },
        GridSize = p542,
        Size = UDim2.fromScale(p542.X, p542.Y),
        AnchorPoint = Vector2.new(0, 0),
        Position = UDim2.new(0, 0, 0, 0),
        Metadata = p543 and {
            IsTradeOffer = true,
            TiedInstance = "TradeOffer_" .. UserId
        } or {
            IsTradeView = true,
            TiedInstance = "TradeView_" .. UserId
        }
    });
    p540:StyleGridContainer(v544);

    function v544.IsColliding() -- Line: 6356
        return false;
    end;

    if p543 then
        v544:ConnectTransferLink(p540.TransferLink);
    end;

    return v544;
end;

function u6.DestroyTradeGrid(u545, u546) -- Line: 6363
    if not u546 then
        return;
    end;

    u545:ClearGridPackInventory(u546);
    pcall(function() -- Line: 6366
        -- upvalues: u546 (copy), u545 (copy)
        u546:DisconnectTransferLink(u545.TransferLink);
    end);
    pcall(function() -- Line: 6367
        -- upvalues: u546 (copy)
        u546:Destroy();
    end);
    pcall(function() -- Line: 6368
        -- upvalues: u546 (copy)
        if u546.GuiElement then
            u546.GuiElement:Destroy();
        end;
    end);
end;

function u6.SetTradeOffered(p547, p548) -- Line: 6376
    -- upvalues: Players (copy)
    local UserId = Players.LocalPlayer.UserId;
    local v549 = p548 or {};

    for _, v in ipairs({
        p547.LocalInventory,
        p547.MainInventory,
        p547.ChestRigInventory,
        p547.BattleBeltInventory,
        p547.StorageInventory
    }) do
        if v and v.Items then
            local v550 = v.Metadata and v.Metadata.TiedInstance;
            local v551 = (typeof(v550) == "Instance" or v550 == tostring(UserId)) and "Pockets" or v550;

            for _, v2 in pairs(v.Items) do
                local ItemElement = v2.ItemElement;
                local v552 = v2.Metadata and v2.Metadata.ItemIndex;

                if ItemElement and (ItemElement.Parent and v552) then
                    local v553;

                    if v551 == nil then
                        v553 = false;
                    else
                        v553 = v549[tostring(v551) .. "#" .. tostring(v552)] == true;
                    end;

                    local TradeOfferedOverlay = ItemElement:FindFirstChild("TradeOfferedOverlay");

                    if v553 and not TradeOfferedOverlay then
                        TradeOfferedOverlay = Instance.new("TextLabel");
                        TradeOfferedOverlay.Name = "TradeOfferedOverlay";
                        TradeOfferedOverlay.Size = UDim2.fromScale(1, 1);
                        TradeOfferedOverlay.BackgroundColor3 = Color3.new(0, 0, 0);
                        TradeOfferedOverlay.BackgroundTransparency = 0.45;
                        TradeOfferedOverlay.Text = "OFFERED";
                        TradeOfferedOverlay.Font = Enum.Font.GothamBold;
                        TradeOfferedOverlay.TextSize = 10;
                        TradeOfferedOverlay.TextColor3 = Color3.fromRGB(230, 200, 90);
                        TradeOfferedOverlay.ZIndex = ItemElement.ZIndex + 5;
                        TradeOfferedOverlay.Parent = ItemElement;
                    end;

                    if TradeOfferedOverlay then
                        TradeOfferedOverlay.Visible = v553;
                    end;
                end;
            end;
        end;
    end;
end;

function u6.CreateMoveMiddleware(u554) -- Line: 6410
    -- upvalues: ReplicatedStorage (copy), Players (copy), ItemDatabase (copy), PlaceConfig (copy)
    return function(u555, p556, p557, u558, p559) -- Line: 6413
        -- upvalues: ReplicatedStorage (ref), u554 (copy), Players (ref), ItemDatabase (ref), PlaceConfig (ref)
        if u558 and (u558.Metadata and (u558.Metadata.IsTradeOffer or u558.Metadata.IsTradeView)) then
            if u558.Metadata.IsTradeOffer and p559 ~= u558 then
                local u560 = u555 and u555.Metadata and u555.Metadata.ItemIndex;
                task.spawn(function() -- Line: 6427
                    -- upvalues: ReplicatedStorage (ref), u560 (copy)
                    require(ReplicatedStorage:WaitForChild("PlayerTradeController")):RemoveFromDrag(u560);
                end);
            end;

            return false;
        end;

        if p559 and (p559.Metadata and p559.Metadata.IsTradeOffer) then
            local u561 = u558 and u558.Metadata and u558.Metadata.TiedInstance;
            local u562 = u555 and u555.Metadata and u555.Metadata.ItemIndex;
            task.spawn(function() -- Line: 6437
                -- upvalues: ReplicatedStorage (ref), u561 (copy), u562 (copy)
                require(ReplicatedStorage:WaitForChild("PlayerTradeController")):OfferFromDrag(u561, u562);
            end);

            return false;
        end;

        local v563 = p559 or u558;

        if p559 == u558 and (u558.ChangeItem and not u558.GridSize) then
            local StorageInventory = u554.StorageInventory;

            if StorageInventory and (StorageInventory.GuiElement and StorageInventory.GuiElement.Visible) then
                local Mouse = Players.LocalPlayer:GetMouse();
                local GuiElement = StorageInventory.GuiElement;
                local AbsolutePosition = GuiElement.AbsolutePosition;
                local AbsoluteSize = GuiElement.AbsoluteSize;

                if Mouse.X >= AbsolutePosition.X and (Mouse.X <= AbsolutePosition.X + AbsoluteSize.X and (Mouse.Y >= AbsolutePosition.Y and Mouse.Y <= AbsolutePosition.Y + AbsoluteSize.Y)) then
                    local ID = u555.Metadata.ID;
                    local ItemData = ItemDatabase.GetItemData(ID);

                    if ItemData and ItemData.NonDroppable then
                        ReplicatedStorage.Remotes.DropItem:FireServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, ID);

                        return false;
                    end;

                    if not PlaceConfig.ItemDropsAllowed() then
                        ReplicatedStorage.Remotes.DropItem:FireServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, ID);

                        return false;
                    end;

                    local Character = Players.LocalPlayer.Character;
                    local v564 = Character and Character:FindFirstChildOfClass("Humanoid");

                    if v564 then
                        v564:UnequipTools();
                    end;

                    ReplicatedStorage.Remotes.DropItem:FireServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, ID);

                    if u558 == u554.BackpackSlot then
                        u554:UpdateBackpackGridSize(nil);
                    elseif u558 == u554.BodySlot then
                        u554:UpdateChestRigGridSize(nil);
                    elseif u558 == u554.BeltGearSlot then
                        u554:UpdateBattleBeltGridSize(nil);
                    end;

                    if u554.CurrentStoragePart then
                        u554:CloseInventoryUI();
                    end;

                    u554:PlaySound("Drop", u555.Metadata.ItemType);

                    return false;
                end;
            end;
        end;

        if u555.Metadata.ItemType == "Backpack" and (p559 == u554.MainInventory and u558 == u554.BackpackSlot) then
            warn("Cannot place the equipped backpack inside its own inventory!");

            return false;
        end;

        if u555.Metadata.ItemType == "BodyGear" and (p559 == u554.ChestRigInventory and u558 == u554.BodySlot) then
            warn("Cannot place the equipped body gear inside its own chest rig!");

            return false;
        end;

        if not p559 then
            if u558.Items then
                local ItemData = ItemDatabase.GetItemData(u555.Metadata.ID);

                if ItemData and (ItemData.ItemType == "Ammo" or ItemData.ItemType == "AmmoPack") then
                    for _, v in pairs(u558.Items) do
                        if v and (v ~= u555 and v.Metadata) then
                            local ItemData2 = ItemDatabase.GetItemData(v.Metadata.ID);
                            local v565;

                            if ItemData2 then
                                if ItemData2.ItemType == "Ammo" then
                                    v565 = ItemData2.ammoType == ItemData.ammoType;
                                else
                                    v565 = false;
                                end;
                            else
                                v565 = ItemData2;
                            end;

                            local v566;

                            if ItemData2 then
                                if ItemData2.ItemType == "AmmoPack" and (ItemData.ItemType == "AmmoPack" and ItemData2.ID == ItemData.ID) then
                                    v566 = v.Metadata.ID == u555.Metadata.ID;
                                else
                                    v566 = false;
                                end;
                            else
                                v566 = ItemData2;
                            end;

                            if v565 or v566 then
                                local v567 = (p557 == 1 or (p557 == 3 or p557 == 90)) and true or p557 == 270;
                                local v568 = v.Rotation or 0;
                                local v569 = (v568 == 1 or (v568 == 3 or v568 == 90)) and true or v568 == 270;
                                local Position = v.Position;

                                if Position and (p556.X + (v567 and ItemData.Size.Y or ItemData.Size.X) > Position.X and (p556.X < Position.X + (v569 and ItemData2.Size.Y or ItemData2.Size.X) and (p556.Y + (v567 and ItemData.Size.X or ItemData.Size.Y) > Position.Y and p556.Y < Position.Y + (v569 and ItemData2.Size.X or ItemData2.Size.Y)))) then
                                    local v570 = u558.Metadata and u558.Metadata.TiedInstance;
                                    ReplicatedStorage.Remotes.RepackMagazine:FireServer(u555.Metadata.ItemIndex, v570, v.Metadata.ItemIndex, v570);
                                    u554:PlaySound("Move", u555.Metadata.ItemType);

                                    return false;
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            local v571 = ReplicatedStorage.Remotes.MoveItem:InvokeServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, p556, p557);

            if not v571 then
                warn("Server rejected item reposition within same grid");

                return v571;
            end;

            u554:PlaySound("Move", u555.Metadata.ItemType);

            if u554.CurrentBodyTied then
                ReplicatedStorage.Remotes.BumpBodyLock:FireServer(u554.CurrentBodyTied);
            end;

            if u558.GridSize then
                task.defer(function() -- Line: 6893
                    -- upvalues: u554 (ref), u555 (copy)
                    u554:ConvertItemToScale(u555);
                end);
            end;

            return v571;
        end;

        local v572 = p559.Metadata and (p559.Metadata.TiedInstance or "") or "";

        if type(v572) == "string" and (v572:sub(1, 9) == "Vicinity_" and u558 ~= p559) then
            local ID = u555.Metadata.ID;
            local ItemData = ItemDatabase.GetItemData(ID);

            if ItemData and ItemData.NonDroppable then
                ReplicatedStorage.Remotes.DropItem:FireServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, ID);

                return false;
            end;

            if not PlaceConfig.ItemDropsAllowed() then
                ReplicatedStorage.Remotes.DropItem:FireServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, ID);

                return false;
            end;

            local Character = Players.LocalPlayer.Character;
            local v573 = Character and Character:FindFirstChildOfClass("Humanoid");

            if v573 then
                v573:UnequipTools();
            end;

            ReplicatedStorage.Remotes.DropItem:FireServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, ID);

            if u558 == u554.BackpackSlot then
                u554:UpdateBackpackGridSize(nil);
            elseif u558 == u554.BodySlot then
                u554:UpdateChestRigGridSize(nil);
            end;

            if u554.CurrentStoragePart then
                u554:CloseInventoryUI();
            end;

            u554:PlaySound("Drop", u555.Metadata.ItemType);

            return true;
        end;

        local v574 = v563 and v563.GridSize and ItemDatabase.GetItemData(u555.Metadata.ID);

        if v574 then
            local v575 = (p557 == 1 or (p557 == 3 or p557 == 90)) and true or p557 == 270;
            local v576 = v575 and v574.Size.Y or v574.Size.X;
            local v577 = v575 and v574.Size.X or v574.Size.Y;

            if v563.GridSize.X < v576 or v563.GridSize.Y < v577 then
                return false;
            end;

            if p556.X + v576 > v563.GridSize.X or p556.Y + v577 > v563.GridSize.Y then
                return false;
            end;
        end;

        if p559.Items then
            local ItemData = ItemDatabase.GetItemData(u555.Metadata.ID);

            if ItemData and (ItemData.ItemType == "Ammo" or ItemData.ItemType == "AmmoPack") then
                for _, v in pairs(p559.Items) do
                    if v and (v ~= u555 and v.Metadata) then
                        local ItemData2 = ItemDatabase.GetItemData(v.Metadata.ID);

                        if ItemData2 and (ItemData2.ItemType == "Ammo" and ItemData2.ammoType == ItemData.ammoType) then
                            local v578 = (p557 == 1 or (p557 == 3 or p557 == 90)) and true or p557 == 270;
                            local v579 = v.Rotation or 0;
                            local v580 = (v579 == 1 or (v579 == 3 or v579 == 90)) and true or v579 == 270;
                            local Position = v.Position;

                            if Position and (p556.X + (v578 and ItemData.Size.Y or ItemData.Size.X) > Position.X and (p556.X < Position.X + (v580 and ItemData2.Size.Y or ItemData2.Size.X) and (p556.Y + (v578 and ItemData.Size.X or ItemData.Size.Y) > Position.Y and p556.Y < Position.Y + (v580 and ItemData2.Size.X or ItemData2.Size.Y)))) then
                                ReplicatedStorage.Remotes.RepackMagazine:FireServer(u555.Metadata.ItemIndex, u558.Metadata and u558.Metadata.TiedInstance, v.Metadata.ItemIndex, p559.Metadata and p559.Metadata.TiedInstance);
                                u554:PlaySound("Move", u555.Metadata.ItemType);

                                return false;
                            end;
                        end;
                    end;
                end;
            end;
        end;

        local v581;

        if p559.ChangeItem == nil then
            v581 = false;
        else
            v581 = not p559.GridSize;
        end;

        if v581 then
            if (p557 == nil and (u555 and (u555.Rotation or 0) or 0) or p557) ~= 0 then
                if u554 and u554.ShowToast then
                    u554:ShowToast("Rotate the item upright before equipping");
                end;

                return false;
            end;

            p557 = 0;
        end;

        if p559.Metadata and p559.Metadata.IsTrader then
            return false;
        end;

        if u558.Metadata and u558.Metadata.IsTrader then
            local ID = u555.Metadata.ID;
            local Price = u555.Metadata.Price;

            if not Price and u554.CurrentTraderProfile then
                local SellPanelPriceLookup = u554.SellPanelPriceLookup;

                if SellPanelPriceLookup and SellPanelPriceLookup[ID] then
                    Price = SellPanelPriceLookup[ID];
                end;
            end;

            if p559 ~= u554.LocalInventory and (p559 ~= u554.MainInventory and (p559 ~= u554.ChestRigInventory and p559 ~= u554.BattleBeltInventory)) then
                p559 = nil;
                p556 = nil;
            end;

            if ID and Price then
                u554:AddToBuyCart(ID, Price, p559, p556);
            end;

            return false;
        end;

        if not (p559.Metadata and p559.Metadata.IsBarterChip) then
            local v582, v583 = ReplicatedStorage.Remotes.MoveItemAcrossItemManager:InvokeServer(u555.Metadata.ItemIndex, u558.Metadata.TiedInstance, p559.Metadata.TiedInstance, p556, p557);

            if v582 then
                u555.Metadata.ItemIndex = v583;

                if u554.CurrentBodyTied then
                    ReplicatedStorage.Remotes.BumpBodyLock:FireServer(u554.CurrentBodyTied);
                end;

                local v584 = u558.Metadata and u558.Metadata.TiedInstance;
                local v585 = p559.Metadata and p559.Metadata.TiedInstance;

                if type(v584) == "string" and v584:sub(1, 5) == "Sell_" or type(v585) == "string" and v585:sub(1, 5) == "Sell_" then
                    task.defer(function() -- Line: 6752
                        -- upvalues: u554 (ref)
                        u554:RefreshSellPanelTotal();
                    end);
                    task.delay(0.1, function() -- Line: 6753
                        -- upvalues: u554 (ref)
                        u554:RefreshSellPanelTotal();
                    end);
                end;

                local v586 = (p559 == u554.HeadSlot or (p559 == u554.BodySlot or (p559 == u554.PrimarySlot or (p559 == u554.SecondarySlot or (p559 == u554.SidearmSlot or (p559 == u554.MeleeSlot or p559 == u554.UniformSlot)))))) and true or p559 == u554.BackpackSlot;
                local v587;

                if u558 == u554.StorageInventory and type(u558.Metadata.TiedInstance) == "string" then
                    v587 = u558.Metadata.TiedInstance:sub(1, 9) == "Vicinity_";
                else
                    v587 = false;
                end;

                if v587 then
                    u554:PlaySound("Pickup", u555.Metadata.ItemType);
                elseif v586 then
                    u554:PlaySound("Equip", u555.Metadata.ItemType);
                else
                    u554:PlaySound("Move", u555.Metadata.ItemType);
                end;

                if p559 == u554.BackpackSlot then
                    print("Backpack equipped, updating grid size");
                    u554:UpdateBackpackGridSize(u555.Metadata.ID);
                elseif u558 == u554.BackpackSlot then
                    print("Backpack unequipped, clearing grid");
                    u554:UpdateBackpackGridSize(nil);
                end;

                if p559 == u554.BodySlot then
                    u554:UpdateChestRigGridSize(u555.Metadata.ID);
                elseif u558 == u554.BodySlot then
                    u554:UpdateChestRigGridSize(nil);
                end;

                if p559 == u554.BeltGearSlot then
                    u554:UpdateBattleBeltGridSize(u555.Metadata.ID);
                elseif u558 == u554.BeltGearSlot then
                    u554:UpdateBattleBeltGridSize(nil);
                end;

                if u558 == u554.PrimarySlot and p559 ~= u554.PrimarySlot then
                    local WeaponRoundsLabel = u554.PrimaryFrame:FindFirstChild("WeaponRoundsLabel");
                    local WeaponLoadedLabel = u554.PrimaryFrame:FindFirstChild("WeaponLoadedLabel");

                    if WeaponRoundsLabel then
                        WeaponRoundsLabel:Destroy();
                    end;

                    if WeaponLoadedLabel then
                        WeaponLoadedLabel:Destroy();
                    end;
                end;

                if u558 == u554.SecondarySlot and p559 ~= u554.SecondarySlot then
                    local WeaponRoundsLabel = u554.SecondaryFrame:FindFirstChild("WeaponRoundsLabel");
                    local WeaponLoadedLabel = u554.SecondaryFrame:FindFirstChild("WeaponLoadedLabel");

                    if WeaponRoundsLabel then
                        WeaponRoundsLabel:Destroy();
                    end;

                    if WeaponLoadedLabel then
                        WeaponLoadedLabel:Destroy();
                    end;
                end;

                if u558 == u554.SidearmSlot and p559 ~= u554.SidearmSlot then
                    local WeaponRoundsLabel = u554.SidearmFrame:FindFirstChild("WeaponRoundsLabel");
                    local WeaponLoadedLabel = u554.SidearmFrame:FindFirstChild("WeaponLoadedLabel");

                    if WeaponRoundsLabel then
                        WeaponRoundsLabel:Destroy();
                    end;

                    if WeaponLoadedLabel then
                        WeaponLoadedLabel:Destroy();
                    end;
                end;

                if p559.GridSize then
                    task.defer(function() -- Line: 6816
                        -- upvalues: u554 (ref), u555 (copy)
                        u554:ConvertItemToScale(u555);
                    end);

                    return v582;
                end;

                if v581 and u555.ItemElement then
                    u555.Rotation = 0;
                    local ItemElement = u555.ItemElement;

                    local function forceRot() -- Line: 6824
                        -- upvalues: ItemElement (copy)
                        if ItemElement and ItemElement.Parent then
                            ItemElement.Rotation = 0;
                        end;
                    end;

                    if ItemElement and ItemElement.Parent then
                        ItemElement.Rotation = 0;
                    end;

                    task.defer(forceRot);
                    task.delay(0.05, forceRot);

                    return v582;
                end;
            else
                warn("Server rejected item move across managers");
            end;

            return v582;
        end;

        local BarterItemId = p559.Metadata.BarterItemId;
        local u588 = u558.Metadata and u558.Metadata.TiedInstance;
        local ItemIndex = u555.Metadata.ItemIndex;

        if u555.GuiElement then
            u555.GuiElement.Visible = false;
        end;

        task.spawn(function() -- Line: 6700
            -- upvalues: ReplicatedStorage (ref), u588 (copy), ItemIndex (copy), BarterItemId (copy), u558 (copy), u555 (copy), u554 (ref)
            local success, result = pcall(function() -- Line: 6701
                -- upvalues: ReplicatedStorage (ref), u588 (ref), ItemIndex (ref), BarterItemId (ref)
                return ReplicatedStorage.Remotes.BarterContributeItem:InvokeServer(u588, ItemIndex, BarterItemId);
            end);

            if success and (result and result.ok) then
                if u558 and (u558.RemoveItem and u555) then
                    pcall(function() -- Line: 6710
                        -- upvalues: u558 (ref), u555 (ref)
                        u558:RemoveItem(u555);
                    end);
                end;

                u554:_updateBarterChipCount(result.itemId, result.newCount);
                u554:PlaySound("Move", "General");

                if type(u588) == "string" and u588:sub(1, 6) == "Stash_" then
                    u554:LoadVicinity();
                end;
            elseif u555 and (u555.GuiElement and u555.GuiElement.Parent) then
                u555.GuiElement.Visible = true;
            end;
        end);

        return false;
    end;
end;

function u6.FindItemManager(p589, p590) -- Line: 6903
    for _, v in ipairs({
        p589.LocalInventory,
        p589.MainInventory,
        p589.ChestRigInventory,
        p589.BattleBeltInventory,
        p589.StorageInventory
    }) do
        if v and v.Items then
            local v591 = v;

            for _, v2 in pairs(v.Items) do
                if v2 == p590 then
                    return v591;
                end;
            end;
        end;
    end;

    for _, v in ipairs({
        p589.HeadSlot,
        p589.FaceWearSlot,
        p589.EyeWearSlot,
        p589.BodySlot,
        p589.BeltGearSlot,
        p589.PrimarySlot,
        p589.SecondarySlot,
        p589.SidearmSlot,
        p589.MeleeSlot,
        p589.UniformSlot,
        p589.BackpackSlot,
        p589.NightOpticalSlot
    }) do
        if v and v.Item == p590 then
            return v;
        end;
    end;

    return nil;
end;

function u6._usesCarried(p592, p593) -- Line: 6959
    -- upvalues: ItemDatabase (copy)
    if type(p593) ~= "string" then
        return 0;
    end;

    local ItemData = ItemDatabase.GetItemData(p593);
    local v594 = ItemData and ItemData.MaxUses or 1;
    local v595 = 0;

    for _, v in ipairs({ "LocalInventory", "ChestRigInventory", "BattleBeltInventory", "MainInventory" }) do
        local v596 = p592[v];

        if v596 and v596.Items then
            for _, v2 in ipairs(v596.Items) do
                local v597;

                if v2 then
                    v597 = v2.Metadata;
                else
                    v597 = v2;
                end;

                if v597 and v597.ID == p593 then
                    local v598;

                    if type(v597.Uses) == "number" then
                        v598 = v597.Uses or v594;
                    else
                        v598 = v594;
                    end;

                    v595 = v595 + v598;
                end;
            end;
        end;
    end;

    return v595;
end;

function u6._filterStock(p599, p600) -- Line: 7002
    -- upvalues: MaskCondition (copy)
    if type(p600) ~= "string" then
        return 0, 0, 0;
    end;

    local v601 = 0;
    local v602 = 0;
    local v603 = 0;

    for _, v in ipairs({ "LocalInventory", "ChestRigInventory", "BattleBeltInventory", "MainInventory" }) do
        local v604 = p599[v];

        if v604 and v604.Items then
            for _, v2 in ipairs(v604.Items) do
                local v605;

                if v2 then
                    v605 = v2.Metadata;
                else
                    v605 = v2;
                end;

                if v605 and v605.ID == p600 then
                    local v606 = MaskCondition.FilterCharge(v605);

                    if v606 > 0 then
                        v601 = v601 + 1;

                        if v602 < v606 then
                            v602 = v606;
                        end;
                    else
                        v603 = v603 + 1;
                    end;
                end;
            end;
        end;
    end;

    return v602, v601, v603;
end;

function u6._displayCondition(p607, p608, p609) -- Line: 7041
    -- upvalues: WeaponCondition (copy), Players (copy)
    local v610;

    if p608 then
        v610 = p608.Metadata;
    else
        v610 = p608;
    end;

    local v611 = WeaponCondition.Get(v610, p609);

    if not (p609 and p609.ToolName) then
        return v611;
    end;

    local v612;

    if p607.PrimarySlot and p607.PrimarySlot.Item == p608 or p607.SecondarySlot and p607.SecondarySlot.Item == p608 then
        v612 = true;
    else
        v612 = p607.SidearmSlot and p607.SidearmSlot.Item == p608;
    end;

    if not v612 then
        return v611;
    end;

    local LocalPlayer = Players.LocalPlayer;
    local v613;

    if LocalPlayer then
        v613 = LocalPlayer.Character;
    else
        v613 = LocalPlayer;
    end;

    if v613 then
        v613 = v613:FindFirstChild(p609.ToolName);
    end;

    if v613 then
        LocalPlayer = v613;
    else
        if LocalPlayer then
            LocalPlayer = LocalPlayer:FindFirstChild("Backpack");
        end;

        if LocalPlayer then
            LocalPlayer = LocalPlayer:FindFirstChild(p609.ToolName);
        end;
    end;

    if LocalPlayer then
        LocalPlayer = LocalPlayer:GetAttribute(WeaponCondition.ATTR);
    end;

    return type(LocalPlayer) == "number" and LocalPlayer and LocalPlayer or v611;
end;

function u6._displayUniformCondition(p614, p615, p616) -- Line: 7072
    -- upvalues: UniformCondition (copy), ReplicatedStorage (copy)
    local v617;

    if p615 then
        v617 = p615.Metadata;
    else
        v617 = p615;
    end;

    local v618 = UniformCondition.Get(v617, p616);

    if not UniformCondition.IsUniform(p616) then
        return v618;
    end;

    if not p614.UniformSlot or p614.UniformSlot.Item ~= p615 then
        return v618;
    end;

    local success, result = pcall(function() -- Line: 7077
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetArmorDurability:InvokeServer("Uniform");
    end);

    if success and type(result) == "number" then
        return result;
    end;

    return v618;
end;

function u6._displayArmorLayer(p619, p620, p621) -- Line: 7103
    -- upvalues: ArmorPlates (copy), ItemDatabase (copy), ReplicatedStorage (copy)
    local v622 = ArmorPlates.Layer(p620, p621, ItemDatabase);

    if not v622 then
        return nil;
    end;

    if not p619.BodySlot or p619.BodySlot.Item ~= p620 then
        return v622;
    end;

    local success, result = pcall(function() -- Line: 7108
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetArmorDurability:InvokeServer("Body");
    end);

    if not success or type(result) ~= "number" then
        return v622;
    end;

    local math_clamp_ret = math.clamp(result, 0, v622.maxCond);
    local v623 = v622.source == "Insert" and (v622.insertDb and v622.insertDb.WearProfile or ArmorPlates.CERAMIC_PROFILE) or ArmorPlates.SOFT_PROFILE;
    local table_clone_ret = table.clone(v622);
    table_clone_ret.cond = math_clamp_ret;
    table_clone_ret.scale = ArmorPlates.ScaleFor(v623, math_clamp_ret, v622.maxCond);

    return table_clone_ret;
end;

function u6._displayHelmetCondition(p624, p625, p626) -- Line: 7140
    -- upvalues: HelmetCondition (copy), ReplicatedStorage (copy)
    local v627 = HelmetCondition.Percent(p625, p626);

    if not p624.HeadSlot or p624.HeadSlot.Item ~= p625 then
        return v627;
    end;

    local success, result = pcall(function() -- Line: 7144
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetArmorDurability:InvokeServer("Head");
    end);

    if not success or type(result) ~= "number" then
        return v627;
    end;

    local v628 = HelmetCondition.MaxOf(p626);

    if v628 <= 0 then
        return v627;
    end;

    return math.clamp(result / v628 * 100, 0, 100);
end;

function u6._displayMaskCondition(p629, p630, p631) -- Line: 7161
    -- upvalues: MaskCondition (copy), ReplicatedStorage (copy)
    local v632 = MaskCondition.Get(p630, p631);

    if not p629.FaceWearSlot or p629.FaceWearSlot.Item ~= p630 then
        return v632;
    end;

    local success, result = pcall(function() -- Line: 7165
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetArmorDurability:InvokeServer("FaceWear");
    end);

    if success and type(result) == "number" then
        return math.clamp(result, 0, MaskCondition.MAX);
    end;

    return v632;
end;

function u6._displayFilterCharge(p633, p634, p635) -- Line: 7189
    -- upvalues: MaskCondition (copy), ReplicatedStorage (copy)
    local v636 = MaskCondition.FilterCharge(p635);

    if not p633.FaceWearSlot or p633.FaceWearSlot.Item ~= p634 then
        return v636;
    end;

    local success, result = pcall(function() -- Line: 7193
        -- upvalues: ReplicatedStorage (ref)
        return ReplicatedStorage.Remotes.GetArmorDurability:InvokeServer("FaceWear", "filter");
    end);

    if success and type(result) == "number" then
        return math.clamp(result, 0, 100);
    end;

    return v636;
end;

function u6._closeRepairPicker(p637, p638) -- Line: 7204
    if not p638 then
        return;
    end;

    for _, child in ipairs(p638:GetChildren()) do
        if child.Name:match("^RepairOption_") then
            child:Destroy();
        end;
    end;

    if p637._repairHidden then
        for i, v in pairs(p637._repairHidden) do
            if i.Parent then
                i.Visible = v;
            end;
        end;

        p637._repairHidden = nil;
    end;

    if p637._repairPrevSize then
        p638.Size = p637._repairPrevSize;
        p637._repairPrevSize = nil;
    end;
end;

function u6._openRepairPicker(u639, u640, u641, u642, p643) -- Line: 7230
    -- upvalues: HelmetCondition (copy), MaskCondition (copy), UniformCondition (copy), WeaponCondition (copy), ItemDatabase (copy), ReplicatedStorage (copy)
    u639:_closeRepairPicker(u640);
    u639:_closeFilterPicker(u640);
    u639:_closeWatchPicker(u640);
    local u644;

    if HelmetCondition.IsHelmet(p643) then
        u644 = {
            remote = "RepairHeadGear",
            mod = HelmetCondition,
            cond = u639:_displayHelmetCondition(u641, p643),
            material = HelmetCondition.Material(p643)
        };
    elseif MaskCondition.IsMask(p643) then
        u644 = {
            remote = "RepairMask",
            mod = MaskCondition,
            cond = u639:_displayMaskCondition(u641, p643)
        };
    elseif UniformCondition.IsUniform(p643) then
        u644 = {
            remote = "RepairUniform",
            mod = UniformCondition,
            cond = u639:_displayUniformCondition(u641, p643)
        };
    else
        u644 = {
            remote = "RepairWeapon",
            mod = WeaponCondition,
            cond = u639:_displayCondition(u641, p643)
        };
    end;

    local cond = u644.cond;
    local v645 = u640:FindFirstChild("ModifyButton") or u640:FindFirstChildWhichIsA("TextButton");

    if not v645 then
        return;
    end;

    u639._repairHidden = {};

    for _, child in ipairs(u640:GetChildren()) do
        if child:IsA("GuiObject") and child.Visible then
            u639._repairHidden[child] = true;
            child.Visible = false;
        end;
    end;

    local v646 = 0;

    for _, v in ipairs(u644.mod.REPAIR_TIERS) do
        v646 = v646 + 1;
        local ItemData = ItemDatabase.GetItemData(v.item);
        local v647 = ItemData and ItemData.Name or v.item;
        local v648 = u639:_usesCarried(v.item);
        local v649 = cond < v.min;
        local v650 = v.max <= cond;
        local v651;

        if v.material == nil then
            v651 = false;
        else
            v651 = v.material ~= u644.material;
        end;

        local requires = v.requires;
        local v652 = not requires or u639:_usesCarried(requires) > 0;
        local v653 = not (v649 or (v650 or v651));

        if v653 then
            if v648 > 0 then
                v653 = v652;
            else
                v653 = false;
            end;
        end;

        local v654 = v645:Clone();
        v654.Name = "RepairOption_" .. v.item;
        v654.LayoutOrder = v646 + 20;
        v654.Visible = true;
        v654.AutoButtonColor = v653;
        local v655;

        if v651 then
            v655 = u644.material and ("This helmet takes " .. u644.material or "Only a repair kit will touch this shell") or "Only a repair kit will touch this shell";
        elseif v649 then
            v655 = "Condition Too Low";
        elseif v650 then
            v655 = "No Effect";
        elseif v648 <= 0 then
            v655 = "Out of Material";
        elseif v652 then
            local v656 = u644.mod.RepairResult(cond, v);
            local math_floor_ret = math.floor(v656);
            local v657 = ("%d use%s left"):format(v648, v648 == 1 and "" or "s");

            if requires then
                local ItemData2 = ItemDatabase.GetItemData(requires);

                if ItemData2 then
                    requires = ItemData2.Name or requires;
                end;

                v657 = v657 .. ", plus 1 " .. requires;
            end;

            v655 = ("%d%% → %d%%\n%s"):format(math.floor(cond), math_floor_ret, v657);
        else
            local ItemData2 = ItemDatabase.GetItemData(requires);

            if ItemData2 then
                requires = ItemData2.Name or requires;
            end;

            v655 = "Needs " .. requires;
        end;

        v654.RichText = true;
        v654.Text = ("<b>%s</b>\n%s"):format(v647, v655);
        local u658 = v;
        local v659 = 1;

        for _ in v655:gmatch("\n") do
            v659 = v659 + 1;
        end;

        v654.Size = UDim2.new(v654.Size.X.Scale, v654.Size.X.Offset, v654.Size.Y.Scale, v659 * 16 + 12);
        v654.TextTransparency = v653 and 0 or 0.55;
        v654.Parent = u640;
        v654.TextTruncate = Enum.TextTruncate.None;

        if v653 then
            table.insert(u639._contextMenuConnections, v654.MouseButton1Click:Connect(function() -- Line: 7406
                -- upvalues: u639 (copy), u640 (copy), u642 (copy), ReplicatedStorage (ref), u644 (ref), u641 (copy), u658 (copy)
                u639:_closeRepairPicker(u640);
                u640.Visible = false;
                ReplicatedStorage.Remotes[u644.remote]:FireServer(u642.Metadata and u642.Metadata.TiedInstance, u641.Metadata and u641.Metadata.ItemIndex, u641.Metadata and u641.Metadata.ID, u658.item);
            end));
        end;
    end;

    local v660 = 0;

    for _, child in ipairs(u640:GetChildren()) do
        if child:IsA("TextButton") and (child.Name:match("^RepairOption_") and v660 < child.TextBounds.X) then
            v660 = child.TextBounds.X;
        end;
    end;

    if v660 > 0 then
        u639._repairPrevSize = u639._repairPrevSize or u640.Size;
        local v661 = math.ceil(v660) + 26;
        local math_min_ret = math.min(340, v661);

        if u640.AbsoluteSize.X < math_min_ret then
            u640.Size = UDim2.new(u640.Size.X.Scale, math_min_ret, u640.Size.Y.Scale, u640.Size.Y.Offset);
        end;
    end;

    for _, child in ipairs(u640:GetChildren()) do
        if child:IsA("TextButton") and child.Name:match("^RepairOption_") then
            child.TextTruncate = Enum.TextTruncate.AtEnd;
        end;
    end;
end;

function u6._openInsertPicker(u662, u663, u664, u665, p666) -- Line: 7468
    -- upvalues: ArmorPlates (copy), ItemDatabase (copy), ReplicatedStorage (copy)
    u662:_closeRepairPicker(u663);
    u662:_closeFilterPicker(u663);
    u662:_closeWatchPicker(u663);
    local v667 = u663:FindFirstChild("ModifyButton") or u663:FindFirstChildWhichIsA("TextButton");

    if not v667 then
        return;
    end;

    u662._repairHidden = {};

    for _, child in ipairs(u663:GetChildren()) do
        if child:IsA("GuiObject") and child.Visible then
            u662._repairHidden[child] = true;
            child.Visible = false;
        end;
    end;

    u662._repairPrevSize = u663.Size;
    local v668, v669 = ArmorPlates.CanFitInsert(u664, p666);
    local v670 = {};

    for i, v in pairs(ItemDatabase) do
        if type(v) == "table" and ArmorPlates.IsInsert(v) then
            table.insert(v670, {
                id = i,
                db = v
            });
        end;
    end;

    table.sort(v670, function(p671, p672) -- Line: 7505
        return (p671.db.ArmorClass or 0) < (p672.db.ArmorClass or 0);
    end);
    local v673 = 0;
    local v674 = {};

    for _, v in ipairs(v670) do
        v673 = v673 + 1;
        local v675 = u662:_usesCarried(v.id);
        local v676 = nil;
        local v677;

        if v668 then
            v677 = v675 <= 0 and "Out of Material" or v676;
        else
            v677 = v669;
        end;

        local v678 = v677 or string.format("Class %s   %d dur   %s kg   5s", tostring(v.db.ArmorClass), v.db.ArmorMaxDurability, (tostring(v.db.Weight)));
        local v679 = v667:Clone();
        v679.Name = "RepairOption_" .. v673;
        v679.LayoutOrder = v673;
        v679.Visible = true;
        v679.RichText = true;
        v679.TextXAlignment = Enum.TextXAlignment.Left;
        v679.TextTruncate = Enum.TextTruncate.None;
        v679.Text = string.format("%s\n<font color=\"rgb(150,150,150)\">%s</font>", v.db.Name or v.id, v678);
        v679.Size = UDim2.new(1, 0, 0, 44);
        v679.TextTransparency = v677 and 0.5 or 0;
        v679.Active = v677 == nil;
        v679.Parent = u663;
        table.insert(v674, v679);

        if not v677 then
            table.insert(u662._contextMenuConnections, v679.MouseButton1Click:Connect(function() -- Line: 7553
                -- upvalues: u665 (copy), ReplicatedStorage (ref), u664 (copy), v (copy), u662 (copy), u663 (copy)
                ReplicatedStorage.Remotes.InsertArmorPlate:FireServer(u665.Metadata and u665.Metadata.TiedInstance, u664.Metadata and u664.Metadata.ItemIndex, u664.Metadata and u664.Metadata.ID, v.id);
                u662:_closeRepairPicker(u663);
                u663.Visible = false;
            end));
        end;
    end;

    local v680 = 0;

    for _, v in ipairs(v674) do
        v680 = math.max(v680, v.TextBounds.X);
    end;

    if v680 > 0 then
        u663.Size = UDim2.new(0, math.max(120, v680 + 24), 0, 0);
    end;

    for _, v in ipairs(v674) do
        v.TextTruncate = Enum.TextTruncate.AtEnd;
    end;
end;

function u6._closeFilterPicker(p681, p682) -- Line: 7588
    if not p682 then
        return;
    end;

    for _, child in ipairs(p682:GetChildren()) do
        if child.Name:match("^FilterOption_") then
            child:Destroy();
        end;
    end;

    if p681._filterHidden then
        for i, v in pairs(p681._filterHidden) do
            if i.Parent then
                i.Visible = v;
            end;
        end;

        p681._filterHidden = nil;
    end;

    if p681._filterPrevSize then
        p682.Size = p681._filterPrevSize;
        p681._filterPrevSize = nil;
    end;
end;

function u6._openFilterPicker(u683, u684, u685, u686, p687) -- Line: 7619
    -- upvalues: ItemDatabase (copy), MaskCondition (copy), ReplicatedStorage (copy)
    u683:_closeRepairPicker(u684);
    u683:_closeFilterPicker(u684);
    u683:_closeWatchPicker(u684);
    local v688 = u684:FindFirstChild("ModifyButton") or u684:FindFirstChildWhichIsA("TextButton");

    if not v688 then
        return;
    end;

    u683._filterHidden = {};

    for _, child in ipairs(u684:GetChildren()) do
        if child:IsA("GuiObject") and child.Visible then
            u683._filterHidden[child] = true;
            child.Visible = false;
        end;
    end;

    u683._filterPrevSize = u684.Size;
    local v689 = {};

    for i, v in pairs(ItemDatabase) do
        if type(v) == "table" and MaskCondition.IsFilter(v) then
            table.insert(v689, {
                id = i,
                db = v
            });
        end;
    end;

    table.sort(v689, function(p690, p691) -- Line: 7650
        return (p690.db.FilterCap or 0) < (p691.db.FilterCap or 0);
    end);
    local v692 = 0;
    local v693 = {};

    for _, v in ipairs(v689) do
        v692 = v692 + 1;
        local v694, v695, v696 = u683:_filterStock(v.id);
        local v697 = v695 <= 0 and (v696 > 0 and "Depleted" or "None carried") or nil;
        local v698;

        if v697 then
            v698 = v697;
        else
            local v699 = v695 <= 1 and "" or ("   %d carried"):format(v695);
            v698 = string.format("Condition: %d%%   Duration: %d min   Efficiency: %d%%%s", math.floor(v694 + 0.5), math.floor((v.db.FilterSeconds or 0) / 60 + 0.5), math.floor((v.db.FilterCap or 0) * 100 + 0.5), v699);
        end;

        local v700 = v688:Clone();
        v700.Name = "FilterOption_" .. v692;
        v700.LayoutOrder = v692;
        v700.Visible = true;
        v700.RichText = true;
        v700.TextXAlignment = Enum.TextXAlignment.Left;
        v700.TextTruncate = Enum.TextTruncate.None;
        v700.Text = string.format("%s\n<font color=\"rgb(150,150,150)\">%s</font>", v.db.Name or v.id, v698);
        v700.Size = UDim2.new(1, 0, 0, 44);
        v700.TextTransparency = v697 and 0.5 or 0;
        v700.Active = v697 == nil;
        v700.Parent = u684;
        table.insert(v693, v700);

        if not v697 then
            table.insert(u683._contextMenuConnections, v700.MouseButton1Click:Connect(function() -- Line: 7744
                -- upvalues: u686 (copy), ReplicatedStorage (ref), u685 (copy), v (copy), u683 (copy), u684 (copy)
                ReplicatedStorage.Remotes.InsertMaskFilter:FireServer(u686.Metadata and u686.Metadata.TiedInstance, u685.Metadata and u685.Metadata.ItemIndex, u685.Metadata and u685.Metadata.ID, v.id);
                u683:_closeFilterPicker(u684);
                u684.Visible = false;
            end));
        end;
    end;

    local v701 = 0;

    for _, v in ipairs(v693) do
        v701 = math.max(v701, v.TextBounds.X);
    end;

    if v701 > 0 then
        u684.Size = UDim2.new(0, math.max(120, v701 + 24), 0, 0);
    end;

    for _, v in ipairs(v693) do
        v.TextTruncate = Enum.TextTruncate.AtEnd;
    end;
end;

function u6._carriedWatches(p702, p703) -- Line: 7782
    -- upvalues: ItemDatabase (copy)
    local v704 = p703 or "Watch";
    local v705 = {};
    local v706 = {};

    for _, v in ipairs({ "LocalInventory", "ChestRigInventory", "BattleBeltInventory", "MainInventory" }) do
        local v707 = p702[v];

        if v707 and v707.Items then
            for _, v2 in ipairs(v707.Items) do
                local v708 = v2 and v2.Metadata and v2.Metadata.ID;
                local v709;

                if v708 then
                    v709 = ItemDatabase.GetItemData(v708);
                else
                    v709 = v708;
                end;

                if v709 and v709.ItemType == v704 then
                    if v705[v708] == nil then
                        v705[v708] = 0;
                        table.insert(v706, v708);
                    end;

                    v705[v708] = v705[v708] + 1;
                end;
            end;
        end;
    end;

    table.sort(v706, function(p710, p711) -- Line: 7807
        -- upvalues: ItemDatabase (ref)
        local ItemData = ItemDatabase.GetItemData(p710);
        local ItemData2 = ItemDatabase.GetItemData(p711);

        return (ItemData and ItemData.BaseSellValue or 0) > (ItemData2 and ItemData2.BaseSellValue or 0);
    end);

    return v706, v705;
end;

function u6._closeWatchPicker(p712, p713) -- Line: 7814
    if not p713 then
        return;
    end;

    for _, child in ipairs(p713:GetChildren()) do
        if child.Name:match("^WatchOption_") then
            child:Destroy();
        end;
    end;

    if p712._watchHidden then
        for i, v in pairs(p712._watchHidden) do
            if i.Parent then
                i.Visible = v;
            end;
        end;

        p712._watchHidden = nil;
    end;

    if p712._watchPrevSize then
        p713.Size = p712._watchPrevSize;
        p712._watchPrevSize = nil;
    end;
end;

function u6._openWatchPicker(u714, u715, p716, u717) -- Line: 7848
    -- upvalues: Players (copy), ItemDatabase (copy), ReplicatedStorage (copy)
    u714:_closeRepairPicker(u715);
    u714:_closeFilterPicker(u715);
    u714:_closeWatchPicker(u715);
    local u718 = u715:FindFirstChild("ModifyButton") or u715:FindFirstChildWhichIsA("TextButton");

    if not u718 then
        return;
    end;

    u714._watchHidden = {};

    for _, child in ipairs(u715:GetChildren()) do
        if child:IsA("GuiObject") and child.Visible then
            u714._watchHidden[child] = true;
            child.Visible = false;
        end;
    end;

    u714._watchPrevSize = u715.Size;
    local v719, v720 = u714:_carriedWatches();
    local Attribute = Players.LocalPlayer:GetAttribute("WornWatch");
    local u721 = {};

    local function addRow(p722, p723, p724, p725) -- Line: 7875
        -- upvalues: u718 (copy), u721 (copy), u715 (copy), u714 (copy)
        local v726 = u718:Clone();
        v726.Name = "WatchOption_" .. #u721 + 1;
        v726.LayoutOrder = #u721 + 1;
        v726.Visible = true;
        v726.RichText = true;
        v726.TextXAlignment = Enum.TextXAlignment.Left;
        v726.TextTruncate = Enum.TextTruncate.None;
        v726.Text = string.format("%s\n<font color=\"rgb(150,150,150)\">%s</font>", p722, p723);
        v726.Size = UDim2.new(1, 0, 0, 44);
        v726.TextTransparency = p724 and 0 or 0.5;
        v726.Active = p724;
        v726.Parent = u715;
        table.insert(u721, v726);

        if p724 and p725 then
            table.insert(u714._contextMenuConnections, v726.MouseButton1Click:Connect(p725));
        end;
    end;

    if #v719 == 0 then
        addRow("No watches carried", "Find one in the Zone, or trade for it", false, nil);
    end;

    for _, v in ipairs(v719) do
        local ItemData = ItemDatabase.GetItemData(v);
        local v727 = v720[v] > 1 and (("   %d carried"):format(v720[v]) or "") or "";

        if v == Attribute then
            addRow(ItemData.Name or v, "Worn" .. v727, false, nil);
        else
            addRow(ItemData.Name or v, ("Value: %d%s"):format(ItemData.BaseSellValue or 0, v727), true, function() -- Line: 7912
                -- upvalues: u717 (copy), ReplicatedStorage (ref), v (copy), u714 (copy), u715 (copy)
                ReplicatedStorage.Remotes.WearWatch:FireServer(u717.Metadata and u717.Metadata.TiedInstance, v);
                u714:_closeWatchPicker(u715);
                u715.Visible = false;
            end);
        end;
    end;

    local v728 = 0;

    for _, v in ipairs(u721) do
        v728 = math.max(v728, v.TextBounds.X);
    end;

    if v728 > 0 then
        u715.Size = UDim2.new(0, math.max(120, v728 + 24), 0, 0);
    end;

    for _, v in ipairs(u721) do
        v.TextTruncate = Enum.TextTruncate.AtEnd;
    end;
end;

function u6._openAccessorizePicker(u729, u730, p731, p732) -- Line: 7945
    -- upvalues: ItemDatabase (copy), Players (copy), ReplicatedStorage (copy)
    u729:_closeRepairPicker(u730);
    u729:_closeFilterPicker(u730);
    u729:_closeWatchPicker(u730);
    local u733 = u730:FindFirstChild("ModifyButton") or u730:FindFirstChildWhichIsA("TextButton");

    if not u733 then
        return;
    end;

    u729._watchHidden = {};

    for _, child in ipairs(u730:GetChildren()) do
        if child:IsA("GuiObject") and child.Visible then
            u729._watchHidden[child] = true;
            child.Visible = false;
        end;
    end;

    u729._watchPrevSize = u730.Size;
    local u734 = p732.Metadata and p732.Metadata.TiedInstance;
    local u735 = {};

    local function v741(p736, p737, p738, u739) -- Line: 7966
        -- upvalues: u733 (copy), u735 (copy), u730 (copy), u729 (copy)
        local v740 = u733:Clone();
        v740.Name = "WatchOption_" .. #u735 + 1;
        v740.LayoutOrder = #u735 + 1;
        v740.Visible = true;
        v740.RichText = true;
        v740.TextXAlignment = Enum.TextXAlignment.Left;
        v740.TextTruncate = Enum.TextTruncate.None;

        if p737 then
            p736 = string.format("%s\n<font color=\"rgb(150,150,150)\">%s</font>", p736, p737) or p736;
        end;

        v740.Text = p736;
        v740.Size = UDim2.new(1, 0, 0, 12 + 16 * (p737 and 2 or 1));
        v740.TextTransparency = p738 and 0 or 0.5;
        v740.Active = p738;
        v740.Parent = u730;
        table.insert(u735, v740);

        if p738 and u739 then
            table.insert(u729._contextMenuConnections, v740.MouseButton1Click:Connect(function() -- Line: 7981
                -- upvalues: u739 (copy), u729 (ref), u730 (ref)
                u739();
                u729:_closeWatchPicker(u730);
                u730.Visible = false;
            end));
        end;
    end;

    local function nameOf(p742) -- Line: 7988
        -- upvalues: ItemDatabase (ref)
        local v743;

        if p742 then
            v743 = ItemDatabase.GetItemData(p742);
        else
            v743 = p742;
        end;

        return v743 and v743.Name or tostring(p742);
    end;

    local Attribute = Players.LocalPlayer:GetAttribute("WornWatch");
    local v744, v745 = u729:_carriedWatches("Watch");
    local v746;

    if Attribute then
        local v747;

        if Attribute then
            v747 = ItemDatabase.GetItemData(Attribute);
        else
            v747 = Attribute;
        end;

        v746 = "Wearing " .. (v747 and v747.Name or tostring(Attribute)) or "Nothing worn";
    else
        v746 = "Nothing worn";
    end;

    v741("<b>WRIST</b>", v746, false, nil);

    if Attribute then
        local v748;

        if Attribute then
            v748 = ItemDatabase.GetItemData(Attribute);
        else
            v748 = Attribute;
        end;

        v741("   Take off " .. (v748 and v748.Name or tostring(Attribute)), nil, true, function() -- Line: 7998
            -- upvalues: ReplicatedStorage (ref), u734 (copy)
            ReplicatedStorage.Remotes.RemoveWatch:FireServer(u734);
        end);
    end;

    for _, v in ipairs(v744) do
        if v ~= Attribute then
            local v749 = v745[v] > 1 and (("  (%d carried)"):format(v745[v]) or "") or "";
            local v750;

            if v then
                v750 = ItemDatabase.GetItemData(v);
            else
                v750 = v;
            end;

            v741("   Wear " .. (v750 and v750.Name or tostring(v)) .. v749, nil, true, function() -- Line: 8005
                -- upvalues: ReplicatedStorage (ref), u734 (copy), v (copy)
                ReplicatedStorage.Remotes.WearWatch:FireServer(u734, v);
            end);
        end;
    end;

    local v751, v752 = u729:_carriedWatches("Patch");

    for _, v in ipairs({ "Left", "Right" }) do
        local Attribute2 = Players.LocalPlayer:GetAttribute("WornPatch" .. v);
        local v753 = "<b>" .. string.upper(v) .. " SHOULDER</b>";
        local v754;

        if Attribute2 then
            local v755;

            if Attribute2 then
                v755 = ItemDatabase.GetItemData(Attribute2);
            else
                v755 = Attribute2;
            end;

            v754 = "Wearing " .. (v755 and v755.Name or tostring(Attribute2)) or "Nothing sewn on";
        else
            v754 = "Nothing sewn on";
        end;

        local v756 = u733:Clone();
        v756.Name = "WatchOption_" .. #u735 + 1;
        v756.LayoutOrder = #u735 + 1;
        v756.Visible = true;
        v756.RichText = true;
        v756.TextXAlignment = Enum.TextXAlignment.Left;
        v756.TextTruncate = Enum.TextTruncate.None;

        if v754 then
            v753 = string.format("%s\n<font color=\"rgb(150,150,150)\">%s</font>", v753, v754) or v753;
        end;

        v756.Text = v753;
        v756.Size = UDim2.new(1, 0, 0, 12 + 16 * (v754 and 2 or 1));
        v756.TextTransparency = 0.5;
        v756.Active = false;
        v756.Parent = u730;
        table.insert(u735, v756);

        if Attribute2 then
            local v757;

            if Attribute2 then
                v757 = ItemDatabase.GetItemData(Attribute2);
            else
                v757 = Attribute2;
            end;

            v741("   Take off " .. (v757 and v757.Name or tostring(Attribute2)), nil, true, function() -- Line: 8018
                -- upvalues: ReplicatedStorage (ref), u734 (copy), v (copy)
                ReplicatedStorage.Remotes.RemovePatch:FireServer(u734, v);
            end);
        else
            local u758 = v;

            for _, v2 in ipairs(v751) do
                local v759 = v752[v2] > 1 and (("  (%d carried)"):format(v752[v2]) or "") or "";
                local v760;

                if v2 then
                    v760 = ItemDatabase.GetItemData(v2);
                else
                    v760 = v2;
                end;

                v741("   Sew on " .. (v760 and v760.Name or tostring(v2)) .. v759, nil, true, function() -- Line: 8024
                    -- upvalues: ReplicatedStorage (ref), u734 (copy), u758 (copy), v2 (copy)
                    ReplicatedStorage.Remotes.WearPatch:FireServer(u734, u758, v2);
                end);
            end;

            if #v751 == 0 then
                local v761 = u733:Clone();
                v761.Name = "WatchOption_" .. #u735 + 1;
                v761.LayoutOrder = #u735 + 1;
                v761.Visible = true;
                v761.RichText = true;
                v761.TextXAlignment = Enum.TextXAlignment.Left;
                v761.TextTruncate = Enum.TextTruncate.None;
                v761.Text = "   No patches carried";
                v761.Size = UDim2.new(1, 0, 0, 28);
                v761.TextTransparency = 0.5;
                v761.Active = false;
                v761.Parent = u730;
                table.insert(u735, v761);
            end;
        end;
    end;

    local v762 = 0;

    for _, v in ipairs(u735) do
        v762 = math.max(v762, v.TextBounds.X);
    end;

    if v762 > 0 then
        u730.Size = UDim2.new(0, math.max(140, v762 + 24), 0, 0);
    end;

    for _, v in ipairs(u735) do
        v.TextTruncate = Enum.TextTruncate.AtEnd;
    end;
end;

function u6._kitsFor(p763, p764) -- Line: 8042
    -- upvalues: ItemDatabase (copy)
    local v765 = {};
    local UpgradeRecipes = ItemDatabase.UpgradeRecipes;
    local v766 = p764 and p764.Metadata and p764.Metadata.ID;

    if not (UpgradeRecipes and v766) then
        return v765;
    end;

    for _, v in ipairs({ "LocalInventory", "ChestRigInventory", "BattleBeltInventory", "MainInventory" }) do
        local v767 = p763[v];

        if v767 and v767.Items then
            for _, v2 in ipairs(v767.Items) do
                local v768 = v2 and v2.Metadata and v2.Metadata.ID;

                if v768 then
                    v768 = UpgradeRecipes[v768];
                end;

                if v768 and v768.base == v766 then
                    table.insert(v765, v2);
                end;
            end;
        end;
    end;

    return v765;
end;

function u6.ShowContextMenu(u769, u770, p771) -- Line: 8083
    -- upvalues: Players (copy), ItemDatabase (copy), WeaponCondition (copy), UniformCondition (copy), MaskCondition (copy), HelmetCondition (copy), ArmorPlates (copy), PlaceConfig (copy), ReplicatedStorage (copy), InventoryWire (copy), GridPack (copy), UserInputService (copy)
    if u769.IsUsingItem then
        return;
    end;

    if p771 and (p771.Metadata and (p771.Metadata.IsTradeOffer or p771.Metadata.IsTradeView)) then
        return;
    end;

    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if not InventoryGui then
        return;
    end;

    local ContextMenu = InventoryGui:FindFirstChild("ContextMenu");

    if not ContextMenu then
        return;
    end;

    u769:HideContextMenu();

    for _, child in ipairs(ContextMenu:GetChildren()) do
        if child:IsA("TextButton") and (typeof(child.Name) == "string" and child.Name:sub(1, 11) == "VialPicker_") then
            child:Destroy();
        end;
    end;

    u769:_closeRepairPicker(ContextMenu);
    u769:_closeFilterPicker(ContextMenu);
    u769:_closeWatchPicker(ContextMenu);

    for _, child in ipairs(ContextMenu:GetChildren()) do
        if child:IsA("TextButton") and (typeof(child.Name) == "string" and child.Name:sub(1, 12) == "QuickAssign_") then
            child:Destroy();
        end;
    end;

    for _, child in ipairs(ContextMenu:GetChildren()) do
        if child:IsA("GuiObject") and (typeof(child.Name) == "string" and child.Name:sub(1, 10) == "ApplySkin_") then
            child:Destroy();
        end;
    end;

    for _, child in ipairs(ContextMenu:GetChildren()) do
        if child:IsA("TextButton") and (typeof(child.Name) == "string" and child.Name:sub(1, 11) == "ToggleVisor") then
            child:Destroy();
        end;
    end;

    for _, child in ipairs(ContextMenu:GetChildren()) do
        if child:IsA("TextButton") and (typeof(child.Name) == "string" and child.Name:sub(1, 11) == "TradeOffer_") then
            child:Destroy();
        end;
    end;

    local ID = u770.Metadata.ID;
    local ItemData = ItemDatabase.GetItemData(ID);

    if not ItemData then
        return;
    end;

    local v772 = u769:FindItemManager(u770) or p771;

    if not v772 then
        return;
    end;

    local u773 = v772;
    local v774 = u773.ChangeItem ~= nil;
    local v775 = u773.Metadata and (u773.Metadata.TiedInstance or "") or "";
    local u776;

    if type(v775) == "string" and type(v775) == "string" then
        u776 = v775:sub(1, 9) == "Vicinity_";
    else
        u776 = false;
    end;

    local u777 = false;

    if not (v774 or u776) then
        local v778 = {
            [tostring(Players.LocalPlayer)] = true,
            ["ChestRigInternal_" .. Players.LocalPlayer.UserId] = true,
            ["BattleBeltInternal_" .. Players.LocalPlayer.UserId] = true,
            ["BackpackInternal_" .. Players.LocalPlayer.UserId] = true
        };
        u777 = type(v775) == "string" and not v778[v775] and true or (type(v775) ~= "string" and v775 ~= Players.LocalPlayer and true or u777);
    end;

    local v779 = {
        HeadGear = true,
        FaceWear = true,
        EyeWear = true,
        BodyGear = true,
        BeltGear = true,
        Primary = true,
        Secondary = true,
        Uniform = true,
        Backpack = true,
        NightOptical = true
    };
    local v780 = false;

    if v779[ItemData.ItemType] and not v774 then
        local v781 = ({
            HeadGear = u769.HeadSlot,
            FaceWear = u769.FaceWearSlot,
            EyeWear = u769.EyeWearSlot,
            BodyGear = u769.BodySlot,
            BeltGear = u769.BeltGearSlot,
            Primary = u769.PrimarySlot,
            Secondary = u769.SecondarySlot,
            Sidearm = u769.SidearmSlot,
            Melee = u769.MeleeSlot,
            Uniform = u769.UniformSlot,
            Backpack = u769.BackpackSlot,
            NightOptical = u769.NightOpticalSlot
        })[ItemData.ItemType];
        v780 = v781 and v781.Item and true or v780;
    end;

    local v782 = v779[ItemData.ItemType] and (not v774 and not v780);
    local v783 = u773 and u773.Metadata and u773.Metadata.IsTrader;
    local EquipButton = ContextMenu:FindFirstChild("EquipButton");
    local DropButton = ContextMenu:FindFirstChild("DropButton");
    local DetailsButton = ContextMenu:FindFirstChild("DetailsButton");
    local AddToCartButton = ContextMenu:FindFirstChild("AddToCartButton");
    local v784;

    if ItemData.ItemType == "Ammo" then
        v784 = ItemData.maxRounds;
    else
        v784 = false;
    end;

    local UnloadButton = ContextMenu:FindFirstChild("UnloadButton");

    if UnloadButton then
        if v784 then
            UnloadButton.Visible = (u770.Metadata.CurrentRounds or ItemData.maxRounds) > 0;
        else
            UnloadButton.Visible = false;
        end;
    end;

    local UseButton = ContextMenu:FindFirstChild("UseButton");
    local v785 = ItemData.RequiresVial or ItemData.ItemType == "Injector";
    local v786 = not (ItemData.HealAmount == nil and not (ItemData.HungerRestore or ItemData.ThirstRestore) or u777 or u776);

    if not v786 then
        if v785 then
            v786 = not u777 and not u776;
        else
            v786 = v785;
        end;
    end;

    if UseButton then
        UseButton.Visible = v786;
    end;

    local ModifyButton = ContextMenu:FindFirstChild("ModifyButton");
    local u787;

    if ModifyButton then
        u787 = not u777 and (not u776 and not v783) and (u769:_kitsFor(u770) or {}) or {};
        ModifyButton.Visible = #u787 > 0;
    else
        u787 = {};
    end;

    local RepairButton = ContextMenu:FindFirstChild("RepairButton");

    if not RepairButton then
        local v788 = ContextMenu:FindFirstChild("ModifyButton") or ContextMenu:FindFirstChildWhichIsA("TextButton");

        if v788 then
            RepairButton = v788:Clone();
            RepairButton.Name = "RepairButton";
            RepairButton.Text = "Repair";
            RepairButton.LayoutOrder = 10;
            RepairButton.Visible = false;
            RepairButton.Parent = ContextMenu;
        end;
    end;

    local v789 = false;

    if RepairButton then
        local v790 = not u777 and (not u776 and not v783);

        if v790 and WeaponCondition.IsWeapon(ItemData) then
            local v791 = u769:_displayCondition(u770, ItemData);

            if v791 < WeaponCondition.MaxFor(ItemData) then
                v789 = #WeaponCondition.UsableRepairs(v791) > 0;
            else
                v789 = false;
            end;
        elseif v790 and UniformCondition.IsUniform(ItemData) then
            local v792 = u769:_displayUniformCondition(u770, ItemData);

            if v792 < UniformCondition.MAX then
                v789 = #UniformCondition.UsableRepairs(v792) > 0;
            else
                v789 = false;
            end;
        elseif v790 and MaskCondition.IsMask(ItemData) then
            local v793 = u769:_displayMaskCondition(u770, ItemData);

            if v793 < MaskCondition.MAX then
                v789 = #MaskCondition.UsableRepairs(v793) > 0;
            else
                v789 = false;
            end;
        elseif v790 and HelmetCondition.IsHelmet(ItemData) then
            local v794 = u769:_displayHelmetCondition(u770, ItemData);
            v789 = #HelmetCondition.UsableRepairs(v794, ItemData) > 0;
        end;

        RepairButton.Visible = v789;
    end;

    local InsertPlateButton = ContextMenu:FindFirstChild("InsertPlateButton");

    if not InsertPlateButton then
        local v795 = ContextMenu:FindFirstChild("ModifyButton") or ContextMenu:FindFirstChildWhichIsA("TextButton");

        if v795 then
            InsertPlateButton = v795:Clone();
            InsertPlateButton.Name = "InsertPlateButton";
            InsertPlateButton.Text = "Insert Plate";
            InsertPlateButton.LayoutOrder = 11;
            InsertPlateButton.Visible = false;
            InsertPlateButton.Parent = ContextMenu;
        end;
    end;

    local RemovePlateButton = ContextMenu:FindFirstChild("RemovePlateButton");

    if not RemovePlateButton then
        local v796 = ContextMenu:FindFirstChild("ModifyButton") or ContextMenu:FindFirstChildWhichIsA("TextButton");

        if v796 then
            RemovePlateButton = v796:Clone();
            RemovePlateButton.Name = "RemovePlateButton";
            RemovePlateButton.Text = "Remove Plate";
            RemovePlateButton.LayoutOrder = 12;
            RemovePlateButton.Visible = false;
            RemovePlateButton.Parent = ContextMenu;
        end;
    end;

    local v797, v798;

    if InsertPlateButton or RemovePlateButton then
        v797 = not u777 and (not u776 and not v783);

        if v797 then
            v798 = ArmorPlates.AcceptsInsert(ItemData);
        else
            v798 = v797;
        end;

        if v797 then
            v797 = ArmorPlates.GetInsert(u770) ~= nil;
        end;

        if InsertPlateButton then
            local v799;

            if v798 then
                v799 = not v797;
            else
                v799 = v798;
            end;

            InsertPlateButton.Visible = v799;
        end;

        if RemovePlateButton then
            RemovePlateButton.Visible = v797;
        end;
    else
        v797 = false;
        v798 = false;
    end;

    local InsertFilterButton = ContextMenu:FindFirstChild("InsertFilterButton");

    if not InsertFilterButton then
        local v800 = ContextMenu:FindFirstChild("ModifyButton") or ContextMenu:FindFirstChildWhichIsA("TextButton");

        if v800 then
            InsertFilterButton = v800:Clone();
            InsertFilterButton.Name = "InsertFilterButton";
            InsertFilterButton.Text = "Insert Filter";
            InsertFilterButton.LayoutOrder = 13;
            InsertFilterButton.Visible = false;
            InsertFilterButton.Parent = ContextMenu;
        end;
    end;

    local RemoveFilterButton = ContextMenu:FindFirstChild("RemoveFilterButton");

    if not RemoveFilterButton then
        local v801 = ContextMenu:FindFirstChild("ModifyButton") or ContextMenu:FindFirstChildWhichIsA("TextButton");

        if v801 then
            RemoveFilterButton = v801:Clone();
            RemoveFilterButton.Name = "RemoveFilterButton";
            RemoveFilterButton.Text = "Remove Filter";
            RemoveFilterButton.LayoutOrder = 14;
            RemoveFilterButton.Visible = false;
            RemoveFilterButton.Parent = ContextMenu;
        end;
    end;

    local v802, v803;

    if InsertFilterButton or RemoveFilterButton then
        v802 = not u777 and (not u776 and not v783) and MaskCondition.TakesFilter(ItemData);

        if v802 then
            v803 = MaskCondition.GetFilter(u770) ~= nil;
        else
            v803 = v802;
        end;

        if InsertFilterButton then
            local v804;

            if v802 then
                v804 = not v803;
            else
                v804 = v802;
            end;

            InsertFilterButton.Visible = v804;
        end;

        if RemoveFilterButton then
            RemoveFilterButton.Visible = v803;
        end;
    else
        v803 = false;
        v802 = false;
    end;

    local WearWatchButton = ContextMenu:FindFirstChild("WearWatchButton");
    local RemoveWatchButton = ContextMenu:FindFirstChild("RemoveWatchButton");
    local v805 = ContextMenu:FindFirstChild("ModifyButton") or ContextMenu:FindFirstChildWhichIsA("TextButton");

    if not WearWatchButton and v805 then
        WearWatchButton = v805:Clone();
        WearWatchButton.Name = "WearWatchButton";
        WearWatchButton.Text = "Accessorize";
        WearWatchButton.LayoutOrder = 15;
        WearWatchButton.Visible = false;
        WearWatchButton.Parent = ContextMenu;
    end;

    if not RemoveWatchButton and v805 then
        RemoveWatchButton = v805:Clone();
        RemoveWatchButton.Name = "RemoveWatchButton";
        RemoveWatchButton.Text = "Take off watch";
        RemoveWatchButton.LayoutOrder = 16;
        RemoveWatchButton.Visible = false;
        RemoveWatchButton.Parent = ContextMenu;
    end;

    local v806;

    if ItemData == nil or ItemData.ItemType ~= "Uniform" then
        v806 = false;
    else
        v806 = not u777 and (not u776 and not v783);
    end;

    local v807 = Players.LocalPlayer:GetAttribute("WornWatch") ~= nil;

    if WearWatchButton then
        WearWatchButton.Text = "Accessorize";
        WearWatchButton.Visible = v806;
    end;

    if RemoveWatchButton then
        RemoveWatchButton.Visible = false;
    end;

    if EquipButton then
        local v808;

        if v782 then
            v808 = not v783;
        else
            v808 = v782;
        end;

        EquipButton.Visible = v808;
    end;

    if DropButton then
        if v783 then
            DropButton.Visible = false;
        elseif u777 or u776 then
            DropButton.Text = "Take";
            DropButton.Visible = true;
        else
            DropButton.Text = "Drop";
            DropButton.Visible = true;
        end;
    end;

    local DropToGroundButton = ContextMenu:FindFirstChild("DropToGroundButton");

    if DropToGroundButton then
        local v809 = u777 and not u776 and not (v783 or u770.Metadata and u770.Metadata.TaskBound == true) and PlaceConfig.ItemDropsAllowed();
        DropToGroundButton.Visible = v809;
    end;

    if DetailsButton then
        DetailsButton.Visible = true;
    end;

    if AddToCartButton then
        AddToCartButton.Visible = v783;
    end;

    if v783 then
        if UseButton then
            UseButton.Visible = false;
        end;

        if UnloadButton then
            UnloadButton.Visible = false;
        end;
    end;

    local u810 = u770.Metadata and u770.Metadata.TaskBound == true;

    if u810 then
        if EquipButton then
            EquipButton.Visible = false;
        end;

        if UseButton then
            UseButton.Visible = false;
        end;

        if UnloadButton then
            UnloadButton.Visible = false;
        end;

        if AddToCartButton then
            AddToCartButton.Visible = false;
        end;

        if DropButton then
            DropButton.Visible = true;
            DropButton.Text = "Destroy";
            DropButton:SetAttribute("_ConfirmDestroy", false);
        end;
    end;

    local v811 = u773 and u773.Metadata and u773.Metadata.TiedInstance;
    local u812;

    if ItemData.ItemType == "StorageBox" then
        u812 = v811 == "Stash_" .. Players.LocalPlayer.UserId;
    else
        u812 = false;
    end;

    if DropButton and (ItemData.NonDroppable or u812) and not u810 then
        DropButton.Visible = true;
        DropButton.Text = "Discard";
        DropButton:SetAttribute("_ConfirmDiscard", false);
    elseif DropButton and not PlaceConfig.ItemDropsAllowed() then
        DropButton.Visible = false;
    end;

    local HeaderLabel = ContextMenu:FindFirstChild("HeaderLabel");

    if HeaderLabel then
        HeaderLabel.Text = " " .. (ItemData.Name or "Item");
    end;

    local DropSeparator = ContextMenu:FindFirstChild("DropSeparator");
    local v813 = DropButton and DropButton.Visible and ((DropButton.Text == "Drop" or DropButton.Text == "Destroy") and true or DropButton.Text == "Discard");

    if DropSeparator then
        local v814 = DropButton and DropButton.Visible;

        if not v814 then
            if DropToGroundButton then
                v814 = DropToGroundButton.Visible or false;
            else
                v814 = false;
            end;
        end;

        DropSeparator.Visible = v814;
    end;

    if DropButton then
        if v813 then
            DropButton.BackgroundColor3 = Color3.fromRGB(50, 22, 22);
            DropButton.TextColor3 = Color3.fromRGB(230, 140, 130);
        else
            DropButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25);
            DropButton.TextColor3 = Color3.fromRGB(200, 200, 200);
        end;
    end;

    local Mouse = Players.LocalPlayer:GetMouse();
    ContextMenu.Position = UDim2.new(0, Mouse.X, 0, Mouse.Y);
    ContextMenu.Visible = true;

    if u769._contextMenuConnections then
        for _, v in ipairs(u769._contextMenuConnections) do
            v:Disconnect();
        end;
    end;

    u769._contextMenuConnections = {};

    if RepairButton and v789 then
        table.insert(u769._contextMenuConnections, RepairButton.MouseButton1Click:Connect(function() -- Line: 8564
            -- upvalues: u769 (copy), ContextMenu (copy), u770 (copy), u773 (ref), ItemData (copy)
            u769:_openRepairPicker(ContextMenu, u770, u773, ItemData);
        end));
    end;

    if InsertPlateButton and (v798 and not v797) then
        table.insert(u769._contextMenuConnections, InsertPlateButton.MouseButton1Click:Connect(function() -- Line: 8574
            -- upvalues: u769 (copy), ContextMenu (copy), u770 (copy), u773 (ref), ItemData (copy)
            u769:_openInsertPicker(ContextMenu, u770, u773, ItemData);
        end));
    end;

    if RemovePlateButton and v797 then
        table.insert(u769._contextMenuConnections, RemovePlateButton.MouseButton1Click:Connect(function() -- Line: 8584
            -- upvalues: u773 (ref), ReplicatedStorage (ref), u770 (copy), u769 (copy)
            ReplicatedStorage.Remotes.RemoveArmorPlate:FireServer(u773.Metadata and u773.Metadata.TiedInstance, u770.Metadata and u770.Metadata.ItemIndex, u770.Metadata and u770.Metadata.ID);
            u769:HideContextMenu();
        end));
    end;

    if InsertFilterButton and (v802 and not v803) then
        table.insert(u769._contextMenuConnections, InsertFilterButton.MouseButton1Click:Connect(function() -- Line: 8599
            -- upvalues: u769 (copy), ContextMenu (copy), u770 (copy), u773 (ref), ItemData (copy)
            u769:_openFilterPicker(ContextMenu, u770, u773, ItemData);
        end));
    end;

    if WearWatchButton and v806 then
        table.insert(u769._contextMenuConnections, WearWatchButton.MouseButton1Click:Connect(function() -- Line: 8608
            -- upvalues: u769 (copy), ContextMenu (copy), u770 (copy), u773 (ref)
            u769:_openAccessorizePicker(ContextMenu, u770, u773);
        end));
    end;

    if RemoveWatchButton and (v806 and v807) then
        table.insert(u769._contextMenuConnections, RemoveWatchButton.MouseButton1Click:Connect(function() -- Line: 8618
            -- upvalues: u773 (ref), ReplicatedStorage (ref), u769 (copy)
            ReplicatedStorage.Remotes.RemoveWatch:FireServer(u773.Metadata and u773.Metadata.TiedInstance);
            u769:HideContextMenu();
        end));
    end;

    if RemoveFilterButton and v803 then
        table.insert(u769._contextMenuConnections, RemoveFilterButton.MouseButton1Click:Connect(function() -- Line: 8630
            -- upvalues: u773 (ref), ReplicatedStorage (ref), u770 (copy), u769 (copy)
            ReplicatedStorage.Remotes.RemoveMaskFilter:FireServer(u773.Metadata and u773.Metadata.TiedInstance, u770.Metadata and u770.Metadata.ItemIndex, u770.Metadata and u770.Metadata.ID);
            u769:HideContextMenu();
        end));
    end;

    if ModifyButton and #u787 > 0 then
        table.insert(u769._contextMenuConnections, ModifyButton.MouseButton1Click:Connect(function() -- Line: 8644
            -- upvalues: ContextMenu (copy), u787 (ref), u773 (ref), ReplicatedStorage (ref), u770 (copy), u769 (copy)
            ContextMenu.Visible = false;
            local v815 = u787[1];
            ReplicatedStorage.Remotes.ModifyWeapon:FireServer(u773.Metadata and u773.Metadata.TiedInstance, u770.Metadata and u770.Metadata.ItemIndex, u770.Metadata and u770.Metadata.ID, v815.Metadata and v815.Metadata.ItemIndex, v815.Metadata and v815.Metadata.ID);
            u769:HideContextMenu();
        end));
    end;

    if UseButton and v786 then
        if v785 then
            table.insert(u769._contextMenuConnections, UseButton.MouseButton1Click:Connect(function() -- Line: 8674
                -- upvalues: ReplicatedStorage (ref), InventoryWire (ref), ItemDatabase (ref), u769 (copy), ContextMenu (copy), u773 (ref), u770 (copy), UseButton (copy)
                local v816 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer();
                local v817 = {};

                for _, v in ipairs({ "Pockets", "ChestRig", "BattleBelt", "Backpack" }) do
                    local v818;

                    if v816 then
                        v818 = v816[v];
                    else
                        v818 = v816;
                    end;

                    if v818 and v818.Items then
                        for i, v2 in InventoryWire.Each(v818.Items) do
                            if v2 and v2.ID then
                                local ItemData2 = ItemDatabase.GetItemData(v2.ID);

                                if ItemData2 and ItemData2.ItemType == "Vial" then
                                    table.insert(v817, {
                                        idx = i,
                                        id = v2.ID,
                                        db = ItemData2,
                                        tied = v818.TiedInstance
                                    });
                                end;
                            end;
                        end;
                    end;
                end;

                if #v817 == 0 then
                    u769:ShowToast("No vials available");
                    u769:HideContextMenu();

                    return;
                end;

                for _, child in ipairs(ContextMenu:GetChildren()) do
                    if child:IsA("TextButton") then
                        child.Visible = false;
                    end;
                end;

                local u819 = u773.Metadata and u773.Metadata.TiedInstance;
                local ItemIndex = u770.Metadata.ItemIndex;

                for i, v in ipairs(v817) do
                    local v820 = UseButton:Clone();
                    v820.Name = "VialPicker_" .. i;
                    v820.Text = v.db and v.db.Name or v.id;
                    v820.LayoutOrder = i;
                    v820.Visible = true;
                    v820.Parent = ContextMenu;
                    local idx = v.idx;
                    local u821 = v.db and v.db.Name or "Vial";
                    table.insert(u769._contextMenuConnections, v820.MouseButton1Click:Connect(function() -- Line: 8725
                        -- upvalues: u769 (ref), u821 (copy), ReplicatedStorage (ref), ItemIndex (copy), u819 (copy), idx (copy)
                        u769:ShowToast("Used " .. u821);
                        ReplicatedStorage.Remotes.UseItem:FireServer(ItemIndex, u819, idx);
                        u769:HideContextMenu();
                    end));
                end;
            end));
        else
            table.insert(u769._contextMenuConnections, UseButton.MouseButton1Click:Connect(function() -- Line: 8733
                -- upvalues: ContextMenu (copy), u773 (ref), u770 (copy), ReplicatedStorage (ref), u769 (copy)
                ContextMenu.Visible = false;
                pcall(function() -- Line: 8736
                    -- upvalues: u773 (ref), u770 (ref)
                    u773:RemoveItem(u770);
                end);
                ReplicatedStorage.Remotes.UseItem:FireServer(u770.Metadata.ItemIndex, u773.Metadata and u773.Metadata.TiedInstance);
                u769:HideContextMenu();
            end));
        end;
    end;

    local v822;

    if ItemData.ItemType == "Medical" or ItemData.ItemType == "FoodAndDrink" then
        v822 = not (u777 or u776) and (not v783 and not u810);
    else
        v822 = false;
    end;

    if v822 and UseButton then
        local v823 = UseButton:Clone();
        v823.Name = "QuickAssign_Btn";
        v823.Text = "Assign to Quick Slot";
        v823.Visible = true;
        v823.LayoutOrder = (UseButton.LayoutOrder or 0) + 1;
        v823.Parent = ContextMenu;
        table.insert(u769._contextMenuConnections, v823.MouseButton1Click:Connect(function() -- Line: 8755
            -- upvalues: ContextMenu (copy), UseButton (copy), u769 (copy), ReplicatedStorage (ref), ID (copy)
            for _, child in ipairs(ContextMenu:GetChildren()) do
                if child:IsA("TextButton") then
                    child.Visible = false;
                end;
            end;

            for i = 1, 4 do
                local v824 = UseButton:Clone();
                v824.Name = "QuickAssign_Pick_" .. i;
                v824.Text = "Quick Slot F" .. i;
                v824.LayoutOrder = i;
                v824.Visible = true;
                v824.Parent = ContextMenu;
                table.insert(u769._contextMenuConnections, v824.MouseButton1Click:Connect(function() -- Line: 8768
                    -- upvalues: ReplicatedStorage (ref), i (copy), ID (ref), u769 (ref)
                    ReplicatedStorage.Remotes.SaveQuickSlots:FireServer(i, ID);
                    local success, result = pcall(require, ReplicatedStorage:WaitForChild("HotbarController"));

                    if success and (result and result.SetQuickSlot) then
                        result:SetQuickSlot(i, ID);
                    end;

                    u769:ShowToast("Assigned to Quick Slot F" .. i);
                    u769:HideContextMenu();
                end));
                local _ = i;
            end;
        end));
    end;

    local u825 = (v772 or u773) and (v772 or u773).Metadata and (v772 or u773).Metadata.TiedInstance;
    local v826 = tostring(Players.LocalPlayer.UserId);
    local v827;

    if typeof(u825) == "Instance" or u825 == v826 then
        v827 = true;
    elseif type(u825) == "string" then
        v827 = (u825 == "ChestRigInternal_" .. v826 or (u825 == "BattleBeltInternal_" .. v826 or u825 == "BackpackInternal_" .. v826)) and true or u825 == "Stash_" .. v826;
    else
        v827 = false;
    end;

    local success, result = pcall(require, ReplicatedStorage:WaitForChild("PlayerTradeController", 1));
    local v828 = UseButton or (DropButton or DetailsButton);

    if v827 and (success and (result and (result.IsTrading and (result:IsTrading() and v828)))) then
        local v829 = v828:Clone();
        v829.Name = "TradeOffer_Btn";
        v829.Text = "Add to Trade Offer";
        v829.Visible = true;
        v829.LayoutOrder = -1;
        v829.Parent = ContextMenu;
        local u830 = u770.Metadata and u770.Metadata.ItemIndex;
        table.insert(u769._contextMenuConnections, v829.MouseButton1Click:Connect(function() -- Line: 8802
            -- upvalues: u769 (copy), result (copy), u825 (copy), u830 (copy)
            u769:HideContextMenu();
            task.spawn(function() -- Line: 8804
                -- upvalues: result (ref), u825 (ref), u830 (ref)
                result:OfferFromDrag(u825, u830);
            end);
        end));
    end;

    local success2, result2 = pcall(require, ReplicatedStorage:WaitForChild("SkinCatalog", 1));

    if (success2 and (result2 and (result2.SUPPORTED_SLOTS and (result2.SUPPORTED_SLOTS[ItemData.ItemType] and not (v783 or (u776 or (u777 or u810)))))) and true or false) and UseButton then
        local v831 = UseButton:Clone();
        v831.Name = "ApplySkin_Btn";
        v831.Text = "Apply Skin...";
        v831.Visible = true;
        v831.LayoutOrder = (UseButton.LayoutOrder or 0) + 2;
        v831.Parent = ContextMenu;
        local ItemType = ItemData.ItemType;
        table.insert(u769._contextMenuConnections, v831.MouseButton1Click:Connect(function() -- Line: 8830
            -- upvalues: ReplicatedStorage (ref), ItemDatabase (ref), ItemType (copy), ContextMenu (copy), u769 (copy), UseButton (copy)
            local success3, result3 = pcall(function() -- Line: 8831
                -- upvalues: ReplicatedStorage (ref)
                return ReplicatedStorage.Remotes.GetUnlockedSkins:InvokeServer();
            end);
            local v832 = {};

            for _, v in ipairs(not success3 and {} or result3 or {}) do
                local ItemData2 = ItemDatabase.GetItemData(v);

                if ItemData2 and ItemData2.ItemType == ItemType then
                    table.insert(v832, {
                        id = v,
                        name = ItemData2.Name or v
                    });
                end;
            end;

            for _, child in ipairs(ContextMenu:GetChildren()) do
                if child:IsA("TextButton") then
                    child.Visible = false;
                end;
            end;

            if #v832 == 0 then
                u769:ShowToast("No skins unlocked for " .. ItemType);
                u769:HideContextMenu();

                return;
            end;

            table.sort(v832, function(p833, p834) -- Line: 8853
                return p833.name < p834.name;
            end);
            local v835 = UseButton.Size.Y.Offset > 0 and UseButton.Size.Y.Offset or 28;
            local v836 = #v832 > 8;
            local ScrollingFrame = Instance.new("ScrollingFrame");
            ScrollingFrame.Name = "ApplySkin_Scroll";
            ScrollingFrame.LayoutOrder = 1;
            ScrollingFrame.Size = UDim2.new(1, 0, 0, math.min(#v832, 8) * v835);
            ScrollingFrame.BackgroundTransparency = 1;
            ScrollingFrame.BorderSizePixel = 0;
            ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.Y;
            ScrollingFrame.ScrollBarThickness = v836 and 4 or 0;
            ScrollingFrame.CanvasSize = UDim2.new();
            ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
            ScrollingFrame.Parent = ContextMenu;
            local UIListLayout = Instance.new("UIListLayout");
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder;
            UIListLayout.Parent = ScrollingFrame;

            for i, v in ipairs(v832) do
                local v837 = UseButton:Clone();
                v837.Name = "ApplySkin_Pick_" .. i;
                v837.Text = v.name;
                v837.TextTruncate = Enum.TextTruncate.AtEnd;
                v837.LayoutOrder = i;
                v837.Size = UDim2.new(1, v836 and -4 or 0, 0, v835);
                v837.Visible = true;
                v837.Parent = ScrollingFrame;
                local id = v.id;
                local name = v.name;
                table.insert(u769._contextMenuConnections, v837.MouseButton1Click:Connect(function() -- Line: 8882
                    -- upvalues: ReplicatedStorage (ref), ItemType (ref), id (copy), u769 (ref), name (copy)
                    ReplicatedStorage.Remotes.ApplySkin:FireServer(ItemType, id);
                    u769:ShowToast("Applied " .. name);
                    u769:HideContextMenu();
                end));
            end;

            local v838 = UseButton:Clone();
            v838.Name = "ApplySkin_Remove";
            v838.Text = "Remove Skin";
            v838.LayoutOrder = ScrollingFrame.LayoutOrder + 1;
            v838.Visible = true;
            v838.Parent = ContextMenu;
            table.insert(u769._contextMenuConnections, v838.MouseButton1Click:Connect(function() -- Line: 8894
                -- upvalues: ReplicatedStorage (ref), ItemType (ref), u769 (ref)
                ReplicatedStorage.Remotes.RemoveSkin:FireServer(ItemType);
                u769:ShowToast("Removed skin");
                u769:HideContextMenu();
            end));
        end));
    end;

    if ItemData.VisorDownModel and (ItemData.ItemType == "HeadGear" and (v774 and UseButton)) then
        local v839 = UseButton:Clone();
        v839.Name = "ToggleVisor_Btn";
        v839.Text = "Toggle Visor";
        v839.Visible = true;
        v839.LayoutOrder = (UseButton.LayoutOrder or 0) + 3;
        v839.Parent = ContextMenu;
        table.insert(u769._contextMenuConnections, v839.MouseButton1Click:Connect(function() -- Line: 8912
            -- upvalues: ReplicatedStorage (ref), u769 (copy)
            local ToggleHelmetVisor = ReplicatedStorage.Remotes:FindFirstChild("ToggleHelmetVisor");

            if ToggleHelmetVisor then
                ToggleHelmetVisor:FireServer();
            end;

            u769:HideContextMenu();
        end));
    end;

    if DropToGroundButton and DropToGroundButton.Visible then
        table.insert(u769._contextMenuConnections, DropToGroundButton.MouseButton1Click:Connect(function() -- Line: 8930
            -- upvalues: ContextMenu (copy), u773 (ref), u769 (copy), ItemData (copy), ReplicatedStorage (ref), u770 (copy), ID (copy)
            ContextMenu.Visible = false;
            local v840 = u773.Metadata and u773.Metadata.TiedInstance;

            if v840 then
                u769:PlaySound("Drop", ItemData.ItemType);
                ReplicatedStorage.Remotes.DropItem:FireServer(u770.Metadata.ItemIndex, v840, ID);
            end;

            u769:HideContextMenu();
        end));
    end;

    if DropButton then
        table.insert(u769._contextMenuConnections, DropButton.MouseButton1Click:Connect(function() -- Line: 8943
            -- upvalues: u810 (copy), DropButton (copy), u770 (copy), u769 (copy), ReplicatedStorage (ref), ItemData (copy), u812 (copy), u773 (ref), ID (copy), ContextMenu (copy), u777 (ref), u776 (copy), Players (ref)
            if u810 then
                if DropButton:GetAttribute("_ConfirmDestroy") then
                    DropButton:SetAttribute("_ConfirmDestroy", false);
                    local v841 = u770.Metadata and u770.Metadata.TaskId;
                    u769:HideContextMenu();

                    if not v841 then
                        u769:ShowToast("Cannot destroy: this item has lost its task link");

                        return;
                    end;

                    local success3, result3 = pcall(require, ReplicatedStorage:WaitForChild("TaskController", 2));

                    if not (success3 and result3) then
                        u769:ShowToast("Could not destroy: task system unavailable");

                        return;
                    end;

                    local v842 = result3:Abandon(v841);

                    if not (v842 and v842.ok) then
                        u769:ShowToast("Could not destroy: " .. tostring(v842 and v842.error or "no response"));

                        return;
                    end;
                else
                    DropButton:SetAttribute("_ConfirmDestroy", true);
                    DropButton.Text = "Confirm? quest fails";
                    task.delay(3, function() -- Line: 8972
                        -- upvalues: DropButton (ref)
                        if DropButton and (DropButton.Parent and DropButton:GetAttribute("_ConfirmDestroy")) then
                            DropButton:SetAttribute("_ConfirmDestroy", false);
                            DropButton.Text = "Destroy";
                        end;
                    end);
                end;

                return;
            end;

            if not (ItemData.NonDroppable or u812) then
                ContextMenu.Visible = false;

                if u777 or u776 then
                    if ItemData.IsCurrency then
                        local v843 = u773.Metadata and u773.Metadata.TiedInstance;
                        pcall(function() -- Line: 9012
                            -- upvalues: u773 (ref), u770 (ref)
                            u773:RemoveItem(u770);
                        end);

                        if v843 then
                            ReplicatedStorage.Remotes.PickupCurrency:FireServer(v843, u770.Metadata.ItemIndex);
                        end;

                        u769:HideContextMenu();

                        return;
                    end;

                    u769:PlaySound("Move", ItemData.ItemType);
                    ReplicatedStorage.Remotes.ContextMenuAction:FireServer("Take", u770.Metadata.ItemIndex, u773.Metadata and u773.Metadata.TiedInstance, ID);
                    task.delay(0.15, function() -- Line: 9033
                        -- upvalues: u769 (ref), ReplicatedStorage (ref)
                        u769._refreshEpoch = (u769._refreshEpoch or 0) + 1;
                        local _refreshEpoch = u769._refreshEpoch;
                        local v844 = ReplicatedStorage.Remotes.GetAllInventories:InvokeServer();

                        if u769._refreshEpoch ~= _refreshEpoch then
                            return;
                        end;

                        if v844 then
                            if v844.Pockets and u769.LocalInventory then
                                u769:LoadInventory(u769.LocalInventory, v844.Pockets);
                            end;

                            if v844.ChestRig and u769.ChestRigInventory then
                                u769:LoadInventory(u769.ChestRigInventory, v844.ChestRig);
                            end;

                            if v844.BattleBelt and u769.BattleBeltInventory then
                                u769:LoadInventory(u769.BattleBeltInventory, v844.BattleBelt);
                            end;

                            if v844.Backpack and u769.MainInventory then
                                u769:LoadInventory(u769.MainInventory, v844.Backpack);
                            end;
                        end;
                    end);
                else
                    u769:PlaySound("Drop", ItemData.ItemType);
                    local Character = Players.LocalPlayer.Character;
                    local v845 = Character and Character:FindFirstChildOfClass("Humanoid");

                    if v845 then
                        v845:UnequipTools();
                    end;

                    pcall(function() -- Line: 9069
                        -- upvalues: u773 (ref), u770 (ref)
                        u773:RemoveItem(u770);
                    end);
                    ReplicatedStorage.Remotes.DropItem:FireServer(u770.Metadata.ItemIndex, u773.Metadata and u773.Metadata.TiedInstance, ID);

                    if u769.CurrentStoragePart then
                        u769:CloseInventoryUI();
                    end;
                end;

                u769:HideContextMenu();

                return;
            end;

            if not DropButton:GetAttribute("_ConfirmDiscard") then
                DropButton:SetAttribute("_ConfirmDiscard", true);
                DropButton.Text = "Confirm? permanent";
                task.delay(3, function() -- Line: 8994
                    -- upvalues: DropButton (ref)
                    if DropButton and (DropButton.Parent and DropButton:GetAttribute("_ConfirmDiscard")) then
                        DropButton:SetAttribute("_ConfirmDiscard", false);
                        DropButton.Text = "Discard";
                    end;
                end);

                return;
            end;

            DropButton:SetAttribute("_ConfirmDiscard", false);
            local v846 = u773.Metadata and u773.Metadata.TiedInstance;
            pcall(function() -- Line: 8988
                -- upvalues: u773 (ref), u770 (ref)
                u773:RemoveItem(u770);
            end);
            ReplicatedStorage.Remotes.DiscardItem:FireServer(u770.Metadata.ItemIndex, v846, ID);
            u769:HideContextMenu();
        end));
    end;

    if AddToCartButton and v783 then
        table.insert(u769._contextMenuConnections, AddToCartButton.MouseButton1Click:Connect(function() -- Line: 9087
            -- upvalues: ContextMenu (copy), u770 (copy), u769 (copy)
            ContextMenu.Visible = false;
            local ID2 = u770.Metadata.ID;
            local Price = u770.Metadata.Price;

            if not Price and u769.SellPanelPriceLookup then
                Price = u769.SellPanelPriceLookup[ID2];
            end;

            if ID2 and Price then
                u769:AddToBuyCart(ID2, Price);
            end;

            u769:HideContextMenu();
        end));
    end;

    if EquipButton and v782 then
        table.insert(u769._contextMenuConnections, EquipButton.MouseButton1Click:Connect(function() -- Line: 9103
            -- upvalues: ContextMenu (copy), u769 (copy), ItemData (copy), u773 (ref), u770 (copy), GridPack (ref), ReplicatedStorage (ref), ID (copy)
            ContextMenu.Visible = false;
            u769:PlaySound("Move", ItemData.ItemType);
            pcall(function() -- Line: 9107
                -- upvalues: u773 (ref), u770 (ref)
                u773:RemoveItem(u770);
            end);
            local u847 = ({
                HeadGear = u769.HeadSlot,
                FaceWear = u769.FaceWearSlot,
                EyeWear = u769.EyeWearSlot,
                BodyGear = u769.BodySlot,
                BeltGear = u769.BeltGearSlot,
                Primary = u769.PrimarySlot,
                Secondary = u769.SecondarySlot,
                Sidearm = u769.SidearmSlot,
                Melee = u769.MeleeSlot,
                Uniform = u769.UniformSlot,
                Backpack = u769.BackpackSlot,
                NightOptical = u769.NightOpticalSlot
            })[ItemData.ItemType];

            if u847 then
                local v848 = u769:CreateMoveMiddleware();
                local u849 = GridPack.createItem({
                    Rotation = 0,
                    Assets = {
                        Item = ReplicatedStorage.GridPack.Item
                    },
                    Position = Vector2.new(0, 0),
                    Size = ItemData.Size,
                    Metadata = {
                        ItemIndex = 1,
                        ItemType = ItemData.ItemType,
                        ID = ID
                    },
                    MoveMiddleware = v848
                });

                if u849.ItemElement then
                    u849.ItemElement.BackgroundColor3 = ItemData.BackgroundColor;
                    u849.ItemElement.BackgroundTransparency = ItemData.BackgroundTransparency or 0;
                    local v850 = u849.ItemElement:FindFirstChildOfClass("ImageLabel");

                    if v850 then
                        v850.Image = ItemData.ImageID;
                    end;

                    u849.ItemElement.Position = UDim2.new(0, 0, 0, 0);
                end;

                pcall(function() -- Line: 9142
                    -- upvalues: u847 (copy), u849 (copy)
                    u847:ChangeItem(u849);
                end);

                if u849.ItemElement then
                    local ItemElement = u849.ItemElement;

                    local function forcePosition() -- Line: 9146
                        -- upvalues: ItemElement (copy)
                        ItemElement.Position = UDim2.new(0, 0, 0, 0);
                        ItemElement.Size = UDim2.new(1, 0, 1, 0);
                        ItemElement.Rotation = 0;
                    end;

                    ItemElement.Position = UDim2.new(0, 0, 0, 0);
                    ItemElement.Size = UDim2.new(1, 0, 1, 0);
                    ItemElement.Rotation = 0;
                    task.defer(forcePosition);
                    task.delay(0.05, forcePosition);
                    task.delay(0.1, forcePosition);
                end;

                u769:BindDropHandler(u849, u847);

                if ItemData.ItemType == "BodyGear" then
                    u769:UpdateChestRigGridSize(ID);
                elseif ItemData.ItemType == "BeltGear" then
                    u769:UpdateBattleBeltGridSize(ID);
                elseif ItemData.ItemType == "Backpack" then
                    u769:UpdateBackpackGridSize(ID);
                end;
            end;

            ReplicatedStorage.Remotes.ContextMenuAction:FireServer("Equip", u770.Metadata.ItemIndex, u773.Metadata and u773.Metadata.TiedInstance, ID);
            u769:HideContextMenu();
        end));
    end;

    if UnloadButton and v784 then
        table.insert(u769._contextMenuConnections, UnloadButton.MouseButton1Click:Connect(function() -- Line: 9174
            -- upvalues: ContextMenu (copy), u773 (ref), ReplicatedStorage (ref), u770 (copy), u769 (copy)
            ContextMenu.Visible = false;
            ReplicatedStorage.Remotes.UnloadMagazine:FireServer(u770.Metadata.ItemIndex, u773.Metadata and u773.Metadata.TiedInstance);
            u769:HideContextMenu();
        end));
    end;

    local OpenContainerButton = ContextMenu:FindFirstChild("OpenContainerButton");
    local u851 = u770.Metadata and u770.Metadata.DroppedContainerTied ~= nil;
    local v852 = u773.ChangeItem ~= nil;
    local v853 = not v852;

    if v853 then
        if ItemData then
            if ItemData.SlotSize == nil then
                v853 = false;
            else
                v853 = (ItemData.ItemType == "Backpack" or (ItemData.ItemType == "BodyGear" or ItemData.ItemType == "BeltGear")) and true or ItemData.ItemType == "StorageBox";
            end;
        else
            v853 = ItemData;
        end;
    end;

    local v854 = u851 or v853;

    if OpenContainerButton then
        OpenContainerButton.Visible = v854;
    end;

    if OpenContainerButton and v854 then
        table.insert(u769._contextMenuConnections, OpenContainerButton.MouseButton1Click:Connect(function() -- Line: 9204
            -- upvalues: ContextMenu (copy), ReplicatedStorage (ref), u851 (copy), u770 (copy), u773 (ref), u769 (copy), ItemDatabase (ref)
            ContextMenu.Visible = false;
            local OpenableContainer = require(ReplicatedStorage:WaitForChild("OpenableContainer"));
            local u855;

            if u851 then
                u855 = ReplicatedStorage.Remotes.RequestOpenContainer:InvokeServer(u770.Metadata.DroppedContainerTied);
            else
                u855 = ReplicatedStorage.Remotes.RequestOpenInventoryContainer:InvokeServer(u773.Metadata and u773.Metadata.TiedInstance, u770.Metadata.ItemIndex, u770.Metadata.ID);
            end;

            if not u855 then
                u769:ShowToast("Container is empty or missing");
                u769:HideContextMenu();

                return;
            end;

            local Open = OpenableContainer.Open;
            local v856 = {
                tiedInstance = u855.tiedInstance,
                items = u855.items,
                gridSize = u855.gridSize
            };
            v856.parentTied = u773.Metadata and u773.Metadata.TiedInstance;
            v856.title = u855.title or (ItemDatabase.GetItemData(u770.Metadata.ID).Name or "Container");
            v856.moveMiddleware = u769:CreateMoveMiddleware();

            function v856.onClose() -- Line: 9232
                -- upvalues: ReplicatedStorage (ref), u855 (ref)
                local CloseNestedContainer = ReplicatedStorage.Remotes:FindFirstChild("CloseNestedContainer");

                if CloseNestedContainer then
                    CloseNestedContainer:FireServer(u855.tiedInstance);
                end;
            end;

            local _, v857 = Open(v856);

            if v857 then
                if u855.maxItemWidth then
                    v857.Metadata.MaxItemWidth = u855.maxItemWidth;
                end;

                v857.IsColliding = u769:CreateGridIsColliding();
                v857:ConnectTransferLink(u769.TransferLink);
                u769:LoadInventory(v857, {
                    Items = u855.items,
                    GridSize = u855.gridSize,
                    TiedInstance = u855.tiedInstance
                });
            end;

            u769:HideContextMenu();
        end));
    end;

    local UnloadMagButton = ContextMenu:FindFirstChild("UnloadMagButton");
    local v858 = false;

    if ItemData.MagType and v852 then
        local Character = Players.LocalPlayer.Character;

        if Character then
            local v859 = Character:FindFirstChild(ItemData.ToolName);

            if not v859 then
                local Backpack = Players.LocalPlayer:FindFirstChild("Backpack");

                if Backpack then
                    v859 = Backpack:FindFirstChild(ItemData.ToolName);
                end;
            end;

            v858 = v859 and not v859:GetAttribute("MagUnloaded") and true or v858;
        end;
    end;

    if UnloadMagButton then
        UnloadMagButton.Visible = v858;
    end;

    if UnloadMagButton and v858 then
        table.insert(u769._contextMenuConnections, UnloadMagButton.MouseButton1Click:Connect(function() -- Line: 9273
            -- upvalues: ContextMenu (copy), u773 (ref), u769 (copy), ReplicatedStorage (ref)
            ContextMenu.Visible = false;
            local v860 = nil;
            local v861 = nil;

            if u773 == u769.PrimarySlot then
                v861 = u769.PrimaryFrame;
                v860 = "Primary";
            elseif u773 == u769.SecondarySlot then
                v861 = u769.SecondaryFrame;
                v860 = "Secondary";
            elseif u773 == u769.SidearmSlot then
                v861 = u769.SidearmFrame;
                v860 = "Sidearm";
            elseif u773 == u769.MeleeSlot then
                v861 = u769.MeleeFrame;
                v860 = "Melee";
            end;

            if v860 then
                ReplicatedStorage.Remotes.UnloadWeaponMag:FireServer(v860);

                if v861 then
                    local v862 = v861:FindFirstChild("WeaponInfoStrip") or v861;
                    local WeaponRoundsLabel = v862:FindFirstChild("WeaponRoundsLabel");

                    if WeaponRoundsLabel then
                        WeaponRoundsLabel.Visible = false;
                    end;

                    local WeaponLoadedLabel = v862:FindFirstChild("WeaponLoadedLabel");

                    if WeaponLoadedLabel then
                        WeaponLoadedLabel.Text = "Unloaded";
                        WeaponLoadedLabel.TextColor3 = Color3.fromRGB(170, 170, 170);
                    end;
                end;
            end;

            u769:HideContextMenu();
        end));
    end;

    local LoadMagButton = ContextMenu:FindFirstChild("LoadMagButton");
    local v863 = false;

    if ItemData.MagType and v852 then
        local Character = Players.LocalPlayer.Character;

        if Character then
            local v864 = Character:FindFirstChild(ItemData.ToolName);

            if not v864 then
                local Backpack = Players.LocalPlayer:FindFirstChild("Backpack");

                if Backpack then
                    v864 = Backpack:FindFirstChild(ItemData.ToolName);
                end;
            end;

            if v864 then
                local Ammo = v864:FindFirstChild("Ammo");

                if Ammo then
                    Ammo = Ammo:FindFirstChild("MagAmmo");
                end;

                v863 = Ammo and Ammo.Value <= 0 and true or v863;
            end;
        end;
    end;

    if LoadMagButton then
        LoadMagButton.Visible = v863;
    end;

    if LoadMagButton and v863 then
        table.insert(u769._contextMenuConnections, LoadMagButton.MouseButton1Click:Connect(function() -- Line: 9331
            -- upvalues: ContextMenu (copy), u773 (ref), u769 (copy), ReplicatedStorage (ref)
            ContextMenu.Visible = false;
            local v865 = nil;
            local v866 = nil;

            if u773 == u769.PrimarySlot then
                v866 = u769.PrimaryFrame;
                v865 = "Primary";
            elseif u773 == u769.SecondarySlot then
                v866 = u769.SecondaryFrame;
                v865 = "Secondary";
            elseif u773 == u769.SidearmSlot then
                v866 = u769.SidearmFrame;
                v865 = "Sidearm";
            elseif u773 == u769.MeleeSlot then
                v866 = u769.MeleeFrame;
                v865 = "Melee";
            end;

            if v865 then
                ReplicatedStorage.Remotes.LoadWeaponMag:FireServer(v865);

                if v866 then
                    local v867 = v866:FindFirstChild("WeaponInfoStrip") or v866;
                    local WeaponRoundsLabel = v867:FindFirstChild("WeaponRoundsLabel");

                    if WeaponRoundsLabel then
                        WeaponRoundsLabel.Text = "Full";
                        WeaponRoundsLabel.TextColor3 = Color3.fromRGB(120, 220, 120);
                        WeaponRoundsLabel.Visible = true;
                    end;

                    local WeaponLoadedLabel = v867:FindFirstChild("WeaponLoadedLabel");

                    if WeaponLoadedLabel then
                        WeaponLoadedLabel.Text = "Loaded";
                        WeaponLoadedLabel.TextColor3 = Color3.fromRGB(120, 200, 120);
                    end;
                end;
            end;

            u769:HideContextMenu();
        end));
    end;

    if DetailsButton then
        table.insert(u769._contextMenuConnections, DetailsButton.MouseButton1Click:Connect(function() -- Line: 9366
            -- upvalues: u769 (copy), ID (copy), u770 (copy)
            u769:HideContextMenu();
            u769:ShowDetailsPanel(ID, u770);
        end));
    end;

    local v868 = u770.Metadata and u770.Metadata.NoteText;
    local ReadButton = ContextMenu:FindFirstChild("ReadButton");

    if v868 and (not ReadButton and DetailsButton) then
        ReadButton = DetailsButton:Clone();
        ReadButton.Name = "ReadButton";
        ReadButton.Text = "Read";
        ReadButton.Parent = ContextMenu;
    end;

    if ReadButton then
        ReadButton.Visible = v868 ~= nil;

        if v868 then
            table.insert(u769._contextMenuConnections, ReadButton.MouseButton1Click:Connect(function() -- Line: 9394
                -- upvalues: u769 (copy), u770 (copy)
                u769:HideContextMenu();
                u769:ShowNotePanel(u770);
            end));
        end;
    end;

    table.insert(u769._contextMenuConnections, UserInputService.InputBegan:Connect(function(p869) -- Line: 9402
        -- upvalues: ContextMenu (copy), Players (ref), u769 (copy)
        if p869.UserInputType == Enum.UserInputType.MouseButton1 or p869.UserInputType == Enum.UserInputType.MouseButton2 then
            task.defer(function() -- Line: 9404
                -- upvalues: ContextMenu (ref), Players (ref), u769 (ref)
                if not ContextMenu.Visible then
                    return;
                end;

                local Mouse2 = Players.LocalPlayer:GetMouse();
                local Vector2_new_ret = Vector2.new(Mouse2.X, Mouse2.Y);
                local AbsolutePosition = ContextMenu.AbsolutePosition;
                local AbsoluteSize = ContextMenu.AbsoluteSize;

                if Vector2_new_ret.X < AbsolutePosition.X or (Vector2_new_ret.X > AbsolutePosition.X + AbsoluteSize.X or (Vector2_new_ret.Y < AbsolutePosition.Y or Vector2_new_ret.Y > AbsolutePosition.Y + AbsoluteSize.Y)) then
                    u769:HideContextMenu();
                end;
            end);
        end;

        if p869.KeyCode == Enum.KeyCode.Escape then
            u769:HideContextMenu();
        end;
    end));
end;

function u6.ShowNotePanel(u870, p871) -- Line: 9424
    -- upvalues: Players (copy)
    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if not InventoryGui then
        return;
    end;

    local v872 = p871 and p871.Metadata and p871.Metadata.NoteText;

    if not v872 then
        return;
    end;

    local v873 = p871.Metadata and p871.Metadata.NoteTitle or "Recovered note";
    local NotePanel = InventoryGui:FindFirstChild("NotePanel");

    if not NotePanel then
        NotePanel = Instance.new("Frame");
        NotePanel.Name = "NotePanel";
        NotePanel.Size = UDim2.fromOffset(430, 300);
        NotePanel.Position = UDim2.fromScale(0.5, 0.5);
        NotePanel.AnchorPoint = Vector2.new(0.5, 0.5);
        NotePanel.BackgroundColor3 = Color3.fromRGB(20, 20, 18);
        NotePanel.BorderSizePixel = 0;
        NotePanel.ZIndex = 200;
        NotePanel.Visible = false;
        NotePanel.Parent = InventoryGui;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Color = Color3.fromRGB(78, 74, 60);
        UIStroke.Thickness = 1;
        UIStroke.Parent = NotePanel;
        local UIPadding = Instance.new("UIPadding");
        UIPadding.PaddingTop = UDim.new(0, 12);
        UIPadding.PaddingBottom = UDim.new(0, 12);
        UIPadding.PaddingLeft = UDim.new(0, 14);
        UIPadding.PaddingRight = UDim.new(0, 14);
        UIPadding.Parent = NotePanel;
        local TextLabel = Instance.new("TextLabel");
        TextLabel.Name = "NoteTitle";
        TextLabel.Size = UDim2.new(1, -28, 0, 22);
        TextLabel.BackgroundTransparency = 1;
        TextLabel.Font = Enum.Font.GothamBold;
        TextLabel.TextSize = 15;
        TextLabel.TextColor3 = Color3.fromRGB(214, 198, 150);
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel.ZIndex = 201;
        TextLabel.Parent = NotePanel;
        local TextButton = Instance.new("TextButton");
        TextButton.Name = "CloseButton";
        TextButton.Size = UDim2.fromOffset(22, 22);
        TextButton.Position = UDim2.new(1, 0, 0, 0);
        TextButton.AnchorPoint = Vector2.new(1, 0);
        TextButton.BackgroundTransparency = 1;
        TextButton.Font = Enum.Font.GothamBold;
        TextButton.TextSize = 16;
        TextButton.Text = "X";
        TextButton.TextColor3 = Color3.fromRGB(190, 190, 190);
        TextButton.ZIndex = 202;
        TextButton.Parent = NotePanel;
        TextButton.MouseButton1Click:Connect(function() -- Line: 9479
            -- upvalues: u870 (copy)
            u870:HideNotePanel();
        end);
        local Frame = Instance.new("Frame");
        Frame.Name = "Divider";
        Frame.Size = UDim2.new(1, 0, 0, 1);
        Frame.Position = UDim2.fromOffset(0, 30);
        Frame.BackgroundColor3 = Color3.fromRGB(78, 74, 60);
        Frame.BorderSizePixel = 0;
        Frame.ZIndex = 201;
        Frame.Parent = NotePanel;
        local ScrollingFrame = Instance.new("ScrollingFrame");
        ScrollingFrame.Name = "Body";
        ScrollingFrame.Size = UDim2.new(1, 0, 1, -42);
        ScrollingFrame.Position = UDim2.fromOffset(0, 40);
        ScrollingFrame.BackgroundTransparency = 1;
        ScrollingFrame.BorderSizePixel = 0;
        ScrollingFrame.ScrollBarThickness = 4;
        ScrollingFrame.CanvasSize = UDim2.new();
        ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y;
        ScrollingFrame.ZIndex = 201;
        ScrollingFrame.Parent = NotePanel;
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = "BodyText";
        TextLabel2.Size = UDim2.new(1, -8, 0, 0);
        TextLabel2.AutomaticSize = Enum.AutomaticSize.Y;
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Font = Enum.Font.Gotham;
        TextLabel2.TextSize = 14;
        TextLabel2.TextColor3 = Color3.fromRGB(206, 206, 200);
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
        TextLabel2.TextWrapped = true;
        TextLabel2.RichText = false;
        TextLabel2.Text = "";
        TextLabel2.ZIndex = 201;
        TextLabel2.Parent = ScrollingFrame;
    end;

    local NoteTitle = NotePanel:FindFirstChild("NoteTitle");

    if NoteTitle then
        NoteTitle.Text = v873;
    end;

    local Body = NotePanel:FindFirstChild("Body");
    local v874;

    if Body then
        v874 = Body:FindFirstChild("BodyText");
    else
        v874 = Body;
    end;

    if v874 then
        v874.Text = v872;
    end;

    if Body then
        Body.CanvasPosition = Vector2.new(0, 0);
    end;

    NotePanel.Visible = true;
end;

function u6.HideNotePanel(p875) -- Line: 9530
    -- upvalues: Players (copy)
    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if not InventoryGui then
        return;
    end;

    local NotePanel = InventoryGui:FindFirstChild("NotePanel");

    if NotePanel then
        NotePanel.Visible = false;
    end;
end;

function u6.HideContextMenu(p876) -- Line: 9537
    -- upvalues: Players (copy)
    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if not InventoryGui then
        return;
    end;

    local ContextMenu = InventoryGui:FindFirstChild("ContextMenu");

    if ContextMenu then
        ContextMenu.Visible = false;
    end;

    if p876._contextMenuConnections then
        for _, v in ipairs(p876._contextMenuConnections) do
            v:Disconnect();
        end;

        p876._contextMenuConnections = nil;
    end;

    if p876._refreshWeight then
        task.delay(0.5, p876._refreshWeight);
        task.delay(1.5, p876._refreshWeight);
    end;
end;

function u6.ShowDetailsPanel(u877, p878, p879) -- Line: 9557
    -- upvalues: Players (copy), ItemDatabase (copy), ReplicatedStorage (copy), u1 (copy), ArmorPlates (copy), WeaponCondition (copy), UniformCondition (copy), HelmetCondition (copy), MaskCondition (copy), UserInputService (copy)
    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");

    if not InventoryGui then
        return;
    end;

    local DetailsPanel = InventoryGui:FindFirstChild("DetailsPanel");

    if not DetailsPanel then
        return;
    end;

    local ItemData = ItemDatabase.GetItemData(p878);

    if not ItemData then
        return;
    end;

    u877:HideDetailsPanel();
    local ItemName = DetailsPanel:FindFirstChild("ItemName");

    if ItemName then
        ItemName.Text = ItemData.Name or p878;
    end;

    local ItemType = DetailsPanel:FindFirstChild("ItemType");

    if ItemType then
        ItemType.Text = ItemData.ItemType or "";
    end;

    local Description = DetailsPanel:FindFirstChild("Description");

    if Description then
        Description.Text = ItemData.Description or "No description available.";
    end;

    local StatsFrame = DetailsPanel:FindFirstChild("StatsFrame");

    if StatsFrame then
        for _, child in StatsFrame:GetChildren() do
            if child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;

        local u880 = 0;

        local function addStat(p881, p882, p883) -- Line: 9591
            -- upvalues: u880 (ref), StatsFrame (copy)
            u880 = u880 + 1;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Size = UDim2.new(1, 0, 0, 16);
            TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
            TextLabel.TextWrapped = true;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Text = p881 .. ": " .. tostring(p882);
            TextLabel.TextColor3 = p883 or Color3.fromRGB(200, 200, 200);
            TextLabel.Font = Enum.Font.Gotham;
            TextLabel.TextSize = 12;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.ZIndex = 101;
            TextLabel.LayoutOrder = u880;
            TextLabel.Parent = StatsFrame;
        end;

        local function addSectionHeader(p884) -- Line: 9611
            -- upvalues: u880 (ref), StatsFrame (copy)
            u880 = u880 + 1;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Size = UDim2.new(1, 0, 0, 20);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Text = p884;
            TextLabel.TextColor3 = Color3.fromRGB(220, 200, 120);
            TextLabel.Font = Enum.Font.GothamBold;
            TextLabel.TextSize = 12;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.ZIndex = 101;
            TextLabel.LayoutOrder = u880;
            TextLabel.Parent = StatsFrame;
        end;

        addStat("Size", ItemData.Size.X .. "x" .. ItemData.Size.Y);

        if ItemData.SlotSize then
            addStat("Storage", ItemData.SlotSize.X * ItemData.SlotSize.Y .. " slots (" .. ItemData.SlotSize.X .. "x" .. ItemData.SlotSize.Y .. ")");
        end;

        if ItemData.MaxItemWidth then
            addStat("Max Item Width", ItemData.MaxItemWidth .. " slot(s)");
        end;

        if ItemData.ItemType == "Backpack" then
            local BackpackTraits = require(ReplicatedStorage:WaitForChild("ItemDatabase"):WaitForChild("BackpackTraits"));

            for _, v in ipairs(BackpackTraits.Rows(ItemData)) do
                addStat(v[1], v[2], v[3] and Color3.fromRGB(140, 220, 80) or Color3.fromRGB(230, 110, 110));
            end;
        end;

        local v885 = u1.Lock.AttachedSlots(p878);
        local v886 = u1.Lock.GearSlots(p878);

        if v885 and v886 then
            local u887;

            if u877.UniformSlot and u877.UniformSlot.Item == p879 then
                u887 = true;
            else
                u887 = u877.BodySlot and u877.BodySlot.Item == p879;
            end;

            local v888;

            if p879 then
                v888 = p879.Metadata;
            else
                v888 = p879;
            end;

            local u889;

            if type(v888) == "table" then
                u889 = type(v888.AttachedGearState) == "table" and v888.AttachedGearState;

                if not u889 then
                    if type(v888.Metadata) == "table" and type(v888.Metadata.AttachedGearState) == "table" then
                        u889 = v888.Metadata.AttachedGearState;
                    else
                        u889 = false;
                    end;
                end;
            else
                u889 = false;
            end;

            local v890 = ItemData.SlotSize and (ItemData.SlotSize.X * ItemData.SlotSize.Y or 0) or 0;
            local v891 = {};

            local function partState(p892, p893) -- Line: 9677
                -- upvalues: u887 (copy), u877 (copy), u889 (copy)
                if u887 then
                    local v894 = p892 == "BodyGear" and u877.BodySlot;

                    if not v894 then
                        if p892 == "BeltGear" then
                            v894 = u877.BeltGearSlot;
                        else
                            v894 = false;
                        end;
                    end;

                    if v894 then
                        v894 = v894.Item;
                    end;

                    if v894 and (v894.Metadata and v894.Metadata.ID == p893) then
                        return v894;
                    end;
                end;

                local v895 = u889 and u889[p892];

                return type(v895) == "table" and {
                    CurrentDurability = v895.CurrentDurability,
                    Metadata = {
                        Insert = v895.Insert
                    }
                } or nil;
            end;

            for _, v in ipairs(u1.ORDER) do
                local v896 = v885[v] and v886[v];
                local v897;

                if v896 then
                    v897 = ItemDatabase.GetItemData(v896);
                else
                    v897 = v896;
                end;

                if v897 then
                    v891[#v891 + 1] = {
                        slotType = v,
                        id = v896,
                        db = v897
                    };

                    if v897.SlotSize then
                        v890 = v890 + v897.SlotSize.X * v897.SlotSize.Y;
                    end;
                end;
            end;

            if #v891 > 0 then
                local v898 = ItemData.ItemType == "Uniform" and "suit" or "vest";
                addSectionHeader("BUILT-IN GEAR");

                for _, v in ipairs(v891) do
                    local db = v.db;
                    addStat(u1.LABEL[v.slotType] or v.slotType, db.Name or v.id, u1.COLOR);

                    if db.SlotSize then
                        addStat(u1.INDENT .. "Storage", string.format("%d slots (%dx%d)%s", db.SlotSize.X * db.SlotSize.Y, db.SlotSize.X, db.SlotSize.Y, db.MaxItemWidth == 1 and ", one item wide" or ""));
                    end;

                    local v899 = partState(v.slotType, v.id);

                    if ArmorPlates.HasSoftArmor(db) then
                        local v900 = u1.INDENT .. "Soft Armor";
                        local string_format = string.format;
                        local SoftArmorClass = db.SoftArmorClass;
                        local v901 = ArmorPlates.VestCondition(v899, db);
                        addStat(v900, string_format("Class %d, %d / %d", SoftArmorClass, math.floor(v901), db.ArmorMaxDurability), Color3.fromRGB(100, 180, 255));
                    end;

                    if type(db.RuptureResist) == "number" and db.RuptureResist > 0 then
                        addStat(u1.INDENT .. "Rupture Resistance", string.format("%d%%", (math.floor(db.RuptureResist * 100 + 0.5))), Color3.fromRGB(180, 140, 100));
                    end;

                    if ArmorPlates.AcceptsInsert(db) then
                        local Insert = ArmorPlates.GetInsert(v899);
                        local v902;

                        if Insert then
                            v902 = ItemDatabase.GetItemData(Insert.ID);
                        else
                            v902 = Insert;
                        end;

                        addStat(u1.INDENT .. "Plate Pocket", Insert and (v902 and v902.Name or (Insert.ID or "Empty")) or "Empty", Insert and Color3.fromRGB(100, 180, 255) or Color3.fromRGB(150, 150, 150));
                    end;
                end;

                addStat("Total Storage", v890 .. " slots", u1.COLOR);
                addStat("Note", "Fitted when the " .. v898 .. " is worn. Empty it before taking the " .. v898 .. " off.", Color3.fromRGB(160, 160, 160));
            end;
        end;

        if ItemData.Weight then
            local v903 = 0;
            local v904 = nil;

            if ItemData.ItemType == "BodyGear" and (u877.BodySlot and (u877.BodySlot.Item and u877.BodySlot.Item == p879)) then
                v904 = u877.ChestRigInventory;
            elseif ItemData.ItemType == "BeltGear" and (ItemData.SlotSize and (u877.BeltGearSlot and (u877.BeltGearSlot.Item and u877.BeltGearSlot.Item == p879))) then
                v904 = u877.BattleBeltInventory;
            elseif ItemData.ItemType == "Backpack" and (u877.BackpackSlot and (u877.BackpackSlot.Item and u877.BackpackSlot.Item == p879)) then
                v904 = u877.MainInventory;
            end;

            if v904 and v904.Items then
                for _, v in pairs(v904.Items) do
                    if v and v.Metadata then
                        local ItemData2 = ItemDatabase.GetItemData(v.Metadata.ID);

                        if ItemData2 and ItemData2.Weight then
                            v903 = v903 + ItemData2.Weight;
                        end;
                    end;
                end;
            end;

            if v903 > 0 then
                addStat("Weight", string.format("%.1f kg (+%.1f kg)", ItemData.Weight, v903));
            else
                addStat("Weight", string.format("%.1f kg", ItemData.Weight));
            end;
        end;

        if ItemData.ArmorClass then
            addStat("Armor Class", ItemData.ArmorClass, Color3.fromRGB(100, 180, 255));
        end;

        if ItemData.ArmorMaxDurability and ItemData.ItemType ~= "BodyGear" then
            local v905 = p879.Metadata and p879.Metadata.CurrentDurability or ItemData.ArmorMaxDurability;
            local v906, u907;

            if ItemData.ItemType == "HeadGear" and (u877.HeadSlot and u877.HeadSlot.Item == p879) then
                v906 = true;
                u907 = "Head";
            else
                v906 = false;
                u907 = nil;
            end;

            local v908;

            if v906 then
                local v909;
                v909, v908 = pcall(function() -- Line: 9806
                    -- upvalues: ReplicatedStorage (ref), u907 (ref)
                    return ReplicatedStorage.Remotes.GetArmorDurability:InvokeServer(u907);
                end);

                if v909 then
                    if v908 == nil then
                        v908 = v905;
                    end;
                else
                    v908 = v905;
                end;
            else
                v908 = v905;
            end;

            local v910 = v908 / ItemData.ArmorMaxDurability;
            local v911;

            if v910 > 0.6 then
                v911 = Color3.fromRGB(100, 255, 100);
            elseif v910 > 0.3 then
                v911 = Color3.fromRGB(255, 220, 80);
            else
                v911 = Color3.fromRGB(255, 80, 80);
            end;

            addStat("Durability", math.floor(v908) .. " / " .. ItemData.ArmorMaxDurability, v911);
        end;

        local v912 = ArmorPlates.KindOf(ItemData);

        if v912 ~= "Rig" and v912 then
            local v913 = u877:_displayArmorLayer(p879, ItemData);

            if ArmorPlates.HasSoftArmor(ItemData) then
                local v914 = v913 and v913.source == "Soft" and v913.cond or ArmorPlates.VestCondition(p879, ItemData);
                addStat("Soft Armor", string.format("Class %d      %d / %d", ItemData.SoftArmorClass, math.floor(v914), ItemData.ArmorMaxDurability), Color3.fromRGB(100, 180, 255));
            end;

            if ArmorPlates.AcceptsInsert(ItemData) then
                local Insert = ArmorPlates.GetInsert(p879);

                if Insert then
                    local ItemData2 = ItemDatabase.GetItemData(Insert.ID);
                    local v915 = v913 and v913.source == "Insert" and v913.cond or ArmorPlates.InsertCondition(Insert, ItemData2);
                    local string_format_ret = string.format("%s   %d / %d", ItemData2 and ItemData2.Name or Insert.ID, math.floor(v915), ItemData2 and ItemData2.ArmorMaxDurability or 0);

                    if v915 <= 0 then
                        string_format_ret = string_format_ret .. "   CRACKED";
                    end;

                    addStat("Insert", string_format_ret, v915 > 0 and Color3.fromRGB(100, 180, 255) or Color3.fromRGB(200, 80, 80));
                else
                    addStat("Insert", "(empty)", Color3.fromRGB(150, 150, 150));
                end;
            end;

            if v913 and v913.rupture > 0 then
                addStat("Rupture Resistance", string.format("%d%% (%d%% max)", math.floor(v913.rupture * v913.scale * 100 + 0.5), (math.floor(v913.rupture * 100 + 0.5))), Color3.fromRGB(180, 140, 100));
            end;
        end;

        if WeaponCondition.IsWeapon(ItemData) then
            local v916 = WeaponCondition.MaxFor(ItemData);
            local v917 = u877:_displayCondition(p879, ItemData) / v916;
            local v918;

            if v917 >= 0.6 then
                v918 = Color3.fromRGB(100, 255, 100);
            elseif v917 >= 0.35 then
                v918 = Color3.fromRGB(255, 220, 80);
            else
                v918 = Color3.fromRGB(255, 80, 80);
            end;

            addStat("Condition", math.floor(v917 * 100) .. "%", v918);
        end;

        local v919;

        if UniformCondition.IsUniform(ItemData) then
            local v920 = u877:_displayUniformCondition(p879, ItemData);
            local v921 = v920 / UniformCondition.MAX;
            local v922;

            if v921 >= 0.6 then
                v922 = Color3.fromRGB(100, 255, 100);
            elseif v921 >= 0.35 then
                v922 = Color3.fromRGB(255, 220, 80);
            else
                v922 = Color3.fromRGB(255, 80, 80);
            end;

            addStat("Condition", math.floor(v921 * 100) .. "%", v922);
            v919 = {
                CurrentDurability = v920
            };
            local v923 = UniformCondition.Rated(ItemData, "Rupture");

            if v923 > 0 then
                local v924 = UniformCondition.Effective(v919, ItemData, "Rupture");
                addStat("Rupture Resistance", string.format("%d%% (%d%% max)", math.floor(v924 * 100 + 0.5), (math.floor(v923 * 100 + 0.5))), Color3.fromRGB(255, 150, 90));
            end;

            local v925 = UniformCondition.Rated(ItemData, "Anomalous");

            if v925 > 0 then
                local v926 = UniformCondition.Effective(v919, ItemData, "Anomalous");
                addStat("Anomaly Resistance", string.format("%d%% (%d%% max)", math.floor(v926 * 100 + 0.5), (math.floor(v925 * 100 + 0.5))), Color3.fromRGB(170, 130, 255));
            end;
        else
            v919 = nil;
        end;

        if HelmetCondition.IsHelmet(ItemData) then
            local v927 = u877:_displayHelmetCondition(p879, ItemData);
            addStat("Condition", string.format("%d%%", (math.floor(v927 + 0.5))), Color3.fromRGB(200, 200, 200));
            addStat("Shell", HelmetCondition.Material(ItemData) or "Composite, kit only", Color3.fromRGB(200, 200, 200));
        end;

        if ItemData.RadResist and ItemData.RadResist > 0 then
            if MaskCondition.IsMask(ItemData) then
                local v928 = u877:_displayMaskCondition(p879, ItemData);
                local Filter = MaskCondition.GetFilter(p879);
                local v929 = Filter and (u877:_displayFilterCharge(p879, Filter) or 0) or 0;
                local v930 = not Filter and 0 or MaskCondition.CapOf(ItemDatabase.GetItemData(Filter.ID), v929);
                local v931 = MaskCondition.EffectiveWith(ItemData, v928, v930);
                addStat("Condition", string.format("%d%%", (math.floor(v928 + 0.5))), Color3.fromRGB(200, 200, 200));
                addStat("Radiation Resistance", string.format("%d%% (%d%% max)", math.floor(v931 * 100 + 0.5), (math.floor(ItemData.RadResist * 100 + 0.5))), Color3.fromRGB(140, 220, 80));

                if Filter then
                    local ItemData2 = ItemDatabase.GetItemData(Filter.ID);
                    addStat("Filter", string.format("%s, %d%%", ItemData2 and ItemData2.Name or Filter.ID, (math.floor(v929 + 0.5))), Color3.fromRGB(140, 220, 80));
                else
                    addStat("Filter", "None", Color3.fromRGB(220, 120, 120));
                end;
            elseif UniformCondition.IsUniform(ItemData) and v919 then
                local v932 = UniformCondition.ScaleRad(v919, ItemData, ItemData.RadResist);
                addStat("Radiation Resistance", string.format("%d%% (%d%% max)", math.floor(v932 * 100 + 0.5), (math.floor(ItemData.RadResist * 100 + 0.5))), Color3.fromRGB(140, 220, 80));
            else
                addStat("Radiation Resistance", string.format("%d%%", (math.floor(ItemData.RadResist * 100 + 0.5))), Color3.fromRGB(140, 220, 80));
            end;
        end;

        if MaskCondition.IsFilter(ItemData) then
            local string_format = string.format;
            local v933 = MaskCondition.FilterCharge(p879.Metadata) + 0.5;
            addStat("Condition", string_format("%d%%", (math.floor(v933))), Color3.fromRGB(200, 200, 200));
            addStat("Duration", string.format("%d min in a hazard", (math.floor((ItemData.FilterSeconds or 0) / 60 + 0.5))), Color3.fromRGB(140, 220, 80));
            addStat("Efficiency", string.format("%d%%", (math.floor((ItemData.FilterCap or 0) * 100 + 0.5))), Color3.fromRGB(140, 220, 80));
        end;

        if ItemData.ammoType then
            addStat("Ammo Type", ItemData.ammoType);
        end;

        if ItemData.maxRounds then
            addStat("Capacity", ItemData.maxRounds .. " rounds");
        end;

        if ItemData.stackSize then
            addStat("Stack Size", ItemData.stackSize .. " rounds");
        end;

        if p879.Metadata and (p879.Metadata.LoadedRounds and #p879.Metadata.LoadedRounds > 0) then
            local v934 = {};
            local v935 = {};

            for _, v in ipairs(p879.Metadata.LoadedRounds) do
                if not v934[v] then
                    v934[v] = 0;
                    table.insert(v935, v);
                end;

                v934[v] = v934[v] + 1;
            end;

            local v936 = {};

            for _, v in ipairs(v935) do
                local v937 = v:match("_(.+)$") or v;
                table.insert(v936, v934[v] .. "x " .. v937);
            end;

            addStat("Rounds", table.concat(v936, ", "));
        end;

        if ItemData.MagType then
            local ItemData2 = ItemDatabase.GetItemData(ItemData.MagType);
            addStat("Magazine", ItemData2 and ItemData2.Name or ItemData.MagType);
        end;

        if (ItemData.ItemType == "FoodAndDrink" or (ItemData.ItemType == "Medical" or ItemData.ItemType == "Vial")) and true or ItemData.ItemType == "Injector" then
            local Color3_fromRGB_ret2 = Color3.fromRGB(140, 220, 80);
            local Color3_fromRGB_ret3 = Color3.fromRGB(230, 110, 110);
            local Color3_fromRGB_ret4 = Color3.fromRGB(180, 180, 180);

            if ItemData.HungerRestore or ItemData.ThirstRestore or (ItemData.HealAmount and ItemData.HealAmount > 0 and true or (ItemData.RadRemoveAmount or ItemData.StaminaRestore or (ItemData.StaminaRegenBuff or ItemData.WeightBonusBuff) or (ItemData.RadResistBuff or ItemData.DamageResistBuff or (ItemData.StopsBleeding or ItemData.BleedImmunity)))) then
                addSectionHeader("EFFECTS");

                if ItemData.HungerRestore then
                    addStat("Satiety", "+" .. ItemData.HungerRestore, Color3_fromRGB_ret2);
                end;

                if ItemData.ThirstRestore then
                    addStat("Hydration", "+" .. ItemData.ThirstRestore, Color3_fromRGB_ret2);
                end;

                if ItemData.HealAmount and ItemData.HealAmount > 0 then
                    if ItemData.HealOverTime then
                        addStat("Health", string.format("+%d HP over %ds", ItemData.HealAmount, ItemData.HealDuration or 30), Color3_fromRGB_ret2);
                    else
                        addStat("Health", "+" .. ItemData.HealAmount, Color3_fromRGB_ret2);
                    end;
                end;

                if ItemData.RadRemoveAmount then
                    addStat("Radiation Removed", "-" .. ItemData.RadRemoveAmount, Color3_fromRGB_ret2);
                end;

                if ItemData.RadResistBuff and ItemData.EffectDuration then
                    addStat("Rad Resist", string.format("+%d%% for %ds", math.floor(ItemData.RadResistBuff * 100), ItemData.EffectDuration), Color3_fromRGB_ret2);
                end;

                if ItemData.DamageResistBuff and ItemData.EffectDuration then
                    addStat("Damage Resist", string.format("+%d%% for %ds", math.floor(ItemData.DamageResistBuff * 100), ItemData.EffectDuration), Color3_fromRGB_ret2);
                end;

                if ItemData.StaminaRestore then
                    addStat("Stamina", "+" .. ItemData.StaminaRestore, Color3_fromRGB_ret2);
                end;

                if ItemData.StaminaRegenBuff and ItemData.StaminaRegenBuffDuration then
                    addStat("Stamina Regen", string.format("x%.1f for %ds", ItemData.StaminaRegenBuff, ItemData.StaminaRegenBuffDuration), Color3_fromRGB_ret2);
                end;

                if ItemData.WeightBonusBuff and ItemData.WeightBonusBuffDuration then
                    addStat("Carry Weight", string.format("+%d kg for %ds", ItemData.WeightBonusBuff, ItemData.WeightBonusBuffDuration), Color3_fromRGB_ret2);
                end;

                if ItemData.StopsBleeding then
                    addStat("Stops Bleeding", "Yes", Color3_fromRGB_ret2);
                end;

                if ItemData.BleedImmunity then
                    addStat("Bleed Immunity", ItemData.BleedImmunity .. "s", Color3_fromRGB_ret2);
                end;
            end;

            if ItemData.HungerDrain or (ItemData.ThirstDrain or ItemData.TipsyStacksPerUse or (ItemData.SideEffect or ItemData.RadAddAmount)) then
                addSectionHeader("SIDE EFFECTS");

                if ItemData.RadAddAmount then
                    addStat("Radiation", "+" .. ItemData.RadAddAmount, Color3_fromRGB_ret3);
                end;

                if ItemData.HungerDrain then
                    addStat("Hunger", "-" .. ItemData.HungerDrain, Color3_fromRGB_ret3);
                end;

                if ItemData.ThirstDrain then
                    addStat("Thirst", "-" .. ItemData.ThirstDrain, Color3_fromRGB_ret3);
                end;

                if ItemData.TipsyStacksPerUse then
                    addStat("Diziness", "+" .. ItemData.TipsyStacksPerUse .. " stack(s) per sip", Color3_fromRGB_ret3);
                end;

                if ItemData.SideEffect then
                    addStat("Vision", ItemData.SideEffect .. " for " .. (ItemData.SideEffectDuration or 30) .. "s", Color3_fromRGB_ret3);
                end;
            end;

            if ItemData.MaxUses and ItemData.MaxUses > 1 then
                addStat("Uses", ItemData.MaxUses, Color3_fromRGB_ret4);
            end;
        end;

        local Color3_fromRGB_ret2 = Color3.fromRGB(140, 220, 80);
        local Color3_fromRGB_ret3 = Color3.fromRGB(180, 180, 180);

        local function addRepairSection(p938, p939) -- Line: 10210
            -- upvalues: addSectionHeader (copy), addStat (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy), ItemDatabase (ref), ItemData (copy)
            addSectionHeader(p938);
            addStat("Condition Restored", "+" .. p939.amount, Color3_fromRGB_ret2);
            addStat("Minimum Condition", p939.min .. "%", Color3_fromRGB_ret3);
            addStat("Maximum Repair", p939.max .. "%", Color3_fromRGB_ret3);
            addStat("Work Time", p939.seconds .. "s", Color3_fromRGB_ret3);

            if p939.requires then
                local ItemData2 = ItemDatabase.GetItemData(p939.requires);
                addStat("Also Needs", ItemData2 and ItemData2.Name or p939.requires, Color3_fromRGB_ret3);
            end;

            if ItemData.MaxUses and ItemData.MaxUses > 1 then
                addStat("Uses", ItemData.MaxUses, Color3_fromRGB_ret3);
            end;
        end;

        local v940 = WeaponCondition.RepairTierFor(p878);
        local v941 = UniformCondition.RepairTierFor(p878);
        local v942 = HelmetCondition.RepairTierFor(p878);

        if v940 then
            addRepairSection("WEAPON REPAIR", v940);
        end;

        if v941 then
            addRepairSection("UNIFORM REPAIR", v941);
        end;

        if v942 then
            addRepairSection("HELMET REPAIR", v942);
        end;

        local v943 = p879 and p879.Metadata and p879.Metadata.NoteText;

        if type(v943) == "string" and v943 ~= "" then
            local NoteExcerpt = p879.Metadata.NoteExcerpt;

            if type(NoteExcerpt) == "string" and NoteExcerpt ~= "" then
                v943 = NoteExcerpt;
            elseif #v943 > 160 then
                local string_sub_ret = string.sub(v943, 1, 160);
                local string_find_ret = string.find(string.reverse(string_sub_ret), "\n", 1, true);

                if string_find_ret then
                    string_sub_ret = string.sub(string_sub_ret, 1, #string_sub_ret - string_find_ret);
                end;

                v943 = string_sub_ret .. "\n...";
            end;

            addSectionHeader("RECOVERED LOG");
            u880 = u880 + 1;
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Size = UDim2.new(1, 0, 0, 0);
            TextLabel.AutomaticSize = Enum.AutomaticSize.Y;
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Text = v943;
            TextLabel.TextColor3 = Color3.fromRGB(185, 182, 172);
            TextLabel.Font = Enum.Font.Gotham;
            TextLabel.TextSize = 11;
            TextLabel.TextWrapped = true;
            TextLabel.RichText = false;
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel.TextYAlignment = Enum.TextYAlignment.Top;
            TextLabel.ZIndex = 101;
            TextLabel.LayoutOrder = u880;
            TextLabel.Parent = StatsFrame;
            u880 = u880 + 1;
            local TextLabel2 = Instance.new("TextLabel");
            TextLabel2.Size = UDim2.new(1, 0, 0, 14);
            TextLabel2.BackgroundTransparency = 1;
            TextLabel2.Text = "Full entry under READ";
            TextLabel2.TextColor3 = Color3.fromRGB(130, 128, 120);
            TextLabel2.Font = Enum.Font.Gotham;
            TextLabel2.TextSize = 10;
            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
            TextLabel2.ZIndex = 101;
            TextLabel2.LayoutOrder = u880;
            TextLabel2.Parent = StatsFrame;
        end;
    end;

    if p879 and p879.ItemElement then
        local AbsolutePosition = p879.ItemElement.AbsolutePosition;
        DetailsPanel.Position = UDim2.new(0, AbsolutePosition.X + p879.ItemElement.AbsoluteSize.X + 5, 0, AbsolutePosition.Y);
    else
        local Mouse = Players.LocalPlayer:GetMouse();
        DetailsPanel.Position = UDim2.new(0, Mouse.X + 10, 0, Mouse.Y);
    end;

    DetailsPanel.Visible = true;
    u877._detailsPanelConn = UserInputService.InputBegan:Connect(function(p944) -- Line: 10304
        -- upvalues: DetailsPanel (copy), Players (ref), u877 (copy)
        if p944.UserInputType == Enum.UserInputType.MouseButton1 or p944.UserInputType == Enum.UserInputType.MouseButton2 then
            task.defer(function() -- Line: 10306
                -- upvalues: DetailsPanel (ref), Players (ref), u877 (ref)
                if not DetailsPanel.Visible then
                    return;
                end;

                local Mouse = Players.LocalPlayer:GetMouse();
                local AbsolutePosition = DetailsPanel.AbsolutePosition;
                local AbsoluteSize = DetailsPanel.AbsoluteSize;

                if Mouse.X < AbsolutePosition.X or (Mouse.X > AbsolutePosition.X + AbsoluteSize.X or (Mouse.Y < AbsolutePosition.Y or Mouse.Y > AbsolutePosition.Y + AbsoluteSize.Y)) then
                    u877:HideDetailsPanel();
                end;
            end);
        end;

        if p944.KeyCode == Enum.KeyCode.Escape then
            u877:HideDetailsPanel();
        end;
    end);
end;

function u6.HideDetailsPanel(p945) -- Line: 10322
    -- upvalues: Players (copy)
    local InventoryGui = Players.LocalPlayer.PlayerGui:FindFirstChild("InventoryGui");
    local v946 = InventoryGui and InventoryGui:FindFirstChild("DetailsPanel");

    if v946 then
        v946.Visible = false;
    end;

    if p945._detailsPanelConn then
        p945._detailsPanelConn:Disconnect();
        p945._detailsPanelConn = nil;
    end;
end;

function u6.AddPouchDividers(p947, p948, p949, p950) -- Line: 10334
end;

function u6.BindDropHandler(u951, u952, u953) -- Line: 10338
    if not u952.ItemElement then
        return;
    end;

    local InteractionButton = u952.ItemElement:FindFirstChild("InteractionButton");

    if InteractionButton then
        InteractionButton.MouseButton2Click:Connect(function() -- Line: 10342
            -- upvalues: u951 (copy), u952 (copy), u953 (copy)
            u951:ShowContextMenu(u952, u953);
        end);
    end;
end;

function u6.FindItemUnderMouse(p954, p955, p956) -- Line: 10348
    -- upvalues: Players (copy)
    local PlayerGui = Players.LocalPlayer:FindFirstChild("PlayerGui");

    if not PlayerGui then
        return nil;
    end;

    local GuiObjectsAtPosition = PlayerGui:GetGuiObjectsAtPosition(p955, p956);

    for _, v in ipairs(GuiObjectsAtPosition) do
        local v957 = v;

        for _, v2 in ipairs({
            p954.LocalInventory,
            p954.MainInventory,
            p954.ChestRigInventory,
            p954.BattleBeltInventory,
            p954.StorageInventory
        }) do
            if v2 and v2.Items then
                for _, v3 in pairs(v2.Items) do
                    if v3 and (v3.ItemElement and (v957 == v3.ItemElement or v957:IsDescendantOf(v3.ItemElement))) then
                        return v3;
                    end;
                end;
            end;
        end;

        for _, v2 in ipairs({
            p954.HeadSlot,
            p954.FaceWearSlot,
            p954.EyeWearSlot,
            p954.BodySlot,
            p954.BeltGearSlot,
            p954.PrimarySlot,
            p954.SecondarySlot,
            p954.SidearmSlot,
            p954.MeleeSlot,
            p954.UniformSlot,
            p954.BackpackSlot,
            p954.NightOpticalSlot
        }) do
            if v2 and (v2.Item and (v2.Item.ItemElement and (v957 == v2.Item.ItemElement or v957:IsDescendantOf(v2.Item.ItemElement)))) then
                return v2.Item;
            end;
        end;
    end;

    return nil;
end;

function u6.AttachViewportIcon(p958, p959, p960, p961) -- Line: 10383
    -- upvalues: ReplicatedStorage (copy)
    if not p959 then
        return;
    end;

    local ViewportIcon = p959:FindFirstChild("ViewportIcon");

    if ViewportIcon then
        ViewportIcon:Destroy();
    end;

    local PlayerItems = ReplicatedStorage:FindFirstChild("PlayerItems");

    if PlayerItems then
        PlayerItems = PlayerItems:FindFirstChild(p960, true);
    end;

    if not PlayerItems then
        return;
    end;

    local ViewportFrame = Instance.new("ViewportFrame");
    ViewportFrame.Name = "ViewportIcon";
    ViewportFrame.Size = UDim2.fromScale(1, 1);
    ViewportFrame.Position = UDim2.fromScale(0, 0);
    ViewportFrame.BackgroundTransparency = 1;
    ViewportFrame.ZIndex = 2;
    local WorldModel = Instance.new("WorldModel");
    WorldModel.Parent = ViewportFrame;
    local v962 = PlayerItems:Clone();
    local u963;

    if v962:IsA("Tool") then
        u963 = Instance.new("Model");
        u963.Name = v962.Name;

        for _, child in ipairs(v962:GetChildren()) do
            child.Parent = u963;
        end;

        v962:Destroy();
    else
        u963 = v962;
    end;

    for _, descendant in ipairs(u963:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Anchored = true;
            descendant.CanCollide = false;
        end;
    end;

    if p961 == "Uniform" then
        for _, descendant in ipairs(u963:GetDescendants()) do
            if descendant:IsA("BasePart") and (descendant.Name ~= "Middle" and descendant.Name ~= "Torso") then
                descendant:Destroy();
            end;
        end;
    end;

    u963.Parent = WorldModel;
    local Camera = Instance.new("Camera");
    Camera.FieldOfView = 40;

    if p961 == "Uniform" then
        local function focusPart(p964) -- Line: 10453
            -- upvalues: u963 (ref)
            local v965 = u963:FindFirstChild(p964, true);

            if not (v965 and (v965:IsA("BasePart") and v965)) then
                v965 = nil;
            end;

            return v965;
        end;

        local Torso = u963:FindFirstChild("Torso", true);

        if not (Torso and (Torso:IsA("BasePart") and Torso)) then
            Torso = nil;
        end;

        if not Torso then
            local Middle = u963:FindFirstChild("Middle", true);

            if not (Middle and (Middle:IsA("BasePart") and Middle)) then
                Middle = nil;
            end;

            Torso = Middle or u963:FindFirstChildWhichIsA("BasePart", true);
        end;

        if not Torso then
            ViewportFrame:Destroy();

            return;
        end;

        Camera.CFrame = CFrame.lookAt(Torso.Position + Torso.CFrame.LookVector * 3, Torso.Position, Torso.CFrame.UpVector);
    else
        local v966 = Vector3.new(-inf, -inf, -inf);
        local v967 = Vector3.new(inf, inf, inf);
        local v968 = false;

        for _, descendant in ipairs(u963:GetDescendants()) do
            if descendant:IsA("BasePart") and descendant.Transparency < 1 then
                local CFrame2 = descendant.CFrame;
                local v969 = descendant.Size * 0.5;
                v968 = true;

                for i = -1, 1, 2 do
                    local v970 = i;

                    for i2 = -1, 1, 2 do
                        local v971 = i2;

                        for i3 = -1, 1, 2 do
                            local v972 = CFrame2 * Vector3.new(v970 * v969.X, v971 * v969.Y, i3 * v969.Z);
                            v967 = v967:Min(v972);
                            v966 = v966:Max(v972);
                            local _ = i3;
                        end;
                    end;
                end;
            end;
        end;

        if not v968 then
            ViewportFrame:Destroy();

            return;
        end;

        local u973 = (v967 + v966) * 0.5;
        local u974 = v966 - v967;
        local Pivot = u963:GetPivot();

        local function frameCam() -- Line: 10486
            -- upvalues: ViewportFrame (copy), Camera (copy), u974 (copy), u973 (copy), Pivot (copy)
            local AbsoluteSize = ViewportFrame.AbsoluteSize;
            local v975 = AbsoluteSize.X > 0 and (AbsoluteSize.Y > 0 and AbsoluteSize.X / AbsoluteSize.Y) or 1;
            local v976 = math.rad(Camera.FieldOfView) / 2;
            local math_tan_ret = math.tan(v976);
            local v977 = math.max(u974.Y * 0.5 / math_tan_ret, u974.X * 0.5 / (math_tan_ret * v975)) * 1.05;
            Camera.CFrame = CFrame.new(u973 + Pivot.LookVector * v977, u973);
        end;

        frameCam();
        task.defer(frameCam);
    end;

    Camera.Parent = ViewportFrame;
    ViewportFrame.CurrentCamera = Camera;
    ViewportFrame.Parent = p959;
end;

local function _itemIdentityKey(p978) -- Line: 10527
    if not (p978 and p978.ID) then
        return nil;
    end;

    local Position = p978.Position;

    return string.format("%s|%s,%s|%s|%s|%s|%s", tostring(p978.ID), Position and (tostring(Position.X) or "?") or "?", Position and tostring(Position.Y) or "?", tostring(p978.Rotation or 0), tostring(p978.CurrentRounds), tostring(p978.Uses), (tostring(p978.Amount)));
end;

local function _inventoryHash(p979) -- Line: 10554
    -- upvalues: _itemIdentityKey (copy)
    if not (p979 and p979.Items) then
        return "";
    end;

    local v980 = {};

    for _, v in pairs(p979.Items) do
        if v then
            local v981 = _itemIdentityKey(v);

            if v981 then
                table.insert(v980, v981);
            end;
        end;
    end;

    table.sort(v980);

    return (p979.TiedInstance and (tostring(p979.TiedInstance) or "?") or "?") .. "#" .. (p979.GridSize and p979.GridSize.X .. "x" .. p979.GridSize.Y or "?") .. "#" .. table.concat(v980, "/");
end;

local function _tileCensus(p982, p983) -- Line: 10580
    local v984 = {};

    if not p982 then
        return v984;
    end;

    for _, v in pairs(p982) do
        local v985;

        if p983 then
            v985 = v and v.Metadata and v.Metadata.ID;
        elseif v then
            v985 = v.ID;
        else
            v985 = v;
        end;

        if v985 then
            v984[v985] = (v984[v985] or 0) + 1;
        end;
    end;

    return v984;
end;

local function _censusString(p986) -- Line: 10595
    local v987 = {};

    for i, v in pairs(p986) do
        local v988 = tostring(i) .. "x" .. v;
        table.insert(v987, v988);
    end;

    table.sort(v987);

    return #v987 > 0 and table.concat(v987, ", ") or "<empty>";
end;

local function _geomString(p989, p990, p991) -- Line: 10607
    -- upvalues: ItemDatabase (copy)
    local v992 = {};
    local v993 = 0;

    for _, v in pairs(p989 or {}) do
        if v and v.ID then
            local ItemData = ItemDatabase.GetItemData(v.ID);
            local v994 = ItemData and ItemData.Size and (ItemData.Size.X or 0) or 0;
            local v995 = ItemData and (ItemData.Size and ItemData.Size.Y) or 0;
            local v996 = v.Rotation or 0;
            local v997 = (v996 == 1 or (v996 == 3 or v996 == 90)) and true or v996 == 270;
            local v998 = v997 and v995 and v995 or v994;

            if v997 then
                v995 = v994 or v995;
            end;

            v993 = v993 + v998 * v995;
            local Position = v.Position;
            local string_format = string.format;
            local v999 = tostring(v.ID);
            local v1000 = Position and (tostring(Position.X) or "?") or "?";
            local v1001 = Position and tostring(Position.Y) or "?";
            local v1002 = tostring(v996);
            table.insert(v992, string_format("%s@(%s,%s) rot=%s %dx%d", v999, v1000, v1001, v1002, v998, v995));
        end;
    end;

    table.sort(v992);
    local v1003 = p990 and (p990.X * p990.Y or 0) or 0;

    return string.format("grid=%sx%s maxW=%s cells=%d/%d | %s", p990 and (tostring(p990.X) or "?") or "?", p990 and tostring(p990.Y) or "?", tostring(p991), v993, v1003, table.concat(v992, ", "));
end;

local function _censusDiffers(p1004, p1005) -- Line: 10633
    for i, v in pairs(p1004) do
        if (p1005[i] or 0) ~= v then
            return true;
        end;
    end;

    for i, v in pairs(p1005) do
        if (p1004[i] or 0) ~= v then
            return true;
        end;
    end;

    return false;
end;

local function isUnsizedPlaceholder(p1006, p1007) -- Line: 10652
    if p1006 then
        p1006 = p1006.GridSize;
    end;

    if not (p1006 and (p1006.X <= 1 and p1006.Y <= 1)) then
        return false;
    end;

    if p1007 and p1007.Items then
        return next(p1007.Items) ~= nil;
    end;

    return false;
end;

function u6.LoadInventory(u1008, u1009, p1010) -- Line: 10659
    -- upvalues: InventoryWire (copy), _tileCensus (copy), _geomString (copy), _censusDiffers (copy), _censusString (copy), _itemIdentityKey (copy), ItemDatabase (copy), GridPack (copy), ReplicatedStorage (copy), ScaleTypeFor (copy), MaskCondition (copy), ConditionValue (copy)
    local v1011 = p1010 and InventoryWire.IsEncoded(p1010.Items) and InventoryWire.DecodeItems(p1010.Items);

    if not v1011 then
        if p1010 then
            v1011 = p1010.Items;
        else
            v1011 = p1010;
        end;
    end;

    if u1009 == nil or u1009 ~= u1008.MainInventory then
        if u1009 == nil or u1009 ~= u1008.ChestRigInventory then
            if u1009 ~= nil and u1009 == u1008.BattleBeltInventory then
                if u1008:EnsureBattleBeltGridSized() then
                    u1009 = u1008.BattleBeltInventory;
                end;

                if not u1009 then
                    return;
                end;

                local v1012;

                if u1009 then
                    v1012 = u1009.GridSize;
                end;

                local v1013;

                if v1012 and (v1012.X <= 1 and v1012.Y <= 1) and (p1010 and p1010.Items) then
                    v1013 = next(p1010.Items) ~= nil;
                else
                    v1013 = false;
                end;

                if v1013 then
                    return;
                end;
            end;
        else
            if u1008:EnsureChestRigGridSized() then
                u1009 = u1008.ChestRigInventory;
            end;

            if not u1009 then
                return;
            end;

            local v1014;

            if u1009 then
                v1014 = u1009.GridSize;
            end;

            local v1015;

            if v1014 and (v1014.X <= 1 and v1014.Y <= 1) and (p1010 and p1010.Items) then
                v1015 = next(p1010.Items) ~= nil;
            else
                v1015 = false;
            end;

            if v1015 then
                return;
            end;
        end;
    else
        if u1008:EnsureBackpackGridSized() then
            u1009 = u1008.MainInventory;
        end;

        if not u1009 then
            return;
        end;

        local v1016;

        if u1009 then
            v1016 = u1009.GridSize;
        end;

        local v1017;

        if v1016 and (v1016.X <= 1 and v1016.Y <= 1) and (p1010 and p1010.Items) then
            v1017 = next(p1010.Items) ~= nil;
        else
            v1017 = false;
        end;

        if v1017 then
            return;
        end;
    end;

    local u1018 = {
        n = 0,
        first = nil
    };
    local v1019;

    if u1009.ChangeItem == nil then
        v1019 = false;
    else
        v1019 = u1009.GridSize == nil;
    end;

    if not v1019 then
        local u1020 = _tileCensus(u1009.Items, true);
        local u1021 = _tileCensus(v1011, false);
        local u1022 = tostring(u1009.Metadata and (u1009.Metadata.TiedInstance or "?") or "?");
        local u1023 = _geomString(v1011, p1010 and p1010.GridSize or u1009.GridSize, p1010 and p1010.MaxItemWidth or u1009.Metadata and u1009.Metadata.MaxItemWidth);
        local GridSize = u1009.GridSize;
        local GuiElement = u1009.GuiElement;
        local string_format = string.format;
        local v1024 = GridSize and string.format("%sx%s", tostring(GridSize.X), (tostring(GridSize.Y))) or "NIL";
        local u1025 = string_format("cgrid=%s cmaxW=%s gui=%s guiParented=%s visible=%s items=%s", v1024, tostring(u1009.Metadata and u1009.Metadata.MaxItemWidth), GuiElement and "yes" or "NIL", GuiElement and (tostring(GuiElement.Parent ~= nil) or "n/a") or "n/a", tostring(u1009.Visible), (tostring(u1009.Items ~= nil)));
        task.defer(function() -- Line: 10754
            -- upvalues: _tileCensus (ref), u1009 (ref), _censusDiffers (ref), u1021 (copy), u1022 (copy), _censusString (ref), u1020 (copy), u1023 (copy), u1025 (copy), u1018 (copy)
            local success, result = pcall(_tileCensus, u1009.Items, true);

            if success and _censusDiffers(result, u1021) then
                warn(string.format("[DUPDIAG] %s MISMATCH | before=[%s] server=[%s] after=[%s]", u1022, _censusString(u1020), _censusString(u1021), (_censusString(result))));
                warn(string.format("[DUPDIAG] %s GEOM | %s", u1022, u1023));
                warn(string.format("[PAINTDIAG] %s CLIENT | %s | addFail=%d first=%s", u1022, u1025, u1018.n, (tostring(u1018.first))));
            end;
        end);
    end;

    local v1026 = {};

    if v1011 then
        for _, v in pairs(v1011) do
            local v1027 = _itemIdentityKey(v);

            if v1027 then
                v1026[v1027] = true;
            end;
        end;
    end;

    local v1028 = {};

    if u1009.Items then
        for _, v in pairs(u1009.Items) do
            if v and v.Metadata then
                local Metadata = v.Metadata;
                local v1029 = _itemIdentityKey({
                    ID = Metadata.ID,
                    Position = v.Position,
                    Rotation = v.Rotation,
                    CurrentRounds = Metadata.CurrentRounds,
                    Uses = Metadata.Uses,
                    Amount = Metadata.Amount
                });

                if v1029 and v1026[v1029] then
                    v1026[v1029] = nil;
                else
                    table.insert(v1028, v);
                end;
            end;
        end;
    end;

    for _, v in ipairs(v1028) do
        pcall(function() -- Line: 10940
            -- upvalues: u1009 (ref), v (copy)
            u1009:RemoveItem(v);
        end);
        pcall(function() -- Line: 10941
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    if u1009.GuiElement then
        local Parent = u1009.GuiElement.Parent;

        if Parent then
            for _, descendant in ipairs(Parent:GetDescendants()) do
                if descendant.Name == "BarterGhostOverlay" then
                    pcall(function() -- Line: 10954
                        -- upvalues: descendant (copy)
                        descendant:Destroy();
                    end);
                end;
            end;
        end;
    end;

    if p1010.TiedInstance then
        u1009.Metadata.TiedInstance = p1010.TiedInstance;
    end;

    local v1030 = u1008:CreateMoveMiddleware();

    for i, v in pairs(v1011) do
        if v then
            local v1031 = _itemIdentityKey(v);

            if not v1031 or v1026[v1031] then
                local ItemData = ItemDatabase.GetItemData(v.ID);

                if ItemData then
                    local createItem = GridPack.createItem;
                    local v1032 = {
                        Assets = {
                            Item = ReplicatedStorage.GridPack.Item
                        },
                        Position = u1009.ChangeItem and Vector2.new(0, 0) or v.Position,
                        Size = ItemData.Size,
                        Rotation = v.Rotation
                    };
                    local v1033 = {
                        ItemIndex = i,
                        ItemType = ItemData.ItemType,
                        ID = v.ID,
                        CurrentRounds = v.CurrentRounds,
                        CurrentDurability = v.CurrentDurability
                    };
                    v1033.Insert = v.Metadata and v.Metadata.Insert;
                    v1033.Filter = v.Metadata and v.Metadata.Filter;
                    v1033.LoadedRounds = v.LoadedRounds;
                    v1033.Uses = v.Uses;
                    v1033.DroppedContainerTied = v.DroppedContainerTied;
                    v1033.Price = v.Price;
                    v1033.Amount = v.Amount;
                    v1033.TaskBound = v.TaskBound;
                    v1033.TaskId = v.TaskId;
                    v1033.NoteText = v.NoteText;
                    v1033.NoteTitle = v.NoteTitle;
                    v1033.NoteExcerpt = v.NoteExcerpt;
                    v1032.Metadata = v1033;
                    v1032.MoveMiddleware = v1030;
                    local u1034 = createItem(v1032);

                    if u1034.ItemElement then
                        local v1035 = v.CurrentRounds ~= nil and v.CurrentRounds or ItemData.ItemType == "Ammo" and ItemData.maxRounds;

                        if not v1035 then
                            if ItemData.ItemType == "AmmoPack" then
                                v1035 = ItemData.stackSize or nil;
                            else
                                v1035 = nil;
                            end;
                        end;

                        if ItemData.ItemType ~= "Ammo" and ItemData.ItemType ~= "AmmoPack" or (v1035 == nil or v1035 > 0) then
                            u1034.ItemElement.BackgroundColor3 = ItemData.BackgroundColor;
                        else
                            u1034.ItemElement.BackgroundColor3 = Color3.fromRGB(120, 30, 30);
                        end;

                        u1034.ItemElement.BackgroundTransparency = ItemData.BackgroundTransparency or 0;
                        local v1036 = u1034.ItemElement:FindFirstChildOfClass("ImageLabel");

                        if v1036 then
                            v1036.Image = ItemData.ImageID or "";
                            v1036.ScaleType = ScaleTypeFor(ItemData);

                            if (ItemData.ImageID == nil or ItemData.ImageID == "") and ItemData.Model then
                                local success, result = pcall(function() -- Line: 11042
                                    -- upvalues: u1008 (copy), u1034 (copy), ItemData (copy)
                                    u1008:AttachViewportIcon(u1034.ItemElement, ItemData.Model, ItemData.ItemType);
                                end);

                                if success then
                                    v1036.ImageTransparency = 1;
                                else
                                    warn("[InventoryController] AttachViewportIcon failed for " .. tostring(ItemData.Model) .. ": " .. tostring(result));
                                end;
                            end;
                        end;

                        local string_upper_ret = string.upper(ItemData.Name or v.ID);
                        local Frame = Instance.new("Frame");
                        Frame.Name = "ItemNameStrip";
                        Frame.Size = UDim2.new(1, 0, 0, 16);
                        Frame.Position = UDim2.new(0, 0, 0, 0);
                        Frame.AnchorPoint = Vector2.new(0, 0);
                        Frame.BackgroundTransparency = 1;
                        Frame.BorderSizePixel = 0;
                        Frame.ZIndex = 5;
                        Frame.Parent = u1034.ItemElement;
                        local TextLabel = Instance.new("TextLabel");
                        TextLabel.Name = "ItemNameTag";
                        TextLabel.Size = UDim2.new(1, -4, 1, 0);
                        TextLabel.Position = UDim2.new(0, 2, 0, 0);
                        TextLabel.BackgroundTransparency = 1;
                        TextLabel.Text = string_upper_ret;
                        TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200);
                        TextLabel.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.SemiBold);
                        TextLabel.TextSize = 14;
                        TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
                        TextLabel.TextTruncate = Enum.TextTruncate.AtEnd;
                        TextLabel.ZIndex = 6;
                        TextLabel.Parent = Frame;

                        if ItemData.ItemType == "Ammo" or ItemData.ItemType == "AmmoPack" then
                            local v1037 = v.CurrentRounds ~= nil and v.CurrentRounds or ItemData.maxRounds or (ItemData.stackSize or 0);
                            local TextLabel2 = Instance.new("TextLabel");
                            TextLabel2.Name = "RoundCount";
                            TextLabel2.Size = UDim2.fromScale(0.45, 0.25);
                            TextLabel2.Position = UDim2.fromScale(0.55, 0.75);
                            TextLabel2.AnchorPoint = Vector2.new(0, 0);
                            TextLabel2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                            TextLabel2.BackgroundTransparency = 0.4;
                            TextLabel2.BorderSizePixel = 0;
                            TextLabel2.Text = tostring(v1037);
                            TextLabel2.TextColor3 = v1037 > 0 and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(255, 80, 80);
                            TextLabel2.TextScaled = true;
                            TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
                            TextLabel2.ZIndex = 5;
                            TextLabel2.Parent = u1034.ItemElement;
                        end;

                        if ItemData.IsCurrency and (v.Amount and v.Amount > 0) then
                            local TextLabel2 = Instance.new("TextLabel");
                            TextLabel2.Name = "CurrencyAmount";
                            TextLabel2.AnchorPoint = Vector2.new(1, 1);
                            TextLabel2.Position = UDim2.new(1, -2, 1, -2);
                            TextLabel2.Size = UDim2.new(1, -4, 0, 16);
                            TextLabel2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                            TextLabel2.BackgroundTransparency = 0.35;
                            TextLabel2.BorderSizePixel = 0;
                            TextLabel2.TextColor3 = Color3.fromRGB(240, 220, 130);
                            TextLabel2.TextStrokeTransparency = 0.6;
                            TextLabel2.TextSize = 13;
                            TextLabel2.Font = Enum.Font.GothamBold;
                            TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
                            TextLabel2.Text = string.format("₽%d", v.Amount);
                            TextLabel2.ZIndex = 7;
                            TextLabel2.Parent = u1034.ItemElement;
                        end;

                        if v.Quantity and v.Quantity > 1 then
                            local TextLabel2 = Instance.new("TextLabel");
                            TextLabel2.Name = "StockOverlay";
                            TextLabel2.AnchorPoint = Vector2.new(1, 0);
                            TextLabel2.Position = UDim2.new(1, -2, 0, 18);
                            TextLabel2.Size = UDim2.new(0, 40, 0, 16);
                            TextLabel2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                            TextLabel2.BackgroundTransparency = 0.35;
                            TextLabel2.BorderSizePixel = 0;
                            TextLabel2.TextColor3 = Color3.fromRGB(220, 220, 220);
                            TextLabel2.TextStrokeTransparency = 0.6;
                            TextLabel2.TextSize = 13;
                            TextLabel2.Font = Enum.Font.RobotoMono;
                            TextLabel2.TextXAlignment = Enum.TextXAlignment.Right;
                            TextLabel2.Text = "x" .. tostring(v.Quantity);
                            TextLabel2.ZIndex = 7;
                            TextLabel2.Parent = u1034.ItemElement;
                        end;

                        if v.Price then
                            local TextLabel2 = Instance.new("TextLabel");
                            TextLabel2.Name = "PriceOverlay";
                            TextLabel2.AnchorPoint = Vector2.new(0, 1);
                            TextLabel2.Position = UDim2.new(0, 2, 1, -2);
                            TextLabel2.Size = UDim2.new(0, 60, 0, 16);
                            TextLabel2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                            TextLabel2.BackgroundTransparency = 0.35;
                            TextLabel2.BorderSizePixel = 0;
                            TextLabel2.TextColor3 = Color3.fromRGB(240, 220, 130);
                            TextLabel2.TextStrokeTransparency = 0.6;
                            TextLabel2.TextSize = 13;
                            TextLabel2.Font = Enum.Font.RobotoMono;
                            TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
                            TextLabel2.Text = "₽" .. tostring(v.Price);
                            TextLabel2.ZIndex = 7;
                            TextLabel2.Parent = u1034.ItemElement;
                        end;

                        if ItemData.MaxUses and ItemData.MaxUses > 1 then
                            local v1038 = v.Uses or ItemData.MaxUses;
                            local TextLabel2 = Instance.new("TextLabel");
                            TextLabel2.Name = "UsesCount";
                            TextLabel2.Size = UDim2.fromScale(0.45, 0.25);
                            TextLabel2.Position = UDim2.fromScale(0.55, 0.75);
                            TextLabel2.AnchorPoint = Vector2.new(0, 0);
                            TextLabel2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                            TextLabel2.BackgroundTransparency = 0.4;
                            TextLabel2.BorderSizePixel = 0;
                            TextLabel2.Text = tostring(v1038) .. "/" .. tostring(ItemData.MaxUses);
                            TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255);
                            TextLabel2.TextScaled = true;
                            TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
                            TextLabel2.ZIndex = 5;
                            TextLabel2.Parent = u1034.ItemElement;
                        end;

                        if MaskCondition.IsFilter(ItemData) then
                            local v1039 = MaskCondition.FilterCharge(v);
                            local TextLabel2 = Instance.new("TextLabel");
                            TextLabel2.Name = "FilterCharge";
                            TextLabel2.Size = UDim2.fromScale(0.45, 0.25);
                            TextLabel2.Position = UDim2.fromScale(0.55, 0.75);
                            TextLabel2.AnchorPoint = Vector2.new(0, 0);
                            TextLabel2.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                            TextLabel2.BackgroundTransparency = 0.4;
                            TextLabel2.BorderSizePixel = 0;
                            TextLabel2.Text = string.format("%d%%", (math.floor(v1039 + 0.5)));
                            local v1040 = MaskCondition.CHARGE_WARNINGS[1] and MaskCondition.CHARGE_WARNINGS[1].at or 25;

                            if v1039 <= 0 then
                                TextLabel2.TextColor3 = Color3.fromRGB(255, 80, 80);
                            elseif v1039 <= v1040 then
                                TextLabel2.TextColor3 = Color3.fromRGB(255, 190, 90);
                            else
                                TextLabel2.TextColor3 = Color3.fromRGB(255, 255, 255);
                            end;

                            TextLabel2.TextScaled = true;
                            TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
                            TextLabel2.ZIndex = 5;
                            TextLabel2.Parent = u1034.ItemElement;
                        end;

                        local v1041;

                        if MaskCondition.IsFilter(ItemData) then
                            v1041 = nil;
                        else
                            v1041 = ConditionValue.Ratio(v, ItemData, ItemDatabase) or nil;
                        end;

                        if v1041 then
                            local ImageLabel = Instance.new("ImageLabel");
                            ImageLabel.Name = "ConditionBadge";
                            ImageLabel.Size = UDim2.fromScale(0.22, 0.22);
                            ImageLabel.AnchorPoint = Vector2.new(1, 1);
                            ImageLabel.Position = UDim2.fromScale(1, 1);
                            ImageLabel.BackgroundTransparency = 1;
                            ImageLabel.Image = ConditionValue.BADGE_IMAGE;
                            ImageLabel.ImageColor3 = ConditionValue.BadgeColor(v1041);
                            ImageLabel.ZIndex = 6;
                            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
                            UIAspectRatioConstraint.AspectRatio = 1;
                            UIAspectRatioConstraint.Parent = ImageLabel;
                            local UISizeConstraint = Instance.new("UISizeConstraint");
                            UISizeConstraint.MinSize = Vector2.new(12, 12);
                            UISizeConstraint.MaxSize = Vector2.new(22, 22);
                            UISizeConstraint.Parent = ImageLabel;

                            if u1009 == u1008.PrimarySlot or (u1009 == u1008.SecondarySlot or u1009 == u1008.SidearmSlot) then
                                ImageLabel:SetAttribute("LiftPx", 20);
                            end;

                            ImageLabel.Parent = u1034.ItemElement;
                        end;

                        if v.Revealed == false then
                            u1034.ItemElement:SetAttribute("ItemIndex", i);
                            local Frame2 = Instance.new("Frame");
                            Frame2.Name = "SilhouetteOverlay";
                            Frame2.Size = UDim2.fromScale(1, 1);
                            Frame2.BackgroundColor3 = Color3.fromRGB(28, 28, 28);
                            Frame2.BackgroundTransparency = 0;
                            Frame2.BorderSizePixel = 0;
                            Frame2.ZIndex = 50;
                            Frame2.Parent = u1034.ItemElement;
                            local TextLabel2 = Instance.new("TextLabel");
                            TextLabel2.Name = "Glyph";
                            TextLabel2.Size = UDim2.fromScale(1, 1);
                            TextLabel2.BackgroundTransparency = 1;
                            TextLabel2.Text = "?";
                            TextLabel2.TextColor3 = Color3.fromRGB(160, 160, 160);
                            TextLabel2.TextScaled = true;
                            TextLabel2.FontFace = Font.new("rbxasset://fonts/families/TitilliumWeb.json", Enum.FontWeight.Bold);
                            TextLabel2.TextStrokeColor3 = Color3.new(0, 0, 0);
                            TextLabel2.TextStrokeTransparency = 0.4;
                            TextLabel2.ZIndex = 51;
                            TextLabel2.Parent = Frame2;
                        end;

                        local u1042 = {
                            tl = {
                                [0] = { 0, 0, 0, 0, 0 },
                                [90] = { 0, 1, 0, 1, -90 },
                                [180] = { 1, 1, 1, 1, 180 },
                                [270] = { 1, 0, 1, 0, 90 }
                            },
                            tr = {
                                [0] = { 1, 0, 1, 0, 0 },
                                [90] = { 0, 0, 0, 0, -90 },
                                [180] = { 0, 1, 0, 1, 180 },
                                [270] = { 1, 1, 1, 1, 90 }
                            },
                            bl = {
                                [0] = { 0, 1, 0, 1, 0 },
                                [90] = { 1, 1, 1, 1, -90 },
                                [180] = { 1, 0, 1, 0, 180 },
                                [270] = { 0, 0, 0, 0, 90 }
                            },
                            br = {
                                [0] = { 1, 1, 1, 1, 0 },
                                [90] = { 1, 0, 1, 0, -90 },
                                [180] = { 0, 0, 0, 0, 180 },
                                [270] = { 0, 1, 0, 1, 90 }
                            }
                        };
                        local u1043 = {
                            [0] = {
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                UDim2.new(1, 0, 0, 16),
                                0
                            },
                            [90] = {
                                1,
                                0,
                                1,
                                0,
                                0,
                                0,
                                UDim2.new(0, 16, 1, 0),
                                -90
                            },
                            [180] = {
                                1,
                                1,
                                1,
                                0,
                                1,
                                0,
                                UDim2.new(1, 0, 0, 16),
                                180
                            },
                            [270] = {
                                0,
                                0,
                                0,
                                0,
                                0,
                                0,
                                UDim2.new(0, 16, 1, 0),
                                90
                            }
                        };
                        local u1044 = {
                            RoundCount = "br",
                            UsesCount = "br",
                            CurrencyAmount = "br",
                            FilterCharge = "br",
                            ConditionBadge = "br",
                            StockOverlay = "tr",
                            PriceOverlay = "bl"
                        };

                        local function applyLayout() -- Line: 11330
                            -- upvalues: u1034 (copy), u1043 (copy), u1044 (copy), u1042 (copy)
                            local ItemElement = u1034.ItemElement;

                            if not ItemElement then
                                return;
                            end;

                            local v1045 = (ItemElement.Rotation or 0) % 360;

                            if v1045 < 0 then
                                v1045 = v1045 + 360;
                            end;

                            local v1046 = math.floor((v1045 + 45) / 90) * 90 % 360;
                            local ItemNameStrip = ItemElement:FindFirstChild("ItemNameStrip");

                            if ItemNameStrip then
                                local v1047 = u1043[v1046];
                                ItemNameStrip.AnchorPoint = Vector2.new(v1047[1], v1047[2]);
                                ItemNameStrip.Position = UDim2.new(v1047[3], 0, v1047[5], 0);
                                ItemNameStrip.Size = v1047[7];
                                ItemNameStrip.Rotation = v1047[8];
                            end;

                            for i2, v2 in pairs(u1044) do
                                local v1048 = ItemElement:FindFirstChild(i2, true);

                                if v1048 then
                                    local v1049 = u1042[v2][v1046];
                                    v1048.AnchorPoint = Vector2.new(v1049[1], v1049[2]);
                                    local v1050 = v1046 == 0 and (v1048:GetAttribute("LiftPx") or 0) or 0;
                                    v1048.Position = UDim2.new(v1049[3], 0, v1049[4], -v1050);
                                    v1048.Rotation = v1049[5];
                                end;
                            end;
                        end;

                        applyLayout();
                        u1034.ItemElement:GetPropertyChangedSignal("Rotation"):Connect(applyLayout);
                    end;

                    local success, result = pcall(function() -- Line: 11367
                        -- upvalues: u1009 (ref), u1034 (copy)
                        if u1009.ChangeItem then
                            u1009:ChangeItem(u1034);

                            return;
                        end;

                        u1009:AddItem(u1034);
                    end);
                    local v1051, v1052;

                    if success or (not u1009.GridSize or u1009.ChangeItem) then
                        v1051 = i;
                        v1052 = v;
                    else
                        local X = u1009.GridSize.X;
                        local Y = u1009.GridSize.Y;

                        local function footprint(p1053) -- Line: 11387
                            -- upvalues: ItemData (copy)
                            if p1053 == 1 then
                                return ItemData.Size.Y, ItemData.Size.X;
                            end;

                            return ItemData.Size.X, ItemData.Size.Y;
                        end;

                        local v1054 = u1034.Rotation or 0;
                        local v1055 = (v1054 == 1 or (v1054 == 3 or (v1054 == 90 or v1054 == 270))) and 1 or 0;
                        local v1056 = { v1055 };

                        if ItemData.Size.X ~= ItemData.Size.Y then
                            table.insert(v1056, 1 - v1055);
                        end;

                        v1051 = i;
                        v1052 = v;

                        for _, v2 in ipairs(v1056) do
                            if success then
                                break;
                            end;

                            local v1057, v1058;

                            if v2 == 1 then
                                v1057 = ItemData.Size.Y;
                                v1058 = ItemData.Size.X;
                            else
                                v1057 = ItemData.Size.X;
                                v1058 = ItemData.Size.Y;
                            end;

                            u1034.Rotation = v2;

                            for i2 = 0, math.max(0, Y - v1058) do
                                if success then
                                    break;
                                end;

                                local v1059 = i2;

                                for i3 = 0, math.max(0, X - v1057) do
                                    u1034.Position = Vector2.new(i3, v1059);

                                    if pcall(function() -- Line: 11403
                                        -- upvalues: u1009 (ref), u1034 (copy)
                                        u1009:AddItem(u1034);
                                    end) then
                                        success = true;
                                        break;
                                    end;

                                    local _ = i3;
                                end;
                            end;
                        end;

                        if not success then
                            u1034.Rotation = v1054;
                        end;
                    end;

                    if success then
                        if u1009.GridSize then
                            task.defer(function() -- Line: 11433
                                -- upvalues: u1008 (copy), u1034 (copy)
                                u1008:ConvertItemToScale(u1034);
                            end);
                        else
                            task.defer(function() -- Line: 11443
                                -- upvalues: u1034 (copy), u1009 (ref)
                                local ItemElement = u1034.ItemElement;

                                if not ItemElement then
                                    return;
                                end;

                                local u1060 = false;
                                local u1061 = nil;
                                local u1062 = nil;

                                local function disconnect() -- Line: 11448
                                    -- upvalues: u1061 (ref), u1062 (ref)
                                    if u1061 then
                                        u1061:Disconnect();
                                        u1061 = nil;
                                    end;

                                    if u1062 then
                                        u1062:Disconnect();
                                        u1062 = nil;
                                    end;
                                end;

                                local function enforce() -- Line: 11452
                                    -- upvalues: u1060 (ref), u1034 (ref), u1009 (ref), u1061 (ref), u1062 (ref), ItemElement (copy)
                                    if u1060 then
                                        return;
                                    end;

                                    if u1034.IsDragging then
                                        return;
                                    end;

                                    if u1009.Item ~= u1034 then
                                        if u1061 then
                                            u1061:Disconnect();
                                            u1061 = nil;
                                        end;

                                        if u1062 then
                                            u1062:Disconnect();
                                            u1062 = nil;
                                        end;

                                        return;
                                    end;

                                    u1060 = true;
                                    ItemElement.Size = UDim2.fromScale(1, 1);
                                    ItemElement.Position = UDim2.fromScale(0, 0);
                                    u1060 = false;
                                end;

                                if not (u1060 or u1034.IsDragging) then
                                    if u1009.Item == u1034 then
                                        u1060 = true;
                                        ItemElement.Size = UDim2.fromScale(1, 1);
                                        ItemElement.Position = UDim2.fromScale(0, 0);
                                        u1060 = false;
                                    else
                                        if u1061 then
                                            u1061:Disconnect();
                                            u1061 = nil;
                                        end;

                                        if u1062 then
                                            u1062:Disconnect();
                                            u1062 = nil;
                                        end;
                                    end;
                                end;

                                u1061 = ItemElement:GetPropertyChangedSignal("Size"):Connect(enforce);
                                u1062 = ItemElement:GetPropertyChangedSignal("Position"):Connect(enforce);
                            end);
                        end;

                        u1008:BindDropHandler(u1034, u1009);
                    else
                        u1018.n = u1018.n + 1;

                        if u1018.first == nil then
                            u1018.first = string.format("%s@%s: %s", tostring(v1052.ID), tostring(v1052.Position), (tostring(result)));
                        end;

                        warn("Failed to add item to grid:", v1052.ID, "at index:", v1051, "| server pos:", tostring(v1052.Position), "| grid size:", tostring(u1009.GridSize), "| err:", (tostring(result)));
                    end;
                else
                    warn("Failed to load item - no database entry for:", v.ID);
                end;
            end;
        end;
    end;
end;

function u6.BindEquipHint(p1063, u1064) -- Line: 11481
    if not (u1064 and u1064.ItemElement) then
        return;
    end;

    local u1065 = u1064.Metadata and u1064.Metadata.ItemType;

    if not u1065 then
        return;
    end;

    local u1066 = ({
        HeadGear = p1063.HeadSlot,
        FaceWear = p1063.FaceWearSlot,
        EyeWear = p1063.EyeWearSlot,
        BodyGear = p1063.BodySlot,
        BeltGear = p1063.BeltGearSlot,
        Primary = p1063.PrimarySlot,
        Secondary = p1063.SecondarySlot,
        Sidearm = p1063.SidearmSlot,
        Melee = p1063.MeleeSlot,
        Uniform = p1063.UniformSlot,
        Backpack = p1063.BackpackSlot,
        NightOptical = p1063.NightOpticalSlot
    })[u1065];
    local u1067;

    if u1065 == "Primary" then
        u1067 = p1063.SecondarySlot or nil;
    else
        u1067 = nil;
    end;

    if not u1066 then
        return;
    end;

    local u1068 = nil;
    local u1069 = nil;
    local u1070 = {};

    local function createHint(p1071) -- Line: 11510
        -- upvalues: u1070 (ref)
        if not (p1071 and p1071.GuiElement) then
            return nil;
        end;

        local GuiElement = p1071.GuiElement;

        if GuiElement.Parent and GuiElement.Parent:IsA("GuiObject") then
            GuiElement = GuiElement.Parent;
        end;

        local EquipHintStroke = GuiElement:FindFirstChild("EquipHintStroke");

        if EquipHintStroke then
            EquipHintStroke:Destroy();
        end;

        local UIStroke = Instance.new("UIStroke");
        UIStroke.Name = "EquipHintStroke";
        UIStroke.Color = Color3.fromRGB(220, 200, 50);
        UIStroke.Thickness = 3;
        UIStroke.Transparency = 0;
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
        UIStroke.Parent = GuiElement;
        table.insert(u1070, UIStroke);

        return UIStroke;
    end;

    local function removeHints() -- Line: 11531
        -- upvalues: u1070 (ref), u1068 (ref), u1069 (ref)
        for _, v in ipairs(u1070) do
            if v and v.Parent then
                v:Destroy();
            end;
        end;

        u1070 = {};
        u1068 = nil;
        u1069 = nil;
    end;

    local InteractionButton = u1064.ItemElement:FindFirstChild("InteractionButton");

    if not InteractionButton then
        return;
    end;

    InteractionButton.MouseButton1Down:Connect(function() -- Line: 11543
        -- upvalues: u1064 (copy), u1068 (ref), createHint (copy), u1066 (copy), u1067 (copy), u1069 (ref), u1065 (copy)
        task.defer(function() -- Line: 11544
            -- upvalues: u1064 (ref), u1068 (ref), createHint (ref), u1066 (ref), u1067 (ref), u1069 (ref), u1065 (ref)
            task.wait();

            if u1064.IsDragging then
                u1068 = createHint(u1066);

                if u1067 then
                    u1069 = createHint(u1067);
                end;

                local v1072 = print;
                local v1073 = u1068 and u1068:GetFullName();
                v1072("[Hint] showing for", u1065, "target=", v1073);
            end;
        end);
    end);
    InteractionButton.MouseButton1Up:Connect(function() -- Line: 11554
        -- upvalues: removeHints (copy)
        removeHints();
    end);
    u1064.ItemElement:GetPropertyChangedSignal("GroupTransparency"):Connect(function() -- Line: 11559
        -- upvalues: u1064 (copy), removeHints (copy)
        if u1064.ItemElement.GroupTransparency < 0.1 then
            removeHints();
        end;
    end);
end;

local function parentSizeInCells(p1074) -- Line: 11603
    local ItemManager = p1074.ItemManager;

    if not (ItemManager and (ItemManager.GridSize and ItemManager.GuiElement)) then
        return 1, 1;
    end;

    local Size = ItemManager.GuiElement.Size;
    local v1075 = Size.X.Scale <= 0 and 1 or ItemManager.GridSize.X / Size.X.Scale;
    local v1076 = Size.Y.Scale <= 0 and 1 or ItemManager.GridSize.Y / Size.Y.Scale;

    return v1075 <= 0 and 1 or v1075, v1076 <= 0 and 1 or v1076;
end;

function u6.ConvertItemToScale(p1077, p1078) -- Line: 11615
    -- upvalues: parentSizeInCells (copy)
    if not (p1078 and p1078.ItemElement) then
        return;
    end;

    task.wait(0.3);
    local v1079 = p1078.Position or Vector2.new(0, 0);
    local v1080 = p1078.Size or Vector2.new(1, 1);
    local v1081 = p1078.Rotation or 0;
    local X = v1080.X;
    local Y = v1080.Y;
    local X2 = v1079.X;
    local Y2 = v1079.Y;

    if v1081 == 90 or v1081 == 1 then
        X2 = v1079.X + (v1080.Y - v1080.X) / 2;
        Y2 = v1079.Y + (v1080.X - v1080.Y) / 2;
    elseif v1081 == 180 or v1081 == 2 then
        X2 = v1079.X;
        Y2 = v1079.Y;
    elseif v1081 == 270 or v1081 == 3 then
        X2 = v1079.X + (v1080.Y - v1080.X) / 2;
        Y2 = v1079.Y + (v1080.X - v1080.Y) / 2;
    end;

    local v1082, v1083 = parentSizeInCells(p1078);
    p1078.ItemElement.Position = UDim2.fromScale(X2 / v1082, Y2 / v1083);
    p1078.ItemElement.Size = UDim2.fromScale(X / v1082, Y / v1083);
end;

function u6.CreateGridIsColliding(u1084) -- Line: 11663
    -- upvalues: ItemDatabase (copy)
    return function(p1085, p1086, p1087, p1088, p1089) -- Line: 11664
        -- upvalues: ItemDatabase (ref), u1084 (copy)
        if not p1085.GuiElement then
            return true;
        end;

        local ItemData = ItemDatabase.GetItemData(p1086.Metadata.ID);

        if not ItemData then
            return true;
        end;

        if p1089 == nil then
            if p1086.PotentialRotation == nil then
                p1089 = p1086.Rotation or 0;
            else
                p1089 = p1086.PotentialRotation;
            end;
        end;

        local v1090 = (p1089 == 1 or (p1089 == 3 or p1089 == 90)) and true or p1089 == 270;
        local v1091 = v1090 and ItemData.Size.Y or ItemData.Size.X;
        local v1092 = v1090 and ItemData.Size.X or ItemData.Size.Y;

        if p1085.GridSize.X < v1091 or p1085.GridSize.Y < v1092 then
            return true;
        end;

        local v1093 = ItemDatabase.WidthCapFor(ItemData, p1085.Metadata and p1085.Metadata.MaxItemWidth);

        if v1093 and v1093 < v1091 then
            return true;
        end;

        local v1094 = p1088 or p1086.Position;

        if not v1094 then
            return true;
        end;

        if v1094.X < 0 or v1094.Y < 0 then
            return true;
        end;

        if v1094.X + v1091 > p1085.GridSize.X or v1094.Y + v1092 > p1085.GridSize.Y then
            return true;
        end;

        local v1095 = {};

        if p1087 then
            for _, v in pairs(p1087) do
                v1095[v] = true;
            end;
        end;

        v1095[p1086] = true;

        for _, v in pairs(p1085.Items or {}) do
            if not v1095[v] then
                local ItemData2 = ItemDatabase.GetItemData(v.Metadata.ID);

                if ItemData2 and v.Position then
                    local v1096 = v.Rotation or 0;
                    local v1097 = (v1096 == 1 or (v1096 == 3 or v1096 == 90)) and true or v1096 == 270;
                    local X = v1094.X;
                    local Y = v1094.Y;
                    local X2 = v.Position.X;
                    local Y2 = v.Position.Y;

                    if not (X + v1091 <= X2 or (X2 + (v1097 and ItemData2.Size.Y or ItemData2.Size.X) <= X or (Y + v1092 <= Y2 or Y2 + (v1097 and ItemData2.Size.X or ItemData2.Size.Y) <= Y)) or (p1086.IsDragging or p1086.IsDropping) and ((ItemData.ItemType == "Ammo" or ItemData.ItemType == "AmmoPack") and (ItemData2.ItemType == "Ammo" and ItemData.ammoType == ItemData2.ammoType)) or (p1086.IsDragging or p1086.IsDropping) and (ItemData.ItemType == "AmmoPack" and (ItemData2.ItemType == "AmmoPack" and p1086.Metadata.ID == v.Metadata.ID))) then
                        return true;
                    end;
                end;
            end;
        end;

        for _, v in ipairs(u1084.BuyCartGhosts or {}) do
            if v.grid == p1085 and (v.position and v.size) then
                local X = v1094.X;
                local Y = v1094.Y;
                local X2 = v.position.X;
                local Y2 = v.position.Y;

                if X + v1091 > X2 and (X2 + v.size.X > X and (Y + v1092 > Y2 and Y2 + v.size.Y > Y)) then
                    return true;
                end;
            end;
        end;

        return false;
    end;
end;

function u6.ClearGridPackInventory(p1098, u1099) -- Line: 11831
    if not u1099 then
        return;
    end;

    local table_clone_ret = table.clone(u1099.Items or {});

    for _, v in pairs(table_clone_ret) do
        pcall(function() -- Line: 11843
            -- upvalues: u1099 (copy), v (copy)
            u1099:RemoveItem(v);
        end);
        pcall(function() -- Line: 11844
            -- upvalues: v (copy)
            v:Destroy();
        end);
    end;

    if u1099.ClearItems then
        pcall(function() -- Line: 11848
            -- upvalues: u1099 (copy)
            u1099:ClearItems(false);
        end);
    end;
end;

return u6;