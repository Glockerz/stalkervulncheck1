-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	Hooks = {
		SystemAdd = "SystemAdd",
		SystemRemove = "SystemRemove",
		SystemReplace = "SystemReplace",
		SystemError = "SystemError",
		OuterSystemCall = "OuterSystemCall",
		InnerSystemCall = "InnerSystemCall",
		SystemCall = "SystemCall",
		PhaseAdd = "PhaseAdd",
		PhaseBegan = "PhaseBegan"
	},
	systemAdd = function(p1, p2) --[[ systemAdd | Line: 3 ]]
		local t = {
			scheduler = p1,
			system = p2
		}

		for v1, v2 in p1._hooks[p1.Hooks.SystemAdd] do
			local ok, result = pcall(v2, t)

			if not ok then
				warn("Unexpected error in hook:", result)
			end
		end
	end,
	systemRemove = function(p1, p2) --[[ systemRemove | Line: 18 ]]
		local t = {
			scheduler = p1,
			system = p2
		}

		for v1, v2 in p1._hooks[p1.Hooks.SystemRemove] do
			local ok, result = pcall(v2, t)

			if not ok then
				warn("Unexpected error in hook:", result)
			end
		end
	end,
	systemReplace = function(p1, p2, p3) --[[ systemReplace | Line: 33 ]]
		local t = {
			scheduler = p1,
			new = p3,
			old = p2
		}

		for v1, v2 in p1._hooks[p1.Hooks.SystemReplace] do
			local ok, result = pcall(v2, t)

			if not ok then
				warn("Unexpected error in hook:", result)
			end
		end
	end,
	systemCall = function(p1, p2, p3, p4) --[[ systemCall | Line: 49 ]]
		local v1 = p1._hooks[p1.Hooks[p2]]

		if v1 then
			for v2, v3 in v1 do
				local v4 = v3({
					scheduler = nil,
					system = p3,
					nextFn = p4
				})

				if v4 then
					p4 = v4

					continue
				end

				local v5, v6 = debug.info(v3, "sl")

				warn((("%*:%*: Expected \'SystemCall\' hook to return a function"):format(v5, v6)))
				p4 = v4
			end
		end

		p4()
	end,
	systemError = function(p1, p2, p3) --[[ systemError | Line: 72 ]]
		local v1 = p1._hooks[p1.Hooks.SystemError]

		if not v1 then
			return
		end

		for v2, v3 in v1 do
			v3({
				scheduler = p1,
				system = p2,
				error = p3
			})
		end
	end,
	phaseAdd = function(p1, p2) --[[ phaseAdd | Line: 91 ]]
		local t = {
			scheduler = p1,
			phase = p2
		}

		for v1, v2 in p1._hooks[p1.Hooks.PhaseAdd] do
			local ok, result = pcall(v2, t)

			if not ok then
				warn("Unexpected error in hook:", result)
			end
		end
	end,
	phaseBegan = function(p1, p2) --[[ phaseBegan | Line: 106 ]]
		local t = {
			scheduler = p1,
			phase = p2
		}

		for v1, v2 in p1._hooks[p1.Hooks.PhaseBegan] do
			local ok, result = pcall(v2, t)

			if not ok then
				warn("Unexpected error in hook:", result)
			end
		end
	end
}