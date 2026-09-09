-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {}

game:GetService("RunService")
game:GetService("ReplicatedStorage")

local CurrentCamera = workspace.CurrentCamera
local Detect = require(script:WaitForChild("Detect"))
local Patcher = require(script:WaitForChild("Patcher"))

function t.init() --[[ init | Line: 11 | Upvalues: Patcher (copy), Detect (copy) ]]
	Patcher.init()
	Detect.init()
end

return t