-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local v1 = game:GetService("SharedTableRegistry"):GetSharedTable("_gorp_common_vm_count")

v1.id = v1.id or 0

return SharedTable.increment(v1, "id", 1)