SMODS.Atlas {
    key = 'jokers',
    path = "jokers.png",
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = 'crossmodjokers',
    path = "compat/jokers.png",
    px = 71,
    py = 95
}

function G.PRISM.Joker(table)
	if table.dependency or table.dependency == nil then
		SMODS.Joker(table)
	end
end
G.PRISM.Joker({
	key = "polydactyly",
	atlas = "jokers",
	pos = {x=2,y=2},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	add_to_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(1)
		SMODS.change_discard_limit(1)
	end,
	remove_from_deck = function(self, card, from_debuff)
		SMODS.change_play_limit(-1)
		SMODS.change_discard_limit(-1)
	end,
})
G.PRISM.Joker({
	key = "rich_joker",
	atlas = "jokers",
	pos = {x=0,y=12},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {
		odds = 2,money = 4
    },
	loc_vars = function(self, info_queue, center)
		return { vars = {
			"" .. (G.GAME and G.GAME.probabilities.normal or 1), 
			center.ability.odds,
			center.ability.money }
		}
	end,
	calculate = function(self, card, context)
		if context.selling_card and context.card ~= card and pseudorandom('rich') < G.GAME.probabilities.normal / card.ability.odds then
			return {
				dollars = card.ability.money,
				card = card
			}
		end
	end,
})
G.PRISM.Joker({
	key = "racecar",
	atlas = "jokers",
	pos = {x=3,y=7},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chips = 0, mult = 0,chips_gain = 3, mult_gain = 1}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.chips_gain, center.ability.extra.mult_gain, center.ability.extra.chips, center.ability.extra.mult} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return{
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult
			}
		end
		if context.cardarea == G.jokers and context.end_of_round and not context.blueprint then
			local mod = G.GAME.current_round.hands_left
			card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_gain * mod
			card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain * mod
			return {
				message = localize('k_upgrade_ex'),
				colour = G.C.FILTER,
				card = card
			}
		end
	end

})
G.PRISM.Joker({
	key = "hit_record",
	atlas = "jokers",
	pos = {x=0,y=11},
	rarity = 1,
	cost = 3,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			context.other_card.config.cycling = true
		end
	end
})

G.PRISM.Joker({
	key = "motherboard",
	atlas = "jokers",
	pos = {x=1,y=4},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {chips = 0, extra = 2},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra, center.ability.chips} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return{
			chips = card.ability.chips
			}
		end
		if context.cardarea == G.play and context.individual and not context.blueprint then
			if context.other_card.ability.set ~= 'Enhanced' and not context.other_card.seal and not context.other_card.edition then
				card.ability.chips = card.ability.chips + card.ability.extra
				return {
					focus = card,
					colour = G.C.CHIPS,
					message = localize{type = 'variable', key = 'a_prism_chips', vars = {card.ability.extra}},
					card = card,
				}
			else
				card.ability.chips = math.max(card.ability.chips - card.ability.extra,0)
				return {
					focus = card,
					colour = G.C.CHIPS,
					message = localize{type = 'variable', key = 'a_prism_chips_minus', vars = {card.ability.extra}},
					card = card,
				}
			end
		end
	end
})
G.PRISM.Joker({
	key = "ghost",
	atlas = "jokers",
	pos = {x=0,y=13},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {chips = 33}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips, G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral * center.ability.extra.chips or 0} }
	end,
	calculate = function(self, card, context)
		if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.spectral > 0 then
			return {
				chips = G.GAME.consumeable_usage_total.spectral * card.ability.extra.chips
			}
		end
    end
	
})
G.PRISM.Joker({
	key = "pizza_cap",
	atlas = "jokers",
	pos = {x=3,y=0},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	
	eternal_compat = false,
	perishable_compat = true,
	pools = {
		Food = true,
		Pizza = true
	},
	config = {extra = {chips = 40,uses = 15}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.chips,center.ability.extra.uses}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('Spades', nil, true) and card.ability.extra.uses > 0 then
				if not context.blueprint then card.ability.extra.uses = card.ability.extra.uses - 1 end
                return {
                    chips = card.ability.extra.chips,
                    card = card
                }
			end
        end
		if context.after and not context.blueprint and card.ability.extra.uses < 1 then
			G.PRISM.remove_joker(card)
			G.GAME.prism_pizza_lv = G.GAME.prism_pizza_lv + 1
			return {
				message = localize('k_eaten_ex'),
				colour = G.C.RED,
			}
		end
    end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.extra.chips = card.ability.extra.chips + (40 * (G.GAME.prism_pizza_lv or 0))
	end
})
G.PRISM.Joker({
	key = "pizza_mar",
	atlas = "jokers",
	pos = {x=3,y=1},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	pools = {
		Food = true,
		Pizza = true
	},
	config = {extra = {x_mult = 1.2,uses = 15}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.x_mult,center.ability.extra.uses}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('Hearts', nil, true) and card.ability.extra.uses > 0 then
				if not context.blueprint then card.ability.extra.uses = card.ability.extra.uses - 1 end
                return {
                    xmult = card.ability.extra.x_mult,
                    card = card
                }
			end
        end
		if context.after and not context.blueprint and card.ability.extra.uses < 1 then
			G.PRISM.remove_joker(card)
			G.GAME.prism_pizza_lv = G.GAME.prism_pizza_lv + 1
			return {
				message = localize('k_eaten_ex'),
				colour = G.C.RED,
			}
		end
    end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.extra.x_mult = card.ability.extra.x_mult + (0.2 * (G.GAME.prism_pizza_lv or 0))
	end
})
G.PRISM.Joker({
	key = "pizza_for",
	atlas = "jokers",
	pos = {x=3,y=2},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	pools = {
		Food = true,
		Pizza = true
	},
	config = {extra = {money = 2,odds = 2, uses = 15}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.money,center.ability.extra.uses,"" .. (G.GAME and G.GAME.probabilities.normal or 1),center.ability.extra.odds}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('Diamonds', nil, true) and card.ability.extra.uses > 0 then
				if not context.blueprint then card.ability.extra.uses = card.ability.extra.uses - 1 end
				if pseudorandom('4cheese') < G.GAME.probabilities.normal / card.ability.extra.odds then
					return {
						dollars = card.ability.extra.money,
						card = card
					}
				end
			end
        end
		if context.after and not context.blueprint and card.ability.extra.uses < 1 then
			G.PRISM.remove_joker(card)
			G.GAME.prism_pizza_lv = G.GAME.prism_pizza_lv + 1
			return {
				message = localize('k_eaten_ex'),
				colour = G.C.RED,
			}
		end
    end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.extra.money = card.ability.extra.money + (2 * (G.GAME.prism_pizza_lv or 0))
	end
})
G.PRISM.Joker({
	key = "pizza_ruc",
	atlas = "jokers",
	pos = {x=3,y=3},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	pools = {
		Food = true,
		Pizza = true
	},
	config = {extra = {mult = 6,uses = 15}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.mult,center.ability.extra.uses}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('Clubs', nil, true) and card.ability.extra.uses > 0 then
				if not context.blueprint then card.ability.extra.uses = card.ability.extra.uses - 1 end
                return {
                    mult = card.ability.extra.mult,
                    card = card
                }
			end
        end
		if context.after and not context.blueprint and card.ability.extra.uses < 1 then
			G.PRISM.remove_joker(card)
			G.GAME.prism_pizza_lv = G.GAME.prism_pizza_lv + 1
			return {
				message = localize('k_eaten_ex'),
				colour = G.C.RED,
			}
		end
    end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.extra.mult = card.ability.extra.mult + (6 * (G.GAME.prism_pizza_lv or 0))
	end
})

