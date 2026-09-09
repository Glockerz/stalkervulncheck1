-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local TaskRemotes = ReplicatedStorage:WaitForChild("TaskRemotes")
local ok, result = pcall(function() --[[ Line: 8 | Upvalues: ReplicatedStorage (copy) ]]
	return require(ReplicatedStorage:WaitForChild("PdaSound", 5))
end)

local function sfx(p1) --[[ sfx | Line: 11 | Upvalues: ok (copy), result (copy) ]]
	if not (ok and result) then
		return
	end

	result.Play(p1)
end

local t = {
	_record = {
		schema_version = 1,
		active = {},
		finished = {},
		giver_cooldowns = {}
	},
	_listeners = {},
	_pendingShares = {},
	_shareListeners = {},
	_shareToastListeners = {},
	_toastFn = nil,
	_initialized = false,
	_pinnedId = nil,
	_pinListeners = {},
	_daily = nil,
	_ecologistRep = 0,
	_dailyListeners = {},
	_main = nil,
	_mainListeners = {}
}

local function broadcastPin() --[[ broadcastPin | Line: 33 | Upvalues: t (copy) ]]
	for i, v in ipairs(t._pinListeners) do
		task.spawn(v, t._pinnedId)
	end
end

local function broadcast() --[[ broadcast | Line: 39 | Upvalues: t (copy), broadcastPin (copy) ]]
	if t._pinnedId and (t._pinnedId:sub(1, 5) ~= "main:" and not t._record.active[t._pinnedId]) then
		t._pinnedId = nil
		broadcastPin()
	end

	for i, v in ipairs(t._listeners) do
		task.spawn(v, t._record)
	end
end

local function broadcastDaily() --[[ broadcastDaily | Line: 53 | Upvalues: t (copy) ]]
	for i, v in ipairs(t._dailyListeners) do
		task.spawn(v, t._daily)
	end
end

local function mainAsTask(p1, p2) --[[ mainAsTask | Line: 63 ]]
	if not p1 then
		return nil
	end

	local t = {
		id = "stage",
		complete = false,
		text = p1.stageText
	}

	if p1.killTarget then
		t.progress = p1.killProgress or 0
		t.target = p1.killTarget
	end

	return {
		__mainTask = true,
		id = "main:" .. p1.id,
		title = p1.title,
		objectives = { t },
		stageKind = p1.stageKind,
		zone = p1.zone,
		promptId = p1.promptId,
		camp = p1.camp,
		targetPos = p1.targetPos,
		giver = {
			npcId = p2 or "Crow"
		}
	}
end

local function broadcastMain() --[[ broadcastMain | Line: 89 | Upvalues: t (copy), broadcastPin (copy) ]]
	local _pinnedId = t._pinnedId

	if _pinnedId and _pinnedId:sub(1, 5) == "main:" then
		local v1 = t._main and t._main.active

		if not v1 or "main:" .. v1.id ~= _pinnedId then
			t._pinnedId = nil
			broadcastPin()
		end
	end

	for i, v in ipairs(t._mainListeners) do
		task.spawn(v, t._main)
	end
end

local function pendingShareList() --[[ pendingShareList | Line: 105 | Upvalues: t (copy) ]]
	local t2 = {}

	for k, v in pairs(t._pendingShares) do
		table.insert(t2, v)
	end

	table.sort(t2, function(p1, p2) --[[ Line: 108 ]]
		return (p1.received_at or 0) > (p2.received_at or 0)
	end)

	return t2
end

local function broadcastShares() --[[ broadcastShares | Line: 112 | Upvalues: pendingShareList (copy), t (copy) ]]
	local v1 = pendingShareList()

	for i, v in ipairs(t._shareListeners) do
		task.spawn(v, v1)
	end
end

local function fireShareToast(p1) --[[ fireShareToast | Line: 119 | Upvalues: t (copy) ]]
	for i, v in ipairs(t._shareToastListeners) do
		task.spawn(v, p1)
	end
end

function t.GetRecord(p1) --[[ GetRecord | Line: 125 ]]
	return p1._record
end
function t.GetActiveTasks(p1) --[[ GetActiveTasks | Line: 128 ]]
	local t = {}

	for k, v in pairs(p1._record.active) do
		table.insert(t, v)
	end

	table.sort(t, function(p1, p2) --[[ Line: 131 ]]
		return (p2.timing and p2.timing.accepted_at or 0) < (p1.timing and p1.timing.accepted_at or 0)
	end)

	return t
end
function t.GetTask(p1, p2) --[[ GetTask | Line: 138 ]]
	return p1._record.active[p2]
