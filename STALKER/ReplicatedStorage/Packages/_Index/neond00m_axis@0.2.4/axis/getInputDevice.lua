-- Decompiled with Potassium's decompiler.

require("./types");
local u1 = {
    Gamepad1 = "Controller",
    Gamepad2 = "Controller",
    Gamepad3 = "Controller",
    Gamepad4 = "Controller",
    Gamepad5 = "Controller",
    Gamepad6 = "Controller",
    Gamepad7 = "Controller",
    Gamepad8 = "Controller",
    Touch = "Touch",
    MouseButton1 = "Desktop",
    MouseButton2 = "Desktop",
    MouseButton3 = "Desktop",
    MouseMovement = "Desktop",
    MouseWheel = "Desktop",
    Keyboard = "Desktop"
};
local u2 = "Desktop";

return function(p3) -- Line: 23, Name: getInputDevice
    -- upvalues: u1 (copy), u2 (ref)
    local v4 = u1[p3.Name];

    if v4 then
        u2 = v4;
    end;

    return u2;
end;