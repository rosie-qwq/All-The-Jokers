SMODS.Blind {
    key = "limbo",
    atlas = "multiverse_blinds",
    pos = { x = 0, y = 0 },
    boss_colour = HEX("F2994B"),
    boss = { min = 1 },
    mult = 2,
    set_blind = function(self)
        Multiverse.add_limbo_keys()
        G.E_MANAGER:add_event(Event({
            func = function()
                Multiverse.limbo_keys_intro()
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 18.6 * (G.SPEEDFACTOR or 1)
        }))
    end,
    disable = function(self)
        if to_big(get_blind_amount(G.GAME.round_resets.ante) * to_big(2)) < G.GAME.blind.chips then
            G.GAME.blind.chips = get_blind_amount(G.GAME.round_resets.ante) * 2
            G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
        end
    end,
    loc_vars = function(self)
        return { vars = { 10 } }
    end,
    collection_loc_vars = function(self)
        return { vars = { 10 } }
    end,
    in_pool = function(self)
        return Multiverse.config.joke
    end
}
SMODS.Blind {
    key = "undying",
    atlas = "multiverse_blinds",
    pos = { x = 0, y = 1 },
    boss_colour = HEX("344245"),
    boss = { min = 1 },
    mult = 2,
    press_play = function(self)
        if not G.GAME.blind.disabled then
            Multiverse.undyne_spears = {}
            Multiverse.done_attacking = false
            Multiverse.in_undyne = true
            local num_attacks = Multiverse.start_undyne_attack()
            G.E_MANAGER:add_event(Event({
                trigger = "immediate",
                func = function()
                    if Multiverse.undyne_spears[num_attacks] and not Multiverse.undyne_spears[num_attacks].active and Multiverse.in_undyne then
                        G.E_MANAGER:add_event(Event({
                            trigger = "after",
                            blockable = false,
                            blocking = false,
                            delay = 0.5 * (G.SPEEDFACTOR or 1),
                            func = function()
                                Multiverse.in_undyne = false
                                return true
                            end
                        }))
                    end
                    return not Multiverse.in_undyne
                end
            }))
        end
    end,
    disable = function(self)
        if G.GAME.chips < to_big(0) then
            G.GAME.chips = to_big(0)
        end
    end,
    loc_vars = function(self)
        return { vars = { 10 } }
    end,
    in_pool = function(self)
        return Multiverse.config.joke
    end
}
