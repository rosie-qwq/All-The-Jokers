-- region The Crowd

local thecrowd = {
	name = "ccc_The Crowd",
	key = "thecrowd",
	config = { extra = { xmult = 1.1, money = 1 } },
	pos = { x = 7, y = 5 },
	rarity = 3,
	cost = 12,
	discovered = true,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	atlas = "j_ccc_jokers",
	credit = {
		art = "Gappie",
		code = "toneblock",
		concept = "Kol_Oss"
	},
    description = "If played hand contains five of a kind, scoring cards give $1 and create the played hands planet card.",
	set_badges = function(self, card, badges)
		badges[#badges+1] = create_badge(localize('k_ccc_strawberry_badge', "labels"), G.C.RED, G.C.WHITE, 1)
	end,
}

thecrowd.calculate = function(self, card, context)
	if context.joker_main then
		if (next(context.poker_hands['Five of a Kind'])) then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({
					func = function()
						G.E_MANAGER:add_event(Event({
							func = function()
								local _planet = 0
								for k, v in pairs(G.P_CENTER_POOLS.Planet) do
									if v.config.hand_type == context.scoring_name then
										_planet = v.key
									end
								end
								local card = create_card(card_type, G.consumeables, nil, nil, nil, nil, _planet, 'blusl')
								G.GAME.consumeable_buffer = 0
								card:add_to_deck()
								G.consumeables:emplace(card)
								return true
							end
						}))
						card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil,
							{ message = localize('k_plus_planet'), colour = G.C.SECONDARY_SET.Planet })
						return true
					end
				}))
			end
			-- the consumable addition happens quite late but you know... it's fine, it feels good enough
			-- unsure how to fix that
			--[[
			return {
				message = localize {
					type = 'variable',
					key = 'a_xmult',
					vars = { card.ability.extra.xmult }
				},
				Xmult_mod = card.ability.extra.xmult
                	}, true
			]]
		end
	end
	if context.individual then
		if context.cardarea == G.play then
			if (next(context.poker_hands['Five of a Kind'])) then
				return {
					dollars = card.ability.extra.money,
					-- xmult = card.ability.extra.xmult,
					card = card
				}
			end
		end
	end
end

function thecrowd.loc_vars(self, info_queue, card)
	return { vars = { card.ability.extra.xmult, card.ability.extra.money } }
end

function thecrowd.in_pool(self)
	if G.GAME.hands["Flush Five"].played > 0 or G.GAME.hands["Five of a Kind"].played > 0 then
		return true
	end
	return false
end

return thecrowd

-- endregion The Crowd