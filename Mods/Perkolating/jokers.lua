SMODS.Atlas{
	key = 'jokers',
	path = 'Jokers.png',
	px = 71,
	py = 95,
	-- 2x is 144 by 190
}

SMODS.Joker:take_ownership('perkeo', -- object key (class prefix not required)
	{ -- table of properties to change from the existing object
	rarity = 'Perkolator_Perkeo_R',
	},
	true -- silent | suppresses mod badge
)


SMODS.Joker{
	key = 'PerkOlator',
	atlas = 'jokers',
	pos = {x = 0, y = 0},
	soul_pos = { x = 0, y = 1 },
	blueprint_compat = true,
	rarity = 'Perkolator_Perkeo_R',
	loc_vars = function (self, info_queue, card)
        --info_queue[#info_queue+1] = G.P_CENTERS.j_perkeo
		info_queue[#info_queue+1] = G.P_CENTERS.e_negative 
	end,
	calculate = function (self,card,context)
		if context.ending_shop then
			G.E_MANAGER:add_event(Event({
				func = function()
					G.E_MANAGER:add_event(Event({
						func = function()
						SMODS.add_card({key='j_perkeo', edition='e_negative'})
							return true
						end
					}))
					return true
				end
			}))
			return {
				message = "Perkeo!",
				colour = HEX('56a786')
			}
		end
	end
}

SMODS.Joker{
	key = 'Perkmentia',
	atlas = 'jokers',
	pos = {x = 1, y = 0},
	rarity = 'Perkolator_Perkeo_R',
	blueprint_compat = true,
	calculate = function (self,card,context)
		if context.ending_shop and context.main_eval then
			local card = pseudorandom_element(G.consumeables.cards, pseudoseed('Perkmentia'))
			if card then 
				G.E_MANAGER:add_event(Event({
					func = function()
						card:start_dissolve()
						local consumable_types = {'Tarot','Spectral','Planet'}
						SMODS.add_card({set =  pseudorandom_element(consumable_types, pseudoseed('Perkmentia')), area = G.consumeables, edition = 'e_negative' })
						SMODS.add_card({set =  pseudorandom_element(consumable_types, pseudoseed('Perkmentia')), area = G.consumeables, edition = 'e_negative' })
						return true
					end
				}))
			end
			return {
				message = "What?",
				colour = HEX('56a786')
			}
		end
	end
}

SMODS.Joker{
	key = 'PNA',
	atlas = 'jokers',
	pos = {x = 1, y = 1},
	rarity = 'Perkolator_Perkeo_R',
	blueprint_compat = true,
	calculate = function (self,card,context)
		if context.first_hand_drawn and not context.blueprint then
			local eval = function() return G.GAME.current_round.hands_played == 0 end
			juice_card_until(card, eval, true)
		end
		if context.cardarea == G.jokers and context.before then
			if #context.full_hand  == 1 and  G.GAME.current_round.hands_played == 0 then
				G.playing_card = (G.playing_card and G.playing_card + 1) or 1
				local _card = copy_card(context.full_hand[1], nil, nil, G.playing_card)
				_card:set_edition('e_negative', true)
				_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, _card)
				G.hand:emplace(_card)
				_card.states.visible = nil
				G.E_MANAGER:add_event(Event({
					func = function()
						_card:start_materialize()
						return true
					end
				})) 
				return {
					message = "DUPLICATED",
					colour = HEX('56a786'),
					playing_cards_created = {true}
				}
			end
		end
	end
}

SMODS.Joker{
    key = "Perkeo_Template",
    atlas = 'jokers',
    rarity = "Perkolator_Perkeo_R",
    pos = {x = 2, y = 0},
    config = { extra = { Xmult_mod = 1,Xmult = 2} },
    loc_vars = function(self,info_queue,card)
        return { vars = {card.ability.extra.Xmult_mod, card.ability.extra.Xmult} }
    end,
    calculate = function (self,card,context)
		if context.card_added then
			sendDebugMessage("test", "perkeo")
		end
        if context.card_added  and context.card.ability.consumeable and context.card.edition and not context.blueprint then
            sendDebugMessage("test", "perkeo")
            if context.card.edition.type == 'negative' then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult,card.ability.extra.Xmult_mod } },
                    colour = G.C.MULT
                }
            end
        end
        if context.joker_main then
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                Xmult_mod = card.ability.extra.Xmult
            }
        end
    end 
}


SMODS.Joker{
	key = 'perkomon',
	rarity = "Perkolator_Perkeo_R",
	atlas = 'jokers',
	pos = {x = 3, y = 0},
	config = {extra = {Xmult = 2}},
	loc_vars = function(self,info_queue,card)
		return { vars = {card.ability.extra.Xmult} }
	end,
	calculate = function (self,card,context)
		if context.other_joker and context.other_joker.config.center.rarity == "Perkolator_Perkeo_R" and card ~= context.other_joker then
			return {
				message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
				Xmult_mod = card.ability.extra.Xmult
			}
		end
	
	end
}

SMODS.Joker{
	key = 'just_the_perks',
	atlas = 'jokers',
	pos = {x = 2, y = 1},
	rarity = "Perkolator_Perkeo_R",
	calculate = function (self,card,context)
		if context.retrigger_joker_check and not context.retrigger_joker and context.other_card ~= card and (context.other_card.config.center.rarity == "Perkolator_Perkeo_R" or context.other_card.config.center.key == "j_perkeo") then
			return {
			  message =  localize('k_again_ex'),
			  repetitions = 1,
			}
		  end
	end,
}
