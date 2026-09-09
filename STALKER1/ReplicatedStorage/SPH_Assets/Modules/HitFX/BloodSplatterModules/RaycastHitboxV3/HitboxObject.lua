-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
game:GetService("Players")

local CollectionService = game:GetService("CollectionService")
local v1 = script.Parent
local CastAttachment = require(v1.CastLogics.CastAttachment)
local CastVectorPoint = require(v1.CastLogics.CastVectorPoint)
local CastLinkAttachment = require(v1.CastLogics.CastLinkAttachment)
local Signal = require(v1.Tools.Signal)
local clock = os.clock
local t = {}
local t2 = {}

t2.__index = t2
function t2.__tostring(p1) --[[ __tostring | Line: 21 ]]
	return string.format("Hitbox for instance %s [%s]", p1.object.Name, p1.object.ClassName)
end
function t.new(p1) --[[ new | Line: 25 | Upvalues: t2 (copy) ]]
	return setmetatable({}, t2)
end
function t2.config(p1, p2, p3) --[[ config | Line: 29 | Upvalues: Signal (copy), CollectionService (copy) ]]
	p1.active = false
	p1.deleted = false
	p1.partMode = false
	p1.debugMode = false
	p1.points = {}
	p1.targetsHit = {}
	p1.endTime = 0
	p1.OnHit = Signal:Create()
	p1.OnUpdate = Signal:Create()
	p1.raycastParams = RaycastParams.new()
	p1.raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
	p1.raycastParams.FilterDescendantsInstances = if p3 then p3 else {}
	p1.object = p2
	CollectionService:AddTag(p1.object, "RaycastModuleManaged")
end
function t2.SetPoints(p1, p2, p3, p4) --[[ SetPoints | Line: 47 | Upvalues: CastVectorPoint (copy) ]]
	if not (p2 and (p2:IsA("BasePart") or (p2:IsA("MeshPart") or p2:IsA("Attachment")))) then
		return
	end

	for i, v in ipairs(p3) do
		if typeof(v) == "Vector3" then
			local t = {
				LastPosition = nil,
				IsAttachment = p2:IsA("Attachment"),
				RelativePart = p2,
				Attachment = v,
				group = p4,
				solver = CastVectorPoint
			}

			table.insert(p1.points, t)
		end
	end
end
function t2.RemovePoints(p1, p2, p3) --[[ RemovePoints | Line: 65 ]]
	if not (p2 and (p2:IsA("BasePart") or p2:IsA("MeshPart"))) then
		return
	end

	for i = 1, #p1.points do
		local v1 = p1.points[i]

		for i2, v in ipairs(p3) do
			if typeof(v1.Attachment) == "Vector3" and (v1.Attachment == v and v1.RelativePart == p2) then
				p1.points[i] = nil
			end
		end
	end
end
function t2.LinkAttachments(p1, p2, p3) --[[ LinkAttachments | Line: 80 | Upvalues: CastLinkAttachment (copy) ]]
	if not (p2:IsA("Attachment") and p3:IsA("Attachment")) then
		return
	end

	local Group = p2:FindFirstChild("Group")
	local t = {
		RelativePart = nil,
		LastPosition = nil,
		Attachment = p2,
		Attachment0 = p3
	}

	t.group = if Group then Group.Value else Group
	t.solver = CastLinkAttachment
	table.insert(p1.points, t)
end
function t2.UnlinkAttachments(p1, p2) --[[ UnlinkAttachments | Line: 95 ]]
	for i, v in ipairs(p1.points) do
		if v.Attachment and v.Attachment == p2 then
			table.remove(p1.points, i)

			return
		end
	end
end
function t2.seekAttachments(p1, p2, p3) --[[ seekAttachments | Line: 104 | Upvalues: CastAttachment (copy) ]]
	if #p1.points <= 0 then
		table.insert(p1.raycastParams.FilterDescendantsInstances, workspace.Terrain)
	end

	for i, v in ipairs(p1.object:GetDescendants()) do
		if v:IsA("Attachment") and v.Name == p2 then
			local Group = v:FindFirstChild("Group")
			local t = {
				RelativePart = nil,
				LastPosition = nil,
				Attachment = v
			}

			t.group = if Group then Group.Value else Group
			t.solver = CastAttachment
			table.insert(p1.points, t)
		end
	end

	if not p3 then
		return
	end

	if #p1.points <= 0 then
		warn(string.format("\n[[RAYCAST WARNING]]\nNo attachments with the name \'%s\' were found in %s. No raycasts will be drawn. Can be ignored if you are using SetPoints.", p2, p1.object.Name))

		return
	end

	print(string.format("\n[[RAYCAST MESSAGE]]\n\nCreated Hitbox for %s - Attachments found: %s", p1.object.Name, #p1.points))
end
function t2.Destroy(p1) --[[ Destroy | Line: 135 ]]
	if p1.deleted then
		return
	end

	if p1.OnHit then
		p1.OnHit:Delete()
	end

	if p1.OnUpdate then
		p1.OnUpdate:Delete()
	end

	p1.points = nil
	p1.active = false
	p1.deleted = true
end
function t2.HitStart(p1, p2) --[[ HitStart | Line: 145 | Upvalues: clock (copy) ]]
	p1.active = true

	if not p2 then
		return
	end

	assert(type(p2) == "number", "Argument #1 must be a number!")

	if p2 <= 1 / 60 or p2 == (1 / 0) then
		p2 = 1 / 60
	end

	p1.endTime = clock() + p2
end
function t2.HitStop(p1) --[[ HitStop | Line: 161 ]]
	if not p1.deleted then
		p1.active = false
		p1.endTime = 0
		table.clear(p1.targetsHit)
	end
end
function t2.PartMode(p1, p2) --[[ PartMode | Line: 169 ]]
	p1.partMode = p2
end
function t2.DebugMode(p1, p2) --[[ DebugMode | Line: 173 ]]
	p1.debugMode = p2
end

return t