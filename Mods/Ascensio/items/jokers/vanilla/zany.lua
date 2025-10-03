SMODS.Joker({
	key = "zany",
	rarity = "cry_exotic",
	atlas = "v_atlas_1",
	blueprint_compat = true,
	demicoloncompat = true,
	pos = { x = 3, y = 10 },
	soul_pos = { x = 5, y = 10, extra = { x = 4, y = 10 } },
	config = { extra = { Xmult = 1, Xmult_mod = 12, hand_type = "Three of a Kind" } },
	cost = 50,
	asc_credits = {
		idea = {
			"bent",
		},
		art = {
			"Tatteredlurker",
		},
		code = {
			"Somethingcom515",
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.Xmult_mod,
				card.ability.extra.Xmult,
				localize(card.ability.extra.hand_type, "poker_hands"),
			},
		}
	end,
	calculate = function(self, card, context)
		if context.before or context.forcetrigger then
			if context.scoring_name == card.ability.extra.hand_type or context.forcetrigger then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "Xmult",
					scalar_value = "Xmult_mod",
					no_message = true,
				})
			elseif to_big(card.ability.extra.Xmult) > to_big(1) then
				card.ability.extra.Xmult = to_big(1)
				SMODS.calculate_effect({ message = localize("k_reset") }, context.blueprint_card or card)
			end
		end
		if (context.end_of_round and context.main_eval) or context.forcetrigger then
			return {
				func = function()
					local temprank = 0
					local tempcard
					for i, v in ipairs(G.hand.cards) do
						if v:get_id() > temprank and not v.debuff then
							temprank = v:get_id()
							tempcard = v
						end
					end
					if not tempcard or tempcard.REMOVED then
						return nil
					end
					G.E_MANAGER:add_event(Event({
						func = function()
							G.hand:add_to_highlighted(tempcard)
							return true
						end,
					}))
					SMODS.calculate_effect({ message = localize("k_level_up_ex") }, context.blueprint_card or card)
					SMODS.smart_level_up_hand(
						context.blueprint_card or card,
						card.ability.extra.hand_type,
						nil,
						temprank
					)
					G.E_MANAGER:add_event(Event({
						func = function()
							G.hand:remove_from_highlighted(tempcard)
							return true
						end,
					}))
				end,
			}
		end
		if context.joker_main and to_big(card.ability.extra.Xmult) > to_big(1) then
			return {
				xmult = card.ability.extra.Xmult,
			}
		end
	end,
})
