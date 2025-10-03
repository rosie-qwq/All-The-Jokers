canio_deck = SMODS.Back { --Canio Deck
    name = "Canio Deck",
    key = "caniodeck",
    order = 16,
    unlocked = true,
    discovered = true,
    config = { extra = { odds = 7 } },
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 0, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
    end,
    calculate = function(self, back, context)
        if context.discard then
            if SMODS.pseudorandom_probability(self, pseudoseed('caniodeck'), 1, self.config.extra.odds, 'caniodeck') then
                G.E_MANAGER:add_event(Event({
                    trigger = 'before',
                    delay = 0.33,
                    func = function()
                        context.other_card:start_dissolve()
                        for i = 1, #G.jokers.cards do
                            G.jokers.cards[i]:calculate_joker({ remove_playing_cards = true, removed = { context.other_card } })
                        end
                        return true
                    end
                }))
            end
        end
    end
}

triboulet_deck = SMODS.Back { --Triboulet Deck
    name = "Triboulet Deck",
    key = "tribouletdeck",
    order = 17,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 11, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
    end,
    calculate = function(self, back, context)
        if (context.cardarea == G.play or context.cardarea == G.hand) and context.repetition and (context.other_card:get_id() == 12 or context.other_card:get_id() == 13) then
            return {
                message = localize('k_again_ex'),
                repetitions = 1,
                card = card
            }
        end
    end
}

yorick_deck = SMODS.Back { --Yorick Deck
    name = "Yorick Deck",
    key = "yorickdeck",
    order = 18,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 13, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.yorickdeck = true
    end,
    calculate = function(self, back, context)
    end
}

chicot_deck = SMODS.Back { --Chicot Deck
    name = "Chicot Deck",
    key = "chicotdeck",
    order = 19,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 2, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.chicotdeck = true
    end,
    calculate = function(self, back, context)
    end
}

perkeo_deck = SMODS.Back { --Perkeo Deck
    name = "Perkeo Deck",
    key = "perkeodeck",
    order = 20,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 7, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.perkeodeck = true
        G.GAME.starting_params.consumables_used = 0
        G.GAME.starting_params.consumables_perkeodeck = {}
    end,
    calculate = function(self, back, context)
        if context.using_consumeable then
            G.GAME.starting_params.consumables_used = G.GAME.starting_params.consumables_used + 1
            table.insert(G.GAME.starting_params.consumables_perkeodeck, context.consumeable.config.center.key)
            if G.GAME.starting_params.consumables_used % 4 == 0 then
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.4,
                    func = function()
                        play_sound('timpani')
                        local index
                        if G.GAME.starting_params.perkeofixed then
                            index = #G.GAME.starting_params.consumables_perkeodeck
                        else
                            index = pseudorandom('perkeodek', 1, #G.GAME.starting_params.consumables_perkeodeck)
                        end
                        local card = create_card('Tarot_Planet', G.consumeables, nil, nil, nil, nil,
                            G.GAME.starting_params.consumables_perkeodeck
                            [index],
                            'perkeodeck')
                        card:set_edition({ negative = true }, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                        G.GAME.starting_params.consumables_perkeodeck = {}
                        return true
                    end
                }))
            elseif (G.GAME.starting_params.consumables_used + 1) % 4 == 0 then
                local eval = function(card) return (G.GAME.starting_params.consumables_used + 1) % 4 == 0 end
                if G.consumables.cards then
                    for i = 1, #G.consumeables.cards do
                        if G.consumeables.cards[i].ability
                            and (G.consumeables.cards[i].ability.set == 'Tarot'
                                or G.consumeables.cards[i].ability.set == 'Planet'
                                or G.consumeables.cards[i].ability.set == 'Spectral') then
                            juice_card_until(G.consumeables.cards[i], eval, true)
                        end
                    end
                end
                if G.shop_jokers.cards then
                    for i = 1, #G.shop_jokers.cards do
                        if G.shop_jokers.cards[i].ability
                            and (G.shop_jokers.cards[i].ability.set == 'Tarot'
                                or G.shop_jokers.cards[i].ability.set == 'Planet'
                                or G.shop_jokers.cards[i].ability.set == 'Spectral') then
                            juice_card_until(G.shop_jokers.cards[i], eval, true)
                        end
                    end
                end
            end
        end
    end
}

