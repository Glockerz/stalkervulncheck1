-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	Messages = {
		Killed = { "was killed by", "was neutralized by", "was made a casualty by", "was oof\'d by", "died of wounds inflicted by" },
		Falling = { "fell from a deadly height", "shattered their legs", "hit the ground too fast" },
		Death = { "died under mysterious circumstances", "inexplicably died", "suddenly fainted", "slipped into a coma", "entered a vegetative state" }
	}
}

function t.GetMessage(p1) --[[ Line: 25 | Upvalues: t (copy) ]]
	local v1 = t.Messages[p1]

	return v1[math.random(#v1)]
end

return t