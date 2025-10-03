SMODS.Joker {
    key = "bloodbath",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { xmult = 1.9 } },
    rarity = 3,
    blueprint_compat = true,
    cost = 9,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    xmult = card.ability.extra.xmult
                }
            end
        end
    end
}
SMODS.Joker {
    key = "cataclysm",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { mult = 19 } },
    rarity = 2,
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    mult = card.ability.extra.mult
                }
            end
        end
    end
}
SMODS.Joker {
    key = "aftermath",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { chips = 19 } },
    rarity = 1,
    blueprint_compat = true,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if G.GAME.current_round.hands_left == 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end
}
SMODS.Joker {
    key = "magic_school_bus",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { mult = 0, mult_gain = 1 } },
    rarity = 2,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.mult_gain,
                card.ability.extra.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.before and not context.blueprint and context.main_eval then
            local has_face_card = false
            for _, playing_card in ipairs(G.hand.cards) do
                if playing_card:is_face() then
                    SMODS.scale_card(card, {
                        ref_table = card.ability.extra,
                        ref_value = "mult",
                        scalar_value = "mult_gain",
                    })
                    has_face_card = true
                end
            end
            if has_face_card then
                return {
                    message = localize("k_upgrade_ex"),
                }
            else
                card.ability.extra.mult = 0
                return {
                    message = localize("k_mul_missed_bus")
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
    key = "v1",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { seal = "Gold" } },
    rarity = 2,
    blueprint_compat = true,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_SEALS[card.ability.extra.seal])
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.before and G.GAME.current_round.hands_played == 0 then
            local rand_card = pseudorandom_element(context.scoring_hand, "mul_v1")
            if rand_card then
                rand_card:set_seal(card.ability.extra.seal)
            end
        end
    end
}
SMODS.Joker {
    key = "villager",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 20, money_loss = 1, transmute_req = Multiverse.set_transmute_requirements(25) } },
    rarity = 1,
    blueprint_compat = true,
    transmutable_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, {
            set = "Other", key = "mul_villager_hint"
        })
        local count = 0
        if G.playing_cards then
            for _, v in ipairs(G.playing_cards) do
                if (SMODS.has_enhancement(v, "m_steel")
                        or SMODS.has_enhancement(v, "m_gold")
                        or SMODS.has_enhancement(v, "m_stone")) then
                    count = count + 1
                end
            end
        end
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.money_loss,
                count,
                card.ability.extra.transmute_req
            }
        }
    end,
    calculate = function(self, card, context)
        local count = 0
        if not context.blueprint then
            for _, c in ipairs(G.playing_cards) do
                if SMODS.has_enhancement(c, "m_steel")
                    or SMODS.has_enhancement(c, "m_gold")
                    or SMODS.has_enhancement(c, "m_stone") then
                    count = count + 1
                end
            end
            if count >= card.ability.extra.transmute_req then
                card:add_sticker("mul_transmutable", true)
            else
                card:remove_sticker("mul_transmutable")
            end
        end
        if context.joker_main then
            G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) - card.ability.extra.money_loss
            ease_dollars(-card.ability.extra.money_loss)
            return {
                mult = card.ability.extra.mult,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
    end
}
SMODS.Joker {
    key = "antimatter",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { mult = 1, dim1 = 1, dim2 = 1, rounds_held = 0 } },
    rarity = 3,
    blueprint_compat = true,
    perishable_compat = false,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
        if context.end_of_round and context.main_eval and not context.blueprint and not context.game_over then
            card.ability.extra.rounds_held = card.ability.extra.rounds_held + 1
            local msg
            if card.ability.extra.rounds_held == 1 then
                msg = localize("k_mul_antimatter_init")
            elseif card.ability.extra.rounds_held <= 3 then
                msg = localize("k_mul_antimatter_grow1")
            elseif card.ability.extra.rounds_held <= 6 then
                card.ability.extra.dim2 = 2
                msg = localize("k_mul_antimatter_grow2")
            elseif card.ability.extra.rounds_held <= 10 then
                card.ability.extra.dim2 = card.ability.extra.dim2 + 1
                msg = localize("k_mul_antimatter_grow3")
            else
                card.ability.extra.dim2 = card.ability.extra.dim2 + card.ability.extra.rounds_held - 9
                msg = localize("k_mul_antimatter_grow4")
            end
            card.ability.extra.dim1 = card.ability.extra.dim1 + card.ability.extra.dim2
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "dim1",
            })
            return { message = msg }
        end
    end
}
SMODS.Joker {
    key = "red_balloon",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { money = 1, rounds_held = 0, total_rounds = 3 } },
    blueprint_compat = true,
    eternal_compat = false,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.rounds_held, card.ability.extra.total_rounds } }
    end,
    calculate = function(self, card, context)
        G.GAME.dollar_buffer = (G.GAME.dollar_buffer or 0) + card.ability.extra.money
        if context.individual and context.cardarea == G.play then
            return {
                dollars = card.ability.extra.money,
                func = function()
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            G.GAME.dollar_buffer = 0
                            return true
                        end
                    }))
                end
            }
        end
        if context.end_of_round and context.main_eval and not context.game_over and not context.blueprint then
            card.ability.extra.rounds_held = card.ability.extra.rounds_held + 1
            if card.ability.extra.rounds_held >= 3 then
                SMODS.destroy_cards(card)
                return { message = localize("k_mul_popped") }
            else
                return { message = card.ability.extra.rounds_held .. "/" .. card.ability.extra.total_rounds }
            end
        end
    end
}
SMODS.Joker {
    key = "summoned_skull",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { xmult = 2.5 } },
    rarity = 3,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.buying_card and context.card == card and G.jokers and not context.blueprint then
            local pool = {}
            for _, c in ipairs(G.jokers.cards) do
                if c ~= card then
                    pool[#pool + 1] = c
                end
            end
            local joker_to_destroy = pseudorandom_element(pool, "mul_summoned_skull")
            SMODS.destroy_cards(joker_to_destroy)
        end
        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end
}
SMODS.Joker {
    key = "fifty_fifty",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { xmult = 3, mult = 3, odds = 2 } },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mul_fifty_fifty")
        return { vars = { num, denom, card.ability.extra.xmult, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            if SMODS.pseudorandom_probability(card, "mul_fifty_fifty", 1, card.ability.extra.odds) then
                return {
                    xmult = card.ability.extra.xmult,
                    message = localize("k_mul_won_fifty_fifty")
                }
            else
                return {
                    mult = card.ability.extra.mult,
                    message = localize("k_mul_lost_fifty_fifty")
                }
            end
        end
    end
}
SMODS.Joker {
    key = "victory_royale",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { odds = 100, decrement = 2 } },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mul_victory_royale")
        return { vars = { num, denom, card.ability.extra.decrement } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and
            #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            if SMODS.pseudorandom_probability(card, "mul_victory_royale", 1, card.ability.extra.odds) then
                card.ability.extra.odds = 100
                G.E_MANAGER:add_event(Event({
                    func = function()
                        SMODS.add_card({
                            set = "Spectral",
                            edition = "e_negative",
                            key_append = "mul_victory_royale",
                            skip_materialize = true
                        })
                        return true
                    end
                }))
                return {
                    message = localize("k_plus_spectral"),
                    colour = G.C.SECONDARY_SET.Spectral
                }
            elseif card.ability.extra.odds > 2 and not context.blueprint then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "odds",
                    scalar_value = "decrement",
                    operation = "-"
                })
            end
        end
    end
}
SMODS.Joker {
    key = "hammer_bro",
    atlas = "placeholder",
    pos = { x = 1, y = 0 },
    config = { extra = { mult = 5, xmult = 1.25, progress = 0, transmute_req = Multiverse.set_transmute_requirements(120) } },
    rarity = 2,
    cost = 7,
    blueprint_compat = true,
    transmutable_compat = true,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, {
            set = "Other",
            key = "mul_hammer_bro_hint"
        })
        return {
            vars = {
                card.ability.extra.mult,
                card.ability.extra.xmult,
                card.ability.extra.progress,
                card.ability.extra.transmute_req
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not context.blueprint then
                card.ability.extra.progress = card.ability.extra.progress + 1
            end
            if pseudorandom("hammer_bro", 1, 2) == 1 then
                return { xmult = card.ability.extra.xmult }
            else
                return { mult = card.ability.extra.mult }
            end
        end
        if context.joker_main and card.ability.extra.progress >= card.ability.extra.transmute_req then
            card:add_sticker("mul_transmutable", true)
        end
    end
}
SMODS.Joker {
    key = "stand_user",
    atlas = "placeholder",
    pos = { x = 2, y = 0 },
    config = { extra = { ante_change = 1, in_boss = false } },
    rarity = 3,
    cost = 8,
    blueprint_compat = false,
    eternal_compat = false,
    loc_vars = function(self, info_queue, card)
        return { vars = { -card.ability.extra.ante_change } }
    end,
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind then
            card.ability.extra.in_boss = G.GAME.blind.boss
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.in_boss = context.blind.boss
        end
        if context.end_of_round and context.game_over and context.main_eval and card.ability.extra.in_boss and not context.blueprint then
            ease_ante(-card.ability.extra.ante_change)
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
            G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - card.ability.extra.ante_change
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.destroy_cards(card)
                    return true
                end
            }))
            return {
                message = localize("k_saved_ex"),
                saved = "mul_stand_user",
                colour = G.C.RED
            }
        end
    end
}
SMODS.Joker {
    key = "foddian_struggle",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 0, mult_gain = 2 } },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        local suit = G.GAME.current_round.mul_foddian_suit or "Hearts"
        return {
            vars = {
                localize(suit, "suits_plural"),
                card.ability.extra.mult_gain,
                card.ability.extra.mult,
                colours = { G.C.SUITS[suit] }
            },
        }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            for _, c in ipairs(context.full_hand) do
                if c:is_suit(G.GAME.current_round.mul_foddian_suit) then
                    card.ability.extra.mult = 0
                    return {
                        message = localize("k_reset")
                    }
                end
            end
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "mult",
                scalar_value = "mult_gain",
            })
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}

local function set_foddian_suit()
    G.GAME.current_round.mul_foddian_suit = "Hearts"
    local valid = {}
    for _, c in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(c) then
            table.insert(valid, c)
        end
    end
    local foddian_card = pseudorandom_element(valid, "mul_foddian" .. G.GAME.round_resets.ante)
    if foddian_card then
        G.GAME.current_round.mul_foddian_suit = foddian_card.base.suit
    end
end

function SMODS.current_mod.reset_game_globals()
    set_foddian_suit()
end

SMODS.Joker {
    key = "peashooter",
    atlas = "placeholder",
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 0, mult_gain = 1 } },
    rarity = 1,
    cost = 6,
    blueprint_compat = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult_gain, card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.before and context.main_eval and not context.blueprint then
            if #context.full_hand == 1 then
                SMODS.scale_card(card, {
                    ref_table = card.ability.extra,
                    ref_value = "mult",
                    scalar_value = "mult_gain",
                })
            end
        end
        if context.joker_main and card.ability.extra.mult > 0 then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
}