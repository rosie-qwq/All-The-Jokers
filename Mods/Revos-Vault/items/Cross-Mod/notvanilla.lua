SMODS.Joker({
	key = "ticketprinter",
	atlas = "notvanilla",
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
	dependencies = "NotVanilla",
	loc_vars = function(self, info_queue, center) end,

	calculate = function(self, card, context)
		local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then
			for i = 1, 3 do
				if
					G.GAME.used_vouchers["v_crv_printerup"] == true
					and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4
				then
					SMODS.add_card({
						set = "Tickets",
						editon = "e_negative",
					})
				else
					if #G.consumeables.cards < G.consumeables.config.card_limit or self.area == G.consumeables then
						SMODS.add_card({
							set = "Tickets",
						})
					end
				end
			end
		end
	end,
})
