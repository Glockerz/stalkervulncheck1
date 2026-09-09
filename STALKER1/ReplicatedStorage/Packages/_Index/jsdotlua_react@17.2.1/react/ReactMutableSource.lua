-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
require(script.Parent.Parent:WaitForChild("shared"))

return function(p1, p2) --[[ createMutableSource | Line: 16 ]]
	local t = {
		_workInProgressVersionPrimary = nil,
		_workInProgressVersionSecondary = nil,
		_getVersion = p2,
		_source = p1
	}

	if _G.__DEV__ then
		t._currentPrimaryRenderer = nil
		t._currentSecondaryRenderer = nil
	end

	return t
end