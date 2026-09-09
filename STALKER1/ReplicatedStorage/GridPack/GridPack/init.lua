-- Saved by UniversalSynSaveInstance (Join to Copy Games) https://discord.gg/wx4ThpAsmw

-- https://lua.expert/
local Item = require(script.Item)
local Grid = require(script.ItemManager.Grid)
local SingleSlot = require(script.ItemManager.SingleSlot)
local TransferLink = require(script.TransferLink)

require(script.Types)

return {
	createItem = Item.new,
	createGrid = Grid.new,
	createSingleSlot = SingleSlot.new,
	createTransferLink = TransferLink.new
}