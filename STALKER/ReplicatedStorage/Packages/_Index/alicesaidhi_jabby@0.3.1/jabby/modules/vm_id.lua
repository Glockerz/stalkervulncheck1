-- Decompiled with Potassium's decompiler.

local SharedTable2 = game:GetService("SharedTableRegistry"):GetSharedTable("_gorp_common_vm_count");
SharedTable2.id = SharedTable2.id or 0;

return SharedTable.increment(SharedTable2, "id", 1);