-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local vide = require(script.Parent.Parent.Parent.vide)

require(script.Parent.Parent.libraries.apcaw3)
require(script.Parent.contrast)

local oklch = require(script.Parent.oklch)
local source = vide.source

local function oklch2(p1) --[[ oklch | Line: 13 | Upvalues: oklch (copy) ]]
	return table.freeze({
		l = p1[1],
		c = p1[2],
		h = p1[3],
		color = oklch(unpack(p1))
	})
end

local v1 = source(oklch2({ 0.2012, 0.01, 0.6 }))
local v2 = source(oklch2({ 0.52, 0.21, 0.71 }))
local v3 = Font.fromName("BuilderSans", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
local v4 = Font.new("rbxassetid://16658246179", Enum.FontWeight.Regular, Enum.FontStyle.Normal)

local function should_flip(p1) --[[ should_flip | Line: 39 ]]
	return p1 > 0.65
end

local function compute_bg(p1) --[[ compute_bg | Line: 57 | Upvalues: v1 (copy), oklch2 (copy), oklch (copy) ]]
	local function get() --[[ get | Line: 58 | Upvalues: v1 (ref), oklch2 (ref), p1 (copy) ]]
		local v12 = v1()
		local t2 = {}

		t2[1] = math.clamp(v12.l + p1 * 0.02, 0, 1)
		t2[2] = v12.c
		t2[3] = v12.h

		return oklch2(t2)
	end

	return function(p1) --[[ Line: 82 | Upvalues: v1 (ref), p1 (copy), oklch (ref) ]]
		if p1 then
			local v12 = v1()
			local t2 = {}

			t2[1] = math.clamp(v12.l + p1 * 0.02, 0, 1)
			t2[2] = v12.c
			t2[3] = v12.h

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			})
		end

		local v3 = v1()
		local t2 = {}

		t2[1] = math.clamp(v3.l + p1 * 0.02, 0, 1)
		t2[2] = v3.c
		t2[3] = v3.h

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end
end

local function compute_acc(p1) --[[ compute_acc | Line: 88 | Upvalues: v2 (copy), oklch2 (copy), oklch (copy) ]]
	local function get() --[[ get | Line: 89 | Upvalues: v2 (ref), oklch2 (ref), p1 (copy) ]]
		local v1 = v2()
		local t2 = {}

		t2[1] = math.clamp(v1.l + p1 * 0.02, 0, 1)
		t2[2] = v1.c
		t2[3] = v1.h

		return oklch2(t2)
	end

	return function(p1) --[[ Line: 112 | Upvalues: v2 (ref), p1 (copy), oklch (ref) ]]
		if p1 then
			local v1 = v2()
			local t2 = {}

			t2[1] = math.clamp(v1.l + p1 * 0.02, 0, 1)
			t2[2] = v1.c
			t2[3] = v1.h

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			})
		end

		local v3 = v2()
		local t2 = {}

		t2[1] = math.clamp(v3.l + p1 * 0.02, 0, 1)
		t2[2] = v3.c
		t2[3] = v3.h

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end
end

local function compute_fg_on_bg_high(p1) --[[ compute_fg_on_bg_high | Line: 118 | Upvalues: v1 (copy), oklch2 (copy), oklch (copy) ]]
	local function get() --[[ get | Line: 58 | Upvalues: v1 (ref), oklch2 (ref), p1 (copy) ]]
		local v12 = v1()
		local t2 = {}

		t2[1] = math.clamp(v12.l + p1 * 0.02, 0, 1)
		t2[2] = v12.c
		t2[3] = v12.h

		return oklch2(t2)
	end

	local function f1(p1) --[[ Line: 82 | Upvalues: v1 (ref), p1 (copy), oklch (ref) ]]
		if p1 then
			local v12 = v1()
			local t2 = {}

			t2[1] = math.clamp(v12.l + p1 * 0.02, 0, 1)
			t2[2] = v12.c
			t2[3] = v12.h

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			})
		end

		local v3 = v1()
		local t2 = {}

		t2[1] = math.clamp(v3.l + p1 * 0.02, 0, 1)
		t2[2] = v3.c
		t2[3] = v3.h

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end

	return function() --[[ Line: 120 | Upvalues: f1 (copy), oklch (ref) ]]
		local v1 = f1(true)

		if v1.l > 0.65 then
			local t2 = { v1.l - 0.7, v1.c, v1.h }

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			}).color
		end

		local t2 = { v1.l + 0.7, v1.c, v1.h }

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end
end

