SMODS.Joker{ --Saltine Cracker
    name = "Saltine Cracker",
    key = "saltinecracker",
    config = {
        extra = {
            chips = 50,
            chip_mod = 10,
            max_chips = 100
        }
    },
    pos = {
        x = 0,
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

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'palestjade'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.chips, card.ability.extra.chip_mod, card.ability.extra.max_chips}}
    end,

    calculate = function(self, card, context)
        if context.end_of_round and context.cardarea == G.jokers and not context.blueprint and not context.repetition and not context.individual then
            if card.ability.extra.chips + (card.ability.extra.chip_mod * G.GAME.food_multiplier) >= card.ability.extra.max_chips then
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
                    message = localize('k_eaten_crumble'),
                    colour = G.C.CHIPS
                }
            else
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "chips",
                    scalar_value = "chip_mod",
                    operation = "+",
                    message_key = 'a_chips',
                    message_colour = G.C.BLUE
                })
            end
        
        elseif context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips, 
            }
        end
    end
}

SMODS.Joker{ --Chocolate Coin
    name = "Chocolate Coin",
    key = "chocolatecoin",
    config = {
        extra = {
            money = 3,
            rounds = 5,
            rounds_mod = 1
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 3,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
    if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'lumahoneyy', 'sophiedeergirl'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.money, card.ability.extra.rounds}}
    end,
    
    calc_dollar_bonus = function(self, card)
        local bonus = card.ability.extra.money
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
        end
        if bonus > 0 then return bonus end
    end,
    
    calculate = function(self, card, context)
        if context.end_of_round and not context.blueprint and not context.repetition and not context.individual then
            if G.GAME.food_multiplier == 0 then
                return {
                    message = localize('k_frozen'),
                    colour = G.C.FILTER
                }
            else
                card.ability.extra.rounds = card.ability.extra.rounds - (card.ability.extra.rounds_mod * G.GAME.food_multiplier)
                if card.ability.extra.rounds <= 0 then
                    return {
                        message = localize('k_eaten_ex'),
                        colour = G.C.FILTER
                    }
                else
                    return {
                        message = tostring(card.ability.extra.rounds),
                        colour = G.C.FILTER
                    }
                end
            end
        end
    end
}

