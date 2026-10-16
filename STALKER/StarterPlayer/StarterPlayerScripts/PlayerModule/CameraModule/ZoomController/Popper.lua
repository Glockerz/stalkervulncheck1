-- Decompiled with Potassium's decompiler.

local Players = game:GetService("Players");
local CommonUtils = script.Parent.Parent.Parent:WaitForChild("CommonUtils");
local FlagUtil = require(CommonUtils:WaitForChild("FlagUtil"));
local CameraWrapper = require(CommonUtils:WaitForChild("CameraWrapper"));
local ConnectionUtil = require(CommonUtils:WaitForChild("ConnectionUtil"));
local UserFlag = FlagUtil.getUserFlag("UserRaycastUpdateAPI2");
local UserFlag2 = FlagUtil.getUserFlag("UserCurrentCameraUpdate2");
local UserFlag3 = FlagUtil.getUserFlag("UserPlayerConnectionMemoryLeak");
local u1;

if UserFlag2 then
    u1 = CameraWrapper.new();
else
    u1 = nil;
end;

local u2;

if UserFlag2 then
    u2 = nil;
else
    u2 = game.Workspace.CurrentCamera;
end;

if UserFlag2 then
    u1:Enable();
end;

local math_min = math.min;
local math_tan = math.tan;
local math_rad = math.rad;
local Ray_new = Ray.new;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.IgnoreWater = true;
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;
local RaycastParams_new_ret2 = RaycastParams.new();
RaycastParams_new_ret2.IgnoreWater = true;
RaycastParams_new_ret2.FilterType = Enum.RaycastFilterType.Include;
local u3;

if UserFlag3 then
    u3 = ConnectionUtil.new();
else
    u3 = nil;
end;

local function getTotalTransparency(p4) -- Line: 43
    return 1 - (1 - p4.Transparency) * (1 - p4.LocalTransparencyModifier);
end;

local function eraseFromEnd(p5, p6) -- Line: 47
    for i = #p5, p6 + 1, -1 do
        p5[i] = nil;
        local _ = i;
    end;
end;

local u7 = nil;
local u8 = nil;
local u9;

if UserFlag2 then
    local function updateProjection() -- Line: 57
        -- upvalues: u1 (copy), math_rad (copy), u8 (ref), math_tan (copy), u7 (ref)
        local Camera = u1:getCamera();
        local v10 = math_rad(Camera.FieldOfView);
        local ViewportSize = Camera.ViewportSize;
        local v11 = ViewportSize.X / ViewportSize.Y;
        u8 = math_tan(v10 / 2) * 2;
        u7 = v11 * u8;
    end;

    u1:Connect("FieldOfView", updateProjection);
    u1:Connect("ViewportSize", updateProjection);
    local Camera = u1:getCamera();
    local v12 = math_rad(Camera.FieldOfView);
    local ViewportSize = Camera.ViewportSize;
    local v13 = ViewportSize.X / ViewportSize.Y;
    u8 = math_tan(v12 / 2) * 2;
    u7 = v13 * u8;
    u9 = u1:getCamera().NearPlaneZ;
    u1:Connect("NearPlaneZ", function() -- Line: 73
        -- upvalues: u9 (ref), u1 (copy)
        u9 = u1:getCamera().NearPlaneZ;
    end);
else
    local function v16() -- Line: 79
        -- upvalues: u2 (ref), math_rad (copy), u8 (ref), math_tan (copy), u7 (ref)
        local v14 = math_rad(u2.FieldOfView);
        local ViewportSize = u2.ViewportSize;
        local v15 = ViewportSize.X / ViewportSize.Y;
        u8 = math_tan(v14 / 2) * 2;
        u7 = v15 * u8;
    end;

    u2:GetPropertyChangedSignal("FieldOfView"):Connect(v16);
    u2:GetPropertyChangedSignal("ViewportSize"):Connect(v16);
    local v17 = math_rad(u2.FieldOfView);
    local ViewportSize = u2.ViewportSize;
    local v18 = ViewportSize.X / ViewportSize.Y;
    u8 = math_tan(v17 / 2) * 2;
    u7 = v18 * u8;
    u9 = u2.NearPlaneZ;
    u2:GetPropertyChangedSignal("NearPlaneZ"):Connect(function() -- Line: 93
        -- upvalues: u9 (ref), u2 (ref)
        u9 = u2.NearPlaneZ;
    end);
end;

local u19 = {};
local u20 = {};

local function refreshIgnoreList() -- Line: 102
    -- upvalues: u19 (ref), u20 (copy)
    local v21 = 1;
    u19 = {};

    for _, v in pairs(u20) do
        u19[v21] = v;
        v21 = v21 + 1;
    end;
end;