G.PRISM.Joker({
	dependency = G.PRISM.compat.paperback,
	key = "pizza_haw",
	atlas = "crossmodjokers",
	pos = {x=0,y=0},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	pools = {
		Food = true,
		Pizza = true
	},
	paperback = {
		requires_crowns = true
	},
	config = {extra = {min_money = -2, max_money = 5, uses = 15}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.min_money,center.ability.extra.max_money,center.ability.extra.uses}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('paperback_Crowns', nil, true) and card.ability.extra.uses > 0 then
				if not context.blueprint then card.ability.extra.uses = card.ability.extra.uses - 1 end
				local dollars = pseudorandom("hawaiian", card.ability.extra.min_money, card.ability.extra.max_money)
        		if dollars ~= 0 then
					return {
						dollars = dollars
					}
				end
			end
        end
		if context.after and not context.blueprint and card.ability.extra.uses < 1 then
			G.PRISM.remove_joker(card)
			G.GAME.prism_pizza_lv = G.GAME.prism_pizza_lv + 1
			return {
				message = localize('k_eaten_ex'),
				colour = G.C.RED,
			}
		end
    end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.extra.min_money = card.ability.extra.min_money + (-2 * (G.GAME.prism_pizza_lv or 0))
		card.ability.extra.max_money = card.ability.extra.max_money + (5 * (G.GAME.prism_pizza_lv or 0))
	end
})
G.PRISM.Joker({
	dependency = G.PRISM.compat.paperback,
	key = "pizza_det",
	atlas = "crossmodjokers",
	pos = {x=0,y=1},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	pools = {
		Food = true,
		Pizza = true
	},
	paperback = {
		requires_stars = true
	},
	config = {extra = {x_chips = 1.3, uses = 15}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.x_chips,center.ability.extra.uses}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if context.other_card:is_suit('paperback_Stars', nil, true) and card.ability.extra.uses > 0 then
				if not context.blueprint then card.ability.extra.uses = card.ability.extra.uses - 1 end
				return {
					x_chips = card.ability.extra.x_chips
				}
			end
        end
		if context.after and not context.blueprint and card.ability.extra.uses < 1 then
			G.PRISM.remove_joker(card)
			G.GAME.prism_pizza_lv = G.GAME.prism_pizza_lv + 1
			return {
				message = localize('k_eaten_ex'),
				colour = G.C.RED,
			}
		end
    end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.extra.x_chips = card.ability.extra.x_chips + (0.3 * (G.GAME.prism_pizza_lv or 0))
	end
})

