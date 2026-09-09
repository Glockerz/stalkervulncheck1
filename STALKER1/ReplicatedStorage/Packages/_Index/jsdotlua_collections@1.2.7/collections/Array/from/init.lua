-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Set = require(script.Parent.Parent:WaitForChild("Set"))
local Map = require(script.Parent.Parent:WaitForChild("Map"):WaitForChild("Map"))
local isArray = require(script.Parent:WaitForChild("isArray"))
local v1 = require(script.Parent.Parent.Parent:WaitForChild("instance-of"))

require(script.Parent.Parent.Parent:WaitForChild("es7-types"))

local fromString = require(script:WaitForChild("fromString"))
local fromSet = require(script:WaitForChild("fromSet"))
local fromMap = require(script:WaitForChild("fromMap"))
local fromArray = require(script:WaitForChild("fromArray"))

return function(p1, p2, p3) --[[ Line: 19 | Upvalues: isArray (copy), fromArray (copy), v1 (copy), Set (copy), fromSet (copy), Map (copy), fromMap (copy), fromString (copy) ]]
	if p1 == nil then
		error("cannot create array from a nil value")
	end

	local v12 = typeof(p1)

	if v12 == "table" and isArray(p1) then
		return fromArray(p1, p2, p3)
	end

	if v1(p1, Set) then
		return fromSet(p1, p2, p3)
	end

	if v1(p1, Map) then
		return fromMap(p1, p2, p3)
	end

	if v12 == "string" then
		return fromString(p1, p2, p3)
	end

	return {}
end