-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local vide = require(script.Parent.Parent.Parent.vide);
require(script.Parent.Parent.modules.types);
local u1 = {};

return {
    unmount_all = function() -- Line: 8, Name: unmount_all
        -- upvalues: u1 (copy)
        for i in u1 do
            i();
        end;
    end,

    spawn_app = function(u2, u3) -- Line: 14, Name: spawn_app
        -- upvalues: vide (copy), u1 (copy), Players (copy)
        return vide.root(function(u4) -- Line: 15
            -- upvalues: u1 (ref), u2 (copy), u3 (copy), Players (ref), vide (ref)
            local function v5() -- Line: 17
                -- upvalues: u1 (ref), u4 (copy)
                u1[u4] = nil;
                u4();
            end;

            local v6 = u2.mount(u3, v5);
            v6.Parent = Players.LocalPlayer.PlayerGui;
            vide.cleanup(v6);
            u1[v5] = true;

            return v5;
        end);
    end
};