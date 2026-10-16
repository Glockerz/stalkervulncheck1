-- Decompiled with Potassium's decompiler.

local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local vide = require(script.Parent.Parent.Parent.Parent.vide);
local loop = require(script.Parent.Parent.Parent.modules.loop);
local spawn_app = require(script.Parent.Parent.spawn_app);
local entity = require(script.Parent.entity);
local script_widget = require(script.widget);
local source = vide.source;
local effect = vide.effect;
local cleanup = vide.cleanup;

return {
    class_name = "app",
    name = "Query",

    mount = function(u1: table, p2: function) -- Line: 25, Name: mount
        -- upvalues: source (copy), loop (copy), cleanup (copy), RunService (copy), spawn_app (copy), entity (copy), effect (copy), ContextActionService (copy), script_widget (copy)
        local u3 = source(nil);
        local u4 = source(false);
        local u5 = source();
        local u6 = source();
        local v7 = source("");
        local v8 = source(false);
        local v9 = source("");
        local v10 = source("");
        local v11 = source();
        local v12 = source({});
        local v13 = source(1);
        local v14 = source(25);
        local v15 = source(0);
        local v16 = source(false);
        local v17 = source(false);
        local v18 = loop("app-client-registry", {
            host = u1.host,
            vm = u1.vm,
            id = u1.id,
            enable_pick = u4,
            entity_hovering_over = u5,
            hovering_over = u6,
            set_entity = u3,
            columns = v12,
            query = v10,
            primary_entity = v11,
            paused = v16,
            refresh = v17,
            total_entities = v15,
            from = v13,
            upto = v14,
            validate_query = v7,
            ok = v8,
            msg = v9
        }, {
            i = 1
        }, script.systems.validate_query, script.systems.obtain_query_data, script.systems.send_workspace_entity, script.systems.highlight_workspace_entity);
        cleanup(RunService.Heartbeat:Connect(v18));

        local function open_entity_widget(p19, p20) -- Line: 88
            -- upvalues: u3 (copy), u4 (copy), u5 (copy), u6 (copy), spawn_app (ref), entity (ref), u1 (copy)
            local v21 = u3();

            if p20 ~= Enum.UserInputState.Begin then
                return;
            end;

            if v21 == nil then
                return;
            end;

            u4(false);
            u5(nil);
            u6(nil);
            spawn_app.spawn_app(entity, {
                host = u1.host,
                vm = u1.vm,
                id = u1.id,
                entity = v21
            });
        end;

        effect(function() -- Line: 106
            -- upvalues: u4 (copy), u1 (copy), ContextActionService (ref), open_entity_widget (copy), cleanup (ref)
            local v22 = u4();
            local u23 = `select entity:{u1.host} {u1.vm} {u1.id}`;

            if v22 then
                ContextActionService:BindAction(u23, open_entity_widget, false, Enum.UserInputType.MouseButton1);
            end;

            cleanup(function() -- Line: 114
                -- upvalues: ContextActionService (ref), u23 (copy)
                ContextActionService:UnbindAction(u23);
            end);
        end);

        return script_widget({
            host = u1.host,
            vm = u1.vm,
            id = u1.id,
            validate_query = v7,
            update_system_query = v10,
            current_query = v10,
            total_rows_per_page = source(25),
            set_rows_per_page = source(25),
            primary_entity = v11,
            from = v13,
            upto = v14,
            total_entities = v15,
            paused = v16,
            refresh = v17,
            enable_pick = u4,
            entity_hovering_over = u5,
            hovering_over = u6,
            ok = v8,
            msg = v9,
            columns = v12,
            destroy = p2
        });
    end
};