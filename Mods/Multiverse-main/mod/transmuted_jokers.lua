SMODS.Rarity {
    key = "transmuted",
    default_weight = 0,
    badge_colour = Multiverse.TRANSMUTED_GRADIENT,
    pools = {
        ["Joker"] = true
    }
}
SMODS.Joker {
    key = "ren_amamiya",
    atlas = "ren_amamiya",
    pos = { x = 0, y = 0 },
    soul_pos = { x = 1, y = 0 },
    rarity = "mul_transmuted",
    blueprint_compat = false,
    cost = 40,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_mul_calling_card)
        local tarots_held = { n = 0 }
        if G.consumeables then
            for _, c in ipairs(G.consumeables.cards) do
                if not tarots_held[c.config.center.key] and c.ability.set == "Tarot" then
                    tarots_held[c.config.center.key] = 1
                    tarots_held.n = tarots_held.n + 1
                end
            end
        end
        return { vars = { tarots_held.n } }
    end,
    config = { extra = {} },
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before then
                context.scoring_hand[1]:set_ability("m_mul_calling_card")
            end
            if context.initial_scoring_step then
                local has_call_card = false
                for _, c in ipairs(G.playing_cards) do
                    if c.config.center.key == "m_mul_calling_card" then
                        has_call_card = true
                        break
                    end
                end
                if has_call_card then
                    G.E_MANAGER:add_event(Event({
                        trigger = "ease",
                        ref_table = G.GAME,
                        ref_value = "mul_call_card_anim_state",
                        ease = "quad",
                        ease_to = 6,
                        delay = 1
                    }))
                end
            end
            if context.repetition and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_mul_calling_card") then
                local tarots_held = { n = 0 }
                if G.consumeables then
                    for _, c in ipairs(G.consumeables.cards) do
                        if not tarots_held[c.config.center.key] and c.ability.set == "Tarot" then
                            tarots_held[c.config.center.key] = 1
                            tarots_held.n = tarots_held.n + 1
                        end
                    end
                end
                if tarots_held.n > 0 then
                    return { repetitions = card.ability.extra.tarots_held.n }
                end
            end
            if context.after then
                local has_call_card = false
                for _, c in ipairs(G.playing_cards) do
                    if c.config.center.key == "m_mul_calling_card" then
                        has_call_card = true
                        break
                    end
                end
                if has_call_card then
                    G.E_MANAGER:add_event(Event({
                        trigger = "ease",
                        ref_table = G.GAME,
                        ref_value = "mul_call_card_anim_state",
                        ease = "quad",
                        ease_to = 0,
                        delay = 1
                    }))
                end
            end
        end
    end
}
SMODS.Joker {
    key = "steve",
    atlas = "placeholder",
    pos = { x = 4, y = 0 },
    rarity = "mul_transmuted",
    blueprint_compat = false,
    cost = 40,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS.m_mul_netherite)
        return { vars = { localize(card.ability.extra.suit, "suits_singular"), card.ability.extra.size_inc } }
    end,
    config = { extra = { suit = "Diamonds", size_inc = 5 } },
    add_to_deck = function(self, card, from_debuff)
        G.hand:change_size(card.ability.extra.size_inc)
    end,
    remove_from_deck = function(self, card, from_debuff)
        G.hand:change_size(-card.ability.extra.size_inc)
    end,
    calculate = function(self, card, context)
        if not context.blueprint then
            if context.before and context.main_eval and context.full_hand then
                for _, c in ipairs(context.full_hand) do
                    if c:is_suit(card.ability.extra.suit) then
                        c:set_ability("m_mul_netherite")
                    end
                end
            end
        end
    end
}
SMODS.Joker {
    key = "gerson",
    atlas = "placeholder",
    pos = { x = 4, y = 0 },
    rarity = "mul_transmuted",
    blueprint_compat = false,
    cost = 40,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.joker_xmult, card.ability.extra.increment } }
    end,
    config = { extra = { joker_xmult = 1, increment = 0.5 } },
    add_to_deck = function(self, card, from_debuff)
        if G.GAME.blind and G.GAME.blind.boss and not G.GAME.blind.disabled then
            card:juice_up(0.4, 0.4)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind:disable()
                    play_sound("mul_gerson_laugh", 1, 1)
                    delay(0.4)
                    return true
                end
            }))
        end
    end,
    calculate = function(self, card, context)
        if context.setting_blind and context.blind.boss and not context.blueprint then
            card.ability.extra.joker_xmult = card.ability.extra.joker_xmult + card.ability.extra.increment
            card:juice_up(0.4, 0.4)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.blind:disable()
                    play_sound("mul_gerson_laugh", 1, 1)
                    delay(0.4)
                    return true
                end
            }))
        end
        if context.other_joker and not context.blueprint and card.ability.extra.joker_xmult > 1 then
            return {
                xmult = card.ability.extra.joker_xmult
            }
        end
    end
}
SMODS.Joker {
    key = "waldo",
    atlas = "placeholder",
    pos = { x = 4, y = 0 },
    config = { extra = { xmult_inc = 0.5 } },
    rarity = "mul_transmuted",
    cost = 40,
    blueprint_compat = false,
    loc_vars = function(self, info_queue, card)
        local cards_in_deck = 0
        if G.playing_cards then
            cards_in_deck = #G.playing_cards
        end
        return { vars = { card.ability.extra.xmult_inc, (card.ability.extra.xmult_inc * cards_in_deck + 1) } }
    end,
    add_to_deck = function(self, card, from_debuff)
        if not from_debuff then
            SMODS.add_card({
                set = "Base",
                area = G.deck,
                skip_materialize = true,
                enhancement = "m_mul_waldo"
            })
        end
    end,
    calculate = function(self, card, context)
        if context.individual and not context.blueprint and SMODS.has_enhancement(context.other_card, "m_mul_waldo") then
            return {
                xmult = card.ability.extra.xmult_inc * #G.playing_cards + 1
            }
        end
    end,
}
