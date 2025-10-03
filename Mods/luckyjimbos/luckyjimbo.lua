-- Welcome to Lucky Jimbos mod (very dumb) (baby's first Balatro mod - don't be surprised if the code sucks)

-- talisman compatibility dummy (so the mod doesnt crash if you dont have talisman enabled) (thank you talisman for making the life of mod devs fucking painful :3)
to_big = to_big or function (value)
    return value
end

SMODS.Atlas {
    key = "LuckyJimbo",
    path = "LuckyJimbo.png",
    px = 71,
    py = 95
}

-- JIMBOTOMY --
SMODS.Joker {
    key = 'lobotojimbo',
    unlocked = true,
    loc_txt = {
        name = "Jimbotomy",
        text = {
            "If played hand contains only",
            "{C:attention}1{} card, adds a random {C:attention}Edition{}",
            "copy to hand",
            "{C:attention}Destroys{} the original card",
            "after scoring"
        }
    },
    config = {extra = {destroy_card_flag = false}},
    loc_vars = function(self, info_queue, card)
        return {}
    end,
    rarity = 3,
    atlas = "LuckyJimbo",
    pos = { x = 1, y = 0 },
    cost = 7,
    blueprint_compat = true,
    calculate = function(self, card, context)
        
        if context.before and #context.full_hand == 1 then

            card.ability.extra.destroy_card_flag = true
            local newcard

            G.E_MANAGER:add_event(Event({
                blocking = false,
                func = function()
                    if not context.before then return false end
                    
                    newcard = copy_card(context.full_hand[1])
                    newcard:set_edition(poll_edition('lobotojimbo_edition', nil, true, true))
                    newcard:add_to_deck()
                    table.insert(G.playing_cards, newcard)
                    G.hand:emplace(newcard)
                    return true
                end
            }))
            
            return {
                message = localize('k_duplicated_ex'),
            }
        end

        if context.destroy_card then

            if card.ability.extra.destroy_card_flag then

                card.ability.extra.destroy_card_flag = false
                return {
                    remove = true
                }

            end
        end
    end
}

-- JIMBO STRIKE --
SMODS.Joker {
    key = 'jimbostrike',
    unlocked = true,
    loc_txt = {
        name = "Jimbo Strike",
        text = {
            "{C:green}#5# in #6#{} chance to apply {C:mult}+#7#{} Mult",
            "{C:green}#1# in #2#{} chance to apply {X:mult,C:white}x#3#{} Mult",
            "Odds improve by {C:green}#4#{} after every hand",
            "{C:inactive}Odds for each effect reset when triggered"
        }
    },
    config = { extra = {mult_mod = 20, xmult_mod = 5, odds = 15, secondary_odds = 5, odds_mod = 1, secondary_odds_mod = 1, reset_flag = false, reset_secondary_flag = false} },
    loc_vars = function(self, info_queue, card)
            return { 
                vars = { (G.GAME.probabilities.normal or 1) * card.ability.extra.odds_mod,
                card.ability.extra.odds, 
                card.ability.extra.xmult_mod,
                (G.GAME.probabilities.normal or 1),
                (G.GAME.probabilities.normal or 1) * card.ability.extra.secondary_odds_mod,
                card.ability.extra.secondary_odds,
                card.ability.extra.mult_mod
            } 
            }
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 2, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then

            local apply_mod = false
            local apply_xmod = false

            if to_big(pseudorandom("jimbostrike_mult")) <= to_big(((G.GAME.probabilities.normal or 1)) * to_big(card.ability.extra.secondary_odds_mod)) / to_big(card.ability.extra.secondary_odds) then
                card.ability.extra.secondary_reset_flag = true
                apply_mod = true
            end

            if to_big(pseudorandom("jimbostrike_Xmult")) <= to_big(((G.GAME.probabilities.normal or 1)) * to_big(card.ability.extra.odds_mod)) / to_big(card.ability.extra.odds) then
                card.ability.extra.reset_flag = true
                apply_xmod = true
            end

            if apply_mod or apply_xmod then

                if apply_mod then
                    SMODS.calculate_effect({message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult_mod } }, card = card, mult_mod = card.ability.extra.mult_mod }, card)
                    if not apply_xmod then
                        card.ability.extra.odds_mod = card.ability.extra.odds_mod + 1 
                    end
                end
                if apply_xmod then
                    SMODS.calculate_effect({message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult_mod } }, card = card, Xmult_mod = card.ability.extra.xmult_mod }, card)
                    if not apply_mod then
                        card.ability.extra.secondary_odds_mod = card.ability.extra.secondary_odds_mod + 1 
                    end
                end

            else

                card.ability.extra.secondary_odds_mod = card.ability.extra.secondary_odds_mod + 1 
                card.ability.extra.odds_mod = card.ability.extra.odds_mod + 1 

                return {
                    message = '+ Odds',
                    card = card
                }

            end

        elseif context.after then
            if card.ability.extra.reset_flag then
                card.ability.extra.odds_mod = 1
                card.ability.extra.reset_flag = false
                return {
                    message = 'Reset!',
                    card = card
                }
            elseif card.ability.extra.secondary_reset_flag then
                card.ability.extra.secondary_odds_mod = 1
                card.ability.extra.secondary_reset_flag = false
                return {
                    message = 'Reset!',
                    card = card
                }
            end
            
        end
    end
}

