SMODS.Joker({
	key = "mystic_summit",
	config = { extra = { mult = 1, gain = 0.25 } },
	rarity = "cry_exotic",
	atlas = "v_atlas_1",
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 9, y = 5 },
	soul_pos = { x = 11, y = 5, extra = { x = 10, y = 5 } },
	cost = 50,
	order = 23,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card and lenient_bignum(card.ability.extra.mult),
				card and lenient_bignum(card.ability.extra.gain),
			},
		}
	end,
	calculate = function(self, card, context)
		if
			(
				context.end_of_round
				and context.cardarea == G.jokers
				and not context.blueprint
				and not context.retrigger_joker
			) or context.forcetrigger
		then
			if (G.GAME.current_round.discards_left == 0) or context.forcetrigger then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "mult",
					scalar_value = "gain",
					message_key = "a_powmult",
					message_colour = G.C.DARK_EDITION,
				})
			end
		end
		if context.joker_main or context.forcetrigger then
			if lenient_bignum(card.ability.extra.mult) > 1 then
				return {
					message = localize({
						type = "variable",
						key = "a_powmult",
						vars = { lenient_bignum(card.ability.extra.mult) },
					}),
					Emult_mod = lenient_bignum(card.ability.extra.mult),
					colour = G.C.DARK_EDITION,
				}
			end
		end
	end,
	asc_credits = {
		idea = {
			"TheOfficalFem",
		},
		art = {
			"Tatteredlurker",
		},
		code = {
			"MarioFan597",
		},
	},
})
