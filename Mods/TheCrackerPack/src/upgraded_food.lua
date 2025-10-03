SMODS.Joker{ --Cybernana MK920
    name = "Cybernana MK920",
    key = "cybernana",
    config = {
        extra = {
            x_mult_add = 3,
            odds = 10000,
            x_mult = 3,
        }
    },
    pos = {
        x = 3,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    atlas = 'Jokers',
    yes_pool_flag = 'cavendish_extinct',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'sugariimari'}, key = 'artist_credits_cracker'} end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'Cybernana MK920')
        return {vars = {card.ability.extra.x_mult_add, new_numerator, new_denominator, card.ability.extra.x_mult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.x_mult > 1 then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.RED
            }
        elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if G.GAME.food_multiplier == 0 then
                return {
                    message = localize('k_frozen'),
                    colour = G.C.FILTER
                }
            else
                if SMODS.pseudorandom_probability(card, 'Cybernana MK920', 1, card.ability.extra.odds * G.GAME.food_multiplier, 'Cybernana MK920') then 
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            card.T.r = -0.2
                            card:juice_up(0.3, 0.4)
                            card.states.drag.is = true
                            card.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                                func = function()
                                        G.jokers:remove_card(card)
                                        card:remove()
                                        card = nil
                                    return true; end})) 
                            return true
                        end
                    }))
                    return {
                        message = localize('k_extinct_ex')
                    }
                else
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "x_mult",
                        scalar_value = "x_mult_add",
                        operation = "+",
                        message_key = 'a_xmult',
                        message_colour = G.C.RED
                    })
                end
            end
            
        end
    end
}

SMODS.Joker{ --Buttered Popcorn
    name = "Buttered Popcorn",
    key = "buttpopcorn",
    config = {
        extra = {
            mult = 50,
            mult_remove = 5,
        }
    },
    pos = {
        x = 5,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    yes_pool_flag = 'popcorn_eaten',
    

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'amoryax', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.mult, card.ability.extra.mult_remove}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.mult > 1 then
            return {
                message = localize{type='variable',key='a_mult',vars={card.ability.extra.mult}},
                mult_mod = card.ability.extra.mult,
                colour = G.C.RED
            }
        elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if card.ability.extra.mult - card.ability.extra.mult_remove * G.GAME.food_multiplier > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_remove",
                    operation = "-",
                    message_key = 'a_mult_minus',
                    message_colour = G.C.RED
                })
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.RED
                }
            end
        end
    end
}

SMODS.Joker{ --Sundae
    name = "Sundae",
    key = "frozencustard",
    config = {
        extra = {
            chips = 250,
            chips_remove = 5,
        }
    },
    pos = {
        x = 6,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    yes_pool_flag = 'ice_cream_eaten',
    

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.chips, card.ability.extra.chips_remove}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.chips > 0 then
            return {
                message = localize{type='variable',key='a_chips',vars={card.ability.extra.chips}},
                chip_mod = card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        elseif context.after and not context.blueprint and not context.repetition then
            if card.ability.extra.chips - (card.ability.extra.chips_remove * G.GAME.food_multiplier) > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chips_remove",
                    operation = "-",
                    message_key = 'a_chips_minus',
                    message_colour = G.C.BLUE
                })
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_melted_ex'),
                    colour = G.C.CHIPS
                }
            end
        end
    end
}

SMODS.Joker{ --Hard Seltzer
    name = "Hard Seltzer",
    key = "hardseltzer",
    config = {
        extra = {
            rounds = 10,
            rounds_remove = 1
        }
    },
    pos = {
        x = 7,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 8,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    yes_pool_flag = 'seltzer_drank',
    

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'None', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.rounds, card.ability.extra.rounds_remove}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        elseif context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.rounds = card.ability.extra.rounds - (card.ability.extra.rounds_remove * G.GAME.food_multiplier)
            if card.ability.extra.rounds <= 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_drank_ex'),
                    colour = G.C.FILTER
                }
            else
                return {
                    message = card.ability.extra.rounds..'',
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.Joker{ --Can of Beans
    name = "Can of Beans",
    key = "canofbeans",
    config = {
        extra = {
            hand_size = 5,
            rounds = 10,
            rounds_remove = 1
        }
    },
    pos = {
        x = 8,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    yes_pool_flag = 'turtle_bean_eaten',
    

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.rounds, card.ability.extra.rounds_remove, card.ability.extra.hand_size}}
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.rounds = card.ability.extra.rounds - card.ability.extra.rounds_remove * G.GAME.food_multiplier
            if card.ability.extra.rounds <= 0 then 
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            else
                return {
                    message = card.ability.extra.rounds..'',
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.Joker{ --Tsukemen
    name = "Tsukemen",
    key = "tsukemen",
    config = {
        extra = {
            x_mult = 2,
            x_mult_add = 0.1,
            x_mult_remove = 0.75,
        }
    },
    pos = {
        x = 9,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    yes_pool_flag = 'ramen_eaten',
    

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'palestjade', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_add, card.ability.extra.x_mult_remove}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.x_mult > 1 then
            return {
                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
                Xmult_mod = card.ability.extra.x_mult,
                colour = G.C.RED
            }
        elseif context.discard and not context.blueprint then
            if G.GAME.food_multiplier > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_add",
                    operation = "+",
                    scaling_message = {
                        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult_add * G.GAME.food_multiplier}},
                        colour = G.C.RED,
                        delay = 0.2
                    }
                })
            end
        elseif context.after and context.cardarea == G.jokers and not context.blueprint then
            if card.ability.extra.x_mult - card.ability.extra.x_mult_remove * G.GAME.food_multiplier >= 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_remove",
                    operation = "-",
                    scaling_message = {
                        card = card,
                        focus = card,
                        message = localize{type='variable',key='a_xmult_minus',vars={card.ability.extra.x_mult_remove * G.GAME.food_multiplier}},
                        colour = G.C.RED
                    }
                })
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.3, blockable = false,
                            func = function()
                                    G.jokers:remove_card(card)
                                    card:remove()
                                    card = nil
                                return true; end})) 
                        return true
                    end
                })) 
                return {
                    message = localize('k_eaten_ex'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}