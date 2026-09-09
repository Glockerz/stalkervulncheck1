-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local create = vide.create
local source = vide.source
local effect = vide.effect
local cleanup = vide.cleanup
local action = vide.action
local read = vide.read
local v1 = 100000

return function(p1) --[[ portal | Line: 28 | Upvalues: source (copy), effect (copy), cleanup (copy), vide (copy), create (copy), v1 (ref), read (copy), action (copy) ]]
	local inherit_layout = p1.inherit_layout
	local v12 = source(nil)
	local v2 = source(nil)
	local v3 = source(UDim2.fromScale(1, 1))
	local v4 = source(UDim2.fromScale(0, 0))
	local v5 = source(nil)

	effect(function() --[[ Line: 40 | Upvalues: v12 (copy), v3 (copy), v4 (copy), cleanup (ref) ]]
		local v1 = v12()

		if v1 then
			local function update() --[[ update | Line: 44 | Upvalues: v3 (ref), v1 (copy), v4 (ref) ]]
				v3(UDim2.fromOffset(v1.AbsoluteSize.X, v1.AbsoluteSize.Y))
				v4(UDim2.fromOffset(v1.AbsolutePosition.X, v1.AbsolutePosition.Y))
			end

			cleanup(v1:GetPropertyChangedSignal("AbsoluteSize"):Connect(update))
			cleanup(v1:GetPropertyChangedSignal("AbsolutePosition"):Connect(update))
		end
	end)
	cleanup(vide.mount(function() --[[ Line: 54 | Upvalues: cleanup (ref), create (ref), v1 (ref), v2 (copy), read (ref), inherit_layout (copy), v3 (copy), v4 (copy), p1 (copy) ]]
		local v22 = create("Frame")
		local t = {
			Name = ("Portal:%*"):format(v1),
			Parent = v2,
			AutoLocalize = false,
			ZIndex = v1,
			Size = function() --[[ Size | Line: 62 | Upvalues: read (ref), inherit_layout (ref), v3 (ref) ]]
				if read(inherit_layout) == true then
					return v3()
				end

				return UDim2.fromScale(1, 1)
			end,
			Position = function() --[[ Position | Line: 66 | Upvalues: read (ref), inherit_layout (ref), v4 (ref) ]]
				if read(inherit_layout) == true then
					return v4()
				end

				return UDim2.fromScale(0, 0)
			end,
			BackgroundTransparency = 1
		}

		t[1] = unpack(p1)
		cleanup(v22(t))
	end))

	return create("Configuration")({
		Name = ("PortalAnchor:%*"):format(v1),
		AncestryChanged = function() --[[ AncestryChanged | Line: 82 | Upvalues: v5 (copy), v12 (copy), v2 (copy) ]]
			local v1 = v5()

			if v1 then
				v12(v1:FindFirstAncestorWhichIsA("GuiBase2d"))
				v2(v1:FindFirstAncestorWhichIsA("LayerCollector"))
			else
				v12(nil)
			end
		end,
		action(function(p1) --[[ Line: 92 | Upvalues: v1 (ref), v5 (copy), v12 (copy), v2 (copy) ]]
			v1 = v1 + 1
			v5(p1)
			v12(p1:FindFirstAncestorWhichIsA("GuiBase2d"))
			v2(p1:FindFirstAncestorWhichIsA("LayerCollector"))
		end)
	})
end