local function compute_fg_on_bg_low(p1) --[[ compute_fg_on_bg_low | Line: 137 | Upvalues: v1 (copy), oklch2 (copy), oklch (copy) ]]
	local function get() --[[ get | Line: 58 | Upvalues: v1 (ref), oklch2 (ref), p1 (copy) ]]
		local v12 = v1()
		local t2 = {}

		t2[1] = math.clamp(v12.l + p1 * 0.02, 0, 1)
		t2[2] = v12.c
		t2[3] = v12.h

		return oklch2(t2)
	end

	local function f1(p1) --[[ Line: 82 | Upvalues: v1 (ref), p1 (copy), oklch (ref) ]]
		if p1 then
			local v12 = v1()
			local t2 = {}

			t2[1] = math.clamp(v12.l + p1 * 0.02, 0, 1)
			t2[2] = v12.c
			t2[3] = v12.h

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			})
		end

		local v3 = v1()
		local t2 = {}

		t2[1] = math.clamp(v3.l + p1 * 0.02, 0, 1)
		t2[2] = v3.c
		t2[3] = v3.h

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end

	return function() --[[ Line: 139 | Upvalues: f1 (copy), oklch (ref) ]]
		local v1 = f1(true)

		if v1.l > 0.65 then
			local t2 = { v1.l - 0.4, v1.c, v1.h }

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			}).color
		end

		local t2 = { v1.l + 0.4, v1.c, v1.h }

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end
end

local function compute_fg_on_acc_low(p1) --[[ compute_fg_on_acc_low | Line: 156 | Upvalues: v2 (copy), oklch2 (copy), oklch (copy) ]]
	local function get() --[[ get | Line: 89 | Upvalues: v2 (ref), oklch2 (ref), p1 (copy) ]]
		local v1 = v2()
		local t2 = {}

		t2[1] = math.clamp(v1.l + p1 * 0.02, 0, 1)
		t2[2] = v1.c
		t2[3] = v1.h

		return oklch2(t2)
	end

	local function f1(p1) --[[ Line: 112 | Upvalues: v2 (ref), p1 (copy), oklch (ref) ]]
		if p1 then
			local v1 = v2()
			local t2 = {}

			t2[1] = math.clamp(v1.l + p1 * 0.02, 0, 1)
			t2[2] = v1.c
			t2[3] = v1.h

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			})
		end

		local v3 = v2()
		local t2 = {}

		t2[1] = math.clamp(v3.l + p1 * 0.02, 0, 1)
		t2[2] = v3.c
		t2[3] = v3.h

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end

	return function() --[[ Line: 158 | Upvalues: f1 (copy), oklch (ref) ]]
		local v1 = f1(true)

		if v1.l > 0.65 then
			local t2 = { v1.l - 0.4, v1.c, v1.h }

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			}).color
		end

		local t2 = { v1.l + 0.4, v1.c, v1.h }

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end
end

local function compute_fg_on_acc_high(p1) --[[ compute_fg_on_acc_high | Line: 175 | Upvalues: v2 (copy), oklch2 (copy), oklch (copy) ]]
	local function get() --[[ get | Line: 89 | Upvalues: v2 (ref), oklch2 (ref), p1 (copy) ]]
		local v1 = v2()
		local t2 = {}

		t2[1] = math.clamp(v1.l + p1 * 0.02, 0, 1)
		t2[2] = v1.c
		t2[3] = v1.h

		return oklch2(t2)
	end

	local function f1(p1) --[[ Line: 112 | Upvalues: v2 (ref), p1 (copy), oklch (ref) ]]
		if p1 then
			local v1 = v2()
			local t2 = {}

			t2[1] = math.clamp(v1.l + p1 * 0.02, 0, 1)
			t2[2] = v1.c
			t2[3] = v1.h

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			})
		end

		local v3 = v2()
		local t2 = {}

		t2[1] = math.clamp(v3.l + p1 * 0.02, 0, 1)
		t2[2] = v3.c
		t2[3] = v3.h

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end

	return function() --[[ Line: 177 | Upvalues: f1 (copy), oklch (ref) ]]
		local v1 = f1(true)

		if v1.l > 0.65 then
			local t2 = { v1.l - 0.7, v1.c, v1.h }

			return table.freeze({
				l = t2[1],
				c = t2[2],
				h = t2[3],
				color = oklch(unpack(t2))
			}).color
		end

		local t2 = { v1.l + 0.7, v1.c, v1.h }

		return table.freeze({
			l = t2[1],
			c = t2[2],
			h = t2[3],
			color = oklch(unpack(t2))
		}).color
	end