-- COMRADE JIMBO --

SMODS.Joker {
    key = 'russianjimbo',
    unlocked = true,
    loc_txt = {
        name = "Comrade Jimbo",
        text = {
            "{X:mult,C:white}x#1#{} Mult if lowest card",
            "held in hand is a {C:attention}2"
        }
    },
    config = { extra = {Xmult = 2} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.Xmult} }
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 3, y = 0 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            for i = 1, #G.hand.cards do
                if G.hand.cards[i]:get_id() == 2 and G.hand.cards[i].ability.effect ~= 'Stone Card' then
                    return
                    {
                        Xmult_mod = card.ability.extra.Xmult,
                        message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
                        card = G.hand.cards[i]
                    }
                end
            end
        end
    end
}

-- JIMBO SHUFFLE --

SMODS.Joker {
    key = 'jimboshuffle',
    unlocked = true,
    loc_txt = {
        name = "Jimbo Shuffle",
        text = {
            "When blind is selected,",
            "{C:attention}destroys{} a random Joker",
            "and creates a new Joker of",
            "{C:attention}higher Rarity{} (up to {C:mult}Rare{})",
            "{C:inactive}(Must have room)",
            "{C:inactive}Applies to all Jokers,",
            "{C:inactive}self included",
        }
    },
    rarity = 3,
    atlas = "LuckyJimbo",
    pos = { x = 4, y = 0 },
    cost = 7,
    calculate = function(self, card, context)
        if context.setting_blind and not context.repetition then
            
            local joker_to_destroy = pseudorandom_element(G.jokers.cards, pseudoseed("jimboshuffle"), nil)
            local old_rarity = joker_to_destroy.config.center.rarity
            local new_rarity = 0
            if old_rarity == 1 then new_rarity = 0.71 -- for some fucking reason when spawning jokers of a specific rarity you can't just do joker.rarity instead you gotta do bumass decimals
            elseif old_rarity >= 2 then new_rarity = 0.96 end

            print(joker_to_destroy.config.center.rarity)

            G.E_MANAGER:add_event(Event({
                blocking = false,
                func = function()
                    if not context.setting_blind then
                        return false
                    end
                    play_sound('tarot1')
                    joker_to_destroy:start_dissolve({G.C.RED}, nil, 1.6)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blocking = false,
                        func = function()
                            -- print("destroying card!")
                            G.jokers:remove_card(joker_to_destroy)
                            joker_to_destroy:remove()
                            return true
                        end
                    }))

                    local card = create_card('Joker', G.jokers, nil, new_rarity, nil, nil, nil, nil)
                    card:add_to_deck()
                    G.jokers:emplace(card)
                    card:start_materialize()

                    return true
                end
            }))     
        end
    end
}

-- JIMBOREE --

