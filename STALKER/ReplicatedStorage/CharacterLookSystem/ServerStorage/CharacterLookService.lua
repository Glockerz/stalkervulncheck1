-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Update = script.CharacterLookClient.Value.Update;
local u1 = {};

function u1.Commence(p2) -- Line: 8
    -- upvalues: Update (copy), Players (copy), u1 (copy)
    Update.OnServerEvent:Connect(function(p3: userdata, p4: vector, p5: any) -- Line: 9
        -- upvalues: Update (ref), Players (ref)
        if typeof(p4) == "Vector3" then
            for _, v in pairs(Players:GetPlayers()) do
                if v ~= p3 then
                    Update:FireClient(v, p3, p4, p5);
                end;
            end;

            return;
        end;

        warn(string.format("[%s]: %s is acting sus... Did not give the server the right type of cameraDirection (gave %s, %s required.)", Update.Name, p3.Name, typeof(cameraDirection), "Vector3"));
    end);

    return u1;
end;

return u1;