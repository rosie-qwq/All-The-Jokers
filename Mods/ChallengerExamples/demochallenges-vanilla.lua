--[[
SMODS.Challenge({
	key = "demo_NAME",
	rules = {
		custom = {
			{ id = "KEY" },
		},
	},
	unlocked = function()
		return true
	end
})
]]

SMODS.Challenge({
	key = "demo_no_editions",
	rules = {
		custom = {
			{ id = "no_editions" },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_individual_edition_bans",
	rules = {
		custom = {
			{ id = "no_foil_cards" },
			{ id = "no_holo_jokers" },
			{ id = "no_polychrome_cards" },
			{ id = "no_negative_jokers" },--
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_money_total_scaling",
	rules = {
		custom = {
			{ id = "money_total_scaling", value = "0.5" },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_disable_hand_containing",
	rules = {
		custom = {
			{ id = "disable_hand_containing", hand = "Flush", value = "Flush" },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_whitelist_hand",
	rules = {
		custom = {
			{ id = "whitelist_hand", hand = "Two Pair", value = "Two Pair" },
			{ id = "whitelist_info" },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_blackjack",
	rules = {
		custom = {
			{ id = "blackjack", value = 21 },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_jokers_per_dollar",
	rules = {
		custom = {
			{ id = "jokers_per_dollar", value = 25 },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_overflow_debuff",
	jokers = {
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
	},
	rules = {
		custom = {
			{ id = "overflow_debuff" },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_overflow_debuff_one",
	jokers = {
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
		{ id = "j_invisible", edition = "negative" },
	},
	rules = {
		custom = {
			{ id = "overflow_debuff_one" },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_rental_hell",
	rules = {
		modifiers = {
			{ id = "dollars", value = 100}
		},
		custom = {
			{ id = "all_rental_jokers" },
			{ id = "rentals_keep_price" },
			{ id = "rental_rate", value = 2 },
			{ id = "rental_rate_increase", value = 1 },
			{ id = "rental_rate_increase_all", value = 0.5 },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_perishable_hell",
	rules = {
		custom = {
			{ id = "all_perishable_jokers" },
			{ id = "perishable_rounds", value = 2 },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_no_vouchers",
	rules = {
		custom = {
			{ id = "no_vouchers" },
		},
	},
	restrictions = {
		banned_cards = {
			{ id = "tag_voucher" }
		}
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_shop_hell",
	rules = {
		modifiers = {
			{ id = "dollars", value = 100}
		},
		custom = {
			{ id = "reroll_cost_increase", value = 1 },
			{ id = "all_shop_scaling", value = 2 },
			{ id = "shop_scaling_ante_increase", value = 1 },
			{ id = "shop_scaling_round_increase", value = 0.5 },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_forced_joker_pool",
	rules = {
		custom = {
			{ id = "forced_joker_pool", pool = {"j_lusty_joker", "j_bloodstone", "j_greedy_joker", "j_rough_gem", "j_smeared"} },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_disabling",
	rules = {
		custom = {
			{ id = "disable_suit", value = "Hearts" },
			{ id = "disable_rank", value = "Queen" },
		},
	},
	unlocked = function()
		return true
	end
})

SMODS.Challenge({
	key = "demo_extra_hand_money_scaling",
	rules = {
		custom = {
			{ id = "extra_hand_money_scaling", value = 0.5},
		},
	},
	unlocked = function()
		return true
	end
})