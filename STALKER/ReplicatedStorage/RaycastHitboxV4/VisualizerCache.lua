-- Decompiled with Potassium's decompiler.

local Color3_fromRGB_ret = Color3.fromRGB(255, 0, 0);
local CFrame_new_ret = CFrame.new(0, (1 / 0), 0);
local u1 = {};
u1.__index = u1;
u1.__type = "RaycastHitboxVisualizerCache";
u1._AdornmentInUse = {};
u1._AdornmentInReserve = {};

function u1._CreateAdornment(p2) -- Line: 25
    -- upvalues: Color3_fromRGB_ret (copy), CFrame_new_ret (copy)
    local LineHandleAdornment = Instance.new("LineHandleAdornment");
    LineHandleAdornment.Name = "_RaycastHitboxDebugLine";
    LineHandleAdornment.Color3 = Color3_fromRGB_ret;
    LineHandleAdornment.Thickness = 4;
    LineHandleAdornment.Length = 0;
    LineHandleAdornment.CFrame = CFrame_new_ret;
    LineHandleAdornment.Adornee = workspace.Terrain;
    LineHandleAdornment.Parent = workspace.Terrain;

    return {
        LastUse = 0,
        Adornment = LineHandleAdornment
    };
end;

function u1.GetAdornment(p3) -- Line: 44
    -- upvalues: u1 (copy)
    if #u1._AdornmentInReserve <= 0 then
        local v4 = u1:_CreateAdornment();
        table.insert(u1._AdornmentInReserve, v4);
    end;

    local table_remove_ret = table.remove(u1._AdornmentInReserve, 1);

    if table_remove_ret then
        table_remove_ret.Adornment.Visible = true;
        table_remove_ret.LastUse = os.clock();
        table.insert(u1._AdornmentInUse, table_remove_ret);
    end;

    return table_remove_ret;
end;

function u1.ReturnAdornment(p5: table, p6: table) -- Line: 64
    -- upvalues: CFrame_new_ret (copy), u1 (copy)
    p6.Adornment.Length = 0;
    p6.Adornment.Visible = false;
    p6.Adornment.CFrame = CFrame_new_ret;
    table.insert(u1._AdornmentInReserve, p6);
end;

function u1.Clear(p7) -- Line: 74
    -- upvalues: u1 (copy)
    for i = #u1._AdornmentInReserve, 1, -1 do
        if u1._AdornmentInReserve[i].Adornment then
            u1._AdornmentInReserve[i].Adornment:Destroy();
        end;

        table.remove(u1._AdornmentInReserve, i);
        local _ = i;
    end;
end;

return u1;