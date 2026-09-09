-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = require(script.Parent.Parent:WaitForChild("luau-polyfill"))
local Error = v1.Error
local inspect = v1.util.inspect
local getComponentName = require(script.Parent:WaitForChild("getComponentName"))
local t = {}

local function isValidFiber(p1) --[[ isValidFiber | Line: 33 ]]
	return if p1.tag == nil or (p1.subtreeFlags == nil or p1.lanes == nil) then false else p1.childLanes ~= nil
end

function t.remove(p1) --[[ Line: 40 ]]
	p1._reactInternals = nil
end
function t.get(p1) --[[ Line: 44 | Upvalues: Error (copy), getComponentName (copy), inspect (copy) ]]
	local _reactInternals = p1._reactInternals

	if not (if _reactInternals.tag == nil or (_reactInternals.subtreeFlags == nil or _reactInternals.lanes == nil) then false elseif _reactInternals.childLanes == nil then false else true) then
		error(Error.new("invalid fiber in " .. (getComponentName(p1) or "UNNAMED Component") .. " during get from ReactInstanceMap! " .. inspect(_reactInternals)))
	end

	if _reactInternals.alternate ~= nil then
		local alternate = _reactInternals.alternate

		if not (if alternate.tag == nil or (alternate.subtreeFlags == nil or alternate.lanes == nil) then false else alternate.childLanes ~= nil) then
			error(Error.new("invalid alternate fiber (" .. (getComponentName(p1) or "UNNAMED alternate") .. ") in " .. (getComponentName(p1) or "UNNAMED Component") .. " during get from ReactInstanceMap! " .. inspect(_reactInternals.alternate)))
		end
	end

	return _reactInternals
end
function t.has(p1) --[[ Line: 74 ]]
	return p1._reactInternals ~= nil
end
function t.set(p1, p2) --[[ Line: 78 | Upvalues: getComponentName (copy), inspect (copy), Error (copy) ]]
	local v1 = p2

	while v1 ~= nil do
		if if v1.tag == nil or (v1.subtreeFlags == nil or v1.lanes == nil) then false else v1.childLanes ~= nil then
			if v1.alternate ~= nil then
				local alternate = v1.alternate

				if not (if alternate.tag == nil or (alternate.subtreeFlags == nil or alternate.lanes == nil) then false else alternate.childLanes ~= nil) then
					local v4 = "invalid alternate fiber (" .. (getComponentName(p1) or "UNNAMED alternate") .. ") in " .. (getComponentName(p1) or "UNNAMED Component") .. " being set in ReactInstanceMap! " .. inspect(v1.alternate) .. "\n"

					if p2 ~= v1 then
						v4 = v4 .. " (from original fiber " .. (getComponentName(p1) or "UNNAMED Component") .. ")"
					end

					error(Error.new(v4))
				end
			end
		else
			local v5 = "invalid fiber in " .. (getComponentName(p1) or "UNNAMED Component") .. " being set in ReactInstanceMap! " .. inspect(v1) .. "\n"

			if p2 ~= v1 then
				v5 = v5 .. " (from original fiber " .. (getComponentName(p1) or "UNNAMED Component") .. ")"
			end

			error(Error.new(v5))
		end

		v1 = v1.return_
	end

	p1._reactInternals = p2
end

return t