-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
return {
	new = function(p1, p2, p3, p4, p5) --[[ new | Line: 11 ]]
		return {
			Target = Vector3.new(),
			Position = Vector3.new(),
			Velocity = Vector3.new(),
			Mass = p2 or 5,
			Force = p3 or 50,
			Damping = p4 or 4,
			Speed = p5 or 4,
			getstats = function(p1) --[[ getstats | Line: 24 ]]
				return p1.Mass, p1.Force, p1.Damping, p1.Speed
			end,
			changestats = function(p1, p2, p3, p4, p5) --[[ changestats | Line: 28 ]]
				p1.Mass = if p2 then p2 else p1.Mass
				p1.Force = if p3 then p3 else p1.Force
				p1.Damping = if p4 then p4 else p1.Damping
				p1.Speed = if p5 then p5 else p1.Speed
			end,
			shove = function(p1, p2) --[[ shove | Line: 35 ]]
				local X = p2.X
				local Y = p2.Y
				local Z = p2.Z

				if X ~= X or (X == (1 / 0) or X == (-1 / 0)) then
					X = 0
				end

				if Y ~= Y or (Y == (1 / 0) or Y == (-1 / 0)) then
					Y = 0
				end

				if Z ~= Z or (Z == (1 / 0) or Z == (-1 / 0)) then
					Z = 0
				end

				p1.Velocity = p1.Velocity + Vector3.new(X, Y, Z)
			end,
			update = function(p1, p2) --[[ update | Line: 49 ]]
				local v1 = p2 * p1.Speed / 8

				for i = 1, 8 do
					p1.Velocity = p1.Velocity + ((p1.Target - p1.Position) * p1.Force / p1.Mass - p1.Velocity * p1.Damping) * v1
					p1.Position = p1.Position + p1.Velocity * v1
				end

				return p1.Position
			end
		}
	end
}