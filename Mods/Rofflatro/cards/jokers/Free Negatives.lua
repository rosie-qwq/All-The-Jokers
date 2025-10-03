SMODS.Joker{
	key = 'free_negatives',
	atlas = 'roffers',
	rarity = 3,
	cost = 8,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 5, y = 7 },
	config = { extra = { rounds = 3 } },
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_TAGS.tag_negative
		return {vars = {card.ability.extra.rounds}}
	end,
	calculate = function(self,card,context)
		if context.ending_shop then
			card.ability.extra.rounds = card.ability.extra.rounds - 1

            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_negative'))
                    play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
                    return true
                end)
            }))

			if card.ability.extra.rounds <= 0 then
				G.E_MANAGER:add_event(Event({
				trigger = 'after',
				delay = 0.5,
				blockable = false,
				func = function()
					play_sound('tarot1')
					card.T.r = -0.2
					card:juice_up(0.3, 0.4)
					card.states.drag.is = true
					card.children.center.pinch.x = true
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
				
				return {
					message = localize('k_extinct_ex')
				}
			else
				return {
					message = localize('k_roff_negatives_trigger')
				}
			end
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
