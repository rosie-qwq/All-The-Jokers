SMODS.Joker {
	key = "progressive", -- isn't there like an insurance company named progressive
	name = "Progressive Joker",
	config = { extra = { mult = 1, xmult = 1 } },
	rarity = "crp_refined",
	atlas = "crp_placeholder",
	pos = { x = 13, y = 0 },
	cost = 13,
	blueprint_compat = true,
	demicoloncompat = true,
	perishable_compat = false,
	loc_vars = function(self, info_queue, card)
		return { vars = { lenient_bignum(card.ability.extra.mult), lenient_bignum(card.ability.extra.xmult) } }
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
			card.ability.extra.mult = lenient_bignum(G.GAME.round)
			card.ability.extra.xmult = lenient_bignum(G.GAME.round_resets.ante)
		end
		if (context.joker_main) or context.forcetrigger then
			return {
				mult = lenient_bignum(card.ability.extra.mult),
				extra = {
					xmult = lenient_bignum(card.ability.extra.xmult)
				}
			}
		end
	end,
	crp_credits = {
		idea = { "Poker The Poker", "Glitchkat10" },
		code = { "Rainstar" }
	}
}