-- -+-+-+-+-+-+-+-+-+-+-+-+-+-+-
--            JOKERS
-- -+-+-+-+-+-+-+-+-+-+-+-+-+-+-

studious_joker = { -- Studious Joker
    key = "studious_joker",
    -- loc_txt = {
    --     name = "Studious Joker",
    --     text = {
    --         "{C:mult}+#1#{} Mult. Sell this",
    --         "joker to get one",
    --         "{C:alchemical} Alchemical{} card"
    --     }
    -- },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.mult } }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    rarity = 1,
    cost = 5,
    effect = "",
    config = {
        mult = 4
    },
    atlas = "arcanum_joker_atlas",
    pos = { x = 0, y = 0 },

    calculate = function(self, card, context)
        if context.selling_self then -- and not context.blueprint then
            add_random_alchemical(card)
            return {
                card = card,
                message = localize('p_plus_alchemical'),
                colour = G.C.SECONDARY_SET.Alchemy
            }
        end

        if context.joker_main then
            return {
                mult = card.ability.mult
            }
        end
    end
}
if ReduxArcanumMod.config.new_content then
    studious_joker.config.mult = 3
end
SMODS.Joker(studious_joker)

SMODS.Joker { -- Bottled Buffoon
    key = "bottled_buffoon",
    loc_vars = function(self, info_queue, card)
        local loyalty
        if card.ability.loyalty_remaining == 0 then
            loyalty = 'loyalty_active'
        else
            loyalty = 'loyalty_inactive'
            if not card.ability.loyalty_remaining then
                card.ability.loyalty_remaining = 3
            end
        end
        return { vars = { card.ability.extra.every + 1, localize { type = 'variable', key = loyalty, vars = { card.ability.loyalty_remaining } } } }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    effect = "",
    config = {
        loyalty_remaining = 3,
        extra = {
            every = 3
        }
    },
    atlas = "arcanum_joker_atlas",
    pos = { x = 1, y = 0 },

    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.after then
            card.ability.loyalty_remaining = (card.ability.extra.every - 1 - (G.GAME.hands_played - card.ability.hands_played_at_create)) %
                (card.ability.extra.every + 1)
            if context.blueprint then
                if card.ability.loyalty_remaining == card.ability.extra.every then
                    add_random_alchemical(card)
                    card.ability.loyalty_remaining = card.ability.extra.every
                    return {
                        message = localize('p_plus_alchemical'),
                        colour = G.C.SECONDARY_SET.Alchemy
                    }
                end
            else
                if card.ability.loyalty_remaining == 0 then
                    local eval = function(_card) return (_card.ability.loyalty_remaining == 0) end
                    juice_card_until(card, eval, true)
                elseif card.ability.loyalty_remaining == card.ability.extra.every then
                    add_random_alchemical(card)
                    card.ability.loyalty_remaining = card.ability.extra.every
                    return {
                        message = localize('p_plus_alchemical'),
                        colour = G.C.SECONDARY_SET.Alchemy
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Mutated Joker
    key = "mutated_joker",
    loc_vars = function(self, info_queue, card)
        local alchemical_tally = 0
        for k, v in pairs(G.GAME.consumeable_usage) do
            if v.set == 'Alchemical' then alchemical_tally = alchemical_tally + 1 end
        end

        local expected_total_chips = alchemical_tally * card.ability.extra.chips

        return { vars = { card.ability.extra.chips, expected_total_chips } }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 1,
    cost = 5,
    effect = "",
    config = {
        extra = {
            chips = 10,
            total_chips = 0
        }
    },
    atlas = "arcanum_joker_atlas",
    pos = { x = 1, y = 2 },

    set_sprites = function(self, card, front)
        if self.discovered or card.bypass_discovery_center then
            local alchemical_tally = 0
            for k, v in pairs(G.GAME.consumeable_usage) do
                if v.set == 'Alchemical' then alchemical_tally = alchemical_tally + 1 end
            end

            if alchemical_tally >= 24 then
                local center = card.children.center
                center:set_sprite_pos({ x = 2, y = 2 })
            end
        end
    end,

    add_to_deck = function(self, card, context)
        local alchemical_tally = 0
        for k, v in pairs(G.GAME.consumeable_usage) do
            if v.set == 'Alchemical' then alchemical_tally = alchemical_tally + 1 end
        end

        local expected_total_chips = alchemical_tally * card.ability.extra.chips
        
        if expected_total_chips == 24 * card.ability.extra.chips then
            check_for_unlock({type = 'ReduxArcanum_mutated_joker_max'})
            local center = card.children.center
            center:set_sprite_pos({ x = 2, y = 2 })
        end

        card.ability.extra.total_chips = expected_total_chips
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Alchemical' and not context.blueprint then
            local alchemical_tally = 0
            for k, v in pairs(G.GAME.consumeable_usage) do
                if v.set == 'Alchemical' then alchemical_tally = alchemical_tally + 1 end
            end

            local expected_total_chips = alchemical_tally * card.ability.extra.chips

            if card.ability.extra.total_chips ~= expected_total_chips then
                if expected_total_chips == 24 * card.ability.extra.chips then
                    check_for_unlock({type = 'ReduxArcanum_mutated_joker_max'})
                    G.E_MANAGER:add_event(Event({
                        trigger = 'immediate',
                        func = function()
                            local center = card.children.center
                            center:set_sprite_pos({ x = 2, y = 2 })
                            return true
                        end
                    }))
                end
                card.ability.extra.total_chips = expected_total_chips

                return {
                    message = localize { type = 'variable', key = 'a_chips', vars = { expected_total_chips } }
                }
            end
            return
        end

        if context.joker_main then
            local alchemical_tally = 0
            for k, v in pairs(G.GAME.consumeable_usage) do
                if v.set == 'Alchemical' then alchemical_tally = alchemical_tally + 1 end
            end

            local expected_total_chips = alchemical_tally * card.ability.extra.chips

            return {
                message = localize { type = 'variable', key = 'a_chips', vars = { expected_total_chips } },
                chip_mod = expected_total_chips
            }
        end
    end
}

SMODS.Joker { -- Essence of Comedy
    key = "essence_of_comedy",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra, card.ability.x_mult } }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = false,
    eternal_compat = true,
    rarity = 2,
    cost = 6,
    effect = "",
    config = {
        extra = 0.1,
        Xmult = 1.0
    },
    atlas = "arcanum_joker_atlas",
    pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Alchemical' and not context.blueprint then
            card.ability.x_mult = card.ability.x_mult + card.ability.extra
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.x_mult } }
            }
        end
    end
}