G.PRISM.Joker({
	dependency = G.PRISM.compat.mintys,
	key = "pizza_con",
	atlas = "crossmodjokers",
	pos = {x=0,y=2},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = true,
	pools = {
		Food = true,
		Pizza = true
	},
	config = {extra = {x_mult = 2.5, uses = 15,again = 0,odds = 3}},
	loc_vars = function(self, info_queue, center)
		return { vars = { center.ability.extra.x_mult,center.ability.extra.uses,
		"" .. (G.GAME and G.GAME.probabilities.normal or 1),center.ability.extra.odds}}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.individual then
			if context.other_card:is_3() and card.ability.extra.uses > 0 then
				if not context.blueprint then card.ability.extra.uses = card.ability.extra.uses - 1 end
				local trycount = context.other_card:is_3()
				local repcount = 0
				for try=1,trycount do
					if pseudorandom('cone') < G.GAME.probabilities.normal/card.ability.extra.odds then 
						repcount = repcount + 1
					end
				end
				card.ability.extra.again = repcount
				--sendDebugMessage('Count (individual): '..card.ability.extra.again)
				if card.ability.extra.again ~= 0 then
					return {
						xmult = card.ability.extra.x_mult,
						card = card
					}
				end
			end
		end
		if context.retrigger_joker_check and card.ability.extra.again ~= 0 and context.other_card == card then 
			local reps = card.ability.extra.again-1
			card.ability.extra.again = 0
			if reps >= 1 then 
				return {
					message = localize('k_again_ex'),
					message_card = card,
					repetitions = reps
				}
			end
		end
		if context.after and not context.blueprint and card.ability.extra.uses < 1 then
			G.PRISM.remove_joker(card)
			G.GAME.prism_pizza_lv = G.GAME.prism_pizza_lv + 1
			return {
				message = localize('k_eaten_ex'),
				colour = G.C.RED,
			}
		end
	end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.extra.x_mult = card.ability.extra.x_mult + (2.5 * (G.GAME.prism_pizza_lv or 0))
	end
})
G.PRISM.Joker({
	key = "sculptor",
	atlas = "jokers",
	pos = {x=1,y=3},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 7},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		return {
		vars = {center.ability.extra}
		}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_stone') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
			if SMODS.has_enhancement(context.other_card,'m_stone') then
            	context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED,
                    card = card
                }
			end
        end
    end
	
})
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "happily",
	atlas = "jokers",
	pos = {x=1,y=12},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.joker_main and not context.before and not context.after and not (context.blueprint_card or card).getting_sliced then
			local kings = 0
			local queens = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 12 then queens = queens + 1 end
				if context.scoring_hand[i]:get_id() == 13 then kings = kings + 1 end
			end
			if kings >= 1 and queens >= 1 then
				G.PRISM.create_card('Myth',G.consumeables, nil, nil, nil, nil, nil, 'happily', function(new_card)
					play_sound("timpani")
					play_sound("polychrome1",2,0.5)
					card:juice_up(0.3, 0.5)
				end)
				return {}
			end
		end
	end
})
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "geo_hammer",
	atlas = "jokers",
	pos = {x=0,y=3},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {"m_stone","m_prism_crystal"}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		info_queue[#info_queue + 1] = G.P_CENTERS.m_prism_crystal
	end,
	calculate = function(self, card, context)
		if context.first_hand_drawn then
			G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
				local eligible_cards = {}
				for k, v in ipairs(G.hand.cards) do
					if v.ability.set ~= 'Enhanced' then
						table.insert(eligible_cards,v)
					end
				end
				local random_card = pseudorandom_element(eligible_cards, pseudoseed('geo'))
				local enhancement = pseudorandom_element(card.ability.extra, pseudoseed('geo'))
				if random_card then
					random_card:set_ability(G.P_CENTERS[enhancement]) 
					random_card:juice_up(0.3, 0.5)
					card:juice_up(0.3, 0.5)
				end
			return true end }))
			return {}
		end
	end
})
G.PRISM.Joker({
	key = "air_balloon",
	atlas = "jokers",
	pos = {x=0,y=0},
	rarity = 1,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {mult = 0,extra = 2},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.mult,center.ability.extra} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.mult,
			}
		end
        if context.cardarea == G.jokers and context.before and not context.blueprint then
			local reset = true
			if context.scoring_name == "High Card" then
				reset = false
			end
			if reset then
				if card.ability.mult > 0 then
					card.ability.mult = 0
					return {
						card = card,
						message = localize('k_reset')
					}
				end
			else
				card.ability.mult = card.ability.mult + card.ability.extra
			end
        end
    end
})
G.PRISM.Joker({
	key = "metalhead",
	atlas = "jokers",
	pos = {x=2,y=5},
	rarity = 1,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_stone') then return true end
		end
		return false
	end,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
		info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
	end,
	add_to_deck = function(self, card, from_debuff)
        for _, deck_card in pairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(deck_card,"m_stone") then
                deck_card.ability.h_x_mult = (deck_card.ability.h_x_mult or 0) + G.P_CENTERS.m_steel.config.h_x_mult
            end
        end
        G.P_CENTERS.m_stone.config.h_x_mult = (G.P_CENTERS.m_stone.config.h_x_mult or 0) + G.P_CENTERS.m_steel.config.h_x_mult
    end,
    remove_from_deck = function(self, card, from_debuff)
        for _, deck_card in pairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(deck_card,"m_stone") then
                deck_card.ability.h_x_mult = (deck_card.ability.h_x_mult or G.P_CENTERS.m_steel.config.h_x_mult) - G.P_CENTERS.m_steel.config.h_x_mult
            end
        end
        G.P_CENTERS.m_stone.config.h_x_mult = (G.P_CENTERS.m_stone.config.h_x_mult or G.P_CENTERS.m_steel.config.h_x_mult) - G.P_CENTERS.m_steel.config.h_x_mult
    end
})

local orig_get_enhancements = SMODS.get_enhancements
function SMODS.get_enhancements(card, extra_only)
	local enhancements = orig_get_enhancements(card,extra_only)
	if next(find_joker("j_prism_metalhead")) and card.config.center == G.P_CENTERS.m_stone then
		enhancements["m_steel"] = true
	end
	return enhancements