end

return setmetatable({
	settings = {
		background = v1,
		accent = v2
	}
}, {
	__index = (function() --[[ compute_theme | Line: 211 | Upvalues: v3 (copy), v4 (copy), v1 (copy), oklch2 (copy), oklch (copy), v2 (copy) ]]
		local t = {
			body = 18,
			header = 24,
			bg = {},
			acc = {},
			fg_on_bg_high = {},
			fg_on_bg_low = {},
			fg_on_acc_high = {},
			fg_on_acc_low = {},
			font = v3,
			code = v4
		}

		for i = -20, 20 do
			local function get() --[[ get | Line: 58 | Upvalues: v1 (ref), oklch2 (ref), i (copy) ]]
				local v12 = v1()
				local t2 = {}

				t2[1] = math.clamp(v12.l + i * 0.02, 0, 1)
				t2[2] = v12.c
				t2[3] = v12.h

				return oklch2(t2)
			end

			t.bg[i] = function(p1) --[[ Line: 82 | Upvalues: v1 (ref), i (copy), oklch (ref) ]]
				if p1 then
					local v12 = v1()
					local t2 = {}

					t2[1] = math.clamp(v12.l + i * 0.02, 0, 1)
					t2[2] = v12.c
					t2[3] = v12.h

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					})
				end

				local v3 = v1()
				local t2 = {}

				t2[1] = math.clamp(v3.l + i * 0.02, 0, 1)
				t2[2] = v3.c
				t2[3] = v3.h

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			local function get2() --[[ get | Line: 89 | Upvalues: v2 (ref), oklch2 (ref), i (copy) ]]
				local v1 = v2()
				local t2 = {}

				t2[1] = math.clamp(v1.l + i * 0.02, 0, 1)
				t2[2] = v1.c
				t2[3] = v1.h

				return oklch2(t2)
			end

			t.acc[i] = function(p1) --[[ Line: 112 | Upvalues: v2 (ref), i (copy), oklch (ref) ]]
				if p1 then
					local v1 = v2()
					local t2 = {}

					t2[1] = math.clamp(v1.l + i * 0.02, 0, 1)
					t2[2] = v1.c
					t2[3] = v1.h

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					})
				end

				local v3 = v2()
				local t2 = {}

				t2[1] = math.clamp(v3.l + i * 0.02, 0, 1)
				t2[2] = v3.c
				t2[3] = v3.h

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			local function get3() --[[ get | Line: 89 | Upvalues: v2 (ref), oklch2 (ref), i (copy) ]]
				local v1 = v2()
				local t2 = {}

				t2[1] = math.clamp(v1.l + i * 0.02, 0, 1)
				t2[2] = v1.c
				t2[3] = v1.h

				return oklch2(t2)
			end

			local function f1(p1) --[[ Line: 112 | Upvalues: v2 (ref), i (copy), oklch (ref) ]]
				if p1 then
					local v1 = v2()
					local t2 = {}

					t2[1] = math.clamp(v1.l + i * 0.02, 0, 1)
					t2[2] = v1.c
					t2[3] = v1.h

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					})
				end

				local v3 = v2()
				local t2 = {}

				t2[1] = math.clamp(v3.l + i * 0.02, 0, 1)
				t2[2] = v3.c
				t2[3] = v3.h

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			t.fg_on_acc_high[i] = function() --[[ Line: 177 | Upvalues: f1 (copy), oklch (ref) ]]
				local v1 = f1(true)

				if v1.l > 0.65 then
					local t2 = { v1.l - 0.7, v1.c, v1.h }

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					}).color
				end

				local t2 = { v1.l + 0.7, v1.c, v1.h }

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			local function get4() --[[ get | Line: 89 | Upvalues: v2 (ref), oklch2 (ref), i (copy) ]]
				local v1 = v2()
				local t2 = {}

				t2[1] = math.clamp(v1.l + i * 0.02, 0, 1)
				t2[2] = v1.c
				t2[3] = v1.h

				return oklch2(t2)
			end

			local function f2(p1) --[[ Line: 112 | Upvalues: v2 (ref), i (copy), oklch (ref) ]]
				if p1 then
					local v1 = v2()
					local t2 = {}

					t2[1] = math.clamp(v1.l + i * 0.02, 0, 1)
					t2[2] = v1.c
					t2[3] = v1.h

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					})
				end

				local v3 = v2()
				local t2 = {}

				t2[1] = math.clamp(v3.l + i * 0.02, 0, 1)
				t2[2] = v3.c
				t2[3] = v3.h

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			t.fg_on_acc_low[i] = function() --[[ Line: 158 | Upvalues: f2 (copy), oklch (ref) ]]
				local v1 = f2(true)

				if v1.l > 0.65 then
					local t2 = { v1.l - 0.4, v1.c, v1.h }

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					}).color
				end

				local t2 = { v1.l + 0.4, v1.c, v1.h }

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			local function get5() --[[ get | Line: 58 | Upvalues: v1 (ref), oklch2 (ref), i (copy) ]]
				local v12 = v1()
				local t2 = {}

				t2[1] = math.clamp(v12.l + i * 0.02, 0, 1)
				t2[2] = v12.c
				t2[3] = v12.h

				return oklch2(t2)
			end

			local function f3(p1) --[[ Line: 82 | Upvalues: v1 (ref), i (copy), oklch (ref) ]]
				if p1 then
					local v12 = v1()
					local t2 = {}

					t2[1] = math.clamp(v12.l + i * 0.02, 0, 1)
					t2[2] = v12.c
					t2[3] = v12.h

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					})
				end

				local v3 = v1()
				local t2 = {}

				t2[1] = math.clamp(v3.l + i * 0.02, 0, 1)
				t2[2] = v3.c
				t2[3] = v3.h

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			t.fg_on_bg_high[i] = function() --[[ Line: 120 | Upvalues: f3 (copy), oklch (ref) ]]
				local v1 = f3(true)

				if v1.l > 0.65 then
					local t2 = { v1.l - 0.7, v1.c, v1.h }

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					}).color
				end

				local t2 = { v1.l + 0.7, v1.c, v1.h }

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			local function get6() --[[ get | Line: 58 | Upvalues: v1 (ref), oklch2 (ref), i (copy) ]]
				local v12 = v1()
				local t2 = {}

				t2[1] = math.clamp(v12.l + i * 0.02, 0, 1)
				t2[2] = v12.c
				t2[3] = v12.h

				return oklch2(t2)
			end

			local function f4(p1) --[[ Line: 82 | Upvalues: v1 (ref), i (copy), oklch (ref) ]]
				if p1 then
					local v12 = v1()
					local t2 = {}

					t2[1] = math.clamp(v12.l + i * 0.02, 0, 1)
					t2[2] = v12.c
					t2[3] = v12.h

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					})
				end

				local v3 = v1()
				local t2 = {}

				t2[1] = math.clamp(v3.l + i * 0.02, 0, 1)
				t2[2] = v3.c
				t2[3] = v3.h

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end

			t.fg_on_bg_low[i] = function() --[[ Line: 139 | Upvalues: f4 (copy), oklch (ref) ]]
				local v1 = f4(true)

				if v1.l > 0.65 then
					local t2 = { v1.l - 0.4, v1.c, v1.h }

					return table.freeze({
						l = t2[1],
						c = t2[2],
						h = t2[3],
						color = oklch(unpack(t2))
					}).color
				end

				local t2 = { v1.l + 0.4, v1.c, v1.h }

				return table.freeze({
					l = t2[1],
					c = t2[2],
					h = t2[3],
					color = oklch(unpack(t2))
				}).color
			end
		end

		return t
	end)()
})