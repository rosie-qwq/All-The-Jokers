SMODS.Joker{
	key = 'watergun',
	atlas = 'roffers',
	rarity = 1,
	cost = 5,
	blueprint_compat = true,
	eternal_compat = false,
	pos = { x = 5, y = 9 },
	config = { extra = { triggers = 10 } },
	loc_vars = function(self,info_queue,card)
      	info_queue[#info_queue+1] = {key = 'roff_favorite', set = 'Other'}
		return {vars = { card.ability.extra.triggers }}
	end,
	calculate = function(self,card,context)
		if context.individual and context.cardarea == G.play and context.other_card.ability.roff_favorite and card.ability.extra.triggers > 0 then
			if not context.blueprint then
				card.ability.extra.triggers = card.ability.extra.triggers - 1
			end
			if card.ability.extra.triggers <= 0 then
				-- kill (after last trigger)
				 G.E_MANAGER:add_event(Event({
					func = function()
						play_sound('tarot1')
						card.T.r = -0.2
						card:juice_up(0.3, 0.4)
						card.states.drag.is = true
						card.children.center.pinch.x = true
						-- This part destroys the card.
						G.E_MANAGER:add_event(Event({
							trigger = 'after',
							delay = 0.3,
							blockable = false,
							func = function()
								G.jokers:remove_card(card)
								card:remove()
								card = nil
								return true;
							end
						}))
						return true
					end
				}))
			end
			return {
				message = localize("k_again_ex"),
				repetitions = 1,
				card = context.other_card
			}
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
