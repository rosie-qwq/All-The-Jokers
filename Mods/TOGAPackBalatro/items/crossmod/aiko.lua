sendInfoMessage("Loading Pure Suit card atlas...", "TOGAPack - Aikoyori")

local rakyrs = SMODS.Atlas{key = "TOGARetroSkinAkyrs", path = "togapuresuit.png", px = 71, py = 95, disable_mipmap = true} -- Pure thingy.
for _, suit in ipairs({'Hearts', 'Clubs', 'Diamonds', 'Spades'}) do
	-- Classic cards.
	local og, lc, hc = { atlas_key = rakyrs.key, pos = { x = suit == 'Hearts' and 0 or suit == 'Clubs' and 1 or suit == 'Diamonds' and 2 or suit == 'Spades' and 3, y = 0 }},
					   { atlas_key = rakyrs.key, pos = { x = suit == 'Hearts' and 0 or suit == 'Clubs' and 1 or suit == 'Diamonds' and 2 or suit == 'Spades' and 3, y = 1 }},
					   { atlas_key = rakyrs.key, pos = { x = suit == 'Hearts' and 0 or suit == 'Clubs' and 1 or suit == 'Diamonds' and 2 or suit == 'Spades' and 3, y = 2 }}
	
	for i, v in pairs(SMODS.DeckSkins['toga_oldschool_'..suit].palettes) do
		if v.key == 'toga_oldschool_og' then v.akyrs_pure_suit = og
		elseif v.key == 'toga_oldschool_lc' then v.akyrs_pure_suit = lc
		elseif v.key == 'toga_oldschool_hc' then v.akyrs_pure_suit = hc
		end
	end
	for i, v in pairs(SMODS.DeckSkins['toga_oldschool_'..suit].palette_map) do
		if v == 'toga_oldschool_og' then v.akyrs_pure_suit = og
		elseif v == 'toga_oldschool_lc' then v.akyrs_pure_suit = lc
		elseif v == 'toga_oldschool_hc' then v.akyrs_pure_suit = hc
		end
	end
end