end
G.PRISM.Joker({
	key = "exotic_card",
	atlas = "jokers",
	pos = {x=0,y=2},
	rarity = 2,
	cost = 6,
	pixel_size = { w = 59, h = 95},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 1},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra} }
	end,
	calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
			if next(SMODS.get_enhancements(context.other_card)) then
                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
                    card = card
                }
            end
        end
    end
	
})
G.PRISM.Joker({
	key = "day",
	atlas = "jokers",
	pos = {x=2,y=7},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 1,trigger = false},
	yes_pool_flag = "day_can_spawn",
	loc_vars = function(self, info_queue, center)
		if not center.fake_card then info_queue[#info_queue + 1] = G.P_CENTERS.j_prism_night end
	end,
	calculate = function(self, card, context)
		if context.before then
			local right_suits, all_cards = 0, 0
			for k, v in ipairs(G.play.cards) do
				all_cards = all_cards + 1
				if v:is_suit('Hearts', nil, true) or v:is_suit('Diamonds', nil, true) then
					right_suits = right_suits + 1
				end
			end
			if right_suits == all_cards then 
				card.ability.trigger = true
			end
		end
		if context.after and card.ability.trigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.j_prism_night)
					return true
				end
			}))
			return {
				message = localize('k_sunset'),
				card = card
			}
		end
		if context.repetition and context.cardarea == G.play and card.ability.trigger then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
        end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.night_can_spawn = false
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.night_can_spawn = true
	end
})
G.PRISM.Joker({
	key = "night",
	atlas = "jokers",
	pos = {x=2,y=8},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 1,trigger = false},
	yes_pool_flag = "night_can_spawn",
	loc_vars = function(self, info_queue, center)
		if not center.fake_card then info_queue[#info_queue + 1] = G.P_CENTERS.j_prism_day end
	end,
	calculate = function(self, card, context)
		if context.before then
			local right_suits, all_cards = 0, 0
			for k, v in ipairs(G.play.cards) do
				all_cards = all_cards + 1
				if v:is_suit('Clubs', nil, true) or v:is_suit('Spades', nil, true) then
					right_suits = right_suits + 1
				end
			end
			if right_suits == all_cards then 
				card.ability.trigger = true
			end
		end
		if context.after and card.ability.trigger then
			G.E_MANAGER:add_event(Event({
				func = function()
					play_sound('tarot2', 1.1, 0.6)
					card:set_ability(G.P_CENTERS.j_prism_day)
					return true
				end
			}))
			return {
				message = localize('k_sunrise'),
				card = card
			}
		end
		if context.repetition and context.cardarea == G.play and card.ability.trigger then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
        end
	end,
	add_to_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.day_can_spawn = false
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.GAME.pool_flags.day_can_spawn = true
	end
})
G.PRISM.Joker({
	key = "whiskey",
	atlas = "jokers",
	pos = {x=2,y=3},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = {required = 4,current = 0,done = false},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = 'tag_double', set = 'Tag'}
		return { vars = {center.ability.required,center.ability.current} }
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and not context.blueprint then
            if context.other_card:get_id() == 11 then
                card.ability.current = card.ability.current + 1
				if card.ability.current >= card.ability.required and not card.ability.done then
					card.ability.current = 0
					card.ability.done = true
					G.E_MANAGER:add_event(Event({
						func = (function()
							add_tag(Tag('tag_double'))
							play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
							play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
						   return true
					   end)
					}))
				elseif card.ability.current > card.ability.required and card.ability.done then
					card.ability.current = card.ability.required
					return nil 
				end
				return {
					message = (card.ability.current == 0) and localize('k_plus_double') or (card.ability.current..'/'..card.ability.required),
					colour = G.C.FILTER,
					focus = card,
					card = card
				}
            end
        end
		if context.setting_blind and not context.blueprint then
			card.ability.done = false
		end
    end
})
G.PRISM.Joker({
	key = "solo_joker",
	atlas = "jokers",
	pos = {x=1,y=14},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 3, trigger = false},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra} }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before then
			if #context.full_hand == 1 then card.ability.trigger = true else card.ability.trigger = false end
		end
        if context.repetition and context.cardarea == G.play and card.ability.trigger then
			return {
				message = localize('k_again_ex'),
				repetitions = card.ability.extra,
				card = card
			}
        end
    end
})
G.PRISM.Joker({
	key = "floppy",
	atlas = "jokers",
	pos = {x=3,y=8},
	pixel_size = { w = 71, h = 74},
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	config = {extra = {cards = {}}},
	loc_vars = function(self, info_queue, center)
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			card.ability.extra.cards = {}
			for i,v in ipairs(context.full_hand) do
				card.ability.extra.cards[i] = {
					config = {
						center = v.config.center,
						card = v.config.card
					},
					ability = v.ability,
					edition = v.edition,
					seal = v.seal,
					params = v.params,
					T = v.T
				}
			end
		end
		if context.selling_self and not context.blueprint and #G.hand.cards ~= 0 then
			for _,v in ipairs(card.ability.extra.cards) do
				--v.T = copy_table(G.hand.cards[1].T)
				local new_card = copy_card(v, nil, nil, G.playing_card)
				new_card:add_to_deck()
				G.deck.config.card_limit = G.deck.config.card_limit + 1
				table.insert(G.playing_cards, new_card)
				G.hand:emplace(new_card)
				new_card.states.visible = nil
				G.E_MANAGER:add_event(Event({func = function()
					new_card:start_materialize()
					return true
				end}))
				playing_card_joker_effects({new_card})
			end
		end
    end,
	generate_ui = function(self, info_queue, cardd, desc_nodes, specific_vars, full_UI_table)
        if #cardd.ability.extra.cards > 0 and cardd.area == G.jokers then
			local stored_cards = cardd.ability.extra.cards
            local cards = {}
            for i = 1, #stored_cards do
				local card = copy_card(stored_cards[i], nil, nil, G.playing_card)
				table.insert(cards,card)
            end
            SMODS.Joker.super.generate_ui(self, info_queue, cardd, desc_nodes, specific_vars, full_UI_table)
            G.PRISM.card_preview(nil,desc_nodes,{
                override = true,
                cards = cards,
                w = 2.9,
                h = 0.75,
                ml = 0,
                scale = 0.4,
				p_plus = -0.45;
            })
        else
            if not cardd then
                cardd = self:create_fake_card()
            end
            local target = {
                type = 'descriptions',
                key = self.key,
                set = self.set,
                nodes = desc_nodes,
                vars =
                    specific_vars or {}
            }
            local res = {}
            if self.loc_vars and type(self.loc_vars) == 'function' then
                res = self:loc_vars(info_queue, cardd) or {}
                target.vars = res.vars or target.vars
                target.key = res.key or target.key
                target.set = res.set or target.set
                target.scale = res.scale
                target.text_colour = res.text_colour
            end
            if desc_nodes == full_UI_table.main and not full_UI_table.name then
                full_UI_table.name = self.set == 'Enhanced' and 'temp_value' or localize { type = 'name', set = target.set, key = res.name_key or target.key, nodes = full_UI_table.name, vars = res.name_vars or target.vars or {} }
            elseif desc_nodes ~= full_UI_table.main and not desc_nodes.name and self.set ~= 'Enhanced' then
                desc_nodes.name = localize{type = 'name_text', key = res.name_key or target.key, set = target.set }
            end
            if specific_vars and specific_vars.debuffed and not res.replace_debuff then
                target = { type = 'other', key = 'debuffed_' ..
                (specific_vars.playing_card and 'playing_card' or 'default'), nodes = desc_nodes }
            end
            if res.main_start then
                desc_nodes[#desc_nodes + 1] = res.main_start
            end
            localize(target)
            if res.main_end then
                desc_nodes[#desc_nodes + 1] = res.main_end
            end
            desc_nodes.background_colour = res.background_colour
        end
    end,
})

G.PRISM.Joker({
	key = "cookie",
	atlas = "jokers",
	pos = {x=2,y=0},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = false,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		local active = G.STATE == G.STATES.SELECTING_HAND
		return {
			main_end = (center.area and center.area == G.jokers) and {{
				n = G.UIT.C,
				config = {
					align = "bm",
					minh = 0.4
				},
				nodes = {{
					n = G.UIT.C,
					config = {
						ref_table = center,
						align = "m", 
						colour = active and G.C.GREEN or G.C.RED,
						r = 0.05, 
						padding = 0.06,
					},
					nodes = {{
						n = G.UIT.T,
						config = {
							text = ' '..localize(active and 'k_active' or 'k_inactive')..' ',
							colour = G.C.UI.TEXT_LIGHT,
							scale = 0.32*0.9
						}
					}}
				}}
			}}
		}
	end,
	calculate = function(self, card, context)
		if context.selling_self and not context.blueprint then
			if G.STATE == G.STATES.SELECTING_HAND then
				G.GAME.prism_fortune_cookie = true
				for k, v in pairs(G.GAME.probabilities) do
					G.GAME.probabilities[k] = v * 9999
				end
			end
		end
    end
	
})
G.PRISM.Joker({
	key = "economics",
	atlas = "jokers",
	pos = {x=1,y=8},
	rarity = 2,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {extra = {x_mult = 1,gain = 0.1,dollars = 2}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.gain,center.ability.extra.dollars,center.ability.extra.x_mult} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				xmult = to_number(to_big(card.ability.extra.x_mult)),
			}
		end
		if context.setting_blind and not context.blueprint then
			local x_mult_gain = card.ability.extra.gain*math.floor((G.GAME.dollars + (G.GAME.dollar_buffer or 0))/card.ability.extra.dollars)
			ease_dollars(-G.GAME.dollars, true)
			if to_big(x_mult_gain) > to_big(0) then 
				card.ability.extra.x_mult = card.ability.extra.x_mult + to_number(to_big(x_mult_gain))
				return {
					focus = card,
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
					card = card,
				}
			end
		end
	end
})
G.PRISM.Joker({
	key = "patch",
	atlas = "jokers",
	pos = {x=2,y=6},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = 'tag_negative', set = 'Tag'}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local sixes = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 6 then sixes = sixes + 1 end
			end
			if sixes == 3 then
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = (function()
						add_tag(Tag('tag_negative'))
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('negative', 1.2 + math.random()*0.1, 0.4)
					return true
				end)}))
				return {
					message = localize('k_plus_negative'),
					colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
	end
})
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "elf",
	atlas = "jokers",
	pos = {x=1,y=13},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 2.5, active = false}},
	loc_vars = function(self, info_queue, center)
		local active = center.ability.extra.active
		return {
			vars = {center.ability.extra.x_mult},
			main_end = (center.area and center.area == G.jokers) and {{
				n = G.UIT.C,
				config = {
					align = "bm",
					minh = 0.4
				},
				nodes = {{
					n = G.UIT.C,
					config = {
						ref_table = center,
						align = "m", 
						colour = active and G.C.GREEN or G.C.RED,
						r = 0.05, 
						padding = 0.06,
					},
					nodes = {{
						n = G.UIT.T,
						config = {
							text = ' '..localize(active and 'k_active' or 'k_inactive')..' ',
							colour = G.C.UI.TEXT_LIGHT,
							scale = 0.32*0.9
						}
					}}
				}}
			}}
		}
	end,
	calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set  == 'Myth' and not context.blueprint and card.ability.extra.active == false then
            card.ability.extra.active = true
			return {
				colour = G.C.GREEN,
				message = localize('k_active_ex')
			}
        end
		if context.cardarea == G.jokers and context.end_of_round and not context.blueprint and card.ability.extra.active then
			card.ability.extra.active = false
			return {
				colour = G.C.RED,
				message = localize('k_inactive_ex')
			}
		end
		if context.joker_main and card.ability.extra.active then
			return {
				xmult = card.ability.extra.x_mult,
				card = card
			}
		end
    end
})

