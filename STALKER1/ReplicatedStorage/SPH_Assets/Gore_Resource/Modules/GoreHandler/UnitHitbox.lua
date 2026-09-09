-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

t.__index = t

local Heartbeat = game:GetService("RunService").Heartbeat

function t.getUnit(p1, p2, p3, p4) --[[ getUnit | Line: 6 ]]
	return (p2 - p1).Unit * p3 * p4
end
function t.new(p1, p2, p3) --[[ new | Line: 10 | Upvalues: t (copy) ]]
	local v2 = setmetatable({}, t)

	v2.connection = nil
	v2.increment = p2 or 0.25
	v2.active = false
	v2.destroyed = false
	v2.instance = p1
	v2.params = if p3 then p3 else RaycastParams.new()
	v2._onHitEvent = Instance.new("BindableEvent")
	v2.onHit = v2._onHitEvent.Event
	v2.oldPosition = p1.Position

	return v2
end
function t.Destroy(p1) --[[ Destroy | Line: 25 ]]
	if not p1.destroyed then
		p1:HitStop()
		p1.destroyed = true
		p1._onHitEvent:Destroy()
	end
end
function t.HitStart(p1) --[[ HitStart | Line: 33 | Upvalues: Heartbeat (copy), t (copy) ]]
	if not (p1.destroyed or p1.active) then
		local instance = p1.instance

		p1.active = true
		p1.oldPosition = instance.Position
		p1.connection = Heartbeat:Connect(function(p12) --[[ Line: 40 | Upvalues: instance (copy), p1 (copy), t (ref) ]]
			if not (instance and instance.Parent) then
				p1:HitStop()

				return
			end

			local v3 = workspace:Raycast(instance.Position, t.getUnit(p1.oldPosition, instance.Position, p12 * 60, p1.increment), p1.params)

			if not v3 then
				p1.oldPosition = instance.Position

				return
			end

			p1._onHitEvent:Fire(v3)
			p1.oldPosition = instance.Position
		end)
	end
end
function t.HitStop(p1) --[[ HitStop | Line: 58 ]]
	if not p1.destroyed and p1.active then
		p1.active = false
		p1.connection:Disconnect()
	end
end

return t