SMODS.Joker {
    key = 'jimboree',
    unlocked = true,
    loc_txt = {
        name = "Jimboree",
        text = {
            "{C:green}#1# in #2#{} chance to add a random",
            "{C:attention}Enhancement{} to each {C:attention}non-Enhanced{} card played",
            "{C:green}#1# in #3#{} chance to remove",
            "{C:attention}Enhancement{} from each {C:attention}Enhanced{} card played"
        }
    },
    config = { extra = {odds1 = 3, odds2 = 5} },
    loc_vars = function(self, info_queue, card)
        return { vars = {G.GAME.probabilities.normal, card.ability.extra.odds1, card.ability.extra.odds2} }
    end,
    rarity = 3,
    atlas = "LuckyJimbo",
    pos = { x = 0, y = 1 },
    soul_pos = {x = 0, y = 0},
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before then
            for i, c in ipairs(context.scoring_hand) do
                if not (c.config.center == G.P_CENTERS.c_base) and not c.debuff then

                    if to_big(pseudorandom('jimboree')) < to_big(G.GAME.probabilities.normal) / to_big(card.ability.extra.odds2) then
    
                        print("removing enhancement from card " .. i)

                        c:set_ability(G.P_CENTERS.c_base, nil, false)
    
                        G.E_MANAGER:add_event(Event({
                            blockable = false,
                            func = function() 
                                c:flip()
                                play_sound('card1')
                                c:juice_up(0.3, 0.3)
                                return true
                            end 
                        }))
                        
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = i * 0.1,
                            blockable = false,
                            func = function()
                                if not context.individual and not context.cardarea == G.play and not context.other_card == c then return false end
                                G.E_MANAGER:add_event(Event({
                                    blockable = false,
                                    trigger = 'after',
                                    delay = 0.35,
                                    func = function() 
                                        c:flip()
                                        play_sound('tarot2')
                                        c:juice_up(0.3, 0.3)
                                        return true 
                                    end 
                                }))
                                return true
                            end
                        }))
                    end
                
                elseif c.config.center == G.P_CENTERS.c_base then
                    
                    if to_big(pseudorandom('jimboree')) < to_big(G.GAME.probabilities.normal) / to_big(card.ability.extra.odds1) then 
    
                        local enhancement = nil
                        while not enhancement do
                            enhancement = SMODS.poll_enhancement({key = 'jimboree', guaranteed = true})
                        end
                        print("adding enhancement " .. enhancement .. " to card " .. i)
                        c:set_ability(G.P_CENTERS[enhancement], nil, false)
    
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = i * 0.1,
                            blockable = false,
                            func = function() 
                                c:flip()
                                play_sound('card1')
                                c:juice_up(0.3, 0.3)
                                return true
                            end 
                        }))

                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            delay = i * 0.1,
                            blockable = false,
                            func = function()
                                if not context.individual and not context.cardarea == G.play and not context.other_card == c then return false end
                                G.E_MANAGER:add_event(Event({
                                    blockable = false,
                                    trigger = 'after',
                                    delay = 0.35,
                                    func = function() 
                                        c:flip()
                                        play_sound('tarot2')
                                        c:juice_up(0.3, 0.3)
                                        return true 
                                    end 
                                }))
                                return true
                            end
                        }))
                    end
                end
            end
        end
    end
}

-- COOL JIMBO --

SMODS.Joker {
    key = 'cooljimbo',
    loc_txt = {
        name = 'Cool Jimbo',
        text = {
            '{C:chips}+#1#{} chips and {C:mult}+#2#{} mult',
            'for each {C:attention}Enhanced{} card played'
        }
    },
    config = { extra = {chips = 25, mult = 5} },
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.chips, card.ability.extra.mult} }
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 2, y = 1 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not (context.other_card.config.center == G.P_CENTERS.c_base) then
            return
            {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                card = card
            }
        end
    end
}

--JIMBRO--