end
function t.OnChanged(p1, p2) --[[ OnChanged | Line: 141 ]]
	table.insert(p1._listeners, p2)
	task.spawn(p2, p1._record)
end
function t.OnSharesChanged(p1, p2) --[[ OnSharesChanged | Line: 145 | Upvalues: pendingShareList (copy) ]]
	table.insert(p1._shareListeners, p2)
	task.spawn(p2, (pendingShareList()))
end
function t.OnShareToast(p1, p2) --[[ OnShareToast | Line: 149 ]]
	table.insert(p1._shareToastListeners, p2)
end
function t.GetPendingShares(p1) --[[ GetPendingShares | Line: 152 | Upvalues: pendingShareList (copy) ]]
	return pendingShareList()
end
function t.GetPendingShare(p1, p2) --[[ GetPendingShare | Line: 155 ]]
	return if p2 then p1._pendingShares[p2] or nil else nil
end
function t.GetDaily(p1) --[[ GetDaily | Line: 158 ]]
	return p1._daily
end
function t.GetDailyTasks(p1) --[[ GetDailyTasks | Line: 161 ]]
	return if p1._daily then p1._daily.tasks or {} else {}
end
function t.GetEcologistRep(p1) --[[ GetEcologistRep | Line: 164 ]]
	return p1._ecologistRep or 0
end
function t.GetDailyTurnIn(p1) --[[ GetDailyTurnIn | Line: 185 ]]
	local _daily = p1._daily
	local v1 = _daily and tonumber(_daily.turninRoubles)
	local v2 = _daily and tonumber(_daily.turninRep) or 1

	if v1 then
		return tostring((math.floor(v1))):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), v1, v2
	end

	return nil, nil, v2
end
function t.OnDailyChanged(p1, p2) --[[ OnDailyChanged | Line: 196 ]]
	table.insert(p1._dailyListeners, p2)
	task.spawn(p2, p1._daily)
end
function t.TurnInDaily(p1, p2) --[[ TurnInDaily | Line: 200 ]]
	local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
	local ok, result = pcall(function() --[[ Line: 202 | Upvalues: Remotes (copy), p2 (copy) ]]
		return Remotes.DailyTaskTurnIn:InvokeServer(p2)
	end)

	if ok then
		return result
	end

	return {
		ok = false,
		err = tostring(result)
	}
end
function t.GetMain(p1) --[[ GetMain | Line: 210 ]]
	return p1._main
end
function t.GetMainActive(p1) --[[ GetMainActive | Line: 213 ]]
	return if p1._main then p1._main.active or nil else nil
end
function t.GetMainAvailable(p1) --[[ GetMainAvailable | Line: 216 ]]
	return if p1._main then p1._main.available or {} else {}
end
function t.GetMainCompleted(p1) --[[ GetMainCompleted | Line: 219 ]]
	return if p1._main then p1._main.completed or {} else {}
end
function t.GetMainSideDone(p1) --[[ GetMainSideDone | Line: 223 ]]
	return if p1._main then p1._main.sideDone or 0 else 0
end
function t.OnMainChanged(p1, p2) --[[ OnMainChanged | Line: 226 ]]
	table.insert(p1._mainListeners, p2)
	task.spawn(p2, p1._main)
end
function t.AcceptMain(p1, p2) --[[ AcceptMain | Line: 230 | Upvalues: ok (copy), result (copy), broadcastPin (copy) ]]
	local v1 = nil

	for i, v in ipairs(p1:GetMainAvailable()) do
		if v.id == p2 then
			v1 = v.title

			break
		end
	end

	local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
	local ok2, result2, result3 = pcall(function() --[[ Line: 238 | Upvalues: Remotes (copy), p2 (copy) ]]
		return Remotes.MainTaskAccept:InvokeServer(p2)
	end)

	if not ok2 then
		return false, "error"
	end

	if result2 then
		if ok and result then
			result.Play("pda_objective")
		end

		p1:ShowToast("Accepted: " .. (v1 or "Story task"))

		local v2 = "main:" .. p2

		if p1._pinnedId ~= v2 then
			p1._pinnedId = v2
			broadcastPin()
		end
	end

	return result2, result3
end
function t.ParleyAsk(p1, p2) --[[ ParleyAsk | Line: 267 ]]
	if type(p2) ~= "string" then
		return
	end

	local MainTaskParleyAsk = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("MainTaskParleyAsk")

	if not MainTaskParleyAsk then
		return
	end

	pcall(function() --[[ Line: 271 | Upvalues: MainTaskParleyAsk (copy), p2 (copy) ]]
		MainTaskParleyAsk:FireServer(p2)
	end)