dusk_deck = SMODS.Back { --Dusk Deck
    name = "Dusk Deck",
    key = "duskdeck",
    order = 21,
    unlocked = true,
    discovered = true,
    config = { hands = -1 },
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 4, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
    end,
    calculate = function(self, back, context)
        if context.cardarea == G.play and context.repetition and G.GAME.current_round.hands_left == 0 then
            return {
                message = localize('k_again_ex'),
                repetitions = 2,
                card = card
            }
        end
    end
}

grosmichel_deck = SMODS.Back { --Gros Michel Deck
    name = "Gros Michel Deck",
    key = "grosmicheldeck",
    order = 22,
    unlocked = true,
    discovered = true,
    config = { jokers = { "j_gros_michel" }, extra = { odds = 6 } },
    loc_vars = function(self, info_queue, center)
        return { vars = { localize { type = 'name_text', key = 'j_gros_michel', set = 'Joker' } } }
    end,
    pos = { x = 5, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
    end,
    calculate = function(self, back, context)
        if context.end_of_round and not context.repetition and not context.individual then
            local eligibles = {}
            for i = 1, #G.jokers.cards do
                if not G.jokers.cards[i].ability.eternal then
                    table.insert(eligibles, G.jokers.cards[i])
                end
            end
            local filtered_eligibles = {}
            if #eligibles > 0 then
                table.insert(filtered_eligibles, eligibles[1])
            end
            if G.GAME.starting_params.grosmichelsleeve then
                if #eligibles > 1 then
                    table.insert(filtered_eligibles, eligibles[2])
                end
            end
            for k, eligible in pairs(filtered_eligibles) do
                local r_val = nil
                if SMODS.pseudorandom_probability(self, pseudoseed('grosmicheldeck'), 1, self.config.extra.odds, 'grosmicheldeck') then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            play_sound('tarot1')
                            eligible.T.r = -0.2
                            eligible:juice_up(0.3, 0.4)
                            eligible.states.drag.is = true
                            eligible.children.center.pinch.x = true
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.3,
                                blockable = false,
                                func = function()
                                    G.jokers:remove_card(eligible)
                                    eligible:remove()
                                    eligible = nil
                                    return true;
                                end
                            }))
                            return true
                        end
                    }))
                    r_val = {
                        message = localize('k_extinct_ex')
                    }
                    if self.ability and self.ability.name == 'Gros Michel' then
                        G.GAME.pool_flags.gros_michel_extinct = true
                        check_for_unlock({ type = 'gros_extinct' })
                    end
                else
                    r_val = {
                        message = localize('k_safe_ex')
                    }
                end
                card_eval_status_text(eligible, 'jokers', nil, nil, nil, r_val)
            end
        end
    end
}

hieroglyph_deck = SMODS.Back { --Hieroglyph Deck
    name = "Hieroglyph Deck",
    key = "hieroglyphdeck",
    order = 23,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 6, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.win_ante = 10
        local m = 1
        if CardSleeves and G.GAME.selected_sleeve == "sleeve_shen_hieroglyph" and G.GAME.selected_back_key.key == "b_shen_hieroglyphdeck" then
            m = 2
        end
        ease_ante(-m)
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante or G.GAME.round_resets.ante
        G.GAME.round_resets.blind_ante = G.GAME.round_resets.blind_ante - m
    end,
    calculate = function(self, back, context)
    end
}

