sendInfoMessage("Loading Enhancements...", "TOGAPack")

SMODS.Enhancement{
	key = 'notification',
	atlas = "TOGAEnhancements",
	pos = { x = 0, y = 0 },
	weight = 3,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'coalcoke',
	atlas = "TOGAEnhancements",
	pos = { x = 1, y = 0 },
	config = { h_chips = 40 },
	replace_base_card = true,
	no_rank = true,
	no_suit = true,
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_chips } }
	end,
	weight = 10
}

SMODS.Enhancement{
	key = 'iron',
	atlas = "TOGAEnhancements",
	pos = { x = 2, y = 0 },
	config = { h_x_mult = 1.25 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_mult } }
	end,
	weight = 8
}

SMODS.Enhancement{
	key = 'silver',
	atlas = "TOGAEnhancements",
	pos = { x = 3, y = 0 },
	config = { x_mult = 1.25 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_mult } }
	end,
}

SMODS.Enhancement{
	key = 'electrum',
	atlas = "TOGAEnhancements",
	pos = { x = 4, y = 0 },
	config = { p_dollars = 1, x_mult = 1.75 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.p_dollars, card.ability.x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('e4d691'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'copper',
	atlas = "TOGAEnhancements",
	pos = { x = 5, y = 0 },
	config = { h_x_chips = 1.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_chips } }
	end,
}

SMODS.Enhancement{
	key = 'tin',
	atlas = "TOGAEnhancements",
	pos = { x = 6, y = 0 },
	always_scores = true,
	weight = 8
}

SMODS.Enhancement{
	key = 'bronze',
	atlas = "TOGAEnhancements",
	pos = { x = 7, y = 0 },
	config = { h_x_chips = 2.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_chips } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('a87544'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'osmium',
	atlas = "TOGAEnhancements",
	pos = { x = 8, y = 0 },
	config = { x_chips = 1.25 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_chips } }
	end,
}

SMODS.Enhancement{
	key = 'sms',
	atlas = "TOGAEnhancements",
	pos = { x = 9, y = 0 },
	weight = 2,
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'redstone',
	atlas = "TOGAEnhancements",
	pos = { x = 0, y = 1 },
	weight = 4,
}

SMODS.Enhancement{
	key = 'signalum',
	atlas = "TOGAEnhancements",
	pos = { x = 1, y = 1 },
	config = { x_mult = 2 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('db4600'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'nickel',
	atlas = "TOGAEnhancements",
	pos = { x = 2, y = 1 },
	weight = 12,
}

SMODS.Enhancement{
	key = 'invar',
	atlas = "TOGAEnhancements",
	pos = { x = 3, y = 1 },
	config = { h_x_mult = 1.75 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('6f7975'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'glowstone',
	atlas = "TOGAEnhancements",
	pos = { x = 4, y = 1 },
	no_rank = true,
	replace_base_card = false,
}

SMODS.Enhancement{
	key = 'lumium',
	atlas = "TOGAEnhancements",
	pos = { x = 5, y = 1 },
	config = { h_x_mult = 2 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.h_x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('cf8f42'), G.C.WHITE, 1)
    end,
	poweritem = true
}

SMODS.Enhancement{
	key = 'refinedglowstone',
	atlas = "TOGAEnhancements",
	pos = { x = 6, y = 1 },
	config = { x_mult = 1.25, x_chips = 1.5 },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.x_chips, card.ability.x_mult } }
	end,
	in_pool = function(self, args)
		return false
	end,
	alloy = true,
	set_badges = function(self, card, badges)
        badges[#badges+1] = create_badge(localize('toga_alloy'), HEX('d4bc41'), G.C.WHITE, 1)
    end,
	poweritem = true
}