-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Object = require(script.Parent:WaitForChild("collections")).Object
local makeTimerImpl = require(script:WaitForChild("makeTimerImpl"))
local makeIntervalImpl = require(script:WaitForChild("makeIntervalImpl"))

return Object.assign({}, makeTimerImpl(task.delay), makeIntervalImpl(task.delay))