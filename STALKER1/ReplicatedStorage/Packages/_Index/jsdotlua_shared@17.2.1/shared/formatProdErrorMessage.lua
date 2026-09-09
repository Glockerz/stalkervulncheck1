-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local HttpService = game:GetService("HttpService")

return function(p1, ...) --[[ formatProdErrorMessage | Line: 17 | Upvalues: HttpService (copy) ]]
	local v1 = "https://reactjs.org/docs/error-decoder.html?invariant=" .. tostring(p1)

	for i = 1, select("#", ...) do
		v1 = v1 .. "&args[]=" .. HttpService:UrlEncode(select(i, ...))
	end

	return string.format("Minified React error #%d; visit %s for the full message or use the non-minified dev environment for full errors and additional helpful warnings.", p1, v1)
end