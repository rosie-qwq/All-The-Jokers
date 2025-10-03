NewAcoustica("j_blueprint", "c_b1999_draft")

SMODS.Consumable {
	key = 'draft',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 0, y = 0 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
	end,
	calculate = function (self, card, context)
        local base_joker = nil
        for i=1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_blueprint" then
               base_joker = G.jokers.cards[i + 1]
		    end
        end
        return SMODS.blueprint_effect(card, base_joker, context)
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_brainstorm", "c_b1999_concept")

SMODS.Consumable {
	key = 'concept',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 1, y = 0 },
	cost = 10,
	loc_vars = function(self, info_queue, card)
	end,
	calculate = function (self, card, context)
        local base_joker = nil
        for i=1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_brainstorm" then
               base_joker = G.jokers.cards[i - 1]
		    end
        end
        return SMODS.blueprint_effect(card, base_joker, context)
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_wee", "c_b1999_wsv")

SMODS.Consumable {
	key = 'wsv',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 2, y = 0 },
	cost = 10,
	config = { extra = { mult_gain = 2, mult = 0 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
	end,
	calculate = function (self, card, context)
		if next(SMODS.find_card("j_wee")) then
			if context.individual and context.cardarea == G.play and context.other_card:get_id() == 2 then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.before then
            return {
                mult = card.ability.extra.mult
            }
        end
    	end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_burnt", "c_b1999_matches")

SMODS.Consumable {
	key = 'matches',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 3, y = 0 },
	cost = 10,
	config = { extra = { x_mult_gain = 0.1, x_mult = 1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.x_mult_gain, card.ability.extra.x_mult } }
	end,
	calculate = function (self, card, context)
		if next(SMODS.find_card("j_burnt")) then
			if context.pre_discard and G.GAME.current_round.discards_used <= 0 and not context.hook then
            card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT,
                message_card = card
            }
        end
        if context.after then
            return {
                x_mult = card.ability.extra.x_mult
            }
        end
    	end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_vagabond", "c_b1999_bindle")

SMODS.Consumable {
	key = 'bindle',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 4, y = 0 },
	cost = 10,
	config = { extra = { dollars = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars } }
    end,
	calculate = function (self, card, context)
		if next(SMODS.find_card("j_vagabond")) then
			if context.end_of_round and context.main_eval and (#G.consumeables.cards < G.consumeables.config.card_limit) then
				if G.GAME.dollars <= card.ability.extra.dollars then
					SMODS.add_card { set = "Spectral" }
				end
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_baron", "c_b1999_coronet")

SMODS.Consumable {
	key = 'coronet',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 5, y = 0 },
	cost = 10,
	config = { extra = { x_mult_gain = 0.1, x_mult = 1, check = 0 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult_gain, card.ability.extra.x_mult, card.ability.extra.check } }
    end,
	calculate = function (self, card, context)
		local base_joker = nil
        for i=1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key == "j_baron" then
               base_joker = G.jokers.cards[i]
		    end
        end
		if context.other_card == base_joker and context.post_trigger then
			card.ability.extra.check = card.ability.extra.check + 1
		end
		if card.ability.extra.check == 5 then
			card.ability.extra.check = 0
			card.ability.extra.x_mult = card.ability.extra.x_mult + card.ability.extra.x_mult_gain
		end
		if card.ability.extra.check > 5 then
			card.ability.extra.check = 5
		end
		if context.after then
			return {
				x_mult = card.ability.extra.x_mult
			}
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_baseball", "c_b1999_bat")

SMODS.Consumable {
	key = 'bat',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 0, y = 1 },
	cost = 10,
	config = { extra = { odds = 2, x_mult = 1.5 } },
    loc_vars = function(self, info_queue, card)
		local n, d = SMODS.get_probability_vars(card, card.ability.extra.n, card.ability.extra.d, 'bat')
        return { vars = { card.ability.extra.x_mult, n, d } }
    end,
	calculate = function (self, card, context)
		local uncom = nil
		if next(SMODS.find_card("j_baseball")) then
			for i=1, #G.jokers.cards do
            	if G.jokers.cards[i].config.center.rarity == 2 then
               		uncom = G.jokers.cards[i]
		    	end
				if context.other_card == uncom and context.post_trigger and SMODS.pseudorandom_probability(card, 'bat', card.ability.extra.n, card.ability.extra.d, 'bat') then
					return {
						x_mult = card.ability.extra.x_mult
					}
				end
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_drivers_license", "c_b1999_fine")

SMODS.Consumable {
	key = 'fine',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 1, y = 1 },
	cost = 10,
	config = { extra = { x_mult = 1.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult } }
    end,
	calculate = function (self, card, context)
		if next(SMODS.find_card("j_drivers_license")) then
			if context.individual and context.cardarea == G.play and context.other_card.ability.effect ~= "Base" then
					return {
						x_mult = card.ability.extra.x_mult
					}
			end			
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_ancient", "c_b1999_olbap")

SMODS.Consumable {
	key = 'olbap',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 2, y = 1 },
	cost = 10,
	config = { extra = { x_mult = 3, check = 0, charge = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.check, card.ability.extra.charge, G.GAME.current_round.ancient_card.suit } }
    end,
	calculate = function (self, card, context)
		if next(SMODS.find_card("j_ancient")) then
			if context.individual and context.cardarea == G.play and context.other_card:is_suit(G.GAME.current_round.ancient_card.suit) then
				card.ability.extra.check = card.ability.extra.check + 1
			end
			if card.ability.extra.check == card.ability.extra.charge then
				card.ability.extra.check = 0
				return {
					x_mult = card.ability.extra.x_mult
				}
			end
		end
	end,
	add_to_deck = function(self, card, from_debuff)
        G.consumeables:change_size(1)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.consumeables:change_size(-1)
    end,
	can_use = function(self, card)
		return false
	end
}

NewAcoustica("j_invisible", "c_b1999_cloak")

SMODS.Consumable {
    key = 'cloak',
	set = 'acoustica',
	atlas = "acoustica",
	pos = { x = 3, y = 1 },
	cost = 10,
    calculate = function(self, card, context)
		local jokers = nil
		for i=1, #G.jokers.cards do
            if G.jokers.cards[i].config.center.key ~= "j_invisible" then
            	jokers = G.jokers.cards[i]
		    end
        end
		if context.selling_card and context.card.config.center.key == "j_invisible" then
		if jokers ~= nil then
            if #G.jokers.cards <= G.jokers.config.card_limit then
                local chosen_joker = pseudorandom_element(G.jokers.cards, 'cloak')
                    local copied_joker = copy_card(jokers, nil, nil, nil,
                        chosen_joker.edition and chosen_joker.edition.negative)
                copied_joker:add_to_deck()
                G.jokers:emplace(copied_joker)
            	return { message = localize('k_duplicated_ex') }
            else
                return { message = localize('k_no_room_ex') }
			end
		else
			return { message = localize('k_no_other_jokers') }
		end
	end
	end
}