freaky_deck = SMODS.Back { --Freaky Deck
    name = "Freaky Deck",
    key = "freakydeck",
    order = 24,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 0, y = 0 },
    atlas = "shenFreakyDeck",
    apply = function(self, back)
        G.GAME.starting_params.freakydeck = true;
    end,
    calculate = function(self, back, context)
        if context.selling_card and context.card.ability.set == 'Joker' then
            play_sound('shen_freaky_scream', pseudorandom('freaker') / 5 + .9, 1)
        end
        if context.other_joker then
            local j = context.other_joker
            if j and j.ability.freaky_effect and not context.blueprint then
                if #G.jokers.cards > 1 then
                    local idx = nil
                    for i = 2, #G.jokers.cards do
                        if G.jokers.cards[i] == j then
                            idx = i
                            break
                        end
                    end
                    if idx then
                        if G.jokers.cards[idx - 1].ability.freaky_effect
                            and G.jokers.cards[idx - 1].ability.freaky_effect < G.jokers.cards[idx].ability.freaky_effect then
                            card_eval_status_text(G.jokers.cards[idx - 1], 'extra', 1.5, nil, nil, {
                                message = localize('k_freaky') })
                            card_eval_status_text(G.jokers.cards[idx], 'x_mult', 1.5, nil, nil, nil)
                            return {
                                Xmult_mod = 1.5
                            }
                        else
                            if j.ability.freaky_effect == 2
                                and #G.jokers.cards > idx
                                and G.jokers.cards[idx + 1].ability.freaky_effect
                                and G.jokers.cards[idx + 1].ability.freaky_effect == 0
                                and G.jokers.cards[idx - 1].ability.freaky_effect
                                and G.jokers.cards[idx - 1].ability.freaky_effect == 4 then
                                card_eval_status_text(G.jokers.cards[idx - 1], 'extra', 4.2, nil, nil, {
                                    message = localize('k_420') })
                                card_eval_status_text(G.jokers.cards[idx], 'x_mult', 4.2, nil, nil, nil)
                                return {
                                    Xmult_mod = 4.2
                                }
                            end
                            if j.ability.freaky_effect == 0
                                and G.jokers.cards[idx - 1].ability.freaky_effect
                                and G.jokers.cards[idx - 1].ability.freaky_effect == 2
                                and G.jokers.cards[idx - 2]
                                and G.jokers.cards[idx - 2].ability.freaky_effect
                                and G.jokers.cards[idx - 2].ability.freaky_effect == 4 then
                                card_eval_status_text(G.jokers.cards[idx - 1], 'extra', 4.2, nil, nil, {
                                    message = localize('k_420') })
                                card_eval_status_text(G.jokers.cards[idx], 'x_mult', 4.2, nil, nil, nil)
                                return {
                                    Xmult_mod = 4.2
                                }
                            end
                        end
                    end
                end
            end
        end
    end
}

showman_deck = SMODS.Back { --Showman Deck
    name = "Showman Deck",
    key = "showmandeck",
    order = 25,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 8, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.showmandeck = true;
    end,
    calculate = function(self, back, context)
    end
}

snakeskin_deck = SMODS.Back { --Snakeskin Deck
    name = "Snakeskin Deck",
    key = "snakeskindeck",
    order = 26,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 9, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
    end,
    calculate = function(self, back, context)
        if (G.GAME.current_round.hands_played > 0 or G.GAME.current_round.discards_used > 0) and not G.booster_pack and not G.shop and context.drawing_cards then
            return {
                cards_to_draw = 3
            }
        end
    end
}

turtlebean_deck = SMODS.Back { --Turtle Bean Deck
    name = "Turtle Bean Deck",
    key = "turtlebeandeck",
    order = 27,
    unlocked = true,
    discovered = true,
    config = { hand_size = 5 },
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 12, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.turtlebeandeck_hand_reduction = 0
    end,
    calculate = function(self, back, context)
        if context.after or context.pre_discard then
            G.hand:change_size(-1)
            G.GAME.starting_params.turtlebeandeck_hand_reduction = G.GAME.starting_params.turtlebeandeck_hand_reduction +
                1
        elseif context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            G.hand:change_size(G.GAME.starting_params.turtlebeandeck_hand_reduction)
            G.GAME.starting_params.turtlebeandeck_hand_reduction = 0
        end
    end
}

