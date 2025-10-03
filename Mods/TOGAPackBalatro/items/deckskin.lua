sendInfoMessage("Loading Deckskins...", "TOGAPack")

-- Vanilla suites, displayed ranks and ranks to replace.
local suits = {'Hearts', 'Clubs', 'Diamonds', 'Spades'}
local dranks = {'Jack', 'Queen', "King", "Ace"}
local ranks = {'2', '3', '4', '5', '6', '7', '8', '9', '10', 'Jack', 'Queen', "King", "Ace"} 

-- Defining atlases for the original, low and high contrast of Old School atlases.
local rog = SMODS.Atlas{key = "TOGARetroSkinOG", path = "togaoldschoolcards_og.png", px = 71, py = 95, disable_mipmap = true}
local rlc = SMODS.Atlas{key = "TOGARetroSkinLC", path = "togaoldschoolcards_lc.png", px = 71, py = 95, disable_mipmap = true}
local rhc = SMODS.Atlas{key = "TOGARetroSkinHC", path = "togaoldschoolcards_hc.png", px = 71, py = 95, disable_mipmap = true}

-- Extracted .jpg sheet from Windows 7's Solitaire executable. No low/high contrast of these... for now.
local mclassic = SMODS.Atlas{key = "TOGAModernSkinClassic", path = "togamoderncards_classic.png", px = 71, py = 95, disable_mipmap = true}
local mhearts = SMODS.Atlas{key = "TOGAModernSkinHearts", path = "togamoderncards_hearts.png", px = 71, py = 95, disable_mipmap = true}
local mseason = SMODS.Atlas{key = "TOGAModernSkinSeasons", path = "togamoderncards_seasons.png", px = 71, py = 95, disable_mipmap = true}
local mlargep = SMODS.Atlas{key = "TOGAModernSkinLargePrint", path = "togamoderncards_largeprint.png", px = 71, py = 95, disable_mipmap = true}

-- A bit easier this way.
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
	
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_oldschool_'..suit], {key = 'toga_oldschool_og', ranks = ranks, display_ranks = dranks, atlas = rog.key,})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_oldschool_'..suit], {key = 'toga_oldschool_lc', ranks = ranks, display_ranks = dranks, atlas = rlc.key,})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_oldschool_'..suit], {key = 'toga_oldschool_hc', ranks = ranks, display_ranks = dranks, atlas = rhc.key,})
	
	-- Modern cards.
	SMODS.DeckSkin {
		key = "modern_"..suit,
		suit = suit,
		loc_txt = {
			['default'] = "Modern Windows Cards"
		},
		palettes = {},
	}
	
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_modern_'..suit], {key = 'toga_modern_default', ranks = ranks, display_ranks = dranks, atlas = mclassic.key,})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_modern_'..suit], {key = 'toga_modern_hearts', ranks = ranks, display_ranks = dranks, atlas = mhearts.key,})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_modern_'..suit], {key = 'toga_modern_seasons', ranks = ranks, display_ranks = dranks, atlas = mseason.key,})
	SMODS.DeckSkin.add_palette(SMODS.DeckSkins['toga_modern_'..suit], {key = 'toga_modern_largeprint', ranks = ranks, display_ranks = dranks, atlas = mlargep.key,})
end