end
function t.BreakTruce(p1) --[[ BreakTruce | Line: 274 ]]
	local MainTaskTruceBreak = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("MainTaskTruceBreak")

	if not MainTaskTruceBreak then
		return
	end

	pcall(function() --[[ Line: 277 | Upvalues: MainTaskTruceBreak (copy) ]]
		MainTaskTruceBreak:FireServer(true)
	end)
end
function t.Parley(p1) --[[ Parley | Line: 280 | Upvalues: ok (copy), result (copy) ]]
	local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
	local ok2, result2, result3, result4, result5 = pcall(function() --[[ Line: 285 | Upvalues: Remotes (copy) ]]
		return Remotes.MainTaskParley:InvokeServer()
	end)

	if not ok2 then
		return false, "error"
	end

	if not (result2 and (ok and result)) then
		return result2, result3, result4, result5
	end

	result.Play("pda_objective")

	return result2, result3, result4, result5
end
function t.ParleyPause(p1, p2) --[[ ParleyPause | Line: 295 ]]
	local MainTaskParleyPause = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):FindFirstChild("MainTaskParleyPause")

	if not MainTaskParleyPause then
		return
	end

	pcall(function() --[[ Line: 298 | Upvalues: MainTaskParleyPause (copy), p2 (copy) ]]
		MainTaskParleyPause:FireServer(p2 and true or false)
	end)
end
function t.TurnInMain(p1) --[[ TurnInMain | Line: 301 | Upvalues: ok (copy), result (copy) ]]
	local v1 = p1._main and p1._main.active
	local v2 = v1 and v1.title or "Story task"
	local v3 = v1 and v1.reward and v1.reward.money or 0
	local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
	local ok2, result2, result3, result4 = pcall(function() --[[ Line: 310 | Upvalues: Remotes (copy) ]]
		return Remotes.MainTaskTurnIn:InvokeServer()
	end)

	if not ok2 then
		return false, "error"
	end

	if result2 then
		if ok and result then
			result.Play("pda_note")
		end

		p1:ShowToast(string.format("Completed: %s | +%d\226\130\189", v2, v3))
	end

	return result2, result3, result4
end
function t.SetPinned(p1, p2) --[[ SetPinned | Line: 322 | Upvalues: broadcastPin (copy) ]]
	if p1._pinnedId == p2 then
		p1._pinnedId = nil
	else
		p1._pinnedId = p2
	end

	broadcastPin()
end
function t.GetPinnedId(p1) --[[ GetPinnedId | Line: 330 ]]
	return p1._pinnedId
end
function t.GetPinnedTask(p1) --[[ GetPinnedTask | Line: 333 | Upvalues: mainAsTask (copy) ]]
	if not p1._pinnedId then
		return nil
	end

	if p1._pinnedId:sub(1, 5) ~= "main:" then
		return p1._record.active[p1._pinnedId]
	end

	local v1 = p1._main and p1._main.active

	if v1 and "main:" .. v1.id == p1._pinnedId then
		return mainAsTask(v1, p1._main.giver)
	end

	return nil
end
function t.OnPinnedChanged(p1, p2) --[[ OnPinnedChanged | Line: 346 ]]
	table.insert(p1._pinListeners, p2)
	task.spawn(p2, p1._pinnedId)
end
function t.SetToastHandler(p1, p2) --[[ SetToastHandler | Line: 350 ]]
	p1._toastFn = p2
end
function t.ShowToast(p1, p2) --[[ ShowToast | Line: 353 ]]
	if not p1._toastFn then
		return
	end

	p1._toastFn(p2)
end
function t.RequestOffers(p1, p2) --[[ RequestOffers | Line: 357 | Upvalues: TaskRemotes (copy) ]]
	return TaskRemotes.RequestOffers:InvokeServer(p2)
end
function t.AcceptOffer(p1, p2) --[[ AcceptOffer | Line: 360 | Upvalues: TaskRemotes (copy), broadcast (copy) ]]
	local v1 = TaskRemotes.AcceptTask:InvokeServer(p2)

	if v1 and v1.ok then
		p1._record.active[v1.task.id] = v1.task
		broadcast()
	end

	return v1
end
function t.Handin(p1, p2, p3) --[[ Handin | Line: 368 | Upvalues: TaskRemotes (copy), broadcast (copy) ]]
	local v1 = TaskRemotes.HandinTask:InvokeServer(p2, p3)

	if v1 and v1.ok then
		p1._record.active[p2] = nil
		broadcast()
	end

	return v1
