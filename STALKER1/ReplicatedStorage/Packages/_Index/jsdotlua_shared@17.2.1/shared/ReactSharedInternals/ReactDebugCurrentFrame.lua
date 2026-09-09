-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}
local v1 = nil

function t.setExtraStackFrame(p1) --[[ setExtraStackFrame | Line: 16 | Upvalues: v1 (ref) ]]
	if not _G.__DEV__ then
		return
	end

	v1 = p1
end

if _G.__DEV__ then
	t.getCurrentStack = nil
	function t.getStackAddendum() --[[ getStackAddendum | Line: 33 | Upvalues: v1 (ref), t (copy) ]]
		local v12 = ""

		if v1 then
			v12 = v12 .. v1
		end

		local getCurrentStack = t.getCurrentStack

		if getCurrentStack then
			v12 = v12 .. (getCurrentStack() or "")
		end

		return v12
	end
end

return t