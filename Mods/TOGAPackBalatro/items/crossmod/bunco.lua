-- Bronze recipe compatibility for Copper from other mods. A bit like the Ore Dictionary of modded Minecraft.
sendInfoMessage("Bronze recipe can now use Copper from Bunco.", "TOGAPack - Bunco")
togabalatro.add_to_oredict('m_bunc_copper', 'copper', true)
-- Cross-mod stuff for Mineral card pool. Iron, gold and diamonds are valid examples,
-- but bronze and steel are not intended for this pool for being alloys.
sendInfoMessage("Added Copper cards of Bunco to mineral pool.", "TOGAPack - Bunco")
togabalatro.add_to_oredict('m_bunc_copper', 'minerals', true)

sendInfoMessage("Loading Deckskins...", "TOGAPack - Bunco")

local suits = {'bunc_Fleurons', 'bunc_Halberds'}
local dranks = {'Jack', 'Queen', "King", "Ace"}
local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace"} 

local rbuncolc = SMODS.Atlas{key = 'TOGABuncoExoticLC', path = 'togaoldschoolcardsbunco_lc.png', px = 71, py = 95, disable_mipmap = true}
local rbuncohc = SMODS.Atlas{key = 'TOGABuncoExoticHC', path = 'togaoldschoolcardsbunco_hc.png', px = 71, py = 95, disable_mipmap = true}

for i, suit in ipairs(suits) do
	-- Classic cards.
	SMODS.DeckSkin {
		key = "oldschool_"..suit,
		suit = suit,
		loc_txt = {
			['default'] = "Classic Windows Cards"
		},
		palettes = {},
	}
	
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_oldschool_'..suit], {key = 'toga_oldschool_lc', ranks = ranks, display_ranks = dranks, atlas = rbuncolc.key,})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_oldschool_'..suit], {key = 'toga_oldschool_hc', ranks = ranks, display_ranks = dranks, atlas = rbuncohc.key,})
end