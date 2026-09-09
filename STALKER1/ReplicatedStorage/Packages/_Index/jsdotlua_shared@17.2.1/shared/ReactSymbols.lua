-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local t = {
	REACT_ELEMENT_TYPE = 60103,
	REACT_PORTAL_TYPE = 60106,
	REACT_FRAGMENT_TYPE = 60107,
	REACT_STRICT_MODE_TYPE = 60108,
	REACT_PROFILER_TYPE = 60114,
	REACT_PROVIDER_TYPE = 60109,
	REACT_CONTEXT_TYPE = 60110,
	REACT_FORWARD_REF_TYPE = 60112,
	REACT_SUSPENSE_TYPE = 60113,
	REACT_SUSPENSE_LIST_TYPE = 60120,
	REACT_MEMO_TYPE = 60115,
	REACT_LAZY_TYPE = 60116,
	REACT_BLOCK_TYPE = 60121,
	REACT_SERVER_BLOCK_TYPE = 60122,
	REACT_FUNDAMENTAL_TYPE = 60117,
	REACT_SCOPE_TYPE = 60119,
	REACT_OPAQUE_ID_TYPE = 60128,
	REACT_DEBUG_TRACING_MODE_TYPE = 60129,
	REACT_OFFSCREEN_TYPE = 60130,
	REACT_LEGACY_HIDDEN_TYPE = 60131,
	REACT_BINDING_TYPE = 60132
}

function t.getIteratorFn(p1) --[[ Line: 83 | Upvalues: t (copy) ]]
	if typeof(p1) ~= "table" then
		return nil
	end

	if p1["$$typeof"] == t.REACT_PORTAL_TYPE then
		return nil
	end

	return function() --[[ Line: 90 | Upvalues: p1 (copy) ]]
		local v1 = nil
		local v2 = nil

		return {
			next = function() --[[ next | Line: 93 | Upvalues: v1 (ref), v2 (ref), p1 (ref) ]]
				local v12, v22 = next(p1, v1)

				v1 = v12
				v2 = v22

				local t = {}

				t.done = v22 == nil
				t.key = v12
				t.value = v22

				return t
			end
		}
	end
end

return t