SMODS.Joker{ --Graham Cracker
    name = "Graham Cracker",
    key = "grahamcracker",
    config = {
        extra = {
            x_mult_add = 1,
            cards_require = 20,
            cards_left = 20,
            x_mult = 1,
            x_mult_max = 6
        }
    },
    pos = {
        x = 2,
        y = 0
    },
    pools = {
        Food = true,
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'amoryax', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.x_mult_add, card.ability.extra.cards_require, card.ability.extra.cards_left, card.ability.extra.x_mult, card.ability.extra.x_mult_max}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.x_mult > 1 then
            return {
                xmult = card.ability.extra.x_mult,
            }
        elseif context.before and context.cardarea == G.jokers and not context.blueprint then
            card.ability.extra.cards_left = card.ability.extra.cards_left - (table_length(context.scoring_hand) * G.GAME.food_multiplier)
            if card.ability.extra.cards_left <= 0 then
                card.ability.extra.cards_left = card.ability.extra.cards_require
                if card.ability.extra.x_mult + (card.ability.extra.x_mult_add) >= card.ability.extra.x_mult_max then 
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
                        message = localize('k_eaten_crumble'),
                        colour = G.C.RED
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

SMODS.Joker{ --Thrifty Joker
    name = "Thrifty Joker",
    key = "thrifty_joker",
    config = {
        extra = {
            vouchers_multiply = 6,
        }
    },
    pos = {
        x = 4,
        y = 0
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'wombatcountry', 'palestjade'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.vouchers_multiply, (math.max((table_length(G.GAME.used_vouchers) - (G.GAME.starting_voucher_count or 0)), 0) * card.ability.extra.vouchers_multiply)}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and (table_length(G.GAME.used_vouchers) - (G.GAME.starting_voucher_count or 0)) > 0 then
            return {
                mult = (math.max((table_length(G.GAME.used_vouchers) - (G.GAME.starting_voucher_count or 0)), 0) * card.ability.extra.vouchers_multiply),
            }
        end
    end
}

SMODS.Joker{ --Cheese
    name = "Cheese",
    key = "cheese",
    config = {
        extra = {
            x_mult = 3,
            x_mult_remove = 1,
            x_mult_base = 3,
        }
    },
    pos = {
        x = 1,
        y = 1
    },
    pools = {
        Food = true,
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'amoryax', 'sophiedeergirl'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.x_mult, card.ability.extra.x_mult_remove, card.ability.extra.x_mult_base}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.x_mult > 1 then
            return {
                xmult = card.ability.extra.x_mult,
            }
        elseif context.after and not context.blueprint and not context.repetition and (to_big(hand_chips) * to_big(mult) + to_big(G.GAME.chips)) < to_big(G.GAME.blind.chips) then
            if card.ability.extra.x_mult - card.ability.extra.x_mult_remove * G.GAME.food_multiplier > 0 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_value = "x_mult_remove",
                    operation = "-",
                    message_key = 'a_xmult_minus',
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
        elseif context.end_of_round and context.cardarea == G.jokers and not context.blueprint and not context.repetition and not context.individual then
            card.ability.extra.x_mult = card.ability.extra.x_mult_base
            
            return {
                message = localize('k_reset'),
                colour = G.C.FILTER
            }
            
        end
    end
}

SMODS.Joker{ --Cracker Barrel
    name = "Cracker Barrel",
    key = "crackerbarrel",
    config = {
        extra = {
            creation = 1,
            jokersleft = 5,
        }
    },
    pos = {
        x = 2,
        y = 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'amoryax', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.creation, card.ability.extra.jokersleft}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind and not self.getting_sliced and not (context.blueprint_card or card).getting_sliced and #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
            local jokers_to_create = math.min(1, G.jokers.config.card_limit - (#G.jokers.cards + G.GAME.joker_buffer))
            if jokers_to_create > 0 then
                card.ability.extra.jokersleft = card.ability.extra.jokersleft - 1
            end
            G.GAME.joker_buffer = G.GAME.joker_buffer + jokers_to_create
            G.E_MANAGER:add_event(Event({
                func = function() 
                    for i = 1, jokers_to_create do
                        local card = create_card('Food', G.jokers, nil, nil, nil, nil)
                        card:add_to_deck()
                        G.jokers:emplace(card)
                        card:start_materialize()
                        G.GAME.joker_buffer = 0
                    end
                    return true
                end}))   
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_plus_joker'), colour = G.C.BLUE}) 
            if card.ability.extra.jokersleft < 1 then
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
                    message = localize('k_eaten_barrel'),
                    colour = G.C.FILTER
                }
            end
        end
    end
}

SMODS.Joker{ --Sacramental Katana
    name = "Sacramental Katana",
    key = "sacramentalkatana",
    config = {
        extra = {
            x_mult = 1,
        }
    },
    pos = {
        x = 3,
        y = 1
    },
    cost = 8,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set='Other',key='d_sacrifice'}
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'palestjade', 'sophiedeergirl'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.x_mult}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main and context.scoring_hand and card.ability.extra.x_mult > 1 then
            return {
                xmult = card.ability.extra.x_mult,
            }
        elseif context.end_of_round and not context.blueprint and G.GAME.blind.boss then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then my_pos = i; break end
            end
            if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then 
                local sliced_card = G.jokers.cards[my_pos+1]
                G.GAME.banned_keys[G.jokers.cards[my_pos+1].config.center_key] = true
                sliced_card.getting_sliced = true
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.joker_buffer = 0
                    card:juice_up(0.8, 0.8)
                    sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
                    play_sound('slice1', 0.96+math.random()*0.08)
                return true end }))
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "x_mult",
                    scalar_table = sliced_card,
                    scalar_value = "sell_cost",
                    operation = function(ref_table, ref_value, initial, scaling)
                        ref_table[ref_value] = initial + 1/4*scaling
                    end,
                    scaling_message = {
                        message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.x_mult+1/4*sliced_card.sell_cost}},
                        colour = G.C.RED,
                        no_juice = true
                    }
                })
            end
        end
    end
}

SMODS.Joker{ --Freezer
    name = "Freezer",
    key = "freezer",
    config = {
        extra = {
            multiply = 0,
        }
    },
    pos = {
        x = 4,
        y = 1
    },
    cost = 7,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {set='Other',key='d_frozen'}
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'palestjade','sophiedeergirl'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.multiply}}
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.food_multiplier = card.ability.extra.multiply
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.food_multiplier = 1
    end,
    
    calculate = function(self, card, context)
        if context.mod_probability and Cracker.is_food(context.trigger_obj) then
            return {
                numerator = 0
            }
        end
    end,
    calc_scaling = function(self, card, other_card, initial, scalar_value, args)
        local stg = card.ability.extra
        if Cracker.is_food(other_card) then
            return {
                
                override_scalar_value = {
                    value = scalar_value * 0
                },
                override_message = {
                    message = localize('k_frozen'),
                }
            }
        end
    end
}