SMODS.Joker {
    key = 'jimbro',
    loc_txt = {
        name = 'Jimbro',
        text = {
            'If played hand is',
            'level {C:attention}#1#{} or higher,',
            'gains {X:mult,C:white}x#2#{} mult per level',
            '{C:inactive}(Currently {X:mult,C:white}x#3#{C:inactive} mult)'
        }
    },
    config = { extra = {xmult = 1, xmult_mod = 0.02, min_level = 5}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.min_level, card.ability.extra.xmult_mod, card.ability.extra.xmult} }
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 3, y = 1 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if to_big(G.GAME.hands[context.scoring_name].level) >= to_big(card.ability.extra.min_level) then
                local mult_gain = G.GAME.hands[context.scoring_name].level * card.ability.extra.xmult_mod
                card.ability.extra.xmult = card.ability.extra.xmult + mult_gain
                return {
                    message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}}
                }
            end
        elseif context.joker_main and to_big(card.ability.extra.xmult) > to_big(1) then
            return {
                Xmult_mod = card.ability.extra.xmult,
                message = localize{type = 'variable', key = 'a_xmult', vars = {card.ability.extra.xmult}}
            }
        end
    end
}

-- THE TWINS --

SMODS.Joker {
    key = 'jimbotwins',
    loc_txt = {
        name = "Jimbo Twins",
        text = {
            "Retriggers joker to the left {C:attention}#1#{} time(s)",
            "When boss blind is selected, {C:attention}destroys{}",
            "{C:attention}Joker{} to the right and adds",
            "retriggers depending on its {C:attention}Rarity{}",
            "{C:inactive}(i. e. Common = +1, Uncommon = +2, etc.)"
        }
    },
    config = { extra = { retriggers = 1 } },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.retriggers}}
    end,
    rarity = 4,
    atlas = "LuckyJimbo",
    pos = { x = 5, y = 2 },
    soul_pos = { x = 6, y = 2 },
    cost = 20,
    calculate = function(self, card, context)

        local my_pos = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then my_pos = i; break end
        end

        if context.setting_blind and G.GAME.blind.boss then
            
            if my_pos and G.jokers.cards[my_pos + 1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal and not G.jokers.cards[my_pos+1].getting_sliced then
                local slice_target = G.jokers.cards[my_pos + 1]
                slice_target.getting_sliced = true
                G.E_MANAGER:add_event(Event({func = function()
                    G.GAME.joker_buffer = 0
                    card.ability.extra.retriggers = card.ability.extra.retriggers + slice_target.config.center.rarity
                    card:juice_up(0.8, 0.8)
                    slice_target:start_dissolve({HEX("57ecab")}, nil, 1.6)
                    play_sound('slice1', 0.96+math.random()*0.08)
                return true end }))
            end
        end

        if context.retrigger_joker_check == true then

            if my_pos and G.jokers.cards[my_pos - 1] and context.other_card == G.jokers.cards[my_pos - 1] then

                return {
                    message = localize('k_again_ex'),
                    repetitions = card.ability.extra.retriggers,
                    card = card
                }

            end
        end
    end
}

--NERDY JIMBO--

SMODS.Joker {
    key = 'nerdyjimbo',
    loc_txt = {
        name = "Nerdy Jimbo",
        text = {
            '{C:mult}+#1#{} Mult',
            'Amount is {C:attention}doubled{} if numeric values of',
            'scored hand add up to {C:attention}#2#',
            '{C:inactive}Number changes every round'
        }
    },
    config = { extra = {mult = 4}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.mult, G.GAME.current_round.nerd_target}}
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 4, y = 1 },
    cost = 4,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            local sum = 0
            for _, c in pairs(context.scoring_hand) do
                if not c:is_face() then
                    local val = c:get_id()

                    if val == 14 then
                        sum = sum + 1 -- ace = 1 i think
                    else
                        sum = sum + val -- hope this is compatible with that one mod with all the crazy number cards
                    end
                end
            end
            
            -- print(sum)

            if sum == G.GAME.current_round.nerd_target then
                card.ability.extra.mult = card.ability.extra.mult * 2
                return {
                    message = "Upgraded!",
                    color = G.C.MULT,
                    card = card
                }
            end

        elseif context.joker_main then
            return{
                mult_mod = card.ability.extra.mult,
                message = localize{type = 'variable', key = 'a_mult', vars = {card.ability.extra.mult}}
            }
        end
    end
}