if shenanigans_mod_config.temple_deck then
    temple_deck = SMODS.Back { --Temple Deck
        name = "Temple Deck",
        key = "templedeck",
        order = 28,
        unlocked = true,
        discovered = true,
        config = { vouchers = { "v_shen_balance", "v_shen_power" } },
        loc_vars = function(self, info_queue, center)
            return { vars = { localize { type = 'name_text', key = 'v_shen_balance', set = 'Voucher' }, localize { type = 'name_text', key = 'v_shen_power', set = 'Voucher' } } }
        end,
        pos = { x = 10, y = 0 },
        atlas = "shenDecks",
        apply = function(self, back)
            G.GAME.starting_params.hand_size = G.GAME.starting_params.hand_size - 1
        end,
        calculate = function(self, back, context)
        end
    }
end

cartomancer_deck = SMODS.Back { --Cartomancer Deck
    name = "Cartomancer Deck",
    key = "cartomancerdeck",
    order = 29,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 1, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.cartomancerdeck_key = nil
    end,
    calculate = function(self, back, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if G.consumeables.config.card_limit > #G.consumeables.cards then
                        play_sound('timpani')
                        local card
                        if G.GAME.starting_params.cartomancerdeck_key == nil then
                            card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, nil, 'cartomancerdeck')
                            G.GAME.starting_params.cartomancerdeck_key = card.config.center.key
                        else
                            card = create_card('Tarot', G.consumeables, nil, nil, nil, nil,
                                G.GAME.starting_params.cartomancerdeck_key, 'cartomancerdeck')
                        end
                        card:add_to_deck()
                        G.consumeables:emplace(card)
                    end
                    return true
                end
            }))
        end
        if context.round_eval and G.GAME.last_blind and G.GAME.last_blind.boss then
            G.GAME.starting_params.cartomancerdeck_key = nil
        end
    end
}

diplopia_deck = SMODS.Back { --Diplopia Deck
    name = "Diplopia Deck",
    key = "diplopiadeck",
    order = 30,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 3, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.diplopiadeck = true
    end,
    calculate = function(self, back, context)
    end
}

riffraff_deck = SMODS.Back { --Riff-Raff Deck
    name = "Riff-Raff Deck",
    key = "riffraffdeck",
    order = 31,
    unlocked = true,
    discovered = true,
    config = {},
    loc_vars = function(self, info_queue, center)
        return { vars = {} }
    end,
    pos = { x = 14, y = 0 },
    atlas = "shenDecks",
    apply = function(self, back)
        G.GAME.starting_params.riffraffdeck = true
        G.GAME.joker_buffer = 1
        G.E_MANAGER:add_event(Event({
            func = function()
                local jokies = {}
                for i = 1, #G.P_JOKER_RARITY_POOLS do
                    for j = 1, #G.P_JOKER_RARITY_POOLS[i] do
                        if G.P_JOKER_RARITY_POOLS[i][j].eternal_compat then
                            table.insert(jokies, G.P_JOKER_RARITY_POOLS[i][j].key)
                        end
                    end
                end
                local chosen = pseudorandom_element(jokies, pseudoseed('riffraffdeck'))
                local card = create_card('Joker', G.jokers, nil, 0, nil, nil, chosen, 'rif_deck')
                card:add_to_deck()
                card:set_eternal(true)
                card:set_edition(nil, true)
                G.jokers:emplace(card)
                G.GAME.starting_params.riffraff_selected_joker = chosen
                card:start_materialize()
                G.GAME.joker_buffer = 0
                return true
            end
        }))
    end,
    calculate = function(self, back, context)
    end
}
