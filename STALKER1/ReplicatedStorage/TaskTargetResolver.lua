-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local TaskController = require(ReplicatedStorage:WaitForChild("TaskController"))
local t = {
	COLOR_KILL = Color3.fromRGB(220, 50, 50),
	COLOR_TURN_IN = Color3.fromRGB(255, 205, 60),
	COLOR_EXPLORE = Color3.fromRGB(110, 180, 255)
}
local v1 = nil

local function findLocationPos(p1) --[[ findLocationPos | Line: 21 | Upvalues: v1 (ref), ReplicatedStorage (copy), TaskController (copy) ]]
	if not p1 then
		return nil
	end

	v1 = v1 or require(ReplicatedStorage:WaitForChild("PdaMapData"))

	local v3 = v1.GetRegion(TaskController and TaskController.GetCurrentZone and TaskController:GetCurrentZone() or "Cordon")
	local v4 = ipairs

	for v6, v7 in v4(v3 and v3.Locations or {}) do
		if v7.Name == p1 then
			return v7.WorldPos
		end
	end

	local CollectionService = game:GetService("CollectionService")

	for i, v in ipairs(CollectionService:GetTagged("LocationZone")) do
		if v:IsA("BasePart") and v:GetAttribute("LocationName") == p1 then
			return v.Position
		end
	end

	return nil
end

local function findNpcPos(p1) --[[ findNpcPos | Line: 41 | Upvalues: Workspace (copy) ]]
	if not p1 then
		return nil
	end

	local NPCs = Workspace:FindFirstChild("NPCs")

	if not NPCs then
		return nil
	end

	local Traders = NPCs:FindFirstChild("Traders")
	local v1 = if Traders then Traders:FindFirstChild(p1) else Traders

	if v1 then
		local HumanoidRootPart = v1:FindFirstChild("HumanoidRootPart", true)

		if HumanoidRootPart then
			return HumanoidRootPart.Position
		end
	end

	for i, v in ipairs(NPCs:GetDescendants()) do
		if v:IsA("Model") and v.Name == p1 then
			local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart", true)

			if HumanoidRootPart then
				return HumanoidRootPart.Position
			end
		end
	end

	return nil
end

local function findPromptPos(p1) --[[ findPromptPos | Line: 65 ]]
	if not p1 then
		return nil
	end

	local CollectionService = game:GetService("CollectionService")

	for i, v in ipairs(CollectionService:GetTagged("MainTaskPrompt")) do
		if v:GetAttribute("PromptId") == p1 then
			if v:IsA("BasePart") then
				return v.Position
			end

			if v:IsA("Model") then
				local v1 = v.PrimaryPart or v:FindFirstChildWhichIsA("BasePart")

				if v1 then
					return v1.Position
				end
			end
		end
	end

	return nil
end

local function findCampPos(p1) --[[ findCampPos | Line: 82 | Upvalues: ReplicatedStorage (copy), Workspace (copy) ]]
	if not p1 then
		return nil
	end

	local TaskCamps = ReplicatedStorage:FindFirstChild("TaskCamps")
	local v1 = if TaskCamps then TaskCamps:FindFirstChild(p1) else TaskCamps
	local v2 = if v1 then v1:FindFirstChild("tp_point") else v1
	local v3 = if v2 then v2.Value else v2

	if not v3 then
		return nil
	end

	local TransitPoints = Workspace:FindFirstChild("TransitPoints")
	local v4 = if TransitPoints then TransitPoints:FindFirstChild(v3) else TransitPoints

	return if v4 and v4:IsA("BasePart") then v4.Position or nil else nil
end

local function killObjectivesDone(p1) --[[ killObjectivesDone | Line: 94 ]]
	if not (p1 and p1.objectives) then
		return true
	end

	for i, v in ipairs(p1.objectives) do
		if v.id ~= "return" and (v.id ~= "deliver" and not v.complete) then
			return false
		end
	end

	return true
end

function t.GetTrackedTask() --[[ GetTrackedTask | Line: 102 | Upvalues: TaskController (copy) ]]
	local v1 = TaskController:GetPinnedTask()

	if v1 then
		return v1
	end

	local v2 = if TaskController.GetMainActive then TaskController:GetMainActive() or nil else nil

	if v2 then
		return {
			__mainTask = true,
			id = v2.id,
			title = v2.title,
			stageKind = v2.stageKind,
			zone = v2.zone,
			promptId = v2.promptId,
			camp = v2.camp,
			targetPos = v2.targetPos,
			giver = {
				npcId = "Crow"
			}
		}
	end

	local v3 = TaskController:GetActiveTasks()

	return if v3 then v3[1] or nil else nil