-- DEALER JIMBO --

SMODS.Joker {
    key = 'dealerjimbo',
    loc_txt = {
        name = "Dealer Jimbo",
        text = {
            '{C:attention}+#1#{} hand size',
            'until a hand is played'
        }
    },
    config = { extra = {h_size = 5, applied = false, start_size = 8}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.h_size}}
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 0, y = 2 },
    cost = 3,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.ending_shop then
            card.ability.extra.start_size = G.hand.config.card_limit
        elseif context.setting_blind then
            G.hand:change_size((card.ability.extra.h_size))
            if not context.blueprint then
                card.ability.extra.applied = true
            end
        elseif (context.before or context.selling_self or context.destroying) and card.ability.extra.applied then
            local hand_diff = card.ability.extra.start_size - G.hand.config.card_limit
            G.hand:change_size((hand_diff))
            if not context.blueprint then
                card.ability.extra.applied = false
            end
            return {
                message = localize('k_reset')
            }
        end
    end,
    remove_from_deck = function (self, card)
        if card and card.ability.extra.applied then
            local hand_diff = card.ability.extra.start_size - G.hand.config.card_limit
            G.hand:change_size((hand_diff))
        end
    end
}

-- NEPO JIMBO --

SMODS.Joker {
    key = 'nepojimbo',
    loc_txt = {
        name = 'Nepo Jimbo',
        text = {
            'Gains {X:mult,C:white}x#1#{} Mult for',
            'every {C:attention}#2#${} {C:inactive}(#4#){} spent in shop',
            '{C:inactive}(Currently {X:mult,C:white}x#3#{C:inactive} mult)'
        }
    },
    config = { extra = {xmult = 1, xmult_mod = 0.1, money_req = 4, money_count = 0, money_req_increase = 1}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.xmult_mod, card.ability.extra.money_req, card.ability.extra.xmult, card.ability.extra.money_count}}
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 1, y = 1 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)

        if (context.lj_easedollars and to_big(context.lj_easedollars) < to_big(0)) and not context.blueprint then -- and G.shop

            card.ability.extra.money_count = to_big(card.ability.extra.money_count) - to_big(context.lj_easedollars)

            if to_big(card.ability.extra.money_count) >= to_big(card.ability.extra.money_req) then

                while to_big(card.ability.extra.money_count) >= to_big(card.ability.extra.money_req) do
                    card.ability.extra.money_count = card.ability.extra.money_count - card.ability.extra.money_req
                    card.ability.extra.money_req = card.ability.extra.money_req + card.ability.extra.money_req_increase
                    card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                end
    
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    card = card
                }
    
            end

        elseif context.joker_main and to_big(card.ability.extra.xmult) > to_big(1) then

            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                Xmult_mod = card.ability.extra.xmult
            }

        end
    end
}

-- JIMBO RIPPER --

SMODS.Joker {
    key = 'jimboripper',
    loc_txt = {
        name = 'Jimbo the Ripper',
        text = {
            '{C:attention}Destroys{} all scoring cards',
            'on first played hand',
            'Gain {C:attention}#1#${} per card destroyed'
        }
    },
    config = { extra = {dollars = 2}},
    loc_vars = function(self, info_queue, card)
        return { vars = {card.ability.extra.dollars}}
    end,
    rarity = 3,
    atlas = "LuckyJimbo",
    pos = { x = 1, y = 2 },
    cost = 4,
    blueprint_compat = false,
    calculate = function(self, card, context)
        if context.first_hand_drawn then

            local eval = function() return G.GAME.current_round.hands_played == 0 end
            juice_card_until(card, eval, true)

        elseif G.GAME.current_round.hands_played == 0 and context.destroy_card and context.cardarea == G.play and not context.blueprint and not context.repetition then

            return {
                remove = true,
                dollars = card.ability.extra.dollars
            }
            
        end
    end
}

