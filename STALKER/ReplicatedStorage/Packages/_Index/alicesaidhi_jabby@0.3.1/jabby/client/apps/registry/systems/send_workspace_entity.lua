-- Decompiled with Potassium's decompiler.

local UserInputService = game:GetService("UserInputService");
local remotes = require(script.Parent.Parent.Parent.Parent.Parent.modules.remotes);

return function(p1: table) -- Line: 14
    -- upvalues: UserInputService (copy), remotes (copy)
    if p1.enable_pick() == false then
        return;
    end;

    local MouseLocation = UserInputService:GetMouseLocation();
    local v2 = workspace.CurrentCamera:ViewportPointToRay(MouseLocation.X, MouseLocation.Y);
    remotes.send_mouse_pointer:fire({
        host = p1.host,
        to_vm = p1.vm
    }, p1.id, v2.Origin, v2.Direction);
end;