end
function t.Abandon(p1, p2) --[[ Abandon | Line: 376 | Upvalues: TaskRemotes (copy), broadcast (copy) ]]
	local v1 = TaskRemotes.AbandonTask:InvokeServer(p2)

	if v1 and v1.ok then
		p1._record.active[p2] = nil
		broadcast()
	end

	return v1
end
function t.Share(p1, p2) --[[ Share | Line: 384 | Upvalues: TaskRemotes (copy) ]]
	return TaskRemotes.ShareTask:InvokeServer(p2)
end
function t.AcceptShare(p1, p2) --[[ AcceptShare | Line: 387 | Upvalues: TaskRemotes (copy), broadcast (copy), broadcastShares (copy) ]]
	if not (if p2 then p1._pendingShares[p2] else p2) then
		return {
			ok = false,
			error = "no_share"
		}
	end

	local v2 = TaskRemotes.AcceptShare:InvokeServer(p2)

	if v2 and v2.ok then
		p1._record.active[v2.task.id] = v2.task
		p1._pendingShares[p2] = nil
		broadcast()
		broadcastShares()

		return v2
	end

	if v2 and (v2.error == "share_gone" or v2.error == "share_expired") then
		p1._pendingShares[p2] = nil
		broadcastShares()
	end

	return v2
end
function t.DeclineShare(p1, p2) --[[ DeclineShare | Line: 403 | Upvalues: broadcastShares (copy), TaskRemotes (copy) ]]
	if p2 and p1._pendingShares[p2] then
		p1._pendingShares[p2] = nil
		broadcastShares()
		TaskRemotes.DeclineShare:InvokeServer(p2)

		return {
			ok = true
		}
	end

	return {
		ok = false,
		error = "no_share"
	}
