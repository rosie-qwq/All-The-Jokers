-- region Waterfall

local waterfall = {
	name = "ccc_Waterfall",
	key = "waterfall",
	config = {},
	pos = { x = 5, y = 2 },
	rarity = 1,
	cost = 5,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "toneblock",
		code = "toneblock",
		concept = "Bred"
	},
    description = "If played hand contains a Flush, convert a random card held in hand to the same suit"
}

waterfall.calculate = function(self, card, context)
	if context.before and context.poker_hands ~= nil and next(context.poker_hands['Flush']) then
		local suits = {}
		local used_suits = {}
		for i = 1, #context.scoring_hand do
			if context.scoring_hand[i].ability.name ~= 'Wild Card' then
				if not suits[context.scoring_hand[i].base.suit] then
					suits[context.scoring_hand[i].base.suit] = 1
					used_suits[#used_suits + 1] = context.scoring_hand[i].base.suit
				else
					suits[context.scoring_hand[i].base.suit] = suits[context.scoring_hand[i].base.suit] + 1
				end
			end
		end
		local value = 0
		if #used_suits ~= 0 then
			for i = 1, #used_suits do
				if suits[used_suits[i]] > value then
					ccc_waterfall_flush_suit = used_suits[i]
					value = suits[used_suits[i]]
				end
			end
		else
			ccc_waterfall_flush_suit = 'Wild'
		end

		local waterfall_card_candidates = {}
		if ccc_waterfall_flush_suit ~= 'Wild' then
			for i = 1, #G.hand.cards do
				if not G.hand.cards[i]:is_suit(ccc_waterfall_flush_suit, true) then
					waterfall_card_candidates[#waterfall_card_candidates + 1] = G.hand.cards[i]
				end
			end
		else
			for i = 1, #G.hand.cards do
				if G.hand.cards[i].ability.name ~= 'Wild Card' or G.hand.cards[i].ability.name ~= 'Steel Card' or G.hand.cards[i].ability.name ~= 'Gold Card' then
					waterfall_card_candidates[#waterfall_card_candidates + 1] = G.hand.cards[i]
				end
			end
		end
		if #waterfall_card_candidates > 0 then -- this used to be bunco code but i changed it
			return {
				message = localize('k_ccc_applied'),
				G.E_MANAGER:add_event(Event({
					trigger = 'immediate',
					func = function()
						if #waterfall_card_candidates > 0 then
							local waterfall_card = pseudorandom_element(waterfall_card_candidates,
								pseudoseed('waterfall'))
							if ccc_waterfall_flush_suit ~= 'Wild' then
								waterfall_card:change_suit(ccc_waterfall_flush_suit)
							else
								waterfall_card:set_ability(G.P_CENTERS.m_wild)
							end
							waterfall_card:juice_up()
							play_sound('tarot1', 0.8, 0.4)
						end
						return true
					end
				}))
			}
		end
	end
end

return waterfall
-- endregion Waterfall