-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local theme = require(script.Parent.Parent.Parent.util.theme)
local typography = require(script.Parent.Parent.display.typography)
local padding = require(script.Parent.Parent.util.padding)
local create = vide.create
local source = vide.source
local changed = vide.changed
local show = vide.show
local read = vide.read

return function(p1) --[[ Line: 43 | Upvalues: source (copy), read (copy), theme (copy), create (copy), anim (copy), typography (copy), show (copy), padding (copy), changed (copy) ]]
	local v1 = source(Enum.GuiState.Idle)

	local function bg() --[[ bg | Line: 47 | Upvalues: read (ref), p1 (copy), v1 (copy), theme (ref) ]]
		local v12 = read(p1.accent)
		local v2 = v1()

		if v12 then
			if v2 == Enum.GuiState.NonInteractable then
				return theme.acc[-5]()
			end

			if v2 == Enum.GuiState.Idle then
				return theme.acc[0]()
			end

			if v2 == Enum.GuiState.Hover then
				return theme.acc[3]()
			end

			if v2 == Enum.GuiState.Press then
				return theme.acc[-8]()
			end

			return theme.acc[0]()
		end

		if v2 == Enum.GuiState.NonInteractable then
			return theme.bg[-2]()
		end

		if v2 == Enum.GuiState.Idle then
			return theme.bg[3]()
		end

		if v2 == Enum.GuiState.Hover then
			return theme.bg[6]()
		end

		if v2 == Enum.GuiState.Press then
			return theme.bg[0]()
		end

		return theme.acc[0]()
	end

	local function stroke() --[[ stroke | Line: 65 | Upvalues: read (ref), p1 (copy), v1 (copy), theme (ref) ]]
		local v12 = read(p1.accent)
		local v2 = v1()

		if v12 then
			local _ = v2 == Enum.GuiState.NonInteractable

			return theme.acc[-7]()
		end

		local _ = v2 == Enum.GuiState.NonInteractable

		return theme.bg[-3]()
	end

	local v2 = create("TextButton")
	local t = {
		Name = p1.text,
		AutoLocalize = false
	}

	t.Size = p1.size or UDim2.fromOffset(100, 30)
	t.Position = p1.position
	t.AnchorPoint = p1.anchorpoint
	t.AutomaticSize = p1.automaticsize
	function t.Interactable() --[[ Interactable | Line: 87 | Upvalues: read (ref), p1 (copy) ]]
		return not read(p1.disabled)
	end
	t.BackgroundColor3 = anim(bg)
	t.Activated = p1.activated
	t.MouseButton2Click = p1.mouse2
	t.MouseButton1Down = p1.down
	t.MouseButton1Up = p1.up
	t[1] = typography({
		position = UDim2.fromScale(0.5, 0.5),
		anchorpoint = Vector2.new(0.5, 0.5),
		size = UDim2.fromScale(1, 1),
		automaticsize = Enum.AutomaticSize.Y,
		text = p1.text,
		truncate = Enum.TextTruncate.SplitWord,
		xalignment = p1.xalignment,
		accent = p1.accent,
		disabled = p1.disabled,
		visible = function() --[[ visible | Line: 112 | Upvalues: read (ref), p1 (copy) ]]
			return read(p1.text) ~= ""
		end,
		code = p1.code,
		create("UIFlexItem")({
			FlexMode = Enum.UIFlexMode.Fill
		})
	})
	t[2] = show(function() --[[ Line: 125 | Upvalues: read (ref), p1 (copy) ]]
		return read(p1.stroke) ~= false
	end, source(create("UIStroke")({
		Thickness = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = anim(stroke),
		Enabled = p1.stroke
	})))
	t[3] = show(function() --[[ Line: 140 | Upvalues: read (ref), p1 (copy) ]]
		return read(p1.corner) ~= false
	end, source(create("UICorner")({
		CornerRadius = UDim.new(0, 4)
	})))
	t[4] = padding({
		x = UDim.new(0, 8),
		y = UDim.new(0, 2)
	})
	t[5] = changed("GuiState", v1)
	t[6] = unpack(p1)

	return v2(t)
end