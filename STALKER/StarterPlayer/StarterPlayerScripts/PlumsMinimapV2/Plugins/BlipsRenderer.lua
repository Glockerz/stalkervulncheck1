-- Decompiled with Potassium's decompiler.

local Internal = script.Parent.Parent.Internal;
require(Internal.GoodSignal);
local Janitor = require(Internal.Janitor);
local BorderSnap = require(Internal.BorderSnap);
local CameraUtils = require(Internal.CameraUtils);
local GeneralSettings = script.Parent.Parent.GeneralSettings;
local CollectionService = game:GetService("CollectionService");
local MinimapRenderer = require(script.Parent.MinimapRenderer);
local v1 = {
    InitializationPriority = 3,
    Signals = {}
};

local function getAngleAboutYAxis(p2) -- Line: 36
    local _, _, _, v3, _, v4, _, _, _, v5, _, v6 = p2:components();

    return math.atan2(v4 - v5, v3 + v6);
end;

function v1.InitializeFrame(u7: userdata, u8: table, u9: any) -- Line: 46
    -- upvalues: Janitor (copy), GeneralSettings (copy), CollectionService (copy), CameraUtils (copy), MinimapRenderer (copy), BorderSnap (copy)
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(1, 1);
    Frame.BackgroundTransparency = 1;
    Frame.Parent = u7;
    Frame.ZIndex = 501;
    local CanvasGroup = Instance.new("CanvasGroup");
    CanvasGroup.Size = UDim2.fromScale(1, 1);
    CanvasGroup.BackgroundTransparency = 1;
    CanvasGroup.Parent = u7;
    CanvasGroup.ZIndex = 501;
    CanvasGroup.ClipsDescendants = true;
    local v10 = u7:FindFirstChildOfClass("UICorner");

    if v10 then
        v10:Clone().Parent = CanvasGroup;
    end;

    u8.BlipHolder = Frame;
    u8.BlipHolderClip = CanvasGroup;
    u8.Blips = {};

    for _, child in script.Parent.Parent.Blips:GetChildren() do
        if not child:FindFirstChild("Rotate") then
            error("No Rotate BoolValue was provided in the blip data " .. child:GetFullName());
        end;

        if not child:FindFirstChild("SnapToBorder") then
            error("No SnapToBorder BoolValue was provided in the blip data " .. child:GetFullName());
        end;

        if not child:FindFirstChildOfClass("Decal") then
            error("No Decal was provided in the blip data " .. child:GetFullName());
        end;

        local function BlipAdded(p11: userdata) -- Line: 83
            -- upvalues: u9 (copy), Janitor (ref), GeneralSettings (ref), Frame (copy), child (copy), CanvasGroup (copy), u8 (copy)
            if not p11:IsA("BasePart") then
                return;
            end;

            local v12 = u9:Add(Janitor.new());
            local v13 = v12:Add(GeneralSettings:WaitForChild("Blip"):Clone());
            v13.AnchorPoint = Vector2.new(0.5, 0.5);
            v13.Parent = Frame;
            v13.Image = child.Decal.Texture;
            v13:SetAttribute("AnchorName", p11.Name);
            local Value = child.SnapToBorder.Value;

            if not Value then
                v13.Parent = CanvasGroup;
            end;

            u8.Blips[p11] = {
                Instance = p11,
                SnapToBorder = Value,
                Rotate = child.Rotate.Value,
                Object = v13,
                Janitor = v12
            };
        end;

        u9:Add(CollectionService:GetInstanceAddedSignal(child.Name):Connect(BlipAdded));

        for _, v in CollectionService:GetTagged(child.Name) do
            BlipAdded(v);
        end;

        u9:Add(CollectionService:GetInstanceRemovedSignal(child.Name):Connect(function(p14) -- Line: 119
            -- upvalues: u8 (copy)
            if u8.Blips[p14] then
                u8.Blips[p14].Janitor:Destroy();
                u8.Blips[p14] = nil;
            end;
        end));
    end;

    u9:Add(u8.CalculatedCFrame:Connect(function(p15, p16: number) -- Line: 127
        -- upvalues: u8 (copy), CameraUtils (ref), MinimapRenderer (ref), u7 (copy), BorderSnap (ref), GeneralSettings (ref)
        local AbsoluteSize = u8.BlipHolder.AbsoluteSize;

        for _, v in u8.Blips do
            local v17 = CameraUtils.PointToViewport(p15, 70, MinimapRenderer.WorldToMap(v.Position or v.Instance.Position), AbsoluteSize);

            if v.SnapToBorder then
                local UDim_new_ret = UDim.new(0, 0);
                local v18 = u7:FindFirstChildOfClass("UICorner");

                if v18 then
                    UDim_new_ret = v18.CornerRadius;
                end;

                v17 = BorderSnap(v17, AbsoluteSize, UDim_new_ret);
            end;

            if v.Rotate then
                local _, _, _, v19, _, v20, _, _, _, v21, _, v22 = v.Instance.CFrame:components();
                local math_atan2_ret = math.atan2(v20 - v21, v19 + v22);
                local Attribute = u7:GetAttribute("DontRotate");

                if Attribute == nil then
                    Attribute = GeneralSettings.DontRotate.Value;
                end;

                if Attribute then
                    v.Object.Rotation = -math.deg(math_atan2_ret);
                else
                    v.Object.Rotation = math.deg(p16 - math_atan2_ret);
                end;
            end;

            v.Object.Position = UDim2.fromScale(v17.X / AbsoluteSize.X, v17.Y / AbsoluteSize.Y);
        end;
    end));
end;

function v1.CleanupFrame(p23: userdata) -- Line: 164
end;

return v1;