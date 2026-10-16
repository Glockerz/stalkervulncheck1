-- Decompiled with Potassium's decompiler.

game:GetService("Players");
local CollectionService = game:GetService("CollectionService");
local script_Parent = script.Parent;
local CastAttachment = require(script_Parent.CastLogics.CastAttachment);
local CastVectorPoint = require(script_Parent.CastLogics.CastVectorPoint);
local CastLinkAttachment = require(script_Parent.CastLogics.CastLinkAttachment);
local Signal = require(script_Parent.Tools.Signal);
local os_clock = os.clock;
local v1 = {};
local u2 = {};
u2.__index = u2;

function u2.__tostring(p3) -- Line: 21
    return string.format("Hitbox for instance %s [%s]", p3.object.Name, p3.object.ClassName);
end;

function v1.new(p4) -- Line: 25
    -- upvalues: u2 (copy)
    return setmetatable({}, u2);
end;

function u2.config(p5, p6, p7) -- Line: 29
    -- upvalues: Signal (copy), CollectionService (copy)
    p5.active = false;
    p5.deleted = false;
    p5.partMode = false;
    p5.debugMode = false;
    p5.points = {};
    p5.targetsHit = {};
    p5.endTime = 0;
    p5.OnHit = Signal:Create();
    p5.OnUpdate = Signal:Create();
    p5.raycastParams = RaycastParams.new();
    p5.raycastParams.FilterType = Enum.RaycastFilterType.Blacklist;
    p5.raycastParams.FilterDescendantsInstances = p7 or {};
    p5.object = p6;
    CollectionService:AddTag(p5.object, "RaycastModuleManaged");
end;

function u2.SetPoints(p8, p9, p10, p11) -- Line: 47
    -- upvalues: CastVectorPoint (copy)
    if p9 and (p9:IsA("BasePart") or (p9:IsA("MeshPart") or p9:IsA("Attachment"))) then
        for _, v in ipairs(p10) do
            if typeof(v) == "Vector3" then
                local v12 = {
                    LastPosition = nil,
                    IsAttachment = p9:IsA("Attachment"),
                    RelativePart = p9,
                    Attachment = v,
                    group = p11,
                    solver = CastVectorPoint
                };
                table.insert(p8.points, v12);
            end;
        end;
    end;
end;

function u2.RemovePoints(p13, p14, p15) -- Line: 65
    if p14 and (p14:IsA("BasePart") or p14:IsA("MeshPart")) then
        for i = 1, #p13.points do
            local v16 = p13.points[i];
            local v17 = i;

            for _, v in ipairs(p15) do
                if typeof(v16.Attachment) == "Vector3" and (v16.Attachment == v and v16.RelativePart == p14) then
                    p13.points[v17] = nil;
                end;
            end;
        end;
    end;
end;

function u2.LinkAttachments(p18, p19, p20) -- Line: 80
    -- upvalues: CastLinkAttachment (copy)
    if p19:IsA("Attachment") and p20:IsA("Attachment") then
        local Group = p19:FindFirstChild("Group");
        local v21 = {
            RelativePart = nil,
            LastPosition = nil,
            Attachment = p19,
            Attachment0 = p20
        };

        if Group then
            Group = Group.Value;
        end;

        v21.group = Group;
        v21.solver = CastLinkAttachment;
        table.insert(p18.points, v21);
    end;
end;

function u2.UnlinkAttachments(p22, p23) -- Line: 95
    for i, v in ipairs(p22.points) do
        if v.Attachment and v.Attachment == p23 then
            table.remove(p22.points, i);

            return;
        end;
    end;
end;

function u2.seekAttachments(p24, p25, p26) -- Line: 104
    -- upvalues: CastAttachment (copy)
    if #p24.points <= 0 then
        table.insert(p24.raycastParams.FilterDescendantsInstances, workspace.Terrain);
    end;

    for _, descendant in ipairs(p24.object:GetDescendants()) do
        if descendant:IsA("Attachment") and descendant.Name == p25 then
            local Group = descendant:FindFirstChild("Group");
            local v27 = {
                RelativePart = nil,
                LastPosition = nil,
                Attachment = descendant
            };

            if Group then
                Group = Group.Value;
            end;

            v27.group = Group;
            v27.solver = CastAttachment;
            table.insert(p24.points, v27);
        end;
    end;

    if p26 then
        if #p24.points <= 0 then
            warn(string.format("\n[[RAYCAST WARNING]]\nNo attachments with the name \'%s\' were found in %s. No raycasts will be drawn. Can be ignored if you are using SetPoints.", p25, p24.object.Name));

            return;
        end;

        print(string.format("\n[[RAYCAST MESSAGE]]\n\nCreated Hitbox for %s - Attachments found: %s", p24.object.Name, #p24.points));
    end;
end;

function u2.Destroy(p28) -- Line: 135
    if p28.deleted then
        return;
    end;

    if p28.OnHit then
        p28.OnHit:Delete();
    end;

    if p28.OnUpdate then
        p28.OnUpdate:Delete();
    end;

    p28.points = nil;
    p28.active = false;
    p28.deleted = true;
end;

function u2.HitStart(p29, p30) -- Line: 145
    -- upvalues: os_clock (copy)
    p29.active = true;

    if p30 then
        local v31 = type(p30) == "number";
        assert(v31, "Argument #1 must be a number!");
        p29.endTime = os_clock() + ((p30 <= 0.016666666666666666 or p30 == (1 / 0)) and 0.016666666666666666 or p30);
    end;
end;

function u2.HitStop(p32) -- Line: 161
    if p32.deleted then
        return;
    end;

    p32.active = false;
    p32.endTime = 0;
    table.clear(p32.targetsHit);
end;

function u2.PartMode(p33, p34) -- Line: 169
    p33.partMode = p34;
end;

function u2.DebugMode(p35, p36) -- Line: 173
    p35.debugMode = p36;
end;

return v1;