SMODS.Atlas {
    key = 'Jokers',
    path = 'Jokers.png',
    px = 71,
    py = 95
}
SMODS.Atlas {
    key = 'Tarots',
    path = 'Tarots.png',
    px = 71,
    py = 95
}

SMODS.Joker {
    key = 'balloony',
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 0 },
    config = { extra = {
        is_contestant = true,
        mult = 8
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'cake',
    atlas = 'Jokers',
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 0 },
    config = { extra = {
        is_contestant = true,
        chips = 50
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS
            }
        end
    end
}
SMODS.Joker {
    key = 'winner',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 0 },
    config = { extra = {
        is_contestant = true,
        Xmult = 3
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_sevens = true
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:get_id() ~= 7 then
                    all_sevens = false
                    break
                end
            end
            if all_sevens then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'bottle',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 0 },
    config = { extra = {
        is_contestant = true,
        chips = 0, chip_mod = 25, mult = 0, mult_mod = 5
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
        return { vars = { card.ability.extra.chip_mod, card.ability.extra.chips, card.ability.extra.mult_mod, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint and not context.retrigger_joker then
            local glass_cards = 0
            for _, removed_card in ipairs(context.removed) do
                if removed_card.shattered then glass_cards = glass_cards + 1 end
            end
            if glass_cards > 0 then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.E_MANAGER:add_event(Event({
                                    func = function()
                                        card.ability.extra.chips = card.ability.extra.chips +
                                            card.ability.extra.chip_mod * glass_cards
                                        card.ability.extra.mult = card.ability.extra.mult +
                                            card.ability.extra.mult_mod * glass_cards
                                        return true
                                    end
                                }))
                                SMODS.calculate_effect(
                                    {
                                        message = 'Upgrade!'
                                    }, card)
                                return true
                            end
                        }))
                    end
                }
            end
        end
        if context.using_consumeable and not context.blueprint and not context.retrigger_joker and context.consumeable.config.center.key == 'c_hanged_man' then
            local glass_cards = 0
            for _, removed_card in ipairs(G.hand.highlighted) do
                if SMODS.has_enhancement(removed_card, 'm_glass') then glass_cards = glass_cards + 1 end
            end
            if glass_cards > 0 then
                card.ability.extra.chips = card.ability.extra.chips +
                    card.ability.extra.chip_mod * glass_cards
                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { card.ability.extra.chips } }
                }
            end
            if glass_cards > 0 then
                card.ability.extra.mult = card.ability.extra.mult +
                    card.ability.extra.mult_mod * glass_cards
                return {
                    message = localize { type = 'variable', key = 'a_mult', vars = { card.ability.extra.mult } }
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'pillow',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 5 },
    config = { extra = {
        is_contestant = true,
        chips = 0
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and not context.retrigger_joker then
            local my_pos = nil
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] == card then
                    my_pos = i
                    break
                end
            end
            if my_pos and G.jokers.cards[my_pos + 1] and not G.jokers.cards[my_pos + 1].ability.eternal and not G.jokers.cards[my_pos + 1].getting_sliced then
                local sliced_card = G.jokers.cards[my_pos + 1]
                for i, isjokercake in ipairs(G.jokers.cards) do
                    if G.jokers.cards[i].config.center.loc_txt ~= nil then
                        if G.jokers.cards[i].config.center.loc_txt.name == 'Cake' then
                            sliced_card = G.jokers.cards[i]
                            break
                        end
                    end
                end
                sliced_card.getting_sliced = true -- Make sure to do this on destruction effects
                G.GAME.joker_buffer = G.GAME.joker_buffer - 1

                local earned_chips = nil
                if sliced_card.config.center.rarity == 1 or sliced_card.config.center.rarity == "Common" then
                    earned_chips = 20
                end
                if G.jokers.cards[my_pos + 1].config.center.rarity == 2 or G.jokers.cards[my_pos + 1].config.center.rarity == "Uncommon" then
                    earned_chips = 40
                end
                if G.jokers.cards[my_pos + 1].config.center.rarity == 3 or G.jokers.cards[my_pos + 1].config.center.rarity == "Rare" then
                    earned_chips = 100
                end
                if G.jokers.cards[my_pos + 1].config.center.rarity == 4 or G.jokers.cards[my_pos + 1].config.center.rarity == "Legendary" then
                    earned_chips = 1000
                end

                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.joker_buffer = 0
                        card.ability.extra.chips = card.ability.extra.chips + earned_chips
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
                        play_sound('slice1', 0.96 + math.random() * 0.08)
                        return true
                    end
                }))
                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { earned_chips .. '' } },
                    colour = G.C.CHIPS,
                    no_juice = true
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker {
    key = 'lollipop',
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 0 },
    config = { extra = {
        is_contestant = true,
        dollars = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, localize('Spades', 'suits_plural'), localize('Clubs', 'suits_plural'), localize('Hearts', 'suits_plural'), localize('Diamonds', 'suits_plural') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local unique_suits = 0
            local num_hearts = 0
            local num_clubs = 0
            local num_spades = 0
            local num_diamonds = 0
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_suit('Clubs') then
                    num_clubs = num_clubs + 1
                end
                if playing_card:is_suit('Spades') then
                    num_spades = num_spades + 1
                end
                if playing_card:is_suit('Diamonds') then
                    num_diamonds = num_diamonds + 1
                end
                if playing_card:is_suit('Hearts') then
                    num_hearts = num_hearts + 1
                end
            end
            if num_hearts > 0 then
                unique_suits = unique_suits + 1
            end
            if num_diamonds > 0 then
                unique_suits = unique_suits + 1
            end
            if num_clubs > 0 then
                unique_suits = unique_suits + 1
            end
            if num_spades > 0 then
                unique_suits = unique_suits + 1
            end
            if unique_suits > 1 then
                return {
                    dollars = card.ability.extra.dollars
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'taco',
    atlas = 'Jokers',
    rarity = 1,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 5 },
    config = { extra = {
        is_contestant = true,
        chip_mod = 50, mult_mod = 10
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                G.jokers and
                math.max(0,
                    ((G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_BfJ_taco"))) * card.ability.extra.chip_mod) +
                    (#SMODS.find_card("j_stencil", true)) * card.ability.extra.chip_mod) or 0,
                G.jokers and
                math.max(0,
                    ((G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_BfJ_taco"))) * card.ability.extra.mult_mod) +
                    (#SMODS.find_card("j_stencil", true)) * card.ability.extra.mult_mod) or 0,
                card.ability.extra.chip_mod,
                card.ability.extra.mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = math.max(0,
                    ((G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_BfJ_taco"))) * 50) +
                    (#SMODS.find_card("j_stencil", true)) * card.ability.extra.chip_mod) or 0,
                mult = math.max(0,
                    ((G.jokers.config.card_limit - (#G.jokers.cards - #SMODS.find_card("j_BfJ_taco"))) * 10) +
                    (#SMODS.find_card("j_stencil", true)) * card.ability.extra.mult_mod) or 0,
            }
        end
    end
}
SMODS.Joker {
    key = 'grassy',
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 7, y = 0 },
    config = { extra = {
        is_contestant = true,
        mult = 15, chips = 50, Xmult = 3, type = 'High Card'
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.Xmult, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.type then
            local grassy_num = math.random(1, 3)
            if grassy_num == 1 then
                return {
                    mult = card.ability.extra.mult
                }
            end
            if grassy_num == 2 then
                return {
                    chips = card.ability.extra.chips
                }
            end
            if grassy_num == 3 then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'eggy',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 8, y = 0 },
    config = { extra = {
        is_contestant = true,
        dollars = 3, price = 2, odds = 6
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.price, (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if pseudorandom('BfJ_eggy') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Cracked!'
                }
            else
                for i = 1, #G.jokers.cards do
                    if G.jokers.cards[i] == card then
                        left_joker = G.jokers.cards[i - 1]
                        right_joker = G.jokers.cards[i + 1]
                    end
                end
                if left_joker ~= nil then
                    left_joker.ability.extra_value = left_joker.ability.extra_value + card.ability.extra.price
                end
                if right_joker ~= nil then
                    right_joker.ability.extra_value = right_joker.ability.extra_value + card.ability.extra.price
                end
                if left_joker ~= nil then
                    left_joker:set_cost()
                end
                if right_joker ~= nil then
                    right_joker:set_cost()
                end
                if left_joker ~= nil or right_joker ~= nil then
                    return {
                        message = localize('k_val_up'),
                        colour = G.C.MONEY
                    }
                end
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.extra.dollars
    end
}
SMODS.Joker {
    key = 'eightball',
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 9, y = 0 },
    config = { extra = {
        is_contestant = true,
        chips = 8, mult = 8
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult }, { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if self.debuff then return nil end
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 8 then
            return {
                card = card,
                chip_mod = card.ability.extra.chips,
                message = '+' .. card.ability.extra.chips,
                colour = G.C.CHIPS,
                card = card,
                mult = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult,
                colour = G.C.MULT
            }
        end
    end
}
SMODS.Joker {
    key = 'foldy',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 1 },
    config = { extra = {
        is_contestant = true,
        mult = 3, key = 'c_base'
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'c_base') then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'clock',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 1 },
    config = { extra = {
        is_contestant = true,
        hands = 0, hands_mod = 1
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands, card.ability.extra.hands_mod, card.ability.extra.hands == 1 and "" or "s" } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.hands = card.ability.extra.hands + card.ability.extra.hands_mod
            return {
                message = '+1 Hand',
                colour = G.C.CHIPS
            }
        end
        if context.setting_blind and G.GAME.blind.boss then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_hands_played(card.ability.extra.hands)
                            SMODS.calculate_effect(
                                { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
                                card)
                            return true
                        end
                    }))
                end
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.hands = 0
            return {
                message = 'Reset!'
            }
        end
    end
}
SMODS.Joker {
    key = 'barfbag',
    atlas = 'Jokers',
    rarity = 1,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 1 },
    config = { extra = {
        is_contestant = true,
        d_size = 0, d_size_mod = 1
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.d_size, card.ability.extra.d_size_mod, card.ability.extra.d_size == 1 and "" or "s" } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size
        ease_discard(card.ability.extra.d_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size
        ease_discard(-card.ability.extra.d_size)
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.retrigger_joker and not context.blueprint then
            if G.GAME.current_round.discards_used >= 1 then
                card.ability.extra.d_size = card.ability.extra.d_size - card.ability.extra.d_size_mod
                G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.extra.d_size_mod
                return {
                    message = localize { type = 'variable', key = card.ability.extra.d_size_mod == 1 and 's_discard' or 's_discards', vars = { card.ability.extra.d_size_mod } },
                    colour =
                        G.C.RED
                }
            else
                card.ability.extra.d_size = card.ability.extra.d_size + card.ability.extra.d_size_mod
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.extra.d_size_mod
                return {
                    message = localize { type = 'variable', key = card.ability.extra.d_size_mod == 1 and 'a_discard' or 'a_discards', vars = { card.ability.extra.d_size_mod } },
                    colour =
                        G.C.RED
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'fanny',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 1 },
    config = { extra = {
        is_contestant = true,
    } },
    calculate = function(self, card, context)
        if context.before and context.main_eval then
            local most_played = true
            local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
            for k, v in pairs(G.GAME.hands) do
                if k ~= context.scoring_name and v.played >= play_more_than and v.visible then
                    most_played = false
                    break
                end
            end
            if not most_played then
                return {
                    level_up = true,
                    message = localize('k_level_up_ex')
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'pie',
    atlas = 'Jokers',
    rarity = 1,
    cost = 2,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 8, y = 4 },
    config = { extra = {
        is_contestant = true,
        mult = 3.14, type = 'Flush', suit = 'Clubs', dollars = 10
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars, localize(card.ability.extra.suit, 'suits_plural'), localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local all_clubs = true
            for _, playing_card in ipairs(context.scoring_hand) do
                if not playing_card:is_suit('Clubs', nil, true) then
                    all_clubs = false
                    break
                end
            end
            if all_clubs and context.scoring_name == card.ability.extra.type then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    dollars = card.ability.extra.dollars,
                    message = 'Extinct!'
                }
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'gaty',
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 1 },
    config = { extra = {
        is_contestant = true,
        mult_mod = 1, mult = 0
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_mod, localize('Pair', 'poker_hands'), card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker and (next(context.poker_hands['Pair']) or next(context.poker_hands['Two Pair']) or next(context.poker_hands['Full House']) or next(context.poker_hands['Three of a Kind']) or next(context.poker_hands['Four of a Kind']) or next(context.poker_hands['Five of a Kind'])) then
            card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.RED
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'robotflower',
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 6, y = 1 },
    config = { extra = { is_contestant = true, max = 2.5, min = 0.5, bfj_mechanical_mind = true } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local min10 = card.ability.extra.min * 10
            local max10 = card.ability.extra.max * 10
            local randomInt = pseudorandom('BfJ_robotflower', math.floor(min10), math.floor(max10))
            return { x_chips = randomInt / 10 }
        end
    end
}
SMODS.Joker {
    key = 'bracelety',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 7, y = 1 },
    config = { extra = {
        is_contestant = true,
        mult = 12, Xmult = 4, type = 'Three of a Kind'
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, localize(card.ability.extra.type, 'poker_hands'), card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.type]) then
            local has_icy = false
            for i, isjokericy in ipairs(G.jokers.cards) do
                if isjokericy.config.center.loc_txt ~= nil then
                    if isjokericy.config.center.loc_txt.name == 'Ice Cube' then
                        has_icy = true
                        break
                    end
                end
            end
            if has_icy then
                return {
                    mult = card.ability.extra.mult,
                    Xmult = card.ability.extra.Xmult
                }
            else
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'cloudy',
    atlas = 'Jokers',
    rarity = 1,
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 8, y = 1 },
    config = { extra = {
        is_contestant = true,
        dollars = 1
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.dollars * math.floor((G.playing_cards and (#G.playing_cards - G.GAME.starting_deck_size) or 0) / 2), G.GAME.starting_deck_size } }
    end,
    calc_dollar_bonus = function(self, card)
        if #G.playing_cards - G.GAME.starting_deck_size ~= 0 then
            return card.ability.extra.dollars * math.floor((#G.playing_cards - G.GAME.starting_deck_size) / 2)
        end
    end
}
SMODS.Joker {
    key = 'saw',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 9, y = 1 },
    config = { extra = {
        is_contestant = true
    } },
    calculate = function(self, card, context)
        if context.selling_self and not context.retrigger_joker and not context.blueprint then
            if G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.boss then
                G.GAME.blind.chips = G.GAME.blind.chips / 2
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                G.GAME.blind:wiggle()
            end
        end
    end
}
SMODS.Joker {
    key = 'blackhole',
    atlas = 'Jokers',
    rarity = 1,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 4 },
    config = { extra = {
        is_contestant = true
    } },
    add_to_deck = function(self, card, from_debuff)
        G.GAME.backupprobabilities = {}
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.backupprobabilities[k] = G.GAME.probabilities[k]
            G.GAME.probabilities[k] = v * 0
        end
    end,
    remove_from_deck = function(self, card, from_debuff)
        for k, v in pairs(G.GAME.probabilities) do
            G.GAME.probabilities[k] = G.GAME.probabilities[k] + G.GAME.backupprobabilities[k]
        end
    end
}
SMODS.Joker {
    key = 'roboty',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 2 },
    config = { extra = {
        is_contestant = true,
        repetitions = 1,
        bfj_mechanical_mind = true
    }
    },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if context.other_card:get_id() == 10 then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'remote',
    atlas = 'Jokers',
    rarity = 1,
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 4 },
    config = { extra = {
        is_contestant = true,
    } },
    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card and context.other_card.ability and context.other_card.ability.extra and context.other_card.ability.extra.bfj_mechanical_mind then
            return { repetitions = 1 }
        end
    end
}
SMODS.Joker {
    key = 'marker',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 4 },
    config = { extra = {
        is_contestant = true,
        hands_remaining = 3
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.hands_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.retrigger_joker and not context.blueprint then
            card.ability.extra.hands_remaining = card.ability.extra.hands_remaining - 1
            if card.ability.extra.hands_remaining == 0 then
                local thingies = {}
                for _, _card in ipairs(context.full_hand) do
                    if _card:is_suit('Hearts') or _card:is_suit('Diamonds') or _card:is_suit('Clubs') or _card:is_suit('Spades') then
                        thingies[#thingies + 1] = _card
                        _card:change_suit('Spades', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                _card:juice_up()
                                return true
                            end
                        }))
                    end
                end
                if #thingies > 0 then
                    card.ability.extra.hands_remaining = 3
                    return {
                        message = 'Marked!',
                        colour = G.C.PURPLE
                    }
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'basketball',
    atlas = 'Jokers',
    rarity = 1,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 7, y = 5 },
    config = { extra = { is_contestant = true, dollars = 0, increase = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.increase } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint and not context.retrigger_joker then
            local _planet, _hand, _tally = nil, nil, 0
            for k, v in ipairs(G.handlist) do
                if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
                    _hand = v
                    _tally = G.GAME.hands[v].played
                end
            end
            local multiple5s = 0
            local maxhands = 1
            local placeholder = multiple5s
            if maxhands > 0 then
                multiple5s = math.floor(_tally / 5)
                card.ability.extra.dollars = card.ability.extra.increase * multiple5s
                placeholder = multiple5s
            end
        end
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.dollars > 0 then
            return card.ability.extra.dollars
        end
    end
}
SMODS.Joker {
    key = 'stapy',
    atlas = 'Jokers',
    rarity = 1,
    cost = 3,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 7, y = 3 },
    config = { extra = {
        is_contestant = true,
        odds = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
        return { vars = { card.ability.extra.odds, (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            local temp_Mult, temp_ID = 2, 2
            local raised_card = nil
            for i = 1, #context.scoring_hand do
                if temp_ID <= context.scoring_hand[i].base.id and not SMODS.has_no_rank(context.scoring_hand[i]) then
                    temp_Mult = context.scoring_hand[i].base.nominal
                    temp_ID = context.scoring_hand[i].base.id
                    raised_card = context.scoring_hand[i]
                end
            end
            if math.random() < G.GAME.probabilities.normal / card.ability.extra.odds then
                local thingies = {}
                for _, scored_card in ipairs(context.scoring_hand) do
                    if scored_card == raised_card then
                        thingies[#thingies + 1] = scored_card
                        scored_card:set_ability('m_bonus', nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                scored_card:juice_up()
                                return true
                            end
                        }))
                    end
                end
                if #thingies > 0 then
                    return {
                        message = 'Stapled',
                        colour = G.C.CHIPS
                    }
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'loser',
    atlas = 'Jokers',
    rarity = 1,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 6, y = 3 },
    config = { extra = {
        is_contestant = true,
        Xmult = 3
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, G.jokers and G.jokers.config and #G.jokers.cards == G.jokers.config.card_limit and localize("BfJ_active") or localize("BfJ_inactive") } }
    end,
    calculate = function(self, card, context)
        if #G.jokers.cards == G.jokers.config.card_limit and context.joker_main then
            return {
                card = card,
                Xmult_mod = card.ability.extra.Xmult,
                message = 'X' .. card.ability.extra.Xmult,
                colour = G.C.MULT
            }
        end
    end
}
SMODS.Joker {
    key = 'lightning',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 7, y = 2 },
    config = { extra = {
        is_contestant = true,
        mult_mod = 1, mult = 0
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_mod,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if #context.full_hand < 5 then
                local last_mult = card.ability.extra.mult
                card.ability.extra.mult = 0
                if last_mult > 0 then
                    return {
                        message = localize('k_reset')
                    }
                end
            else
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.RED
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'fireyjr',
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 8, y = 2 },
    config = { extra = {
        is_contestant = true,
        chips = 0, chip_mod = 10
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker and G.GAME.current_round.hands_played == 0 and #context.full_hand == 5 then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.CHIPS
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker {
    key = 'bell',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 9, y = 2 },
    config = { extra = {
        is_contestant = true,
        type = 'High Card', odds = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.type, 'poker_hands'), card.ability.extra.odds, (G.GAME and G.GAME.probabilities.normal or 1) } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and context.scoring_name == card.ability.extra.type and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if math.random() < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Planet',
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = '+1 Planet',
                    colour = G.C.SECONDARY_SET.Planet,
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'pricetag',
    atlas = 'Jokers',
    rarity = 1,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 3 },
    config = { extra = {
        is_contestant = true,
        price = 1
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.price } }
    end,
    calculate = function(self, card, context)
        if context.selling_card and not context.blueprint and not context.retrigger_joker then
            card.ability.extra_value = card.ability.extra_value + card.ability.extra.price
            card:set_cost()
            return {
                message = 'Value Up!',
                colour = G.C.MONEY
            }
        end
    end
}
SMODS.Joker {
    key = 'tree',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = false,
    perishable_compat = false,
    pos = { x = 4, y = 3 },
    config = { extra = {
        is_contestant = true,
        rounds = 18, rounds_done = 0
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_soul
        return {
            vars = { card.ability.extra.rounds, card.ability.extra.rounds - card.ability.extra.rounds_done }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.rounds_done = card.ability.extra.rounds_done + 1
            if card.ability.extra.rounds_done == card.ability.extra.rounds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card({ key = "c_soul" })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                end
                return {
                    message = ('+The Soul'),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'naily',
    atlas = 'Jokers',
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 3 },
    config = { extra = {
        is_contestant = true
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = "eternal", set = "Other" }
    end,
    calculate = function(self, card, context)
        if context.selling_self and not context.retrigger_joker and not context.blueprint then
            local jokers = {}
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i] ~= card then
                    jokers[#jokers + 1] = G.jokers.cards[i]
                end
            end
            if #jokers > 0 then
                local chosen_joker = pseudorandom_element(jokers, pseudoseed('BfJ_naily'))
                return {
                    chosen_joker:set_eternal(true),
                    message = 'Nailed It!'
                }
            else
                return { message = localize('k_no_other_jokers') }
            end
        end
    end
}
SMODS.Joker {
    key = 'liy',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 3 },
    config = { extra = {
        is_contestant = true,
        mult = 6, chips = 18, hands = 5, hands_remaining = 5
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.chips,
                card.ability.extra.hands,
                card.ability.extra.hands_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.hands_remaining = card.ability.extra.hands_remaining - 1
            if card.ability.extra.hands_remaining == 0 then
                card.ability.extra.hands_remaining = card.ability.extra.hands
                card:set_ability("j_BfJ_liy2")
                return {
                    chips = card.ability.extra.chips,
                    mult = card.ability.extra.mult,
                    message = 'Flip!'
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'liy2',
    atlas = 'Jokers',
    rarity = 1,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    in_pool = function(self) return false end,
    pos = { x = 1, y = 8 },
    config = { extra = {
        is_contestant = true,
        Xmult = 3, hands = 5, hands_remaining = 5
    }
    },
    loc_vars = function(self, info_queue, card)

        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.hands,
                card.ability.extra.hands_remaining
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.hands_remaining = card.ability.extra.hands_remaining - 1
            if card.ability.extra.hands_remaining == 0 then
                card.ability.extra.hands_remaining = card.ability.extra.hands
                card:set_ability("j_BfJ_liy")
                return {
                    Xmult = card.ability.extra.Xmult,
                    message = 'Flip!'
                }
            end
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'blocky',
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 3 },
    config = { extra = {
        is_contestant = true,
        mult = 50, chips = 250, Xmult = 7
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.Xmult, card.ability.extra.chips } }
    end,
    add_to_deck = function(self, card, from_debuff)
        blockycount = 0
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i].config.center_key == "j_BfJ_blocky" and G.jokers.cards[i].debuff ~= true then
                blockycount = blockycount + 1
            end
        end
        if blockycount > 0 then
            card:start_dissolve()
            ease_dollars(2)
        end
    end,
    calculate = function(self, card, context)
        prank_rarity = 0
        local shmell = 0
        if #G.jokers.cards == 1 then
            shmell = shmell + 1
        else
            if context.setting_blind and not context.blueprint and not context.retrigger_joker then
                local jokers = {}
                for i = 1, #G.jokers.cards do
                    if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then jokers[#jokers + 1] = G.jokers.cards[i] end
                    G.jokers.cards[i]:set_debuff(false)
                end
                isblocky = true
                while isblocky == true do
                    blocky_joker = pseudorandom_element(jokers, pseudoseed('BfJ_blocky'))
                    if blocky_joker.config.center.loc_txt == nil then
                        if blocky_joker.config.center.rarity == 1 or blocky_joker.config.center.rarity == 'Common' then
                            blocky_joker:set_debuff(true)
                            blocky_joker:juice_up()
                            prank_rarity = 1
                            isblocky = false
                        end
                        if blocky_joker.config.center.rarity == 2 or blocky_joker.config.center.rarity == 'Uncommon' then
                            blocky_joker:set_debuff(true)
                            blocky_joker:juice_up()
                            prank_rarity = 2
                            isblocky = false
                        end
                        if blocky_joker.config.center.rarity == 3 or blocky_joker.config.center.rarity == 'Rare' then
                            blocky_joker:set_debuff(true)
                            blocky_joker:juice_up()
                            prank_rarity = 3
                            isblocky = false
                        end
                        if blocky_joker.config.center.rarity == 4 or blocky_joker.config.center.rarity == 'Legendary' then
                            blocky_joker:set_debuff(true)
                            blocky_joker:juice_up()
                            prank_rarity = 4
                            isblocky = false
                        end
                        return {
                            message = ('Pranked!')
                        }
                    else
                        if blocky_joker.config.center.loc_txt.name ~= 'Blocky' then
                            if blocky_joker.config.center.rarity == 1 or blocky_joker.config.center.rarity == 'Common' then
                                blocky_joker:set_debuff(true)
                                blocky_joker:juice_up()
                                prank_rarity = 1
                                isblocky = false
                            end
                            if blocky_joker.config.center.rarity == 2 or blocky_joker.config.center.rarity == 'Uncommon' then
                                blocky_joker:set_debuff(true)
                                blocky_joker:juice_up()
                                prank_rarity = 2
                                isblocky = false
                            end
                            if blocky_joker.config.center.rarity == 3 or blocky_joker.config.center.rarity == 'Rare' then
                                blocky_joker:set_debuff(true)
                                blocky_joker:juice_up()
                                prank_rarity = 3
                                isblocky = false
                            end
                            if blocky_joker.config.center.rarity == 4 or blocky_joker.config.center.rarity == 'Legendary' then
                                blocky_joker:set_debuff(true)
                                blocky_joker:juice_up()
                                prank_rarity = 4
                                isblocky = false
                            end
                            return {
                                message = ('Pranked!')
                            }
                        end
                    end
                end
            end
            if context.joker_main then
                if blocky_joker.config.center.rarity == 1 or blocky_joker.config.center.rarity == 'Common' then
                    return {
                        chips = card.ability.extra.chips
                    }
                end
                if blocky_joker.config.center.rarity == 2 or blocky_joker.config.center.rarity == 'Uncommon' then
                    return {
                        mult = card.ability.extra.mult
                    }
                end
                if blocky_joker.config.center.rarity == 3 or blocky_joker.config.center.rarity == 'Rare' then
                    return {
                        Xmult = card.ability.extra.Xmult
                    }
                end
                if blocky_joker.config.center.rarity == 4 or blocky_joker.config.center.rarity == 'Legendary' then
                    return {
                        chips = card.ability.extra.chips,
                        mult = card.ability.extra.mult,
                        Xmult = card.ability.extra.Xmult
                    }
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'david',
    atlas = 'Jokers',
    rarity = 2,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 3 },
    config = { extra = {
        is_contestant = true,
        slots = 1, rounds = 6
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = { card.ability.extra.slots, card.ability.extra.rounds }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.rounds = card.ability.extra.rounds - 1
            if card.ability.extra.rounds == 0 then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                return {
                    message = ('Aw, seriously!'),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end,
    in_pool = function(self, args)
        return false
    end
}
SMODS.Joker {
    key = 'rocky',
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 6, y = 2 },
    config = { extra = { is_contestant = true, odds = 4 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and (pseudorandom('BfJ_rocky') < G.GAME.probabilities.normal / card.ability.extra.odds) then
            local _card = create_playing_card({
                front = pseudorandom_element(G.P_CARDS, pseudoseed('BfJ_rockycard')),
                center = G.P_CENTERS.c_base
            }, G.discard, true, nil, { G.C.SECONDARY_SET.Enhanced }, true)
            _card:set_seal(SMODS.poll_seal({ guaranteed = true, type_key = 'BfJ_rockyseal' }), true)
            _card:set_edition(poll_edition('BfJ_rockyedition', nil, true, true), true)
            _card:set_ability(SMODS.poll_enhancement({ guaranteed = true, type_key = 'BfJ_rockyenhancement' }), true)

            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.hand:emplace(_card)
                            _card:start_materialize()
                            G.GAME.blind:debuff_card(_card)
                            G.hand:sort()
                            if context.blueprint_card then
                                context.blueprint_card:juice_up()
                            else
                                card:juice_up()
                            end
                            return true
                        end
                    }))
                    SMODS.calculate_context({ playing_card_added = true, cards = { _card } })
                end,
                message = 'Bleh!'
            }
        end
    end,
}
SMODS.Joker {
    key = 'teardrop',
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 2 },
    config = { extra = { is_contestant = true, poker_hand = 'Five of a Kind', suit = 'Clubs' } },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.poker_hand, 'poker_hands'), localize(card.ability.extra.suit, 'suits_singular') } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands[card.ability.extra.poker_hand]) and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local has_club = false
            for _, playing_card in ipairs(context.scoring_hand) do
                if playing_card:is_suit('Clubs', nil, true) then
                    has_club = true
                    break
                end
            end
            if has_club then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Spectral',
                            key_append = 'BfJ_teardrop'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = localize('k_plus_spectral'),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'snowball',
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 8, y = 3 },
    config = { extra = {
        is_contestant = true
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Straight Flush"]) then
            local ace_check = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 then
                    ace_check = true
                    break
                end
            end
            if ace_check then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
                            key_append = 'BfJ_snowballcard1',
                            edition = 'e_negative'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
                            key_append = 'BfJ_snowballcard2',
                            edition = 'e_negative'
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                return {
                    message = '+2 Tarots',
                    colour = G.C.SECONDARY_SET.Tarot,
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'eraser',
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 9, y = 3 },
    config = { extra = {
        is_contestant = true
    } },
    calculate = function(self, card, context)
        if context.end_of_round and not context.retrigger_joker and not context.blueprint then
            for _, playing_card in ipairs(G.hand.cards) do
                SMODS.destroy_cards(playing_card)
            end
        end
    end
}
SMODS.Joker {
    key = 'tennisball',
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 2 },
    config = { extra = {
        is_contestant = true,
        type = 'High Card'
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn and not context.blueprint and not context.retrigger_joker then
            local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and context.scoring_name == card.ability.extra.type and not context.retrigger_joker and not context.blueprint then
            local chosen_seal = SMODS.poll_seal({ guaranteed = true, type_key = 'BfJ_tennisballseal' })
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.scoring_hand[1]:set_seal(chosen_seal)
                    context.scoring_hand[1]:juice_up()
                    return true
                end
            }))
            return {
                message = localize(chosen_seal .. "seal", "labels"),
                colour = G.C.FILTER,
            }
        end
    end
}
SMODS.Joker {
    key = 'woody',
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 2 },
    config = { extra = {
        is_contestant = true,
    } },
    calculate = function(self, card, context)
        if context.setting_blind and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            local woody_set = pseudorandom_element({ "Tarot", "Planet", "Spectral" }, pseudoseed('BfJ_woody'))
            G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    SMODS.add_card {
                                        set = woody_set,
                                    }
                                    G.GAME.consumeable_buffer = 0
                                    return true
                                end
                            }))
                            return true
                        end)
                    }))
                end,
                message = localize(woody_set == "Tarot" and "k_plus_tarot" or
                    woody_set == "Planet" and "k_plus_planet" or "k_plus_spectral"),
                colour = (woody_set == "Tarot" and G.C.PURPLE or woody_set == "Planet" and G.C.BLUE or G.C.SECONDARY_SET.Spectral),
                context.blueprint_card or card
            }
        end
    end
}
SMODS.Joker {
    key = 'purpleface',
    atlas = 'Jokers',
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 4 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_SEALS.Purple
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and G.GAME.current_round.hands_played == 0 and not context.blueprint and not context.retrigger_joker then
            local did_something = false
            for _, scored_card in ipairs(context.scoring_hand) do
                if not scored_card.seal then
                    did_something = true
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:set_seal("Purple", nil, true)
                            scored_card:juice_up()
                            return true
                        end
                    }))
                end
            end
            if did_something then
                return {
                    message = 'Purple',
                    colour = G.C.PURPLE
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'flower',
    atlas = 'Jokers',
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 2 },
    config = { extra = {
        is_contestant = true,
        chips = 0, chips_mod = 15
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.chips_mod } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chips_mod
            return {
                card = card,
                message = localize("k_upgrade_ex"),
                colour = G.C.FILTER
            }
        end

        if context.joker_main and card.ability.extra.chips > 0 then
            return {
                chips = card.ability.extra.chips
            }
        end
    end
}
SMODS.Joker {
    key = 'profily',
    atlas = 'Jokers',
    rarity = 2,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 2 },
    calculate = function(self, card, context)
        local me = nil
        for i = 1, #G.jokers.cards do
            if G.jokers.cards[i] == card then
                me = i
                break
            end
        end
        if G.jokers.cards[me + 1] and G.jokers.cards[me + 1].config.center.key == "j_blueprint" then
            return SMODS.blueprint_effect(card, G.jokers.cards[me + 1], context)
        end
    end
}
SMODS.Joker {
    key = 'pen',
    atlas = 'Jokers',
    rarity = 2,
    cost = 4,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 4 },
    config = { extra = {
        is_contestant = true
    } },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_hanged_man
        info_queue[#info_queue + 1] = G.P_CENTERS.c_death
    end,
    calculate = function(self, card, context)
        if context.joker_main and next(context.poker_hands["Straight Flush"]) and not context.retrigger_joker and not context.blueprint then
            local ace_check = false
            local king_check = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 then
                    ace_check = true
                    break
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 13 then
                    king_check = true
                    break
                end
            end
            if ace_check and king_check and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card({ key = "c_hanged_man" })
                        G.GAME.consumeable_buffer = 0
                        return true
                    end)
                }))
                if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            SMODS.add_card({ key = "c_death" })
                            G.GAME.consumeable_buffer = 0
                            return true
                        end)
                    }))
                    return {
                        message = '+2 Tarots',
                        colour = G.C.SECONDARY_SET.Tarot,
                    }
                else
                    return {
                        message = localize("k_plus_tarot"),
                        colour = G.C.SECONDARY_SET.Tarot,
                    }
                end
            end
        end
        if context.after and context.poker_hands and next(context.poker_hands["Straight Flush"]) and #context.poker_hands['Straight Flush'] > 0 and not context.retrigger_joker and not context.blueprint then
            local ace_check = false
            local king_check = false
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 14 then
                    ace_check = true
                    break
                end
            end
            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i]:get_id() == 13 then
                    king_check = true
                    break
                end
            end
            if ace_check and king_check then
                local flush_suit = context.scoring_hand[1].base.suit
                for _, c in ipairs(G.hand.cards) do
                    if c and c.base then
                        SMODS.change_base(c, flush_suit)
                        c:juice_up(0.5, 0.5)
                    end
                end
            end
        end
    end
}
SMODS.Joker {
    key = 'coiny',
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 6, y = 4 },
    config = { extra = {
        is_contestant = true,
        Xmult = 0.1, dollars = 10
    }
    },
    loc_vars = function(self, info_queue, card)
        local heart_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Hearts') or playing_card.base.suit == "Hearts" then heart_tally = heart_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.Xmult, 1 + card.ability.extra.Xmult * heart_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local heart_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Hearts') or playing_card.base.suit == "Hearts" then heart_tally = heart_tally + 1 end
            end
            return {
                Xmult = 1 + card.ability.extra.Xmult * heart_tally,
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        if next(SMODS.find_card("j_BfJ_nickel")) then
            return card.ability.extra.dollars
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card:is_suit('Hearts') or playing_card.base.suit == "Hearts" then
                return true
            end
        end
        return false
    end
}
SMODS.Joker {
    key = 'pin',
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 7, y = 4 },
    config = { extra = {
        is_contestant = true
    } },
    remove_from_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.BfJ_pin_doubled and G.GAME.blind.BfJ_pin_doubled > 0 then
            G.GAME.blind.BfJ_pin_doubled = G.GAME.blind.BfJ_pin_doubled - 1
            G.GAME.blind.chips = G.GAME.blind.chips / 2
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.GAME.blind:wiggle()
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and not context.retrigger_joker then
            if not G.GAME.blind.BfJ_pin_doubled then G.GAME.blind.BfJ_pin_doubled = 0 end
            G.GAME.blind.BfJ_pin_doubled = G.GAME.blind.BfJ_pin_doubled + 1
            G.GAME.blind.chips = G.GAME.blind.chips * 2
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
            G.GAME.blind:wiggle()
            return {
                message = 'Doubled',
                colour = G.C.RED
            }
        end
    end
}
SMODS.Joker {
    key = 'firey',
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 1 },
    config = { extra = { is_contestant = true, mult = 0, mult_mod = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.mult_mod } }
    end,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.discard and not context.blueprint and not context.retrigger_joker and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    card.ability.extra.mult = card.ability.extra.mult +
                                        card.ability.extra.mult_mod
                                    return true
                                end
                            }))
                            SMODS.calculate_effect(
                                {
                                    message = localize { type = 'variable', key = 'a_mult', vars = {
                                        card.ability.extra.mult_mod } }
                                }, card
                            )
                            return true
                        end
                    }))
                end,
                remove = true
            }
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'icecube',
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 9, y = 4 },
    config = { extra = {
        is_contestant = true,
        hands = 2, odds = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.hands, (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.joker_main and G.GAME.current_round.hands_left == 1 and not context.retrigger_joker then
            if pseudorandom('BfJ_icecube') < G.GAME.probabilities.normal / card.ability.extra.odds and not context.blueprint then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:shatter()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                ease_hands_played(card.ability.extra.hands)
                                SMODS.calculate_effect(
                                    { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
                                    context.blueprint_card or card)
                                return true
                            end
                        }))
                    end,
                    message = 'Shattered!',
                    colour = G.C.RED
                }
            else
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                ease_hands_played(card.ability.extra.hands)
                                SMODS.calculate_effect(
                                    { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
                                    context.blueprint_card or card)
                                return true
                            end
                        }))
                    end,
                    message = 'Revenge!',
                    colour = G.C.BLUE
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'spongy',
    atlas = 'Jokers',
    rarity = 2,
    cost = 2,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 5 },
    config = { extra = {
        is_contestant = true,
        mult = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_negative
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult .. ' Mult',
                colour = G.C.MULT
            }
        end
        if context.end_of_round and context.game_over == false and context.main_eval then
            SMODS.add_card({
                set = 'Joker',
                key = 'j_BfJ_spongy2',
                edition = 'e_negative'
            })
        end
    end
}
SMODS.Joker {
    key = 'spongy2',
    atlas = 'Jokers',
    rarity = 2,
    cost = 2,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    no_collection = true,
    in_pool = function(self) return false end,
    pos = { x = 0, y = 5 },
    config = { extra = {
        is_contestant = true,
        mult = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                card = card,
                mult_mod = card.ability.extra.mult,
                message = '+' .. card.ability.extra.mult .. ' Mult',
                colour = G.C.MULT
            }
        end
    end
}
SMODS.Joker {
    key = 'pencil',
    atlas = 'Jokers',
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 5 },
    config = { extra = {
        is_contestant = true,
        levels = 5
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Planet' and not context.blueprint and not context.retrigger_joker then
            G.E_MANAGER:add_event(Event({
                func = function()
                    play_sound('tarot1')
                    card.T.r = -0.2
                    card:juice_up(0.3, 0.4)
                    card.states.drag.is = true
                    card.children.center.pinch.x = true
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.3,
                        blockable = false,
                        func = function()
                            card:remove()
                            return true
                        end
                    }))
                    return true
                end
            }))
            return {
                message = localize("k_upgrade_ex"),
                level_up = card.ability.extra.levels,
                level_up_hand = context.consumeable.config.center.config.hand_type
            }
        end
    end
}
SMODS.Joker {
    key = 'needle',
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 6, y = 0 },
    config = { extra = {
        is_contestant = true,
        hands = 3, Xmult = 1.25, odds = 4
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.hands, card.ability.extra.Xmult, (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and (pseudorandom('BfJ_needle') < G.GAME.probabilities.normal / card.ability.extra.odds) then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            ease_hands_played(card.ability.extra.hands)
                            SMODS.calculate_effect(
                                { message = localize { type = 'variable', key = 'a_hands', vars = { card.ability.extra.hands } } },
                                context.blueprint_card or card)
                            return true
                        end
                    }))
                end
            }
        end
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, 'm_steel') then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'golfball',
    atlas = 'Jokers',
    rarity = 2,
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 0 },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_glass
    end,
    config = { extra = {
        is_contestant = true,
        repetitions = 1
    }
    },
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_glass') then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'match',
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = false,
    pos = { x = 4, y = 5 },
    config = { extra = {
        is_contestant = true,
        Xmult = 1, Xmult_mod = 0.05
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:is_suit('Hearts') and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.FILTER,
                card = card
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'bubble',
    atlas = 'Jokers',
    rarity = 2,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 5 },
    config = { extra = {
        is_contestant = true,
        Xmult = 1, Xmult_mod = 2, odds = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and not context.blueprint and not context.retrigger_joker then
            if pseudorandom('BfJ_bubble') < G.GAME.probabilities.normal / card.ability.extra.odds then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        play_sound('tarot1')
                        card.T.r = -0.2
                        card:juice_up(0.3, 0.4)
                        card.states.drag.is = true
                        card.children.center.pinch.x = true
                        G.E_MANAGER:add_event(Event({
                            trigger = 'after',
                            delay = 0.3,
                            blockable = false,
                            func = function()
                                card:remove()
                                return true
                            end
                        }))
                        return true
                    end
                }))
                return {
                    message = 'Popped!'
                }
            else
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.FILTER,
                    card = card
                }
            end
        end

        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult = card.ability.extra.Xmult,
            }
        end
    end
}
SMODS.Joker {
    key = 'leafy',
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 6, y = 5 },
    config = { extra = {
        is_contestant = true,
        repetitions = 1, odds = 5
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card.config.center.rarity == 1 and (pseudorandom('BfJ_leafy') < G.GAME.probabilities.normal / card.ability.extra.odds) then
            return {
                repetitions = 1
            }
        end
    end
}
SMODS.Joker {
    key = 'roottwo',
    atlas = 'Jokers',
    rarity = 2,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 7 },
    config = { extra = {
        Xmult = 1.5
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            (context.other_card:get_id() == 4 or context.other_card:get_id() == 9) then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'tv',
    atlas = 'Jokers',
    rarity = 3,
    cost = 11,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 4 },
    config = { extra = {
        is_contestant = true,
        repetitions = 1,
        bfj_mechanical_mind = true
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.repetitions } }
    end,
    calculate = function(self, card, context)
        if context.retrigger_joker_check and context.other_card.config.center.rarity == 2 then
            return {
                repetitions = 1
            }
        end
    end
}
SMODS.Joker {
    key = 'evilleafy',
    atlas = 'Jokers',
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 8, y = 5 },
    config = { extra = {
        Xmult = 1, odds = 10
    }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.Xmult,
                (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        if context.destroy_card and context.cardarea == G.play and not context.blueprint and not context.retrigger_joker and pseudorandom('BfJ_evilleafy') < G.GAME.probabilities.normal / card.ability.extra.odds then
            local temp_ID = context.destroy_card.base.nominal
            card.ability.extra.Xmult = card.ability.extra.Xmult + (temp_ID / 10)
            return {
                message = localize("k_upgrade_ex"),
                colour = G.C.FILTER,
                remove = true
            }
        end

        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'yellowface',
    atlas = 'Jokers',
    rarity = 3,
    cost = 10,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 9, y = 5 },
    config = { extra = {
        is_contestant = true,
        discount = 25
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_coupon', set = 'Tag' }
        return { vars = { card.ability.extra.discount } }
    end,
    add_to_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent + card.ability.extra.discount
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.E_MANAGER:add_event(Event({
            func = function()
                G.GAME.discount_percent = G.GAME.discount_percent - card.ability.extra.discount
                for k, v in pairs(G.I.CARD) do
                    if v.set_cost then v:set_cost() end
                end
                return true
            end
        }))
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and context.main_eval and G.GAME.blind.boss then
            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag('tag_coupon'))
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end)
                    }))
                end,
                message = '+Coupon Tag',
                colour = G.C.RED
            }
        end
    end
}
SMODS.Joker {
    key = 'ruby',
    atlas = 'Jokers',
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 6 },
    config = { extra = {
        is_contestant = true,
        mult = 0, chips = 0, Xmult = 1, money = 0, mult_min = 10, mult_max = 30, chips_min = 10, chips_max = 30, Xmult_min = 1, Xmult_max = 3, money_min = 1, money_max = 3, odds = 3
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, card.ability.extra.chips, card.ability.extra.Xmult, card.ability.extra.money, card.ability.extra.mult_mod, card.ability.extra.chips_mod, card.ability.extra.Xmult_mod, card.ability.extra.increase, (G.GAME and G.GAME.probabilities.normal or 1), card.ability.extra.odds } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind and (pseudorandom('BfJ_ruby') < G.GAME.probabilities.normal / card.ability.extra.odds) and not context.blueprint and not context.retrigger_joker then
            local ruby_num = pseudorandom('BfJ_rubynum', 1, 4)
            if ruby_num == 1 then
                local change_mult = pseudorandom('BfJ_rubymult',
                    card.ability.extra.mult_min, card.ability.extra.mult_max)
                card.ability.extra.mult = card.ability.extra.mult + change_mult
                return {
                    card = card,
                    message = '+' .. change_mult .. ' Mult',
                    colour = G.C.MULT
                }
            end
            if ruby_num == 2 then
                local change_chips = pseudorandom('BfJ_rubychips',
                    card.ability.extra.chips_min, card.ability.extra.chips_max)
                card.ability.extra.chips = card.ability.extra.chips + change_chips
                return {
                    card = card,
                    message = '+' .. change_chips .. ' Chips',
                    colour = G.C.CHIPS
                }
            end
            if ruby_num == 3 then
                local change_xmult = pseudorandom('BfJ_rubyxmult',
                    card.ability.extra.Xmult_min, card.ability.extra.Xmult_max)
                card.ability.extra.Xmult = card.ability.extra.Xmult + change_xmult
                return {
                    card = card,
                    message = '+' .. change_xmult .. ' Xmult',
                    colour = G.C.MULT
                }
            end
            if ruby_num == 4 then
                local change_money = pseudorandom('BfJ_rubyxmult',
                    card.ability.extra.money_min, card.ability.extra.money_max)
                card.ability.extra.money = card.ability.extra.money + change_money
                return {
                    card = card,
                    message = '+$' .. change_money,
                    colour = G.C.MONEY
                }
            end
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult,
                Xmult = card.ability.extra.Xmult
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.money > 0 then
            return card.ability.extra.money
        end
    end
}
SMODS.Joker {
    key = 'puffball',
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 6 },
    config = { extra = {
        is_contestant = true
    } },
    calculate = function(self, card, context)
        if context.setting_blind and not context.blueprint and context.blind.boss and not context.retrigger_joker then
            if G.GAME.blind.name == 'The Pillar' or G.GAME.blind.name == 'Verdant Leaf' or G.GAME.blind.name == 'The Club' or G.GAME.blind.name == 'The Goad' or G.GAME.blind.name == 'The Window' or G.GAME.blind.name == 'The Plant' or G.GAME.blind.name == 'The Head' then
                return {
                    func = function()
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                G.GAME.blind:disable()
                                play_sound('timpani')
                                delay(0.4)
                                return true
                            end
                        }))
                        SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
                        return true
                    end
                }
            end
        end
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            if G.GAME.blind.name == 'The Pillar' or G.GAME.blind.name == 'Verdant Leaf' or G.GAME.blind.name == 'The Club' or G.GAME.blind.name == 'The Goad' or G.GAME.blind.name == 'The Window' or G.GAME.blind.name == 'The Plant' or G.GAME.blind.name == 'The Head' then
                G.GAME.blind:disable()
                play_sound('timpani')
                SMODS.calculate_effect({ message = localize('ph_boss_disabled') }, card)
            end
        end
    end
}
SMODS.Joker {
    key = 'gelatin',
    atlas = 'Jokers',
    rarity = 3,
    cost = 5,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 6 },
    config = { extra = {
        is_contestant = true,
        dollars = 0, increase = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.dollars, card.ability.extra.increase } }
    end,
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false and not context.blueprint and not context.retrigger_joker then
            card.ability.extra.dollars = card.ability.extra.dollars + card.ability.extra.increase
            return {
                card = card,
                message = 'Upgrade!',
                colour = G.C.MONEY
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        if card.ability.extra.dollars > 0 then
            return card.ability.extra.dollars
        end
    end
}
SMODS.Joker {
    key = 'fries',
    atlas = 'Jokers',
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 6 },
    config = { extra = {
        is_contestant = true
    } },
    calculate = function(self, card, context)
        if context.end_of_round and context.game_over == false then
            local tag_var = pseudorandom_element(G.P_TAGS, pseudoseed('BfJ_fries')).key

            return {
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = (function()
                            add_tag(Tag(tag_var, false, 'Small'))
                            play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                            return true
                        end)
                    }))
                end,
                message = localize { type = 'name_text', key = tag_var, set = 'Tag' },
            }
        end
    end
}
SMODS.Joker {
    key = 'dora',
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 4, y = 6 },
    config = { extra = {
        is_contestant = true,
        Xmult = 1, Xmult_mod = 0.05, Xmult_mod_mod = 0.05, odds = 5
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_stone
        return {
            vars = {
                card.ability.extra.Xmult,
                card.ability.extra.Xmult_mod,
                card.ability.extra.Xmult_mod_mod,
                (G.GAME and G.GAME.probabilities.normal or 1),
                card.ability.extra.odds
            }
        }
    end,
    calculate = function(self, card, context)
        if self.debuff then return nil end
        if context.individual and context.cardarea == G.play and not context.blueprint and not context.retrigger_joker then
            if SMODS.has_enhancement(context.other_card, 'm_stone') then
                card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
                return {
                    message = localize('k_upgrade_ex'),
                    colour = G.C.FILTER,
                    message_card = card
                }
            end
        end
        if context.destroy_card and context.cardarea == G.play and not context.blueprint and not context.retrigger_joker then
            if SMODS.has_enhancement(context.destroy_card, 'm_stone') then
                if context.destroy_card and (pseudorandom('BfJ_dora') < G.GAME.probabilities.normal / card.ability.extra.odds) then
                    card.ability.extra.Xmult_mod = card.ability.extra.Xmult_mod + card.ability.extra.Xmult_mod_mod
                    return {
                        message = 'Eaten!',
                        colour = G.C.BROWN,
                        remove = true
                    }
                end
            end
        end
        if context.joker_main and card.ability.extra.Xmult > 1 then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'donut',
    atlas = 'Jokers',
    rarity = 3,
    cost = 9,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 0, y = 7 },
    config = { extra = {
        is_contestant = true,
        Xmult = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult * 10 } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 10 then
            if #SMODS.find_card('j_BfJ_four') > 0 and #SMODS.find_card('j_BfJ_x') > 0 then
                return {
                    Xmult = card.ability.extra.Xmult * 10
                }
            else
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}
SMODS.Joker {
    key = 'nickel',
    atlas = 'Jokers',
    rarity = 3,
    cost = 6,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 1, y = 7 },
    config = { extra = {
        is_contestant = true,
        chips = 15, dollars = 10
    }
    },
    loc_vars = function(self, info_queue, card)
        local spade_tally = 0
        if G.playing_cards then
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Spades') or playing_card.base.suit == "Spades" then spade_tally = spade_tally + 1 end
            end
        end
        return { vars = { card.ability.extra.chips, card.ability.extra.chips * spade_tally } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            local spade_tally = 0
            for _, playing_card in ipairs(G.playing_cards) do
                if playing_card:is_suit('Spades') or playing_card.base.suit == "Spades" then spade_tally = spade_tally + 1 end
            end
            return {
                chips = card.ability.extra.chips * spade_tally,
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        if next(SMODS.find_card('j_BfJ_coiny')) then
            return card.ability.extra.dollars
        end
    end,
    in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if playing_card:is_suit('Spades') or playing_card.base.suit == "Spades" then
                return true
            end
        end
        return false
    end
}
SMODS.Joker {
    key = 'book',
    atlas = 'Jokers',
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 2, y = 7 },
    config = { extra = {
        is_contestant = true,
        mult = 15, dollars = 3, repetitions = 1
    }
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        return { vars = { card.ability.extra.mult, card.ability.extra.dollars } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            if SMODS.has_enhancement(context.other_card, 'm_lucky') then
                return {
                    repetitions = card.ability.extra.repetitions
                }
            end
        end
        if context.individual and context.other_card.lucky_trigger then
            return {
                dollars = card.ability.extra.dollars,
                mult = card.ability.extra.mult
            }
        end
    end
}
SMODS.Joker {
    key = 'bomby',
    atlas = 'Jokers',
    rarity = 3,
    cost = 7,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 3, y = 7 },
    config = { extra = { is_contestant = true, mult = 2 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult or 0
            context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.extra.mult
            return {
                extra = { message = localize('k_upgrade_ex'), colour = G.C.MULT },
                card = card
            }
        end
    end
}
SMODS.Joker {
    key = 'one',
    atlas = 'Jokers',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 5, y = 6 },
    soul_pos = { x = 5, y = 7 },
    config = { extra = {
        x_chips = 1, x_chips_mod = 0.25, type = 'Pair'
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.x_chips, card.ability.extra.x_chips_mod * 2, localize(card.ability.extra.type, 'poker_hands') } }
    end,
    calculate = function(self, card, context)
        if context.scoring_name == card.ability.extra.type then
            if context.destroy_card and context.cardarea == G.play and not context.blueprint and not context.retrigger_joker then
                card.ability.extra.x_chips = card.ability.extra.x_chips + card.ability.extra.x_chips_mod
                return {
                    message = 'Deal!',
                    colour = G.C.CHIPS,
                    remove = true
                }
            end
        end
        if context.joker_main then
            return {
                x_chips = card.ability.extra.x_chips
            }
        end
    end
}
SMODS.Joker {
    key = 'two',
    atlas = 'Jokers',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 6, y = 6 },
    soul_pos = { x = 6, y = 7 },
    config = { extra = {
        Emult = 2
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Emult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                emult = card.ability.extra.Emult
            }
        end
    end
}
SMODS.Joker {
    key = 'four',
    atlas = 'Jokers',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 8, y = 6 },
    soul_pos = { x = 8, y = 7 },
    config = { extra = {
        Xmult_mod = 0.4, Xmult = 1
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_mod } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker and #context.full_hand == 4 then
            card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_mod
            return {
                message = localize('k_upgrade_ex'),
                colour = G.C.MULT
            }
        end
        if context.joker_main then
            return {
                Xmult = card.ability.extra.Xmult
            }
        end
    end
}
SMODS.Joker {
    key = 'x',
    atlas = 'Jokers',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 7, y = 6 },
    soul_pos = { x = 7, y = 7 },
    config = { extra = { max = 30, min = 5 } },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.min, card.ability.extra.max } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                Xmult = pseudorandom('BfJ_x', card.ability.extra.min, card.ability.extra.max)
            }
        end
    end
}
SMODS.Joker {
    key = 'announcer',
    atlas = 'Jokers',
    rarity = 4,
    cost = 20,
    unlocked = true,
    discovered = false,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    pos = { x = 9, y = 6 },
    soul_pos = { x = 9, y = 7 },
    config = { extra = {} },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        info_queue[#info_queue + 1] = G.P_CENTERS.m_lucky
        local suit = G.GAME and G.GAME.current_round and G.GAME.current_round.BfJ_announcer_card and G.GAME.current_round.BfJ_announcer_card.suit or 'Spades'
        return { vars = { localize('Flush', 'poker_hands'), localize(suit, 'suits_singular'), colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint and not context.retrigger_joker and (next(context.poker_hands['Flush']) or next(context.poker_hands['Straight Flush']) or next(context.poker_hands['Flush House']) or next(context.poker_hands['Flush Five'])) then
            local suits = {}
            for _, scored_card in ipairs(context.scoring_hand) do
                if scored_card:is_suit(G.GAME.current_round.BfJ_announcer_card and G.GAME.current_round.BfJ_announcer_card.suit, nil, true) then
                    suits[#suits + 1] = scored_card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            scored_card:set_edition('e_polychrome', nil, true)
                            scored_card:juice_up()
                            return true
                        end
                    }))
                    scored_card:set_ability('m_lucky', nil, true)
                end
            end
            if #suits > 0 then
                return {
                    message = 'Wow!',
                    colour = G.C.MULT
                }
            end
        end
    end
}







SMODS.PokerHand {
  key = "twosevensixthree",
  chips = 27,
  mult = 6.3,
  l_mult = 2.7,
  l_chips = 63,
  visible = true,
  above_hand = "Full House",
  example = {
    { 'C_Q', false },
    { 'S_2', true },
    { 'S_7', true },
    { 'D_6', true },
    { 'H_3', true }
  },
  evaluate = function(parts, hand)
    local twos = {}
    local sevens = {}
    local sixes = {}
    local threes = {}

    for _, card in ipairs(hand) do
        if card:get_id() == 2 then twos[#twos + 1] = card end
        if card:get_id() == 7 then sevens[#sevens + 1] = card end
        if card:get_id() == 6 then sixes[#sixes + 1] = card end
        if card:get_id() == 3 then threes[#threes + 1] = card end
    end

    if next(twos) and next(sevens) and next(sixes) and next(threes) then return {SMODS.merge_lists{twos, sevens, sixes, threes}} else return {} end
  end
}

SMODS.Consumable {
  set = "Planet",
  key = "algebra",
  pos = { x = 0, y = 0 },
  config = {
    hand_type = "BfJ_twosevensixthree",
    softlock = false
  },
  atlas = "Tarots",
  loc_vars = function(self, info_queue, center)
    return {
      vars = {
        G.GAME.hands["BfJ_twosevensixthree"].level,
        localize("BfJ_twosevensixthree"),
        G.GAME.hands["BfJ_twosevensixthree"].l_mult,
        G.GAME.hands["BfJ_twosevensixthree"].l_chips,
        colours = { (to_big(G.GAME.hands["BfJ_twosevensixthree"].level) == to_big(1) and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, G.GAME.hands["BfJ_twosevensixthree"].level)]) }
      }
    }
  end
}












local mod_path = "" .. SMODS.current_mod.path
function SMODS.current_mod.reset_game_globals(run_start)
    G.GAME.current_round.BfJ_announcer_card = G.GAME.current_round.BfJ_announcer_card or { suit = 'Spades' }
    local suits = {}
    for k, v in ipairs({ 'Spades', 'Hearts', 'Clubs', 'Diamonds' }) do
        if v ~= G.GAME.current_round.BfJ_announcer_card.suit then suits[#suits + 1] = v end
    end
    G.GAME.current_round.BfJ_announcer_card.suit = pseudorandom_element(suits,
        pseudoseed('BfJ_announcer' .. G.GAME.round_resets.ante))
end

SMODS.current_mod.optional_features = function()
    return {
        retrigger_joker = true,
    }
end
local oldaddroundevalrow = add_round_eval_row
function add_round_eval_row(config)
    config = config or {}
    if config.dollars and next(SMODS.find_card("j_BfJ_pin")) then
        config.dollars = config.dollars *
            (2 ^ #SMODS.find_card("j_BfJ_pin"))
    end
    return oldaddroundevalrow(config)
end

local files = NFS.getDirectoryItems(mod_path .. "libs/")
for _, file in ipairs(files) do
    print("[BfJ] Loading lib file " .. file)
    local f, err = SMODS.load_file("libs/" .. file)
    if err then
        error(err)
    end
    f()
end

SMODS.current_mod.extra_tabs = function() --Credits tab
    local scale = 0.5
    return {
        label = "Credits",
        tab_definition_function = function()
            return {
                n = G.UIT.ROOT,
                config = {
                    align = "cm",
                    padding = 0.05,
                    colour = G.C.CLEAR,
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Creator, mod director, and coder:",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.INACTIVE
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "WusGud",
                                    shadow = false,
                                    scale = scale * 1,
                                    colour = G.C.ORANGE
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Co-creator and coder:",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.INACTIVE
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "NitroPixel3783",
                                    shadow = false,
                                    scale = scale,
                                    colour = G.C.PURPLE
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Artwork:",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.INACTIVE
                                }
                            }
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Caldox, Kazt",
                                    shadow = false,
                                    scale = scale,
                                    colour = G.C.GREEN
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Janitorial duties (cleanup and fixes):",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.INACTIVE
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "GhostSalt",
                                    shadow = false,
                                    scale = scale,
                                    colour = G.C.SECONDARY_SET.Spectral
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "MANY idea contributions (thank you again!):",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.INACTIVE
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "MilkChan, ☆Melody☆",
                                    shadow = false,
                                    scale = scale * 1,
                                    colour = G.C.RED
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Playtesters:",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.INACTIVE
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Daxton, Mr. 2 Xs, My Dad, MilkChan",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.BLUE
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "My friend, for watching BFDI:",
                                    shadow = false,
                                    scale = scale * 0.66,
                                    colour = G.C.INACTIVE
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "JMFTx3",
                                    shadow = false,
                                    scale = scale * 1,
                                    colour = G.C.MONEY
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0.2,
                            align = "cm",
                        },
                        nodes = {
                            UIBox_button({
                                minw = 3.85,
                                button = "BFJ_Youtube",
                                label = { "Youtube" }
                            }),
                            UIBox_button({
                                minw = 3.85,
                                colour = HEX("9656ce"),
                                button = "BFJ_Discord",
                                label = { "Discord" }
                            })
                        },
                    },
                },
            }
        end
    }
end

function G.FUNCS.BFJ_Youtube(e)
    love.system.openURL("https://www.youtube.com/@WusGud6")
end

function G.FUNCS.BFJ_Discord(e)
    love.system.openURL("https://discord.gg/sa3uvjKbvs")
end

function G.FUNCS.BFJ_Youtube(e)
    love.system.openURL("https://www.youtube.com/@WusGud6")
end

function G.FUNCS.BFJ_Discord(e)
    love.system.openURL("https://discord.gg/sa3uvjKbvs")
end

--test 2