local function playerAdded(u22) -- Line: 111
    -- upvalues: u20 (copy), u19 (ref), UserFlag3 (copy), u3 (copy)
    local function characterAdded(p23) -- Line: 112
        -- upvalues: u20 (ref), u22 (copy), u19 (ref)
        u20[u22] = p23;
        local v24 = 1;
        u19 = {};

        for _, v in pairs(u20) do
            u19[v24] = v;
            v24 = v24 + 1;
        end;
    end;

    local function characterRemoving() -- Line: 116
        -- upvalues: u20 (ref), u22 (copy), u19 (ref)
        u20[u22] = nil;
        local v25 = 1;
        u19 = {};

        for _, v in pairs(u20) do
            u19[v25] = v;
            v25 = v25 + 1;
        end;
    end;

    if UserFlag3 then
        u3:trackConnection(`{u22.UserId}CharacterAdded`, u22.CharacterAdded:Connect(characterAdded));
        u3:trackConnection(`{u22.UserId}CharacterRemoving`, u22.CharacterRemoving:Connect(characterRemoving));
    else
        u22.CharacterAdded:Connect(characterAdded);
        u22.CharacterRemoving:Connect(characterRemoving);
    end;

    if u22.Character then
        u20[u22] = u22.Character;
        local v26 = 1;
        u19 = {};

        for _, v in pairs(u20) do
            u19[v26] = v;
            v26 = v26 + 1;
        end;
    end;
end;

local function playerRemoving(p27) -- Line: 134
    -- upvalues: u20 (copy), u19 (ref), UserFlag3 (copy), u3 (copy)
    u20[p27] = nil;
    local v28 = 1;
    u19 = {};

    for _, v in pairs(u20) do
        u19[v28] = v;
        v28 = v28 + 1;
    end;

    if UserFlag3 then
        u3:disconnect((`{p27.UserId}CharacterAdded`));
        u3:disconnect((`{p27.UserId}CharacterRemoving`));
    end;
end;

Players.PlayerAdded:Connect(playerAdded);
Players.PlayerRemoving:Connect(playerRemoving);

for _, v in ipairs(Players:GetPlayers()) do
    playerAdded(v);
end;

local v29 = 1;
u19 = {};

for _, v in pairs(u20) do
    u19[v29] = v;
    v29 = v29 + 1;
end;

local u30 = nil;
local u31 = nil;

if UserFlag2 then
    u1:Connect("CameraSubject", function() -- Line: 174
        -- upvalues: u1 (copy), u31 (ref)
        local CameraSubject = u1:getCamera().CameraSubject;

        if CameraSubject and CameraSubject:IsA("Humanoid") then
            u31 = CameraSubject.RootPart;

            return;
        end;

        if CameraSubject and CameraSubject:IsA("BasePart") then
            u31 = CameraSubject;

            return;
        end;

        u31 = nil;
    end);
else
    u2:GetPropertyChangedSignal("CameraSubject"):Connect(function() -- Line: 185
        -- upvalues: u2 (ref), u31 (ref)
        local CameraSubject = u2.CameraSubject;

        if CameraSubject:IsA("Humanoid") then
            u31 = CameraSubject.RootPart;

            return;
        end;

        if CameraSubject:IsA("BasePart") then
            u31 = CameraSubject;

            return;
        end;

        u31 = nil;
    end);
end;

local function isRebuiltCollision(p32) -- Line: 208
    local Parent = p32.Parent;
    local v33;

    if Parent == nil then
        v33 = false;
    else
        v33 = Parent.Name == "CollisionsFixed";
    end;

    return v33;
end;

local function canOcclude(p34) -- Line: 213
    -- upvalues: UserFlag (copy), u30 (ref)
    local v35;

    if 1 - (1 - p34.Transparency) * (1 - p34.LocalTransparencyModifier) < 0.25 then
        v35 = UserFlag or p34.CanCollide;

        if v35 then
            if u30 == (p34:GetRootPart() or p34) then
                v35 = false;
            else
                v35 = not p34:IsA("TrussPart");
            end;
        end;
    else
        local Parent = p34.Parent;

        if Parent == nil then
            v35 = false;
        else
            v35 = Parent.Name == "CollisionsFixed";
        end;

        if v35 then
            v35 = UserFlag or p34.CanCollide;

            if v35 then
                if u30 == (p34:GetRootPart() or p34) then
                    v35 = false;
                else
                    v35 = not p34:IsA("TrussPart");
                end;
            end;
        end;
    end;

    return v35;
end;

local u36 = {
    Vector2.new(0.4, 0),
    Vector2.new(-0.4, 0),
    Vector2.new(0, -0.4),
    Vector2.new(0, 0.4),
    Vector2.new(0, 0.2)
};

