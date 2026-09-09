-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble)

require(script.Parent.Parent.Parent.Parent.Parent.vide)
require(script.Parent.Parent.Parent.Parent.modules.types)

local watch_tracker = require(script.Parent.watch_tracker)

return function(p1) --[[ Line: 22 | Upvalues: pebble (copy), watch_tracker (copy) ]]
	return pebble.widget({
		title = ("system - %*"):format(p1.name),
		subtitle = ("host: %* vm: %* scheduler: %* system: %*"):format(p1.host, p1.vm, p1.scheduler, p1.system),
		bind_to_close = p1.destroy,
		size = Vector2.new(350, 400),
		min_size = Vector2.new(300, 300),
		watch_tracker(p1)
	})
end