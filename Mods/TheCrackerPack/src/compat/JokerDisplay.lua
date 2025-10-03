JokerDisplay.Definitions.j_cracker_saltinecracker = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}
JokerDisplay.Definitions.j_cracker_chocolatecoin = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money" },
    },
    text_config = { colour = G.C.GOLD },
    reminder_text = {
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "rounds" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = "(" .. localize("k_round") .. ")"
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.rounds
    end
}
JokerDisplay.Definitions.j_cracker_grahamcracker = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "grahamcracker_cards" },
        { text = "/" },
        { ref_table = "card.ability.extra",        ref_value = "cards_require" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.grahamcracker_cards = card.ability.grahamcracker_cards or card.ability.extra.cards_left
    end
}
JokerDisplay.Definitions.j_cracker_thrifty_joker = {
     text = {
        { text = "+" },
        { ref_table = "card.joker_display_values", ref_value = "mult", retrigger_type = "mult" }
    },
    calc_function = function(card)
        card.joker_display_values.mult = (math.max((table_length(G.GAME.used_vouchers) - (G.GAME.starting_voucher_count or 0)), 0) * card.ability.extra.vouchers_multiply)
    end,
    text_config = { colour = G.C.MULT },
}
JokerDisplay.Definitions.j_cracker_cheese = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions.j_cracker_cheese = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions.j_cracker_crackerbarrel = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "jokersleft" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.jokersleft
    end
}
JokerDisplay.Definitions.j_cracker_sacramentalkatana = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions.j_cracker_curry = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "localized_text" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.localized_text = localize("jdis_before")
    end
}
JokerDisplay.Definitions.j_cracker_northstar = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}
JokerDisplay.Definitions.j_cracker_thedealer = {
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'thedealer')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end,
}
JokerDisplay.Definitions.j_cracker_bomb = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra",              ref_value = "rounds" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.rounds
    end,
}
JokerDisplay.Definitions.j_cracker_cybernana = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
    extra = {
        {
            { text = "(" },
            { ref_table = "card.joker_display_values", ref_value = "odds" },
            { text = ")" },
        }
    },
    extra_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'Cybernana MK920')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end
}
JokerDisplay.Definitions.j_cracker_buttpopcorn = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "mult", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.MULT },
}
JokerDisplay.Definitions.j_cracker_frozencustard = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}
JokerDisplay.Definitions.j_cracker_hardseltzer = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "rounds" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.rounds
    end,
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return JokerDisplay.calculate_joker_triggers(joker_card)
    end
}
JokerDisplay.Definitions.j_cracker_canofbeans = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra",        ref_value = "rounds" },
        { text = "/" },
        { ref_table = "card.joker_display_values", ref_value = "start_count" },
        { text = ")" },
    },
    reminder_text_config = { scale = 0.35 },
    calc_function = function(card)
        card.joker_display_values.start_count = card.joker_display_values.start_count or card.ability.extra.rounds
    end
}
JokerDisplay.Definitions.j_cracker_tsukemen = {
    text = {
        {
            border_nodes = {
                { text = "X" },
                { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
            }
        }
    },
}
JokerDisplay.Definitions.j_cracker_bluecard = {
    text = {
        { text = "+" },
        { ref_table = "card.ability.extra", ref_value = "chips", retrigger_type = "mult" }
    },
    text_config = { colour = G.C.CHIPS },
}
JokerDisplay.Definitions.j_cracker_violetcard = {
    text = {
        border_nodes = {
            { text = "X" },
            { ref_table = "card.ability.extra", ref_value = "x_mult", retrigger_type = "exp" }
        }
    },
}
JokerDisplay.Definitions.j_cracker_indigocard = {
    text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "odds" },
        { text = ")" },
    },
    text_config = { colour = G.C.GREEN, scale = 0.3 },
    calc_function = function(card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'indigo')
        card.joker_display_values.odds = localize { type = 'variable', key = "jdis_odds", vars = { numerator, denominator } }
    end,
}
JokerDisplay.Definitions.j_cracker_pinkcard = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "h_size", colour = G.C.FILTER, retrigger_type = "mult" },
    },
    text_config = { colour = G.C.FILTER },
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] then
            text.children[1].config.colour = card.joker_display_values.active and G.C.FILTER or
                G.C.UI.TEXT_INACTIVE
        end
        return false
    end,
    calc_function = function(card)
        card.joker_display_values.active = card.ability.extra.current_add > 0
        card.joker_display_values.h_size = card.joker_display_values.active and ("+" .. (card.ability.extra.current_add and JokerDisplay.number_format(card.ability.extra.current_add) or 0)) or "-"
    end,
}
JokerDisplay.Definitions.j_cracker_yellowcard = {
    text = {
        { text = "+$" },
        { ref_table = "card.ability.extra", ref_value = "money" },
    },
    text_config = { colour = G.C.GOLD },
}
JokerDisplay.Definitions.j_cracker_blackcard = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.ability.extra", ref_value = "skips" },
        { text = "/" },
        { ref_table = "card.ability.extra", ref_value = "skips_needed" },
        { text = ")" },
    },
}
JokerDisplay.Definitions.j_cracker_whitecard = {
    text = {
        { ref_table = "card.joker_display_values", ref_value = "tarot_count", colour = G.C.SECONDARY_SET.Tarot, retrigger_type = "mult" },
    },
    text_config = { colour = G.C.FILTER },
    style_function = function(card, text, reminder_text, extra)
        if text and text.children[1] then
            text.children[1].config.colour = card.joker_display_values.active and G.C.SECONDARY_SET.Tarot or
                G.C.UI.TEXT_INACTIVE
        end
        return false
    end,
    calc_function = function(card)
        card.joker_display_values.active = card.ability.extra.active
        card.joker_display_values.tarot_count = card.joker_display_values.active and ("+" .. (G.consumeables.config.card_limit and JokerDisplay.number_format(G.consumeables.config.card_limit - #G.consumeables.cards) or 0)) or "-"
    end,
}
JokerDisplay.Definitions.j_cracker_rainbowcard = {
    reminder_text = {
        { text = "(" },
        { ref_table = "card.joker_display_values", ref_value = "active" },
        { text = ")" },
    },
    calc_function = function(card)
        card.joker_display_values.active = card.ability.extra.active and localize("jdis_active") or localize("jdis_inactive")
    end,
    retrigger_function = function(playing_card, scoring_hand, held_in_hand, joker_card)
        if held_in_hand then return 0 end
        return joker_card.ability.extra.retriggers * JokerDisplay.calculate_joker_triggers(joker_card) or 0
    end
}
