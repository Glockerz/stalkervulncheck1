-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Phase = require(script.Phase)
local Pipeline = require(script.Pipeline)
local Scheduler = require(script.Scheduler)
local conditions = require(script.conditions)

require(script.utils)

return {
	Phase = Phase,
	Pipeline = Pipeline,
	Scheduler = Scheduler,
	isNot = conditions.isNot,
	runOnce = conditions.runOnce,
	timePassed = conditions.timePassed,
	onEvent = conditions.onEvent
}