SMODS.Joker { -- Shock Humor
    key = "shock_humor",
    loc_vars = function(self, info_queue, card)
        return { vars = {SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'ReduxArcanum_shock_humor')} }
    end,
    unlocked = true,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 5,
    effect = "",
    config = {
        extra = { odds = 5 }
    },
    atlas = "arcanum_joker_atlas",
    pos = { x = 1, y = 1 },

    calculate = function(self, card, context)
        if context.discard and not context.other_card.debuff then
            local other_card_enhancement = SMODS.get_enhancements(context.other_card)
            if other_card_enhancement["m_steel"] or other_card_enhancement["m_gold"] or other_card_enhancement["m_stone"] then
                if SMODS.pseudorandom_probability(card, 'shock_humor', 1, card.ability.extra.odds, 'ReduxArcanum_shock_humor') then
                    add_random_alchemical(card)
                    return {
                        message = localize('p_plus_alchemical'),
                        colour = G.C.SECONDARY_SET.Alchemy
                    }
                end
            end
        end
    end
}

SMODS.Joker { -- Breaking Bozo
    key = "breaking_bozo",
    locked_loc_vars = function(self, info_queue)
        return { vars = { self.unlock_condition.extra } }
    end,

    unlocked = false,
    unlock_condition = { extra = 5 },

    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 7,
    effect = "",
    config = {},
    atlas = "arcanum_joker_atlas",
    pos = { x = 2, y = 1 },

    check_for_unlock = function(self, args)
        if args.type == 'used_alchemical' then
            local alchemicals_count = 0
            for k, v in pairs(G.GAME.consumeable_usage) do
                if v.set == 'Alchemical' then alchemicals_count = alchemicals_count + v.count end
            end
            if alchemicals_count >= self.unlock_condition.extra then -- self.unlock_condition.extra then
                unlock_card(self)
            end
        end
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Alchemical' then
            local choice = math.random(1, 3)
            if choice == 1 then
                for i = 1, 2 do --draw cards from deckL
                    draw_card(G.deck, G.hand, i * 100 / 2, 'up', true)
                end
                return {
                    message = localize('p_alchemy_plus_card'),
                    colour = G.C.SECONDARY_SET.Alchemy
                }
            elseif choice == 2 then
                return {
                    dollars = 5
                }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        G.GAME.blind.chips = math.floor(G.GAME.blind.chips * 0.90)
                        G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

                        local chips_UI = G.hand_text_area.blind_chips
                        G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                        G.HUD_blind:recalculate()
                        chips_UI:juice_up()

                        if not silent then play_sound('chips2') end
                        return true
                    end
                }))
                return {
                    message = localize('p_alchemy_reduce_blind'),
                    colour = G.C.SECONDARY_SET.Alchemy
                }
            end
        end
    end
}

