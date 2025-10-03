
-- region Winged Golden Strawberry

local wingedgoldenstrawberry = {
	name = "ccc_Winged Golden Strawberry",
	key = "wingedgoldenstrawberry",
	config = { extra = { condition_satisfied = true, winged_poker_hand = 'Pair', after_boss = false, money = 18 } },
	pos = { x = 4, y = 1 },
	rarity = 2,
	cost = 7,
	discovered = true,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Gappie"
	},
    description = "Earn $18 at the end of Boss Blind if beaten without playing a hand that contains a randomly chosen Hand. Changes each round",
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

wingedgoldenstrawberry.set_ability = function(self, card, initial, delay_sprites)
	local _poker_hands = {}
	for k, v in pairs(G.GAME.hands) do
		if v.visible and k ~= 'High Card' then
			_poker_hands[#_poker_hands + 1] = k
		end
	end
	card.ability.extra.winged_poker_hand = pseudorandom_element(_poker_hands, pseudoseed('wingedgolden'))
	if (G.GAME.blind_on_deck and G.GAME.blind_on_deck == "Boss") or 
	(G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
		card.ability.extra.after_boss = true
	else
		card.ability.extra.after_boss = false
	end
end

wingedgoldenstrawberry.calculate = function(self, card, context)
	if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
		if not context.blueprint then
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.extra.winged_poker_hand and k ~= 'High Card' then
					_poker_hands[#_poker_hands + 1] = k
				end
			end
			card.ability.extra.winged_poker_hand = pseudorandom_element(_poker_hands, pseudoseed('wingedgolden'))
		end
		card_eval_status_text(card, 'extra', nil, nil, nil, { message = localize('k_ccc_reset'), colour = G.C.FILTER })
	end
	if context.cardarea == G.jokers then
		if context.before and not context.end_of_round then
			if next(context.poker_hands[card.ability.extra.winged_poker_hand]) then
				card.ability.extra.condition_satisfied = false
			end
		end
	end
	if context.setting_blind then
		card.ability.extra.condition_satisfied = true
		if context.blind.boss 
		or (G.GAME.modifiers and (G.GAME.modifiers.ccc_bside and G.GAME.modifiers.ccc_bside >= 1)) then
			card.ability.extra.after_boss = true
		else
			card.ability.extra.after_boss = false
		end
	end
end

wingedgoldenstrawberry.calc_dollar_bonus = function(self, card)
	if card.ability.extra.after_boss == true then
		if card.ability.extra.condition_satisfied == true then
			return card.ability.extra.money
		end
	end
end

function wingedgoldenstrawberry.loc_vars(self, info_queue, card)
	return { vars = { localize(card.ability.extra.winged_poker_hand, 'poker_hands'), card.ability.extra.money } }
end

return wingedgoldenstrawberry
-- endregion Winged Golden Strawberry