-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.Parent.vide)
local anim = require(script.Parent.Parent.Parent.util.anim)
local theme = require(script.Parent.Parent.Parent.util.theme)
local create = vide.create
local read = vide.read

return function(p1) --[[ Line: 36 | Upvalues: read (copy), theme (copy), create (copy), anim (copy) ]]
	local function font() --[[ font | Line: 38 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
		if read(p1.code) then
			return theme.code
		end

		return theme.font
	end

	local function fg() --[[ fg | Line: 42 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
		local v1 = read(p1.accent)
		local v2 = read(p1.disabled)

		if v1 then
			if v2 then
				return theme.fg_on_acc_low[0]()
			end

			return theme.fg_on_acc_high[0]()
		end

		if v2 then
			return theme.fg_on_bg_low[0]()
		end

		return theme.fg_on_bg_high[0]()
	end

	local v1 = create("TextLabel")
	local t = {
		Size = p1.size,
		Position = p1.position,
		AnchorPoint = p1.anchorpoint
	}

	t.AutomaticSize = p1.automaticsize or Enum.AutomaticSize.XY
	t.AutoLocalize = false
	t.TextXAlignment = p1.xalignment
	t.TextYAlignment = p1.yalignment
	t.TextTruncate = p1.truncate
	t.BackgroundTransparency = 1
	t.Text = p1.text
	t.TextSize = p1.textsize or (function() --[[ Line: 70 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
		if read(p1.header) then
			return theme.header
		end

		return theme.body
	end)
	t.TextWrapped = p1.wrapped
	function t.FontFace() --[[ FontFace | Line: 74 | Upvalues: read (ref), p1 (copy), theme (ref) ]]
		if read(p1.header) then
			local v1 = Font.new

			return v1((if read(p1.code) then theme.code else theme.font).Family, Enum.FontWeight.Bold)
		end

		if read(p1.code) then
			return theme.code
		end

		return theme.font
	end
	t.TextColor3 = anim(fg)
	t.Visible = p1.visible
	t[1] = unpack(p1)

	return v1(t)
end