G.PRISM.Joker({
	key = "vaquero",
	atlas = "jokers",
	pos = {x=1,y=2},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {x_mult = 1.75}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_wild
		return {
		vars = {center.ability.extra.x_mult}
		}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_wild') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
            if SMODS.has_enhancement(context.other_card,'m_wild') then
                return {
                    xmult = card.ability.extra.x_mult,
                    card = card
                }
            end
        end
    end
})
G.PRISM.Joker({
	key = "hopscotch",
	atlas = "jokers",
	pos = {x=1,y=10},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {rank = 14, mult = 0,extra = 1},
	immutable = true, --For Cryptid reasons
	loc_vars = function(self, info_queue, center)
		local rank = center.ability.rank
		if rank < 11 then rank = tostring(rank)
		elseif rank == 11 then rank = 'Jack'
		elseif rank == 12 then rank = 'Queen'
		elseif rank == 13 then rank = 'King'
		elseif rank == 14 then rank = 'Ace' 
		end
		return { vars = {center.ability.extra,center.ability.mult,localize(rank, 'ranks')} }
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.mult,
			}
		end
        if context.cardarea == G.play and context.individual and not context.blueprint then
			if context.other_card:get_id() == card.ability.rank then
				card.ability.mult = card.ability.mult + card.ability.extra
				card.ability.rank = card.ability.rank == 14 and 2 or math.min(card.ability.rank + 1, 14)
				return {
					focus = card,
					colour = G.C.RED,
					message = localize('k_upgrade_ex'),
					card = card,
				}
			end
        end
    end
})
G.PRISM.Joker({
	key = "aces_high",
	atlas = "jokers",
	pos = {x=1,y=11},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue+1] = {key = 'tag_uncommon', set = 'Tag'}
		info_queue[#info_queue+1] = {key = 'tag_rare', set = 'Tag'}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local aces = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:get_id() == 14 then aces = aces + 1 end
			end
			if aces >= 1 and next(context.poker_hands["Straight"]) then
				local tag 
				local message
				local color
				if pseudorandom('aces high') < 1 / 3 then
					tag = 'tag_rare'
					message = 'k_plus_rare'
					color = G.C.RED
				else
					tag = 'tag_uncommon'
					message = 'k_plus_uncommon'
					color = G.C.GREEN
				end
				G.E_MANAGER:add_event(Event({
					trigger = 'before',
					func = (function()
						add_tag(Tag(tag))
						play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
						play_sound('holo1', 1.2 + math.random()*0.1, 0.4)
					return true
				end)}))
				return {
					message = localize(message),
					colour = color,
					card = card,
				}
			end
		end
    end
})
G.PRISM.Joker({
	key = "murano",
	atlas = "jokers",
	pos = {x=2,y=9},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {odds = 3}},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
		info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
		info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
		info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
		return { vars = {
			"" .. (G.GAME and G.GAME.probabilities.normal or 1), 
			center.ability.extra.odds
		}}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_glass') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before then
			local trigger = false
            for k, v in ipairs(context.scoring_hand) do
				if SMODS.has_enhancement(v,'m_glass') and not v.edition and not v.debuff then 
					if pseudorandom('murano') < G.GAME.probabilities.normal/card.ability.extra.odds then
						trigger = true
						local edition = poll_edition('bismuth', nil, nil, true, {
							'e_foil',
							'e_holo',
							'e_polychrome'
					    })
                        v:set_edition(edition)
						G.E_MANAGER:add_event(Event({
							func = function()
								v:juice_up()
								return true
							end
						}))
					end
				end
			end
			if trigger then
				return {
					message = localize('k_edition_ex'),
                    colour = G.C.DARK_EDITION,
					card = card,
				}
			end
		end
    end
	
})
G.PRISM.Joker({
	key = "medusa",
	atlas = "jokers",
	pos = {x=0,y=6},
	rarity = 2,
	cost = 5,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.before and not context.blueprint then
			local has_face = false
            for k, v in ipairs(context.scoring_hand) do
				if v:is_face() then 
					has_face = true
					v:set_ability(G.P_CENTERS.m_stone,nil,true)
					G.E_MANAGER:add_event(Event({
						func = function()
							v:juice_up()
							return true
						end
					}))
				end
			end
			if has_face then
				return {
					message = localize('k_stone_ex'),
					colour = HEX("D0D2D6"),
					card = card,
				}
			end
		end
    end
	
})
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "amethyst",
	atlas = "jokers",
	pos = {x=1,y=7},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	config = {x_mult = 1, extra = 0.15},
	loc_vars = function(self, info_queue, center)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_prism_crystal
		return {vars = {center.ability.x_mult,center.ability.extra}}
	end,
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_prism_crystal') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
        if context.joker_main then
			return {
				xmult = card.ability.x_mult
			}
		end
		if context.end_of_round and context.individual and context.cardarea == G.hand and not context.blueprint then
			if SMODS.has_enhancement(context.other_card,'m_prism_crystal') then
				card.ability.x_mult = card.ability.x_mult + card.ability.extra
				return {
					focus = card,
					colour = G.C.RED,
					message = localize('k_upgrade_ex'),
					card = card,
				}
			end
        end
    end
	
})
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "minstrel",
	atlas = "jokers",
	pos = {x=1,y=0},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.setting_blind and not context.blind.boss and not (context.blueprint_card or card).getting_sliced then
			G.PRISM.create_card('Myth',G.consumeables, nil, nil, nil, nil, nil, 'minst', function(new_card)
				play_sound("timpani")
				card:juice_up(0.3, 0.5)
			end)
			return {}
		end
	end
})
G.PRISM.Joker({
	key = "whale",
	atlas = "jokers",
	pos = {x=3,y=9},
	soul_pos = {x=3,y=10},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {planets = {},levels = 0}},
	loc_vars = function(self, info_queue, center)
		return {vars = {center.ability.extra.levels}}
	end,
	calculate = function(self, card, context)
		if context.using_consumeable and context.consumeable.ability.set == 'Planet' and not card.ability.extra.planets[context.consumeable.config.center_key] then
			card.ability.extra.planets[context.consumeable.config.center_key] = true
			card.ability.extra.levels = card.ability.extra.levels + 1
			return {
				card = card,
				message = localize('k_upgrade_ex')
			}
		end
		if context.cardarea == G.jokers and context.end_of_round and G.GAME.blind.boss then
			local _hand, _tally = nil, 0
			for _, v in ipairs(G.handlist) do
				if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
					_hand = v
					_tally = G.GAME.hands[v].played
				end
			end
			local levels = card.ability.extra.levels
			card.ability.extra.planets = {}
			card.ability.extra.levels = 0
			if levels > 0 then
				return {
					level_up = levels,
					level_up_hand = _hand,
					card = card
				}
			end
			return {}
		end
	end
})
--[[ G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "schrodinger",
	atlas = "jokers",
	pos = {x=2,y=12},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 0},
	in_pool = function(self)
		for k, v in pairs(G.playing_cards or {}) do
			if SMODS.has_enhancement(v,'m_prism_double') then return true end
		end
		return false
	end,
	calculate = function(self, card, context)
		if context.repetition and context.cardarea == G.play then
			if context.other_card.config.center == G.P_CENTERS.m_prism_double then
				card.ability.extra = card.ability.extra + 1
				return {
					message = localize('k_again_ex'),
                    repetitions = card.ability.extra,
					card = card
				}
		  	else
				card.ability.extra = 0
			end
		end
		if context.after and not context.blueprint then
		  	card.ability.extra = 0
		end
	end
}) ]]
G.PRISM.Joker({
	key = "promotion",
	atlas = "jokers",
	pos = {x=0,y=9},
	rarity = 2,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.first_hand_drawn and not context.blueprint then
			local eval = function() return G.GAME.current_round.hands_played == 0 end
			juice_card_until(card, eval, true)
		end
		if context.cardarea == G.jokers and context.before and not context.blueprint  then
			if #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
				local _card = context.full_hand[1]
				SMODS.change_base(_card,nil,'Queen')
				G.E_MANAGER:add_event(Event({
					func = function()
						_card:juice_up(0.3, 0.5)
						return true
					end
				}))
				return {
					message = localize('k_promoted'),
					focus = _card,
					card = card,
				}
			end
		end
	end
})
G.PRISM.Joker({
	key = "reverse_card",
	atlas = "jokers",
	pos = {x=1,y=5},
	rarity = 2,
	cost = 6,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	calculate = function(self, card, context)
		if context.joker_main and not context.before and not context.after and hand_chips and mult then
			local old_chips = hand_chips
			local old_mult = mult
			hand_chips = mod_chips(old_mult)
			mult = mod_mult(old_chips)
			update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
			return {
				message = localize("k_uno_reverse"),
				colour = G.C.RED
			}
		end
	end
})
G.PRISM.Joker({
	key = "vip_pass",
	atlas = "jokers",
	pos = {x=1,y=6},
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	
})
local orig_poll_rarity = SMODS.poll_rarity
function SMODS.poll_rarity(_pool_key, _rand_key)
	if not next(find_joker('j_prism_vip_pass')) then
		return orig_poll_rarity(_pool_key, _rand_key)
	end
	local rarity_poll = pseudorandom(pseudoseed(_rand_key or ('rarity'..G.GAME.round_resets.ante))) -- Generate the poll value
	local available_rarities = copy_table(SMODS.ObjectTypes[_pool_key].rarities) -- Table containing a list of rarities and their rates
    local vanilla_rarities = {["Common"] = 1, ["Uncommon"] = 2, ["Rare"] = 3, ["Legendary"] = 4}
	table.remove(available_rarities,1)
    -- Calculate total rates of rarities
    local total_weight = 0
    for _, v in ipairs(available_rarities) do
        v.mod = G.GAME[tostring(v.key):lower().."_mod"] or 1
        -- Should this fully override the v.weight calcs? 
        if SMODS.Rarities[v.key] and SMODS.Rarities[v.key].get_weight and type(SMODS.Rarities[v.key].get_weight) == "function" then
            v.weight = SMODS.Rarities[v.key]:get_weight(v.weight, SMODS.ObjectTypes[_pool_key])
        end
        v.weight = v.weight*v.mod
        total_weight = total_weight + v.weight
    end
    -- recalculate rarities to account for v.mod
    for _, v in ipairs(available_rarities) do
        v.weight = v.weight / total_weight
    end

	-- Calculate selected rarity
	local weight_i = 0
	for _, v in ipairs(available_rarities) do
		weight_i = weight_i + v.weight
		if rarity_poll < weight_i then
            if vanilla_rarities[v.key] then 
                return vanilla_rarities[v.key]
            else
			    return v.key
            end
		end
	end
	return nil
