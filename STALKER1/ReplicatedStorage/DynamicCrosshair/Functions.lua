-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	CreateHairs = function(p1, p2, p3, p4) --[[ CreateHairs | Line: 3 ]]
		local t = {}

		for i = 1, 7 do
			local ImageCrosshair = Instance.new("ImageLabel")

			ImageCrosshair.BorderSizePixel = 0
			ImageCrosshair.Image = ""
			ImageCrosshair.Name = "_hair"
			ImageCrosshair.Parent = p2
			ImageCrosshair.AnchorPoint = Vector2.new(0.5, 0.5)

			if i < 3 then
				ImageCrosshair.Size = UDim2.fromOffset(p4, p3)
			elseif i > 2 and i < 5 then
				ImageCrosshair.Size = UDim2.fromOffset(p3, p4)
			elseif i == 5 then
				ImageCrosshair.BackgroundTransparency = 1
				ImageCrosshair.Size = UDim2.fromOffset(50, 50)
				ImageCrosshair.Image = "rbxassetid://285779644"
				ImageCrosshair.Name = "HitMarker"
				ImageCrosshair.ImageTransparency = 1
			else
				if i == 6 then
					ImageCrosshair.BackgroundTransparency = 1
					ImageCrosshair.Size = UDim2.fromOffset(10, 10)
					ImageCrosshair.Image = "rbxassetid://11003529439"
					ImageCrosshair.Name = "CenterDot"
					ImageCrosshair.ImageTransparency = 0
				else
					ImageCrosshair.BackgroundTransparency = 1
					ImageCrosshair.Name = "ImageCrosshair"
				end

				ImageCrosshair.Visible = false
			end

			ImageCrosshair.BorderSizePixel = 0
			table.insert(t, i, ImageCrosshair)
		end

		return unpack(t)
	end,
	RandomPointsInsideCrosshair = function(p1, p2) --[[ RandomPointsInsideCrosshair | Line: 48 ]]
		local v2 = p2 * math.sqrt((math.random())) / 2.5
		local v3 = math.random() * 2 * math.pi

		return v2 * math.cos(v3), v2 * math.sin(v3)
	end,
	UpdateEnabled = function(p1, p2, p3) --[[ UpdateEnabled | Line: 57 ]]
		for k, v in pairs(p2) do
			v.Visible = p3
		end
	end
}