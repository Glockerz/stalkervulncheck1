-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Version = "3.3",
	AttachmentName = "DmgPoint",
	DebugMode = false,
	WarningMessage = false
}
local MainHandler = require(script.MainHandler)
local HitboxObject = require(script.HitboxObject)

function t.Initialize(p1, p2, p3) --[[ Initialize | Line: 15 | Upvalues: MainHandler (copy), HitboxObject (copy), t (copy) ]]
	assert(p2, "You must provide an object instance.")

	local v1 = MainHandler:check(p2)

	if not v1 then
		local v2 = HitboxObject:new()

		v2:config(p2, p3)
		v2:seekAttachments(t.AttachmentName, t.WarningMessage)
		v2.debugMode = t.DebugMode
		MainHandler:add(v2)
		v1 = v2
	end

	return v1
end
function t.Deinitialize(p1, p2) --[[ Deinitialize | Line: 29 | Upvalues: MainHandler (copy) ]]
	MainHandler:remove(p2)
end
function t.GetHitbox(p1, p2) --[[ GetHitbox | Line: 33 | Upvalues: MainHandler (copy) ]]
	return MainHandler:check(p2)
end

return t