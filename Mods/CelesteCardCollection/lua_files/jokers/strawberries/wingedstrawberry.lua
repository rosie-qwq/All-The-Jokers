-- region Winged Strawberry

local wingedstrawberry = {
	name = "ccc_Winged Strawberry",
	key = "wingedstrawberry",
	config = { extra = { winged_poker_hand = 'Pair', money = 3 } },
	pos = { x = 2, y = 1 },
	rarity = 1,
	cost = 7,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "Earn $3 if poker hand does not contain a randomly chosen hand. Changes each round",
    set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

wingedstrawberry.set_ability = function(self, card, initial, delay_sprites)
	local _poker_hands = {}
	for k, v in pairs(G.GAME.hands) do
		if v.visible and k ~= 'High Card' then
			_poker_hands[#_poker_hands + 1] = k
		end
	end
	card.ability.extra.winged_poker_hand = pseudorandom_element(_poker_hands, pseudoseed('winged'))
end

wingedstrawberry.calculate = function(self, card, context)
	if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
		if not context.blueprint then
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.extra.winged_poker_hand and k ~= 'High Card' then
					_poker_hands[#_poker_hands + 1] = k
				end
			end
			card.ability.extra.winged_poker_hand = pseudorandom_element(_poker_hands, pseudoseed('winged'))
		end
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_ccc_reset'), colour = G.C.FILTER })
	end
	if context.cardarea == G.jokers then
		if context.before and not context.end_of_round then
			if not next(context.poker_hands[card.ability.extra.winged_poker_hand]) then
				G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
				G.E_MANAGER:add_event(Event({ func = (function()
					G.GAME.dollar_buffer = 0; return true
				end) }))
				return {
					dollars = card.ability.extra.money,
					colour = G.C.MONEY
				}
			end
		end
	end
end



function wingedstrawberry.loc_vars(self, info_queue, card)
	return { vars = { localize(card.ability.extra.winged_poker_hand, 'poker_hands'), card.ability.extra.money } }
end

return wingedstrawberry
-- endregion Winged Strawberry