-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local Players = game:GetService("Players");
local GuiInset = GuiService:GetGuiInset();
require(script.Parent.Types);
local u1 = {};
u1.__index = u1;

function u1.new(p2) -- Line: 33
    -- upvalues: u1 (copy)
    local v3 = setmetatable({}, u1);
    v3.ConnectedItemManagers = p2.ConnectedItemManagers or {};

    return v3;
end;

function u1.AddItemManager(p4, p5) -- Line: 41
    table.insert(p4.ConnectedItemManagers, p5);
end;

function u1.RemoveItemManager(p6, p7) -- Line: 46
    local table_find_ret = table.find(p6.ConnectedItemManagers, p7);
    assert(table_find_ret, "Failed to remove ItemManager connection: Could not find connected ItemManager in TransferLink");
    table.remove(p6.ConnectedItemManagers, table_find_ret);
end;

function u1.GetItemOverlappingItemManagers(p8, p9) -- Line: 58
    local AbsolutePosition = p9.ItemElement.AbsolutePosition;
    local v10 = AbsolutePosition + p9.ItemElement.AbsoluteSize;
    local v11 = {};

    for _, v in pairs(p8.ConnectedItemManagers) do
        if v.Visible then
            local AbsolutePosition2 = v.GuiElement.AbsolutePosition;
            local v12 = AbsolutePosition2 + v.GuiElement.AbsoluteSize;
            local v13;

            if AbsolutePosition.X <= v12.X then
                v13 = v10.X >= AbsolutePosition2.X;
            else
                v13 = false;
            end;

            local v14;

            if AbsolutePosition.Y <= v12.Y then
                v14 = v10.Y >= AbsolutePosition2.Y;
            else
                v14 = false;
            end;

            if v13 and v14 then
                table.insert(v11, v);
            end;
        end;
    end;

    return v11;
end;

function u1.SortByMouse(p15, p16, p17, p18) -- Line: 100
    local v20 = p18 or function(p19) -- Line: 101
        return p19.GuiElement.AbsolutePosition, p19.GuiElement.AbsoluteSize;
    end;
    local u21 = {};
    local u22 = {};

    for _, v in ipairs(p15) do
        local v23, v24 = v20(v);
        u21[v] = (Vector2.new(math.clamp(p16.X, v23.X, v23.X + v24.X), (math.clamp(p16.Y, v23.Y, v23.Y + v24.Y))) - p16).Magnitude;
        u22[v] = (1 / 0);

        if p17 then
            local v25 = v;

            for i, v2 in ipairs(p17) do
                if v2 == v25.GuiElement or v2:IsDescendantOf(v25.GuiElement) then
                    u22[v25] = i;
                    break;
                end;
            end;
        end;
    end;

    table.sort(p15, function(p26, p27) -- Line: 122
        -- upvalues: u21 (copy), u22 (copy)
        if u21[p26] == u21[p27] then
            return u22[p26] < u22[p27];
        end;

        return u21[p26] < u21[p27];
    end);

    return p15;
end;

function u1.GetClosestItemOverlappingItemManagers(p28, p29) -- Line: 129
    -- upvalues: UserInputService (copy), GuiInset (copy), Players (copy), u1 (copy)
    local ItemOverlappingItemManagers = p28:GetItemOverlappingItemManagers(p29);
    local v30 = UserInputService:GetMouseLocation() - GuiInset;
    local v31 = nil;
    local v32;

    if #ItemOverlappingItemManagers > 1 then
        local LocalPlayer = Players.LocalPlayer;

        if LocalPlayer then
            LocalPlayer = LocalPlayer:FindFirstChildOfClass("PlayerGui");
        end;

        if LocalPlayer then
            local v33;
            v33, v32 = pcall(LocalPlayer.GetGuiObjectsAtPosition, LocalPlayer, v30.X, v30.Y);

            if not v33 then
                v32 = v31;
            end;
        else
            v32 = v31;
        end;
    else
        v32 = v31;
    end;

    return u1.SortByMouse(ItemOverlappingItemManagers, v30, v32);
end;

return u1;