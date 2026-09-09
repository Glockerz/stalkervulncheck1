-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if not game then
	script = require("test/relative-string")
end

local root = require(script.root)
local mount = require(script.mount)
local create = require(script.create)
local apply = require(script.apply)
local source = require(script.source)
local effect = require(script.effect)
local derive = require(script.derive)
local cleanup = require(script.cleanup)
local untrack = require(script.untrack)
local read = require(script.read)
local batch = require(script.batch)
local context = require(script.context)
local switch = require(script.switch)
local show = require(script.show)
local v1, v2 = require(script.maps)()
local v3, v4 = require(script.spring)()
local v5 = require(script.action)()
local changed = require(script.changed)
local throw = require(script.throw)
local flags = require(script.flags)

local function step(p1) --[[ step | Line: 35 | Upvalues: v4 (copy) ]]
	if game then
		debug.profilebegin("VIDE STEP")
		debug.profilebegin("VIDE SPRING")
	end

	v4(p1)

	if not game then
		return
	end

	debug.profileend()
	debug.profileend()
end

local v6 = game and game:GetService("RunService").Heartbeat:Connect(function(p1) --[[ Line: 49 | Upvalues: step (copy) ]]
	task.defer(step, p1)
end)
local t2 = {
	strict = nil,
	version = {
		major = 0,
		minor = 3,
		patch = 1
	},
	root = root,
	mount = mount,
	create = create,
	source = source,
	effect = effect,
	derive = derive,
	switch = switch,
	show = show,
	indexes = v1,
	values = v2,
	cleanup = cleanup,
	untrack = untrack,
	read = read,
	batch = batch,
	context = context,
	spring = v3,
	action = v5,
	changed = changed,
	apply = function(p1) --[[ apply | Line: 86 | Upvalues: apply (copy) ]]
		return function(p12) --[[ Line: 87 | Upvalues: apply (ref), p1 (copy) ]]
			apply(p1, p12)

			return p1
		end
	end,
	step = function(p1) --[[ step | Line: 94 | Upvalues: v6 (ref), step (copy) ]]
		if not v6 then
			step(p1)

			return
		end

		v6:Disconnect()
		v6 = nil
		step(p1)
	end
}

setmetatable(t2, {
	__index = function(p1, p2) --[[ __index | Line: 104 | Upvalues: flags (copy), throw (copy) ]]
		if p2 == "strict" then
			return flags.strict
		end

		throw((("%* is not a valid member of vide"):format((tostring(p2)))))
	end,
	__newindex = function(p1, p2, p3) --[[ __newindex | Line: 112 | Upvalues: flags (copy), throw (copy) ]]
		if p2 == "strict" then
			flags.strict = p3
		else
			throw((("%* is not a valid member of vide"):format((tostring(p2)))))
		end
	end
})

return t2