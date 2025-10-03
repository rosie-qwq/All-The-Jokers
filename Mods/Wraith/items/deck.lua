SMODS.Atlas {
	key = "decks",
	px = 71,
	py = 95,
	path = "decks.png"
}

local tarot = {
	object_type = "Back",
	key = "tarot",
	name = "wrt-Tarot Deck",
	atlas = "decks",
	pos = {x = 0, y = 0},
	
	unlocked = false,
	discovered = false,
	
	unlock_condition = {type = 'discover_amount', tarot_count = 24},
	config = {vouchers = {'v_tarot_merchant'}, consumable_slot = 1},
}

return {
	name = "Decks",
	items = {
		tarot
	},
}