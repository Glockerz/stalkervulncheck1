-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local function inline_test() --[[ inline_test | Line: 1 ]]
	return debug.info(1, "n")
end

return {
	batch = false,
	strict = not (debug.info(1, "n") ~= "inline_test")
}