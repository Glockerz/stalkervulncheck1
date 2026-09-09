-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local theme = require(script.Parent.Parent.Parent.util.theme)

require(script.Parent.Parent.display.typography)

local padding = require(script.Parent.Parent.util.padding)
local create = vide.create
local source = vide.source
local changed = vide.changed
local effect = vide.effect
local action = vide.action
local read = vide.read

return function(p1) --[[ Line: 41 | Upvalues: source (copy), effect (copy), read (copy), theme (copy), create (copy), anim (copy), action (copy), changed (copy), padding (copy) ]]
	local v1 = source(Enum.GuiState.Idle)
	local v2 = source(false)
	local v3 = source()
	local v4 = source("")

	effect(function() --[[ Line: 48 | Upvalues: v4 (copy), read (ref), p1 (copy) ]]
		v4(read(p1.text) or "")
	end)

	local function bg() --[[ bg | Line: 52 | Upvalues: v1 (copy), theme (ref), v2 (copy) ]]
		if v1() == Enum.GuiState.NonInteractable then
			return theme.bg[0]()
		end

		if v2() then
			return theme.bg[-3]()
		end

		return theme.bg[-2]()
	end

	local function fg() --[[ fg | Line: 60 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
		if read(p1.disabled) then
			return theme.fg_on_bg_low[0]()
		end

		return theme.fg_on_bg_high[0]()
	end

	local function stroke() --[[ stroke | Line: 67 | Upvalues: v1 (copy), theme (ref), v2 (copy) ]]
		local v12 = v1()

		if v12 == Enum.GuiState.NonInteractable then
			return theme.bg[-3]()
		end

		if v2() then
			return theme.acc[5]()
		end

		if v12 == Enum.GuiState.Idle then
			return theme.bg[-3]()
		end

		if v12 == Enum.GuiState.Hover then
			return theme.bg[3]()
		end

		return theme.bg[-3]()
	end

	effect(function() --[[ Line: 78 | Upvalues: v2 (copy), v3 (copy) ]]
		if v2() ~= true or not v3() then
			return
		end

		v3():CaptureFocus()
	end)

	local v5 = create("TextButton")
	local t = {
		Name = p1.placeholder or "Textbox",
		AutoLocalize = false
	}

	t.Size = p1.size or UDim2.fromOffset(300, 30)
	t.Position = p1.position
	t.AnchorPoint = p1.anchorpoint
	function t.Activated() --[[ Activated | Line: 93 | Upvalues: v2 (copy) ]]
		v2(true)
	end
	function t.Interactable() --[[ Interactable | Line: 97 | Upvalues: p1 (copy) ]]
		return not p1.disabled
	end
	t.BackgroundColor3 = anim(bg)
	t.ClipsDescendants = true

	local v7 = create("TextBox")
	local t2 = {
		Size = UDim2.fromScale(1, 1),
		AutoLocalize = false,
		MultiLine = p1.multiline,
		BackgroundTransparency = 1,
		Focused = function() --[[ Focused | Line: 114 | Upvalues: v2 (copy) ]]
			v2(true)
		end,
		FocusLost = function(p12) --[[ FocusLost | Line: 118 | Upvalues: v2 (copy), p1 (copy), v4 (copy) ]]
			v2(false)

			if p1.focuslost then
				p1.focuslost(v4(), p12)
			end

			if not p1.enter then
				return
			end

			p1.enter(v4())
		end,
		TextSize = theme.body,
		FontFace = function() --[[ FontFace | Line: 130 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
			if read(p1.code) then
				return theme.code
			end

			return theme.font
		end,
		TextColor3 = anim(fg),
		PlaceholderColor3 = theme.fg_on_bg_low[0],
		PlaceholderText = p1.placeholder,
		Text = p1.text,
		ClipsDescendants = true,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextYAlignment = function() --[[ TextYAlignment | Line: 142 | Upvalues: read (ref), p1 (copy) ]]
			if read(p1.multiline) then
				return Enum.TextYAlignment.Top
			end

			return Enum.TextYAlignment.Center
		end
	}
	local v8 = action(v3)
	local v9 = changed("Text", v4)
	local v10 = if p1.oninput then changed("Text", p1.oninput) else nil

	t2[1] = v8
	t2[2] = v9
	t2[3] = v10
	t[1] = v7(t2)
	t[2] = create("UIStroke")({
		Thickness = 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = anim(stroke),
		Enabled = p1.stroke
	})
	t[3] = create("UICorner")({
		CornerRadius = function() --[[ CornerRadius | Line: 161 | Upvalues: read (ref), p1 (copy) ]]
			if read(p1.corner) == false then
				return UDim.new()
			end

			return UDim.new(0, 4)
		end
	})
	t[4] = padding({
		x = UDim.new(0, 8),
		y = UDim.new(0, 2)
	})
	t[5] = changed("GuiState", v1)

	return v5(t)
end