SMODS.Joker{ --Life Support
    name = "Life Support",
    key = "lifesupport",
    config = {
        extra = {
            rounds = 3,
            active = false,
        }
    },
    pos = {
        x = 5,
        y = 1
    },
    cost = 7,
    rarity = 3,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'amoryax', 'sophiedeergirl'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.rounds}}
    end,
    
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 0 and not context.blueprint then
            local maxim = math.max(to_big(hand_chips), to_big(mult))
            hand_chips = maxim
            mult = maxim
            update_hand_text({ delay = 0 }, { mult = mult, chips = hand_chips })
            
            card_eval_status_text(card, 'extra', nil, nil, nil, {message = localize('k_maximized'), colour = { 0.8, 0.45, 0.85, 1 }, sound = 'gong', pitch = 0.94 })
            
            
            
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = (function()
                    ease_colour(G.C.UI_CHIPS, { 0.8, 0.45, 0.85, 1 })
                    ease_colour(G.C.UI_MULT, { 0.8, 0.45, 0.85, 1 })
                    ease_dollars(-G.GAME.dollars, true)
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
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        delay = 4.3,
                        func = (function()
                            ease_colour(G.C.UI_CHIPS, G.C.BLUE, 1)
                            ease_colour(G.C.UI_MULT, G.C.RED, 1)
                            return true
                        end)
                    }))
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        blockable = false,
                        blocking = false,
                        no_delete = true,
                        delay = 6.3,
                        func = (function()
                            G.C.UI_CHIPS[1], G.C.UI_CHIPS[2], G.C.UI_CHIPS[3], G.C.UI_CHIPS[4] = G.C.BLUE[1], G.C.BLUE[2], G.C.BLUE[3], G.C.BLUE[4]
                            G.C.UI_MULT[1], G.C.UI_MULT[2], G.C.UI_MULT[3], G.C.UI_MULT[4] = G.C.RED[1], G.C.RED[2], G.C.RED[3], G.C.RED[4]
                            return true
                        end)
                    }))
                    return true
                end)
            }))
        end
    end
}

SMODS.Joker{ --Curry
    name = "Curry",
    key = "curry",
    config = {
        extra = {
            mult = 15,
            mult_remove = 3,
        }
    },
    pos = {
        x = 6,
        y = 1
    },
    pools = {
        Food = true,
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = false,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'sophiedeergirl'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.mult, card.ability.extra.mult_remove}}
    end,
    
    calculate = function(self, card, context)
        if context.initial_scoring_step then
            return {
                mult = card.ability.extra.mult,
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

SMODS.Joker{ --Knife Thrower
    name = "Knife Thrower",
    key = "knifethrower",
    config = {
        extra = {
            hands = 1,
        }
    },
    pos = {
        x = 7,
        y = 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'palestjade', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.hands}}
    end,
    
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hands
        ease_hands_played(card.ability.extra.hands)
    end,
    
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.extra.hands
        ease_hands_played(-card.ability.extra.hands)
    end
}

SMODS.Joker{ --Northern Star
    name = "Northern Star",
    key = "northstar",
    config = {
        extra = {
            chips_add = 10,
            chips = 10,
        }
    },
    pos = {
        x = 8,
        y = SMODS.current_mod.config.starlo and 2 or 1
    },
    cost = 5,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        local hand, highest = G.GAME.hands["High Card"], to_big(0)
        for k, v in pairs(G.GAME.hands) do
            if v.visible and v.level > highest then
                hand = v
                highest = v.level
            end
        end
        card.ability.extra.chips = highest * card.ability.extra.chips_add
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'palestjade'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.chips_add, card.ability.extra.chips}}
    end,
    
    calculate = function(self, card, context)
        if context.level_up_hand and not context.blueprint then
            local hand, highest = G.GAME.hands["High Card"], to_big(0)
            for k, v in pairs(G.GAME.hands) do
                if v.visible and v.level > highest then
                    hand = v
                    highest = v.level
                end
            end
            card.ability.extra.chips = highest * card.ability.extra.chips_add
        elseif context.scoring_hand and context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.chips,
            }
        end
    end,
}

SMODS.Joker{ --The Dealer
    name = "The Dealer",
    key = "thedealer",
    config = {
        extra = {
            odds = 2,
        }
    },
    pos = {
        x = SMODS.current_mod.config.starlo and 1 or 9,
        y = SMODS.current_mod.config.starlo and 3 or 1
    },
    cost = 6,
    rarity = 2,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'wombatcountry', 'sophiedeergirl'}, key = 'artist_credits_cracker'} end
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'thedealer')
        return {vars = {new_numerator, new_denominator}}
    end,
    
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.repetition and not context.repetition_only and SMODS.pseudorandom_probability(card, 'thedealer', 1, card.ability.extra.odds, 'thedealer') then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card,
            }
        end
    end,
}

SMODS.Joker{ --Bomb Joker
    name = "Bomb Joker",
    key = "bomb",
    config = {
        extra = {
            rounds = 12,
        }
    },
    pos = {
        x = 0,
        y = 2
    },
    cost = 0,
    rarity = 2,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = false,
    no_collection = true,
    unlocked = true,
    discovered = true,
    atlas = 'Jokers',
    yes_pool_flag = 'bomb_enabled',

    loc_vars = function(self, info_queue, card)
        if card and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'vyletbunni', 'sophiedeergirl'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.rounds}}
    end,
    
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds <= 0 then
                G.STATE = G.STATES.GAME_OVER
                G.STATE_COMPLETE = false
                return {
                    message = localize('k_bomb_explode'),
                    colour = G.C.FILTER
                }
            else
                return {
                    message = card.ability.extra.rounds..'',
                    colour = G.C.FILTER
                }
            end
        end
    end,
}