-- JIMBO SWITCH -- *I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU I HATE YOU 

J_switch = { -- utils

    change_direction = function(card, context)
                    
        card.ability.extra.isLeft = not card.ability.extra.isLeft
    
        --switch & set correct sprite
        if card.ability.extra.isLeft and card.ability.extra.left_joker then
            print("SWITCHY - switching to " .. card.ability.extra.left_joker.ability.name)
            card.ability.extra.active_joker = card.ability.extra.left_joker
            G.E_MANAGER:add_event(Event({
                func = function() 
                    if not context.cardarea == G.jokers then return false end
                    card.children.center:set_sprite_pos({ x = 5, y = 0 })
                    card.children.floating_sprite:set_sprite_pos({ x = 6, y = 0 })
                    return true
                end
            }))
        elseif not card.ability.extra.isLeft and card.ability.extra.right_joker then
            print("SWITCHY - switching to " .. card.ability.extra.right_joker.ability.name)
            card.ability.extra.active_joker = card.ability.extra.right_joker
            G.E_MANAGER:add_event(Event({
                func = function() 
                    if not context.cardarea == G.jokers then return false end
                    card.children.center:set_sprite_pos({ x = 5, y = 1 })
                    card.children.floating_sprite:set_sprite_pos({ x = 6, y = 1 })
                    return true
                end
            }))
        end
    end,
    
    get_jokers = function(card)

        local joker_id = 0

        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then 
                joker_id = i
                break
            end
        end
    
        return G.jokers.cards[joker_id - 1], G.jokers.cards[joker_id + 1]
        
    end
    
}

