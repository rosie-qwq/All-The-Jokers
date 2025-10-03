local path = SMODS.current_mod.path:gsub("/$", "")
package.path = package.path .. string.format(";%s/src/?.lua;%s/src/?/init.lua", path, path)

require("bplus.setup")
require("bplus.uidef")
require("bplus.funcs")
require("bplus.override")
require("bplus.mod_func")

BPlus.u.load_object("joker", SMODS.Joker)
BPlus.u.load_object("deck", SMODS.Back)
BPlus.u.load_object("enhancement", SMODS.Enhancement)
BPlus.u.load_object("voucher", SMODS.Voucher, { asset_row = 6 })
BPlus.u.load_object("tag", SMODS.Tag, { asset_row = 6, px = 34, py = 34 })
BPlus.u.load_object("blind", SMODS.Blind, { asset_row = 1, px = 34, py = 34, frames = 21 })
BPlus.u.load_object("booster", SMODS.Booster, { asset_row = 4 })
BPlus.u.load_object("consumable/tarot", SMODS.Consumable, { set = "Tarot", cost = 3 })
BPlus.u.load_object("seal", SMODS.Seal)
BPlus.u.load_consumable("consumable/sigil", {
  cost = 4,
  primary = HEX("8e32db"),
  secondary = HEX("5524b0"),
  rows = { 3, 4 },
  default = "c_bplus_sigil_blank",
})