count_alchemical_uses = function()
    local alchemicals_count = 0
    for k, v in pairs(G.GAME.consumeable_usage) do
        if v.set == 'Alchemical' then alchemicals_count = alchemicals_count + v.count end
    end

    return alchemicals_count
end

chain_reaction = { -- Chain Reaction
    key = "chain_reaction",
    loc_vars = function(self, info_queue)
        if not ReduxArcanumMod.config.new_content then
            return { key = self.key .. "_classic" }
        end
    end,

    unlocked = false,
    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = true,
    rarity = 2,
    cost = 8,
    effect = "",
    config = {
        extra = {
            active = true,
            count = 0
        }
    },
    atlas = "arcanum_joker_atlas",
    pos = { x = 2, y = 0 },

    check_for_unlock = function(self, args)
        if args.type == 'discover_amount' then
            if G.DISCOVER_TALLIES.alchemicals.tally / G.DISCOVER_TALLIES.alchemicals.of >= 1 then -- self.unlock_condition.extra then
                unlock_card(self)
            end
        end
    end,

    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.ability.set == 'Alchemical' then
            if card.ability.extra.count == count_alchemical_uses() - 1 then
                if not context.blueprint then
                    card.ability.extra.active = false
                end
                if (not ReduxArcanumMod.config.new_content) or ((#G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit) or (context.consumeable.edition and context.consumeable.edition.negative)) then
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                    local _card
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            _card = copy_card(context.consumeable, nil, nil, nil)
                            if not ReduxArcanumMod.config.new_content then
                                _card:set_edition({ negative = true }, true)
                            end
                            _card:set_ability(context.consumeable.config.center) -- To handle polychrome
                            _card:add_to_deck()
                            G.play:emplace(_card)
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    }))
                    return {
                        message = localize('k_copied_ex'),
                        func = function ()
                            -- delay(0.5)
                            G.E_MANAGER:add_event(Event({
                                func = function()
                                    G.play:remove_card(_card)
                                    G.consumeables:emplace(_card)
                                    return true
                                end
                            }))
                            delay(0.15)
                        end
                    }
                end
                return
            end
        end

        if context.first_hand_drawn and not context.blueprint then
            card.ability.extra.active = true
            card.ability.extra.count = count_alchemical_uses()
            local eval = function() return card.ability.extra.active end
            juice_card_until(card, eval, true)
        end

        if context.end_of_round and not context.blueprint then
            card.ability.extra.active = false
        end
    end
}
if ReduxArcanumMod.config.new_content then
    chain_reaction.rarity = 3
end
SMODS.Joker(chain_reaction)

SMODS.Joker { -- Catalyst Joker
    key = "catalyst_joker",
    loc_vars = function(self, info_queue, card)
        local current_value = 1
        -- Check to prevent doing calculations on nill variables
        if G.consumeables then
            current_value = card.ability.extra.slots + card.ability.extra.bonus * (#G.consumeables.cards or 0)
        end
        return { vars = { card.ability.extra.bonus, current_value } }
    end,
    locked_loc_vars = function(self, info_queue)
        return { vars = { self.unlock_condition.extra } }
    end,
    unlocked = false,
    unlock_condition = { extra = 4 },

    discovered = false,
    blueprint_compat = true,
    perishable_compat = true,
    eternal_compat = false,
    rarity = 3,
    cost = 8,
    effect = "",
    config = {
        extra = {
            slots = 1,
            bonus = 0.5
        }
    },
    atlas = "arcanum_joker_atlas",
    pos = { x = 0, y = 2 },

    check_for_unlock = function(self, args)
        if args.type == "ReduxArcanum_modify_cards" and G.consumeables then
            if (#G.consumeables.cards or 0) >= self.unlock_condition.extra then
                unlock_card(self)
            end
        end
    end,

    add_to_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.consumeables.config.card_limit = G.consumeables.config.card_limit - 1
    end,

    calculate = function(self, card, context)
        if context.joker_main and #G.consumeables.cards > 0 then
            return {
                message = localize { type = 'variable', key = 'a_xmult', vars = { 1 + card.ability.extra.bonus * (#G.consumeables.cards or 0) } },
                Xmult_mod = 1 + card.ability.extra.bonus * (#G.consumeables.cards or 0),
                colour = G.C.MULT
            }
        end
    end
}