end
G.PRISM.Joker({
	dependency = G.PRISM.config.myth_enabled,
	key = "romantic",
	atlas = "jokers",
	pos = {x=2,y=13},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		local myth = G.GAME.last_myth and G.P_CENTERS[G.GAME.last_myth] or nil
		local last_myth = myth and localize{type = 'name_text', key = myth.key, set = myth.set} or localize('k_none')
		local colour = not myth and G.C.RED or G.C.GREEN
		return {
			main_end = {
                {n=G.UIT.C, config={align = "bm", padding = 0.02}, nodes={
                    {n=G.UIT.C, config={align = "m", colour = colour, r = 0.05, padding = 0.05}, nodes={
                        {n=G.UIT.T, config={text = ' '..last_myth..' ', colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true}},
                    }}
                }}
            }
		}
	end,
	calculate = function(self, card, context)
		if context.joker_main and not context.before and not context.after and not (context.blueprint_card or card).getting_sliced and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			local hearts = 0
			local spades = 0
			for i = 1, #context.scoring_hand do
				if context.scoring_hand[i]:is_suit("Hearts") then hearts = hearts + 1 end
				if context.scoring_hand[i]:is_suit("Spades") then spades = spades + 1 end
			end
			if hearts >= 1 and spades >= 1 and G.GAME.last_myth then
				G.PRISM.create_card('Myth',G.consumeables, nil, nil, nil, nil, G.GAME.last_myth, 'return', function(new_card)
					play_sound("timpani")
					card:juice_up(0.3, 0.5)
				end)
				return {}
			end
		end
	end
})
G.PRISM.Joker({
	key = "pie",
	atlas = "jokers",
	pos = {x=2,y=1},
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {index = 1,x_mult = 3.14}},
	loc_vars = function(self, info_queue, center)
		local rank = string.sub(G.PRISM.PI,center.ability.extra.index,center.ability.extra.index)
		if rank == "1" then rank = "Ace" end
		if rank == "0" then rank = "10" end
		return{ vars = {localize(rank,'ranks'),
		center.ability.extra.x_mult,
		string.sub(G.PRISM.PI,center.ability.extra.index + 1,center.ability.extra.index + 5)}}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
			local rank = string.sub(G.PRISM.PI,card.ability.extra.index,card.ability.extra.index)
			if rank == "1" then rank = "Ace" end
			if rank == "0" then rank = "10" end
			if context.other_card.config.card.value == rank then
				if not context.blueprint then
					card.ability.extra.index = card.ability.extra.index + 1
					if card.ability.extra.index > G.PRISM.PI:len() then card.ability.extra.index = 1 end
				end
				return {
					xmult = card.ability.extra.x_mult,
					card = card
				}
			end
        end
    end
	
})
G.PRISM.Joker({
	key = "plasma_lamp",
	atlas = "jokers",
	pos = {x=1,y=9},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {poker_hand_1 = 'High Card',poker_hand_2 = 'Three of a Kind',reset = false},
	loc_vars = function(self, info_queue, center)
		return {vars = {localize(center.ability.poker_hand_1, 'poker_hands'),localize(center.ability.poker_hand_2, 'poker_hands')}}
	end,
	set_ability = function(self, card, initial,delay_sprites)
		card.ability.reset = false
		local _poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible then _poker_hands[#_poker_hands+1] = k end
		end
		card.ability.poker_hand_1 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
		_poker_hands = {}
		for k, v in pairs(G.GAME.hands) do
			if v.visible and k ~= card.ability.poker_hand_1 then _poker_hands[#_poker_hands+1] = k end
		end
		card.ability.poker_hand_2 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and ((context.end_of_round and not context.blueprint) or (context.after and card.ability.reset)) then
			card.ability.reset = false
			local _poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.poker_hand_1 and k ~= card.ability.poker_hand_2 then _poker_hands[#_poker_hands+1] = k end
			end
			card.ability.poker_hand_1 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
			_poker_hands = {}
			for k, v in pairs(G.GAME.hands) do
				if v.visible and k ~= card.ability.poker_hand_1 and k ~= card.ability.poker_hand_2 then _poker_hands[#_poker_hands+1] = k end
			end
			card.ability.poker_hand_2 = pseudorandom_element(_poker_hands, pseudoseed('plasma'))
			return {
				message = localize('k_reset')
			}
		end
		if context.joker_main then
			if context.scoring_name == card.ability.poker_hand_1 or context.scoring_name == card.ability.poker_hand_2 then
				local tot = hand_chips + mult
				hand_chips = math.floor(tot/2)
				mult = math.floor(tot/2)
				update_hand_text({delay = 0}, {mult = mult, chips = hand_chips})
				card.ability.reset = true
				return {
					message = localize("k_balanced"),
					colour = { 0.8, 0.45, 0.85, 1 },
				}
			end
		end
	end
})
G.PRISM.Joker({
	key = "razor_blade",
	atlas = "jokers",
	pos = {x=0,y=10},
	rarity = 3,
	cost = 6,
	pixel_size = { w = 47, h = 91},
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = 1},
	loc_vars = function(self, info_queue, center)
		local x_mult = 1
		for k, v in pairs(G.GAME.prism_start_deck_ranks or {}) do
			local is_present = false
			for _k, _v in pairs(G.playing_cards or {}) do
				if not is_present and _v:get_id() == v then is_present = true end
			end
			if not is_present then
				x_mult = x_mult + center.ability.extra
			end
		end
		return {vars = {center.ability.extra, x_mult}}
	end,
	calculate = function(self, card, context)
		if context.joker_main then
			local x_mult = 1
			for k, v in pairs(G.GAME.prism_start_deck_ranks or {}) do
				local is_present = false
				for _k, _v in pairs(G.playing_cards or {}) do
					if not is_present and _v:get_id() == v then is_present = true end
				end
				if not is_present then
					x_mult = x_mult + card.ability.extra
				end
			end
			return {
				xmult = x_mult
			}
		end
	end,
})
G.PRISM.Joker({
	key = "shork",
	atlas = "jokers",
	pos = {x=2,y=4},
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	loc_vars = function(self, info_queue, center)
		local edition = G.PRISM.compat.darkside and "e_pridark_trans" or "e_polychrome"
		info_queue[#info_queue + 1] = G.P_CENTERS[edition]
	end,
})

local orig_set_edition = Card.set_edition
function Card.set_edition(self,edition, immediate, silent)
	local new_edition = edition
	if not G.GAME.prism_shork_copy and edition and not (type(edition) == "table" and next(edition) == nil) then
		if next(find_joker("j_prism_shork")) and G.PRISM.compat.darkside and edition ~= "e_pridark_trans" then
			new_edition = "e_pridark_trans"
		elseif next(find_joker("j_prism_shork")) and edition ~= {polychrome = true} then
			new_edition = {polychrome = true}
		end
	end
	orig_set_edition(self,new_edition, immediate, silent)
end
G.PRISM.Joker({
	key = "swiss",
	atlas = "jokers",
	pos = {x=2,y=14},
	rarity = 3,
	cost = 7,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {extra = {chips = 15, mult = 3, x_mult = 0.1,odds = 2}},
	loc_vars = function(self, info_queue, center)
		return {
		vars = {center.ability.extra.chips,center.ability.extra.mult,center.ability.extra.x_mult,G.GAME.probabilities.normal,center.ability.extra.odds}
		}
	end,
	calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual then
			if pseudorandom('swiss') < G.GAME.probabilities.normal / card.ability.extra.odds then
				local poll = pseudorandom('swiss_poll')
				local color = nil
				if poll < 1/3 then
					context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus or 0
					context.other_card.ability.perma_bonus = context.other_card.ability.perma_bonus + card.ability.extra.chips
					color = G.C.CHIPS
				elseif poll < 2/3 then
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
					context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
					color = G.C.MULT
				else
					context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult or 0
					context.other_card.ability.perma_x_mult = context.other_card.ability.perma_x_mult + card.ability.extra.x_mult
					color = G.C.MULT
				end
                return {
                    message = localize('k_upgrade_ex'),
					colour = color,
                    card = card
                }
			end
        end
    end
	
})
G.PRISM.Joker({
	key = "hypercube",
	atlas = "jokers",
	pos = {x=2,y=10},
	soul_pos = {x=2,y=11},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = {e_mult = 1.33},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.e_mult} }
	end,
	calculate = function(self, card, context)
        if context.joker_main then
			local hands = evaluate_poker_hand(G.hand.cards)
      		local amount = #hands["Four of a Kind"]
			if amount > 0 then
				return {
					emult = card.ability.e_mult
				}
			end
		end
	end
}) 

G.PRISM.Joker({
	key = "prism",
	atlas = "jokers",
	pos = {x=0,y=14},
	rarity = 3,
	cost = 8,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
})

local orig_is_suit = Card.is_suit
function Card.is_suit(self, suit, bypass_debuff, flush_calc)
	if next(find_joker('j_prism_prism')) then
		if not (self.debuff and not bypass_debuff) and G.PRISM.is_numbered(self) then
            return true
		end
	end
    return orig_is_suit(self, suit, bypass_debuff, flush_calc)
end

G.PRISM.Joker({
	key = "harlequin",
	atlas = "jokers",
	pos = { x = 0, y = 4 },
	soul_pos = { x = 0, y = 5 },
	rarity = 4,
	cost = 20,
	unlocked = false,
	unlock_condition = {hidden = true},
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = { bonus = 0.1, x_mult = 1,suits = {}}},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra.bonus,center.ability.extra.x_mult} }
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.jokers and context.before and not context.blueprint then
			card.ability.extra.suits = {}
		end
		if context.joker_main then
			return {
				xmult = card.ability.extra.x_mult,
			}
		end
		local upgrade = false
		if context.cardarea == G.play and context.individual and not context.blueprint then
			local suits = G.PRISM.get_suits({context.other_card})
			for k,v in pairs(suits) do
				if not card.ability.extra.suits[k] and v > 0 then
					card.ability.extra.suits[k] = true
					card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.bonus
					upgrade = true
				end
			end
			if upgrade then
				return {
					focus = card,
					message = localize({ type = "variable", key = "a_xmult", vars = { card.ability.extra.x_mult } }),
					card = card,
				}
			end
		end
	end,
	
})

