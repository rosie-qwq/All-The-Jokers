SMODS.Joker({
	key = "loteriaprinter",
	atlas = "ortalab",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	dependencies = "ortalab",
	loc_vars = function(self, info_queue, center) end,

	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then

				if
					G.GAME.used_vouchers["v_crv_printerup"] == true
					and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4
				then
					SMODS.add_card({
						set = "Loteria",
						editon = "e_negative",
					})
				else
					if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then
						SMODS.add_card({
							set = "Loteria",
						})
					end
				end
			end
	end,
})

SMODS.Joker({
	key = "zodiacprinterortalab",
	atlas = "ortalab",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 1,
		y = 0,
	},
	dependencies = "ortalab",
	loc_vars = function(self, info_queue, center) end,

	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then
				if
					G.GAME.used_vouchers["v_crv_printerup"] == true
					and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4
				then
					SMODS.add_card({
						set = "Zodiac",
						editon = "e_negative",
					})
				else
					if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then
						SMODS.add_card({
							set = "Zodiac",
						})
					end
				end
			end
	end,
})

SMODS.Joker({
	key = "jesterprinter",
	atlas = "ortalab",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 2,
		y = 0,
	},
	dependencies = "ortalab",
	loc_vars = function(self, info_queue, center) end,

	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then
				if
					G.GAME.used_vouchers["v_crv_printerup"] == true
					and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4
				then
					SMODS.add_card({
						key = "j_ortalab_jester",
						editon = "e_negative",
					})
				else
					if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
						SMODS.add_card({
							key = "j_ortalab_jester",
						})
					end
				end
			end
	end,
})
