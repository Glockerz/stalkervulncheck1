-- Decompiled with Potassium's decompiler.

local workspace_CurrentCamera = workspace.CurrentCamera;
local script_Parent = script.Parent;

local function layout() -- Line: 8
    -- upvalues: workspace_CurrentCamera (ref), script_Parent (copy)
    if not workspace_CurrentCamera then
        workspace_CurrentCamera = workspace.CurrentCamera;
    end;

    local v1 = workspace_CurrentCamera and workspace_CurrentCamera.ViewportSize;

    if not (v1 and (v1.X > 0 and v1.Y > 0)) then
        return;
    end;

    local math_max_ret = math.max(0, 0.5 - 0.4 * (v1.Y / v1.X) + 0.02);
    local LeftBar = script_Parent:FindFirstChild("LeftBar");
    local RightBar = script_Parent:FindFirstChild("RightBar");
    local TopBar = script_Parent:FindFirstChild("TopBar");
    local BottomBar = script_Parent:FindFirstChild("BottomBar");

    if LeftBar then
        LeftBar.AnchorPoint = Vector2.new(0, 0.5);
        LeftBar.Position = UDim2.fromScale(0, 0.5);
        LeftBar.Size = UDim2.fromScale(math_max_ret, 1);
    end;

    if RightBar then
        RightBar.AnchorPoint = Vector2.new(1, 0.5);
        RightBar.Position = UDim2.fromScale(1, 0.5);
        RightBar.Size = UDim2.fromScale(math_max_ret, 1);
    end;

    if TopBar then
        TopBar.AnchorPoint = Vector2.new(0.5, 0);
        TopBar.Position = UDim2.fromScale(0.5, 0);
        TopBar.Size = UDim2.fromScale(1, 0.11999999999999998);
    end;

    if BottomBar then
        BottomBar.AnchorPoint = Vector2.new(0.5, 1);
        BottomBar.Position = UDim2.fromScale(0.5, 1);
        BottomBar.Size = UDim2.fromScale(1, 0.11999999999999998);
    end;
end;

layout();

if workspace_CurrentCamera then
    workspace_CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(layout);
end;

task.spawn(function() -- Line: 25
    -- upvalues: layout (copy)
    for i = 1, 10 do
        task.wait(0.1);
        layout();
        local _ = i;
    end;
end);