SMODS.Joker {
    key = 'jimboswitch',
    loc_txt = {
        name = "Jimbo Switch",
        text = {
            "Copies ability of",
            "{C:attention}Joker{} to the {V:1}#1#{}",
            "Direction {C:attention}changes{} after",
            "all {C:attention}cards{} are scored and",
            "after all {C:attention}effects{} are scored"
        }
    },
    config = { extra = { isLeft = true, last_card_scored = false, left_joker = nil, right_joker = nil, active_joker = nil } },
    loc_vars = function(self, info_queue, card)
        if card.ability.extra.isLeft then
            return { vars = { "left", colours = {G.C.BLUE} } }
        else
            return { vars = { "right", colours = {G.C.RED} } }
        end
    end,
    rarity = 3,
    atlas = "LuckyJimbo",
    pos = { x = 5, y = 0 },
    soul_pos = { x = 6, y = 0 },
    cost = 8,
    blueprint_compat = true,
    calculate = function(self, card, context)

        if context.individual and context.cardarea == G.play then
            if context.other_card and context.other_card == context.scoring_hand[#context.scoring_hand] then
                card.ability.extra.last_card_scored = true
            end
        end
        
        if ((card.ability.extra.last_card_scored and (context.cardarea == G.hand)) or (context.after and context.cardarea == G.jokers)) and not context.blueprint then

            card.ability.extra.last_card_scored = false
            J_switch.change_direction(card, context)
            SMODS.calculate_effect({ message = 'Switch!' }, card)

        end

        if card.ability.extra.active_joker then
            local ret = SMODS.blueprint_effect(card, card.ability.extra.active_joker, context)
            if ret then return ret end
        end
        
    end,

    update = function (self, card, dt)
        
        if G.jokers then
            card.ability.extra.left_joker, card.ability.extra.right_joker = J_switch.get_jokers(card)
        end

        if card.ability.extra.isLeft then
            card.ability.extra.active_joker = card.ability.extra.left_joker
        else
            card.ability.extra.active_joker = card.ability.extra.right_joker
        end
    end,

    set_sprites = function(self, card, front)
        if card.ability and card.ability.extra then
            if card.ability.extra.isLeft then
                card.children.center:set_sprite_pos({ x = 5, y = 0 })
                card.children.floating_sprite:set_sprite_pos({ x = 6, y = 0 })
            else
                card.children.center:set_sprite_pos({ x = 5, y = 1 })
                card.children.floating_sprite:set_sprite_pos({ x = 6, y = 1 })
            end
        else
            card.children.center:set_sprite_pos({ x = 5, y = 0 })
            card.children.floating_sprite:set_sprite_pos({ x = 6, y = 0 })
        end
    end
}

-- HIMBO --

SMODS.Joker {
    key = 'himbo',
    unlocked = true,
    loc_txt = {
        name = "Himbo",
        text = {
            "{X:mult,C:white}x#1#{} Mult for every",
            "{C:attention}King{} in deck above {C:attention}#2#{}",
            "{C:inactive}(Currently{} {X:mult,C:white}x#4#{}{C:inactive} Mult)"
        }
    },
    config = { extra = { xmult_mod = 0.25, threshold = 4, current_count = 0, xmult = 1 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_mod, card.ability.extra.threshold, card.ability.extra.current_count, card.ability.extra.xmult} }
    end,
    rarity = 2,
    atlas = "LuckyJimbo",
    pos = { x = 2, y = 2 },
    cost = 5,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.joker_main then
            if to_big(card.ability.extra.xmult) > to_big(1) then
                return {
                    Xmult_mod = card.ability.extra.xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end
    end,

    update = function(self, card, dt)
        if G.playing_cards then
            card.ability.extra.current_count = 0
            for k, v in pairs(G.playing_cards) do
                if v:get_id() == 13 then card.ability.extra.current_count = to_big(card.ability.extra.current_count) + to_big(1) end
            end
            if card.ability.extra.threshold then
                card.ability.extra.xmult = to_big(1) + ((to_big(card.ability.extra.current_count) - to_big(card.ability.extra.threshold)) * to_big(card.ability.extra.xmult_mod))
                if to_big(card.ability.extra.xmult) < to_big(1) then card.ability.extra.xmult = to_big(1) end
            end
        end
    end
}

-- GROUPIE JIMBO --

SMODS.Joker {
    key = 'groupiejimbo',
    unlocked = true,
    loc_txt = {
        name = "Groupie Jimbo",
        text = {
            "{C:attention}Aces{} of {V:1}Spades{} held in hand",
            "give {X:mult,C:white}x#1#{} Mult",
            "Increases by {X:mult,C:white}x#2#{} Mult for every",
            "{C:attention}Ace{} of {V:1}Spades{} scored this round",
            "{C:inactive}Resets at end of round"
        }
    },
    config = { extra = { xmult = 1.25, xmult_mod = 0.25, start_xmult = 1.25 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.xmult_mod, colours = {G.C.SUITS['Spades']}} }
    end,
    rarity = 3,
    atlas = "LuckyJimbo",
    pos = { x = 3, y = 2 },
    cost = 6,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.individual and not context.end_of_round and context.other_card:get_id() == 14 and context.other_card:is_suit('Spades') then
            if context.cardarea == G.play and not context.blueprint then
                card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_mod
                return {
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } },
                    card = card
                }
            elseif context.cardarea == G.hand then
                return {
                    Xmult_mod = card.ability.extra.xmult,
                    message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.xmult } }
                }
            end
        end

        if context.end_of_round and not context.individual and not context.blueprint and not context.repetition then
            card.ability.extra.xmult = card.ability.extra.start_xmult
            return {
                message = localize('k_reset')
            }
        end

    end
}

-- SETUP FUNCS / HOOKS --

-- game init hook
local igo = Game.init_game_object
function Game:init_game_object()
    local ret = igo(self)
    ret.current_round.nerd_target = 50
    return ret
end

-- easedollars context hook
local ed = ease_dollars
function ease_dollars(mod, x)
    ed(mod, x)
    local effects
    SMODS.calculate_context({lj_easedollars = mod}, effects)
end

function SMODS.current_mod.reset_game_globals(run_start)
    G.GAME.current_round.nerd_target = math.floor(2 + (pseudorandom('nerdyjimbo') * 48)) -- random number between 2 and 50
end

SMODS.current_mod.optional_features = { retrigger_joker = true } -- this one line makes the twins work

-- JOKER TEMPLATE -- 

