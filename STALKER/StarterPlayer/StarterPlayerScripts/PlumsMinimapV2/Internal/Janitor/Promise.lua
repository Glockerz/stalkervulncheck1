-- Decompiled with Potassium's decompiler.

local Packages = script.Parent.Packages;

if Packages:FindFirstChild("Promise") then
    return require(Packages.Promise);
end;

return nil;