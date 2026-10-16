-- Decompiled with Potassium's decompiler.

local function inline_test() -- Line: 1
    return debug.info(1, "n");
end;

return {
    batch = false,
    strict = not (debug.info(1, "n") ~= "inline_test")
};