end
function t.Init(p1) --[[ Init | Line: 411 | Upvalues: TaskRemotes (copy), broadcast (copy), broadcastShares (copy), ok (copy), result (copy), fireShareToast (copy), ReplicatedStorage (copy), broadcastMain (copy), broadcastDaily (copy) ]]
	if not p1._initialized then
		p1._initialized = true
		task.spawn(function() --[[ Line: 415 | Upvalues: TaskRemotes (ref), p1 (copy), broadcast (ref), broadcastShares (ref) ]]
			local ok, result = pcall(function() --[[ Line: 416 | Upvalues: TaskRemotes (ref) ]]
				return TaskRemotes.RequestTaskList:InvokeServer()
			end)

			if not (ok and result) then
				return
			end

			p1._record.active = result.active or {}
			p1._record.finished = result.finished or {}
			p1._record.giver_cooldowns = result.giver_cooldowns or {}
			p1._pendingShares = {}

			for v6, v7 in pairs(result.pending_shares or {}) do
				p1._pendingShares[v6] = {
					received_at = 0,
					task = v7,
					fromName = v7.shared_from_name or "Squadmate"
				}
			end

			broadcast()
			broadcastShares()
		end)
		TaskRemotes.OnTaskAccepted.OnClientEvent:Connect(function(p12) --[[ Line: 430 | Upvalues: p1 (copy), broadcast (ref), ok (ref), result (ref) ]]
			if not (p12 and p12.id) then
				return
			end

			p1._record.active[p12.id] = p12
			broadcast()

			if ok and result then
				result.Play("pda_objective")
			end

			p1:ShowToast("Accepted: " .. (p12.title or "Task"))
		end)
		TaskRemotes.OnTaskProgress.OnClientEvent:Connect(function(p12) --[[ Line: 439 | Upvalues: p1 (copy), broadcast (ref), ok (ref), result (ref) ]]
			if not (p12 and p12.id) then
				return
			end

			local v1 = p1._record.active[p12.id]
			local v2 = false

			if v1 and (v1.objectives and p12.objectives) then
				local t = {}

				for i, v in ipairs(v1.objectives) do
					if v.id then
						t[v.id] = v
					end
				end

				for i, v in ipairs(p12.objectives) do
					local v3 = v.id and t[v.id]

					if v3 and (not v3.complete and v.complete) then
						v2 = true

						break
					end
				end
			end

			p1._record.active[p12.id] = p12
			broadcast()

			if not (v2 and (ok and result)) then
				return
			end

			result.Play("pda_note")
		end)
		TaskRemotes.OnTaskCompleted.OnClientEvent:Connect(function(p12) --[[ Line: 466 | Upvalues: p1 (copy), broadcast (ref), ok (ref), result (ref) ]]
			if not (p12 and p12.id) then
				return
			end

			p1._record.active[p12.id] = nil
			broadcast()

			if ok and result then
				result.Play("pda_note")
			end

			p1:ShowToast(string.format("Completed: %s | +%d\226\130\189", p12.title or "Task", (p12.rewards or {}).money or 0))
		end)
		TaskRemotes.OnTaskFailed.OnClientEvent:Connect(function(p12, p2) --[[ Line: 476 | Upvalues: p1 (copy), broadcast (ref), ok (ref), result (ref) ]]
			local v1 = p1._record.active[p12]

			if not v1 then
				return
			end

			p1._record.active[p12] = nil
			broadcast()

			if ok and result then
				result.Play("pda_communication_lost")
			end

			p1:ShowToast((v1.title or "Task") .. " \226\128\148 " .. (({
				abandoned = "Abandoned",
				died = "Failed: you died",
				deadline = "Failed: time\'s up",
				deadline_offline = "Failed: time\'s up",
				squad_done = "Completed by your squad",
				squad_dropped = "Squad task cancelled",
				squad_incomplete = "Squad finished it without your share"
			})[p2] or "Failed"))
		end)
		TaskRemotes.OnShareOffered.OnClientEvent:Connect(function(p12, p2) --[[ Line: 495 | Upvalues: p1 (copy), broadcastShares (ref), ok (ref), result (ref), fireShareToast (ref) ]]
			if not (p12 and p12.id) then
				return
			end

			local t = {
				task = p12,
				fromName = p2 or "Squadmate",
				received_at = os.clock()
			}

			p1._pendingShares[p12.id] = t
			broadcastShares()

			if ok and result then
				result.Play("pda_news")
			end

			fireShareToast(t)
		end)
		TaskRemotes.OnShareWithdrawn.OnClientEvent:Connect(function(p12) --[[ Line: 504 | Upvalues: p1 (copy), broadcastShares (ref) ]]
			if not (p12 and p1._pendingShares[p12]) then
				return
			end

			p1._pendingShares[p12] = nil
			broadcastShares()
		end)

		local Remotes = ReplicatedStorage:WaitForChild("Remotes")

		Remotes:WaitForChild("MainTaskState").OnClientEvent:Connect(function(p12) --[[ Line: 514 | Upvalues: p1 (copy), broadcastMain (ref), ok (ref), result (ref) ]]
			local v1 = p1._main and p1._main.active

			p1._main = p12
			broadcastMain()

			local v2 = if p12 then p12.active else p12

			if not v1 or (not v2 or (v1.id ~= v2.id or not ((v2.stageIndex or 0) > (v1.stageIndex or 0) and (ok and result)))) then
				return
			end

			result.Play("pda_objective")
		end)
		Remotes:WaitForChild("MainTaskMessage").OnClientEvent:Connect(function(p12) --[[ Line: 529 | Upvalues: ok (ref), result (ref), p1 (copy) ]]
			if not (p12 and p12.text) then
				return
			end

			if p12.kind ~= "note" or not (ok and result) then
				p1:ShowToast(p12.text)

				return
			end

			result.Play("pda_note")
			p1:ShowToast(p12.text)
		end)
		task.spawn(function() --[[ Line: 536 | Upvalues: Remotes (copy), p1 (copy), broadcastMain (ref) ]]
			local ok, result = pcall(function() --[[ Line: 537 | Upvalues: Remotes (ref) ]]
				return Remotes:WaitForChild("MainTaskSnapshot"):InvokeServer()
			end)

			if not (ok and result) then
				return
			end

			p1._main = result
			broadcastMain()
		end)

		local Remotes2 = ReplicatedStorage:WaitForChild("Remotes")

		Remotes2:WaitForChild("DailyTaskAssigned").OnClientEvent:Connect(function(p12) --[[ Line: 550 | Upvalues: p1 (copy), broadcastDaily (ref) ]]
			p1._daily = p12
			p1._ecologistRep = if p12 then p12.ecologistRep or 0 else 0
			broadcastDaily()
		end)
		Remotes2:WaitForChild("DailyTaskCompleted").OnClientEvent:Connect(function(p12) --[[ Line: 555 | Upvalues: p1 (copy), broadcastDaily (ref), ok (ref), result (ref) ]]
			if not (p1._daily and (p1._daily.tasks and (p12 and p12.taskIndex))) then
				return
			end

			local v1 = p1._daily.tasks[p12.taskIndex]

			if not v1 then
				return
			end

			v1.completed = true
			v1.progress = p12.progress or v1.progress
			broadcastDaily()

			if ok and result then
				result.Play("pda_note")
			end

			p1:ShowToast("Daily complete \226\128\148 return to the Ecologist")
		end)
	end
end

return t