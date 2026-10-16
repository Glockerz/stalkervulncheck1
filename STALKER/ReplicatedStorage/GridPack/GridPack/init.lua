-- Decompiled with Potassium's decompiler.

local script_Item = require(script.Item);
local Grid = require(script.ItemManager.Grid);
local SingleSlot = require(script.ItemManager.SingleSlot);
local script_TransferLink = require(script.TransferLink);
require(script.Types);

return {
    createItem = script_Item.new,
    createGrid = Grid.new,
    createSingleSlot = SingleSlot.new,
    createTransferLink = script_TransferLink.new
};