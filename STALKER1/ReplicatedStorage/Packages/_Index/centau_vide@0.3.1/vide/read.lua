-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
if game then
	return function(p13) --[[ read | Line: 3 ]]
		if type(p13) == "function" then
			return p13()
		end

		return p13
	end
end

script = require("test/relative-string")

return function(p13) --[[ read | Line: 3 ]]
	if type(p13) == "function" then
		return p13()
	end

	return p13
end