G.PRISM.Joker({
	key = "rigoletto",
	atlas = "jokers",
	pos = { x = 0, y = 7 },
	soul_pos = { x = 0, y = 8 },
	rarity = 4,
	cost = 20,
	unlocked = false,
	unlock_condition = {hidden = true},
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = true,
	config = { extra = 1, hand_size = 0},
	loc_vars = function(self, info_queue, center)
		return { vars = {center.ability.extra,center.ability.hand_size} }
	end,
	remove_from_deck = function(self, card, from_debuff)
		G.hand:change_size(-card.ability.hand_size)
	end,
	calculate = function(self, card, context)
		if (context.cardarea == G.jokers and context.before) or context.discard and context.other_card == context.full_hand[1] and not context.blueprint  then
			card.ability.hand_size = card.ability.hand_size + card.ability.extra
			G.hand:change_size(card.ability.extra)
			return {
				message = localize('k_upgrade_ex'),
				card = card,
			}
		end
		if context.cardarea == G.jokers and context.end_of_round and not context.blueprint  then
			G.hand:change_size(-card.ability.hand_size)
			card.ability.hand_size = 0
			return {
				card = card,
				message = localize('k_reset')
			}
		end
	end,
})

--[[ SMODS.Joker {
	dependency = G.PRISM.compat.finity,
    key = "roseclub",
    atlas = 'crossmodjokers',
    unlocked = true,
    discovered = false,
    eternal_compat = true,
    perishable_compat = true,
    blueprint_compat = true,
    rarity = "finity_showdown",
    pos = { x = 1, y = 0 },
    cost = 10,
	soul_pos = { x = 1, y = 1 },
	calculate = function(self, card, context)
	end
} ]]