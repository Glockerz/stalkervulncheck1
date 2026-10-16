-- Decompiled with Potassium's decompiler.

local pebble = require(script.Parent.Parent.Parent.Parent.Parent.pebble);
require(script.Parent.Parent.Parent.Parent.Parent.vide);
require(script.Parent.Parent.Parent.Parent.modules.types);
local watch_tracker = require(script.Parent.watch_tracker);

return function(p1: table) -- Line: 22
    -- upvalues: pebble (copy), watch_tracker (copy)
    return pebble.widget({
        title = `system - {p1.name}`,
        subtitle = `host: {p1.host} vm: {p1.vm} scheduler: {p1.scheduler} system: {p1.system}`,
        bind_to_close = p1.destroy,
        size = Vector2.new(350, 400),
        min_size = Vector2.new(300, 300),
        watch_tracker(p1)
    });
end;