end
function t.Resolve(p1) --[[ Resolve | Line: 129 | Upvalues: t (copy), findLocationPos (copy), findPromptPos (copy), findCampPos (copy), findNpcPos (copy), killObjectivesDone (copy), Workspace (copy) ]]
	if not p1 then
		return {}
	end

	local t2 = {}

	local function add(p1, p2, p3, p4, p5) --[[ add | Line: 137 | Upvalues: t2 (copy), t (ref) ]]
		if not p1 then
			return
		end

		local t3 = {
			pos = p1
		}

		t3.color = if p2 then p2 else t.COLOR_KILL
		t3.kind = p3 or "kill"
		t3.npcId = p4
		t3.subject = p5
		t2[#t2 + 1] = t3
	end

	local v1 = p1.giver and p1.giver.npcId

	if p1.__mainTask then
		local stageKind = p1.stageKind
		local targetPos = p1.targetPos

		if stageKind == "reach_location" then
			local v2 = if targetPos then targetPos else findLocationPos(p1.zone)
			local COLOR_EXPLORE = t.COLOR_EXPLORE

			if v2 then
				local t3 = {
					kind = "explore",
					npcId = nil,
					subject = nil,
					pos = v2
				}

				t3.color = if COLOR_EXPLORE then COLOR_EXPLORE else t.COLOR_KILL
				t2[#t2 + 1] = t3

				return t2
			end
		elseif stageKind == "investigate" or stageKind == "pickup" then
			local v5 = if targetPos then targetPos else findPromptPos(p1.promptId)
			local COLOR_EXPLORE = t.COLOR_EXPLORE

			if v5 then
				local t3 = {
					kind = "explore",
					npcId = nil,
					subject = nil,
					pos = v5
				}

				t3.color = if COLOR_EXPLORE then COLOR_EXPLORE else t.COLOR_KILL
				t2[#t2 + 1] = t3

				return t2
			end
		elseif stageKind == "kill" then
			local v8 = if targetPos then targetPos else findCampPos(p1.camp)
			local COLOR_KILL = t.COLOR_KILL

			if v8 then
				local t3 = {
					kind = "kill",
					npcId = nil,
					subject = "bandit",
					pos = v8
				}

				t3.color = if COLOR_KILL then COLOR_KILL else t.COLOR_KILL
				t2[#t2 + 1] = t3

				return t2
			end
		elseif stageKind == "turn_in" then
			local v11 = findNpcPos(v1)
			local COLOR_TURN_IN = t.COLOR_TURN_IN

			if v11 then
				local t3 = {
					kind = "turnin",
					subject = nil,
					pos = v11
				}

				t3.color = if COLOR_TURN_IN then COLOR_TURN_IN else t.COLOR_KILL
				t3.npcId = v1
				t2[#t2 + 1] = t3
			end
		end
	elseif p1.type == "fetching" then
		local v14 = findNpcPos(v1)
		local COLOR_TURN_IN = t.COLOR_TURN_IN

		if v14 then
			local t3 = {
				kind = "turnin",
				subject = nil,
				pos = v14
			}

			t3.color = if COLOR_TURN_IN then COLOR_TURN_IN else t.COLOR_KILL
			t3.npcId = v1
			t2[#t2 + 1] = t3

			return t2
		end
	elseif p1.type == "delivery" then
		local v17 = p1.params and p1.params.destination_npc
		local v18 = findNpcPos(v17)
		local COLOR_TURN_IN = t.COLOR_TURN_IN

		if v18 then
			local t3 = {
				kind = "turnin",
				subject = nil,
				pos = v18
			}

			t3.color = COLOR_TURN_IN or t.COLOR_KILL
			t3.npcId = v17
			t2[#t2 + 1] = t3

			return t2
		end
	elseif p1.type == "mutant_hunting" then
		if killObjectivesDone(p1) then
			local v21 = findNpcPos(v1)
			local COLOR_TURN_IN = t.COLOR_TURN_IN

			if v21 then
				local t3 = {
					kind = "turnin",
					subject = nil,
					pos = v21
				}

				t3.color = if COLOR_TURN_IN then COLOR_TURN_IN else t.COLOR_KILL
				t3.npcId = v1
				t2[#t2 + 1] = t3

				return t2
			end
		else
			local v25 = (if p1.params then p1.params.mutant_type or "" else ""):lower()

			if v25 ~= "" then
				local v26 = v25 .. "_"
				local v27 = "mutantspawn_" .. v25
				local v28 = Workspace.CurrentCamera and Workspace.CurrentCamera.CFrame.Position or Vector3.new()
				local t3 = {}

				for i, v in ipairs(Workspace:GetChildren()) do
					if v:IsA("BasePart") and v.Name:lower() == v27 then
						t3[#t3 + 1] = v.Position
					end
				end

				local list = {}

				local function collect(p1) --[[ collect | Line: 186 | Upvalues: v25 (copy), v26 (copy), list (copy) ]]
					if not p1:IsA("Model") then
						return
					end

					local v1 = p1.Name:lower()

					if v1 ~= v25 and v1:sub(1, #v26) ~= v26 then
						return
					end

					local Humanoid = p1:FindFirstChildOfClass("Humanoid")
					local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart")

					if not (Humanoid and (Humanoid.Health > 0 and HumanoidRootPart)) then
						return
					end

					list[#list + 1] = HumanoidRootPart.Position
				end

				local Mutants = Workspace:FindFirstChild("Mutants")

				if Mutants then
					for i, v in ipairs(Mutants:GetChildren()) do
						collect(v)
					end
				end

				for i, v in ipairs(Workspace:GetChildren()) do
					collect(v)
				end

				if #list > 0 then
					local v29 = (1 / 0)
					local v30 = nil

					for i, v in ipairs(list) do
						local Magnitude = (v - v28).Magnitude

						if Magnitude < v29 then
							v29 = Magnitude
							v30 = v
						end
					end

					if v30 then
						for i, v in ipairs(list) do
							if (v - v30).Magnitude <= 150 then
								local COLOR_KILL = t.COLOR_KILL

								if v then
									local t4 = {
										kind = "kill",
										npcId = nil,
										subject = "mutant",
										pos = v
									}

									t4.color = if COLOR_KILL then COLOR_KILL else t.COLOR_KILL
									t2[#t2 + 1] = t4
								end
							end
						end

						return t2
					end
				elseif t3[1] then
					table.sort(t3, function(p1, p2) --[[ Line: 214 | Upvalues: v28 (copy) ]]
						return (p1 - v28).Magnitude < (p2 - v28).Magnitude
					end)

					local v33 = t3[1]
					local COLOR_KILL = t.COLOR_KILL

					if v33 then
						local t4 = {
							kind = "kill",
							npcId = nil,
							subject = "mutant",
							pos = v33
						}

						t4.color = if COLOR_KILL then COLOR_KILL else t.COLOR_KILL
						t2[#t2 + 1] = t4

						return t2
					end
				end
			end
		end
	elseif p1.type == "deposit" then
		local v36 = false
		local v37 = ipairs

		for v39, v40 in v37(p1.objectives or {}) do
			if v40.id == "deposit" and v40.complete then
				v36 = true

				break
			end
		end

		if v36 then
			local v41 = findNpcPos(v1)
			local COLOR_TURN_IN = t.COLOR_TURN_IN

			if v41 then
				local t3 = {
					kind = "turnin",
					subject = nil,
					pos = v41
				}

				t3.color = COLOR_TURN_IN or t.COLOR_KILL
				t3.npcId = v1
				t2[#t2 + 1] = t3

				return t2
			end
		else
			local v44 = p1.params and p1.params.target_stash_pos

			if v44 then
				local v48 = Vector3.new(v44.X or 0, v44.Y or 0, v44.Z or 0)
				local COLOR_EXPLORE = t.COLOR_EXPLORE

				if v48 then
					local t3 = {
						kind = "deposit",
						npcId = nil,
						subject = nil,
						pos = v48
					}

					t3.color = if COLOR_EXPLORE then COLOR_EXPLORE else t.COLOR_KILL
					t2[#t2 + 1] = t3

					return t2
				end
			end
		end
	elseif p1.type == "exploration" then
		local v51 = true
		local v52 = ipairs

		for v54, v55 in v52(p1.objectives or {}) do
			if v55.id == "visit" and not v55.complete then
				v51 = false

				break
			end
		end

		if v51 then
			local v56 = findNpcPos(v1)
			local COLOR_TURN_IN = t.COLOR_TURN_IN

			if v56 then
				local t3 = {
					kind = "turnin",
					subject = nil,
					pos = v56
				}

				t3.color = COLOR_TURN_IN or t.COLOR_KILL
				t3.npcId = v1
				t2[#t2 + 1] = t3

				return t2
			end
		else
			local v60 = findLocationPos(p1.params and p1.params.location_name)
			local COLOR_EXPLORE = t.COLOR_EXPLORE

			if v60 then
				local t3 = {
					kind = "explore",
					npcId = nil,
					subject = nil,
					pos = v60
				}

				t3.color = if COLOR_EXPLORE then COLOR_EXPLORE else t.COLOR_KILL
				t2[#t2 + 1] = t3

				return t2
			end
		end
	elseif p1.type == "clearing" then
		if killObjectivesDone(p1) then
			local v63 = findNpcPos(v1)
			local COLOR_TURN_IN = t.COLOR_TURN_IN

			if v63 then
				local t3 = {
					kind = "turnin",
					subject = nil,
					pos = v63
				}

				t3.color = if COLOR_TURN_IN then COLOR_TURN_IN else t.COLOR_KILL
				t3.npcId = v1
				t2[#t2 + 1] = t3

				return t2
			end
		else
			local v66 = nil
			local v67 = nil
			local v68 = p1.params and p1.params.camp_id
			local TaskBanditSpawns = Workspace:FindFirstChild("TaskBanditSpawns")
			local v69 = if TaskBanditSpawns then if v68 then TaskBanditSpawns:FindFirstChild(v68) else v68 else TaskBanditSpawns

			if v69 then
				local v70 = (-1 / 0)
				local v71 = (1 / 0)
				local v72 = (-1 / 0)
				local v73 = (1 / 0)
				local v74 = (-1 / 0)
				local v75 = (1 / 0)

				for i, v in ipairs(v69:GetChildren()) do
					if v:IsA("BasePart") then
						local X = v.Position.X
						local Y = v.Position.Y
						local Z = v.Position.Z

						if X < v71 then
							v71 = X
						end

						if v72 < X then
							v72 = X
						end

						if Y < v73 then
							v73 = Y
						end

						if v74 < Y then
							v74 = Y
						end

						if Z < v75 then
							v75 = Z
						end

						if v70 < Z then
							v70 = Z
						end
					end
				end

				if v71 < (1 / 0) then
					v66 = Vector3.new((v71 + v72) / 2, (v73 + v74) / 2, (v75 + v70) / 2)

					local v76 = 0

					for i, v in ipairs(v69:GetChildren()) do
						if v:IsA("BasePart") then
							local Magnitude = (v.Position - v66).Magnitude

							if v76 < Magnitude then
								v76 = Magnitude
							end
						end
					end

					v67 = v76 + 30
				end
			end

			if not v66 then
				local tp_point = p1.tp_point

				if typeof(tp_point) == "Vector3" then
					v66 = tp_point
				elseif type(tp_point) == "table" then
					v66 = Vector3.new(tp_point.X or (tp_point[1] or 0), tp_point.Y or (tp_point[2] or 0), tp_point.Z or (tp_point[3] or 0))
				end

				if v66 then
					v67 = p1.radius or 60
				end
			end

			if v66 then
				local PlayerCharacters = Workspace:FindFirstChild("PlayerCharacters")
				local v80 = if PlayerCharacters then PlayerCharacters:FindFirstChild("HostileNPCs") else PlayerCharacters

				if v80 then
					for i, v in ipairs(v80:GetChildren()) do
						if v:IsA("Model") then
							local Humanoid = v:FindFirstChildOfClass("Humanoid")
							local HumanoidRootPart = v:FindFirstChild("HumanoidRootPart")

							if Humanoid and (Humanoid.Health > 0 and (HumanoidRootPart and (HumanoidRootPart.Position - v66).Magnitude <= v67)) then
								local Position = HumanoidRootPart.Position
								local COLOR_KILL = t.COLOR_KILL

								if Position then
									local t3 = {
										kind = "kill",
										npcId = nil,
										subject = "bandit",
										pos = Position
									}

									t3.color = if COLOR_KILL then COLOR_KILL else t.COLOR_KILL
									t2[#t2 + 1] = t3
								end
							end
						end
					end
				end
			end
		end
	end

	return t2
end

return t