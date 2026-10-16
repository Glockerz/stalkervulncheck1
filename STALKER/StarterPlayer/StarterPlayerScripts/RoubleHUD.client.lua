-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local BalanceChanged = Remotes:WaitForChild("BalanceChanged");
local RequestBalance = Remotes:WaitForChild("RequestBalance");
local LocalPlayer = Players.LocalPlayer;
local RoubleDisplay = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("InventoryGui"):WaitForChild("MainFrame"):WaitForChild("InventoryFrame"):WaitForChild("RoubleDisplay");
local RoubleLabel = RoubleDisplay:WaitForChild("RoubleLabel");
local DropButton = RoubleDisplay:WaitForChild("DropButton");
BalanceChanged.OnClientEvent:Connect(function(p1) -- Line: 21, Name: render
    -- upvalues: RoubleLabel (copy)
    RoubleLabel.Text = string.format("₽ %d", p1 or 0);
end);
local u2 = false;
BalanceChanged.OnClientEvent:Connect(function() -- Line: 32
    -- upvalues: u2 (ref)
    u2 = true;
end);
task.spawn(function() -- Line: 33
    -- upvalues: u2 (ref), RequestBalance (copy), RoubleLabel (copy)
    while not u2 do
        local success, result = pcall(function() -- Line: 35
            -- upvalues: RequestBalance (ref)
            return RequestBalance:InvokeServer();
        end);

        if success and type(result) == "number" then
            RoubleLabel.Text = string.format("₽ %d", result or 0);

            return;
        end;

        task.wait(1);
    end;
end);
local DropRoubles = Remotes:WaitForChild("DropRoubles");
local u3 = false;
local u4 = nil;
local u5 = 0;
local u6 = nil;
local u7 = 0;
BalanceChanged.OnClientEvent:Connect(function(p8) -- Line: 52
    -- upvalues: u5 (ref)
    u5 = p8 or 0;
end);

local function commitText(p9) -- Line: 56
    -- upvalues: DropRoubles (copy)
    local v10 = tonumber(p9);

    if v10 and v10 > 0 then
        DropRoubles:FireServer((math.floor(v10)));
    end;
end;

local function resetToLabel() -- Line: 63
    -- upvalues: u3 (ref), u4 (ref), RoubleLabel (copy), DropButton (copy)
    u3 = false;

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    RoubleLabel.Visible = true;
    DropButton.Text = "DROP";
end;

local function enterDropMode() -- Line: 73
    -- upvalues: u3 (ref), RoubleLabel (copy), u4 (ref), RoubleDisplay (copy), DropButton (copy), u6 (ref), u7 (ref), DropRoubles (copy)
    if u3 then
        return;
    end;

    u3 = true;
    RoubleLabel.Visible = false;
    u4 = Instance.new("TextBox");
    u4.Name = "RoubleDropInput";
    u4.AnchorPoint = RoubleLabel.AnchorPoint;
    u4.Position = RoubleLabel.Position;
    u4.Size = RoubleLabel.Size;
    u4.BackgroundTransparency = 1;
    u4.TextColor3 = Color3.fromRGB(240, 220, 130);
    u4.FontFace = RoubleLabel.FontFace;
    u4.TextSize = RoubleLabel.TextSize;
    u4.TextXAlignment = RoubleLabel.TextXAlignment;
    u4.PlaceholderText = "Amount";
    u4.PlaceholderColor3 = Color3.fromRGB(140, 140, 140);
    u4.Text = "";
    u4.ClearTextOnFocus = false;
    u4.ZIndex = 6;
    u4.Parent = RoubleDisplay;
    u4:CaptureFocus();
    DropButton.Text = "OK";
    u4.FocusLost:Connect(function(p11) -- Line: 97
        -- upvalues: u6 (ref), u4 (ref), u7 (ref), DropRoubles (ref), u3 (ref), RoubleLabel (ref), DropButton (ref)
        u6 = u4.Text;
        u7 = os.clock();

        if not p11 then
            task.delay(0.12, function() -- Line: 108
                -- upvalues: u4 (ref), u3 (ref), RoubleLabel (ref), DropButton (ref)
                if u4 then
                    u3 = false;

                    if u4 then
                        u4:Destroy();
                        u4 = nil;
                    end;

                    RoubleLabel.Visible = true;
                    DropButton.Text = "DROP";
                end;
            end);

            return;
        end;

        local v12 = tonumber(u6);

        if v12 and v12 > 0 then
            DropRoubles:FireServer((math.floor(v12)));
        end;

        u3 = false;

        if u4 then
            u4:Destroy();
            u4 = nil;
        end;

        RoubleLabel.Visible = true;
        DropButton.Text = "DROP";
    end);
end;

DropButton.MouseButton1Click:Connect(function() -- Line: 114
    -- upvalues: u4 (ref), DropRoubles (copy), u3 (ref), RoubleLabel (copy), DropButton (copy), u6 (ref), u7 (ref), enterDropMode (copy)
    if u4 then
        local v13 = tonumber(u4.Text);

        if v13 and v13 > 0 then
            DropRoubles:FireServer((math.floor(v13)));
        end;

        u3 = false;

        if u4 then
            u4:Destroy();
            u4 = nil;
        end;

        RoubleLabel.Visible = true;
        DropButton.Text = "DROP";

        return;
    end;

    if not (u3 and (u6 and os.clock() - u7 < 0.2)) then
        enterDropMode();

        return;
    end;

    local v14 = tonumber(u6);

    if v14 and v14 > 0 then
        DropRoubles:FireServer((math.floor(v14)));
    end;

    u6 = nil;
    u3 = false;

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    RoubleLabel.Visible = true;
    DropButton.Text = "DROP";
end);
LocalPlayer.CharacterRemoving:Connect(function() -- Line: 133
    -- upvalues: u3 (ref), u4 (ref), RoubleLabel (copy), DropButton (copy)
    u3 = false;

    if u4 then
        u4:Destroy();
        u4 = nil;
    end;

    RoubleLabel.Visible = true;
    DropButton.Text = "DROP";
end);