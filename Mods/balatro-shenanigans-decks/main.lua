SMODS.Atlas({ key = "shenDecks", path = "shenDecks.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS" }):register()
SMODS.Atlas({ key = "shenFreakyDeck", path = "shenFreakyDeck.png", px = 284, py = 380, atlas_table = "ASSET_ATLAS" })
	:register()
SMODS.Atlas({ key = "shenTempleGames", path = "shenTempleGames.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS" })
	:register()
SMODS.Atlas({ key = "shenSleeves", path = "shenSleeves.png", px = 73, py = 95, atlas_table = "ASSET_ATLAS" })
	:register()
SMODS.Atlas({ key = "modicon", path = "modicon.png", px = 31, py = 32, atlas_table = "ASSET_ATLAS" }):register()
SMODS.Atlas({ key = "shenVouchers", path = "shenVouchers.png", px = 71, py = 95, atlas_table = "ASSET_ATLAS" }):register()
SMODS.Sound({ key = "freaky_scream", path = "freaky_scream.ogg", pitch = 1, volume = 1 })
SMODS.Sound({ key = "temple", path = "temple.wav", pitch = 1, volume = .5 })

SMODS.current_mod.optional_features = { retrigger_joker = true }
shenanigans_mod_config = SMODS.current_mod.config

SMODS.current_mod.config_tab = function()
	return {
		n = G.UIT.ROOT,
		config = {
			align = "cm",
			padding = 0.05,
			colour = G.C.CLEAR,
		},
		nodes = {
			create_toggle({
				label = "Temple Deck & Temple Game Vouchers (restart required)",
				ref_table = shenanigans_mod_config,
				ref_value = "temple_deck",
			}),
		},
	}
end

G.C.CYAN = HEX('00AAAA')
G.C.LIGHT_CYAN = HEX('55FFFF')


local subdir = "src"
local files = NFS.getDirectoryItems(SMODS.current_mod.path .. subdir)
for _, filename in pairs(files) do
	assert(SMODS.load_file(subdir .. "/" .. filename))()
end