local function getCollisionPoint(p37, p38) -- Line: 241
    -- upvalues: UserFlag (copy), RaycastParams_new_ret (copy), u19 (ref), Ray_new (copy)
    if UserFlag then
        RaycastParams_new_ret.FilterDescendantsInstances = u19;
        local v39 = workspace:Raycast(p37, p38, RaycastParams_new_ret);

        if v39 then
            return v39.Position, true;
        end;
    else
        local v40 = #u19;
        local v41;

        repeat
            local v42;
            v41, v42 = workspace:FindPartOnRayWithIgnoreList(Ray_new(p37, p38), u19, false, true);

            if v41 then
                if v41.CanCollide then
                    local v43 = u19;

                    for i = #v43, v40 + 1, -1 do
                        v43[i] = nil;
                        local _ = i;
                    end;

                    return v42, true;
                end;

                u19[#u19 + 1] = v41;
            end;
        until not v41;

        local v44 = u19;

        for i = #v44, v40 + 1, -1 do
            v44[i] = nil;
            local _ = i;
        end;
    end;

    return p37 + p38, false;
end;

local function queryPoint(p45, p46, p47, p48) -- Line: 274
    -- upvalues: u19 (ref), u9 (ref), UserFlag (copy), RaycastParams_new_ret (copy), u30 (ref), RaycastParams_new_ret2 (copy), Ray_new (copy)
    debug.profilebegin("queryPoint");
    local v49 = #u19;
    local v50 = p47 + u9;
    local v51 = p45 + p46 * v50;
    local v52 = (1 / 0);
    local v53 = (1 / 0);
    local v54 = 0;
    local v55;

    if UserFlag then
        RaycastParams_new_ret.FilterDescendantsInstances = u19;
        local v56 = p45;

        while true do
            local v57 = workspace:Raycast(p45, v51 - p45, RaycastParams_new_ret);

            if not v57 then
                v55 = v52;
                break;
            end;

            v54 = v54 + 1;
            local Instance = v57.Instance;
            local Position = v57.Position;
            v55 = (Position - v56).Magnitude;

            if v54 >= 64 then
                v53 = v55;
                v55 = v52;
            else
                local v58;

                if 1 - (1 - Instance.Transparency) * (1 - Instance.LocalTransparencyModifier) < 0.25 then
                    v58 = UserFlag or Instance.CanCollide;

                    if v58 then
                        if u30 == (Instance:GetRootPart() or Instance) then
                            v58 = false;
                        else
                            v58 = not Instance:IsA("TrussPart");
                        end;
                    end;
                else
                    local Parent = Instance.Parent;

                    if Parent == nil then
                        v58 = false;
                    else
                        v58 = Parent.Name == "CollisionsFixed";
                    end;

                    if v58 then
                        v58 = UserFlag or Instance.CanCollide;

                        if v58 then
                            if u30 == (Instance:GetRootPart() or Instance) then
                                v58 = false;
                            else
                                v58 = not Instance:IsA("TrussPart");
                            end;
                        end;
                    end;
                end;

                if v58 then
                    RaycastParams_new_ret2.FilterDescendantsInstances = { Instance };

                    if workspace:Raycast(v51, Position - v51, RaycastParams_new_ret2) then
                        local v59;

                        if p48 then
                            v59 = workspace:Raycast(p48, v51 - p48, RaycastParams_new_ret2) or workspace:Raycast(v51, p48 - v51, RaycastParams_new_ret2);
                        else
                            v59 = false;
                        end;

                        if v59 then
                            v53 = v55;
                            v55 = v52;
                        elseif v50 >= v52 then
                            v55 = v52;
                        end;
                    else
                        v53 = v55;
                        v55 = v52;
                    end;
                else
                    v55 = v52;
                end;
            end;

            RaycastParams_new_ret:AddToFilter(Instance);
            p45 = Position - p46 * 0.001;

            if v53 < (1 / 0) or not Instance then
                break;
            end;

            v52 = v55;
        end;
    else
        local v60 = p45;

        while true do
            local v61;

            if true then
                local v62;
                v61, v62 = workspace:FindPartOnRayWithIgnoreList(Ray_new(p45, v51 - p45), u19, false, true);
                v54 = v54 + 1;

                if v61 then
                    local v63 = v54 >= 64;
                    local v64;

                    if 1 - (1 - v61.Transparency) * (1 - v61.LocalTransparencyModifier) < 0.25 then
                        v64 = UserFlag or v61.CanCollide;

                        if v64 then
                            if u30 == (v61:GetRootPart() or v61) then
                                v64 = false;
                            else
                                v64 = not v61:IsA("TrussPart");
                            end;
                        end;
                    else
                        local Parent = v61.Parent;

                        if Parent == nil then
                            v64 = false;
                        else
                            v64 = Parent.Name == "CollisionsFixed";
                        end;

                        if v64 then
                            v64 = UserFlag or v61.CanCollide;

                            if v64 then
                                if u30 == (v61:GetRootPart() or v61) then
                                    v64 = false;
                                else
                                    v64 = not v61:IsA("TrussPart");
                                end;
                            end;
                        end;
                    end;

                    if v64 or v63 then
                        local v65 = { v61 };
                        local v66 = workspace:FindPartOnRayWithWhitelist(Ray_new(v51, v62 - v51), v65, true);
                        v55 = (v62 - v60).Magnitude;

                        if v66 and not v63 then
                            local v67;

                            if p48 then
                                v67 = workspace:FindPartOnRayWithWhitelist(Ray_new(p48, v51 - p48), v65, true) or workspace:FindPartOnRayWithWhitelist(Ray_new(v51, p48 - v51), v65, true);
                            else
                                v67 = false;
                            end;

                            if v67 then
                                v53 = v55;
                                v55 = v52;
                            elseif v50 >= v52 then
                                v55 = v52;
                            end;
                        else
                            v53 = v55;
                            v55 = v52;
                        end;
                    else
                        v55 = v52;
                    end;

                    u19[#u19 + 1] = v61;
                    p45 = v62 - p46 * 0.001;
                else
                    v55 = v52;
                end;
            end;

            if v53 < (1 / 0) or not v61 then
                break;
            end;

            v52 = v55;
        end;

        local v68 = u19;

        for i = #v68, v49 + 1, -1 do
            v68[i] = nil;
            local _ = i;
        end;
    end;

    debug.profileend();

    return v55 - u9, v53 - u9;
end;

local function queryViewport(p69, p70) -- Line: 377
    -- upvalues: u2 (ref), UserFlag2 (copy), u1 (copy), u7 (ref), u8 (ref), u9 (ref), queryPoint (copy)
    debug.profilebegin("queryViewport");
    local p = p69.p;
    local rightVector = p69.rightVector;
    local upVector = p69.upVector;
    local v71 = -p69.lookVector;
    local v72;

    if UserFlag2 then
        v72 = u1:getCamera();
    else
        v72 = u2;
    end;

    u2 = v72;
    local ViewportSize = u2.ViewportSize;
    local v73 = (1 / 0);
    local v74 = (1 / 0);

    for i = 0, 1 do
        local v75 = rightVector * ((i - 0.5) * u7);
        local v76 = i;

        for i2 = 0, 1 do
            local v77, v78 = queryPoint(p + u9 * (v75 + upVector * ((i2 - 0.5) * u8)), v71, p70, u2:ViewportPointToRay(ViewportSize.x * v76, ViewportSize.y * i2).Origin);

            if v78 >= v73 then
                v78 = v73;
            end;

            local v79;

            if v77 < v74 then
                v79 = i2;
                v74 = v77;
                v73 = v78;
            else
                v79 = i2;
                v73 = v78;
            end;
        end;
    end;

    debug.profileend();

    return v74, v73;
end;

local function testPromotion(p80, p81, p82) -- Line: 420
    -- upvalues: getCollisionPoint (copy), math_min (copy), queryPoint (copy), u36 (copy)
    debug.profilebegin("testPromotion");
    local p = p80.p;
    local rightVector = p80.rightVector;
    local upVector = p80.upVector;
    local v83 = -p80.lookVector;
    debug.profilebegin("extrapolate");
    local Magnitude = (getCollisionPoint(p, p82.posVelocity * 1.25) - p).Magnitude;

    for i = 0, math_min(1.25, p82.rotVelocity.magnitude + Magnitude / p82.posVelocity.magnitude), 0.0625 do
        local v84 = p82.extrapolate(i);

        if p81 <= queryPoint(v84.p, -v84.lookVector, p81) then
            return false;
        end;

        local _ = i;
    end;

    debug.profileend();
    debug.profilebegin("testOffsets");

    for _, v in ipairs(u36) do
        local v85 = getCollisionPoint(p, rightVector * v.x + upVector * v.y);

        if queryPoint(v85, (p + v83 * p81 - v85).Unit, p81) == (1 / 0) then
            return false;
        end;
    end;

    debug.profileend();
    debug.profileend();

    return true;
end;

return function(p86, p87, p88) -- Line: 469, Name: Popper
    -- upvalues: u30 (ref), u31 (ref), queryViewport (copy), testPromotion (copy)
    debug.profilebegin("popper");
    u30 = u31 and u31:GetRootPart() or u31;
    local v89, v90 = queryViewport(p86, p87);

    if v90 >= p87 then
        v90 = p87;
    end;

    if v89 < v90 then
        if not testPromotion(p86, p87, p88) then
            v89 = v90;
        end;
    else
        v89 = v90;
    end;

    u30 = nil;
    debug.profileend();

    return v89;
end;