-- SMODS.Joker {
--     key = 'jimbo',
--     unlocked = true,
--     loc_txt = {
--         name = "Jimbo",
--         text = {
--             "desc"
--         }
--     },
--     config = { extra = { } },
--     loc_vars = function(self, info_queue, card)
--         return { vars = { } }
--     end,
--     rarity = 2,
--     atlas = "LuckyJimbo",
--     pos = { x = 0, y = 0 },
--     cost = 5,
--     blueprint_compat = true,
--     calculate = function(self, card, context)
--
--     end
-- }

-- SCRAPYARD --


-- -- VEGAS JIMBO --

-- reason for scrap: this was my first ever joker, the mechanic is kind of niche and useless, doesn't exactly fit vanilla, and the card art is ugly as hell. just not really worth my time lol

-- SMODS.Joker {
--     key = 'jimbovegas',
--     unlocked = true,
--     loc_txt = {
--         name = "Jimbo in Vegas",
--         text = {
--             "Gains {X:chips,C:white}x#2#{} Chips for",
--             "every {C:attention}Straight Flush{} played",
--             "{C:inactive}(Currently {X:chips,C:white}x#1#{C:inactive} Chips)"
--         }
--     },
--     config = { extra = { xchips = 1, xchips_gain = 0.5, current_chip_gain = 0 } },
--     loc_vars = function(self, info_queue, card)
--         return { vars = {card.ability.extra.xchips, card.ability.extra.xchips_gain} }
--     end,
--     rarity = 2,
--     atlas = "LuckyJimbo",
--     pos = { x = 0, y = 0 },
--     cost = 5,
--     blueprint_compat = true,
--     calculate = function(self, card, context)
--         if context.before and next(context.poker_hands['Straight Flush']) and not context.blueprint then
--             card.ability.extra.xchips = card.ability.extra.xchips + card.ability.extra.xchips_gain
--             return {
--                 message = 'x'..card.ability.extra.xchips,
--                 colour = G.C.CHIPS,
--                 card = card
--             }
--         elseif context.joker_main then
--             card.ability.extra.current_chip_gain = hand_chips * (card.ability.extra.xchips - 1)
--             return {
--                 chip_mod = card.ability.extra.current_chip_gain,
--                 message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.current_chip_gain } }
--             }
--         end
--     end
-- }


-- -- JIMBROKER --

-- reason for scrap: made a better legendary, wanted to keep only 1 legendary per 15 jokers. might consider doing something in this vein in the future, probably much more fleshed out
-- (idea: x1 money at the end of round, adds x0.25 for every gold card destroyed)
-- update: nepo jimbo is the spiritual successor of this

-- SMODS.Joker {
--     key = 'jimbroker',
--     loc_txt = {
--         name = "Jimbroker",
--         text = {
--             "When playing a {C:attention}gold card{},",
--             "{C:green}#1# in #2#{} chance of doubling your money",
--             "If unsuccessful,",
--             "{C:green}#1# in #3#{} chance of halving your money"
--         }
--     },
--     config = { extra = {odds = 2, sec_odds = 2} },
--     loc_vars = function(self, info_queue, card)
--         return { vars = {G.GAME.probabilities.normal, card.ability.extra.odds, card.ability.extra.sec_odds} }
--     end,
--     rarity = 4,
--     atlas = "LuckyJimbo",
--     pos = { x = 1, y = 1 },
--     cost = 15,
--     calculate = function(self, card, context)
--         if context.individual and context.cardarea == G.play then
--             if context.other_card.ability.name == 'Gold Card' then
--                 if pseudorandom('jimbroker') < G.GAME.probabilities.normal / card.ability.extra.odds then
--                     return 
--                     {
--                         dollars = G.GAME.dollars,
--                         card = card
--                     }
--                 else
--                     if pseudorandom('jimbroker') < G.GAME.probabilities.normal / card.ability.extra.sec_odds then
--                         return 
--                         {
--                             dollars = -G.GAME.dollars/2,
--                             card = card
--                         }
--                     end
--                 end
--             end
--         end
--     end
-- }
