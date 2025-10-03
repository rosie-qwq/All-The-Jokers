SMODS.Consumable {
    key = "lobotomized",
    set = "Tarot",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    config = { max_highlighted = 2, mod_conv = "m_mul_normal" },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS[card.ability.mod_conv])
        return { vars = { card.ability.max_highlighted } }
    end
}
SMODS.Consumable {
    key = "chair",
    set = "Tarot",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    config = { max_highlighted = 1, mod_conv = "m_mul_motivated" },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, G.P_CENTERS[card.ability.mod_conv])
        return { vars = { card.ability.max_highlighted } }
    end
}
SMODS.Consumable {
    key = "apple",
    set = "Tarot",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    in_pool = function(self, args)
        return Multiverse.config["joke"]
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        Multiverse.play_video("bad_apple")
        Multiverse.start_animation("black_bg")
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 218 * (G.SPEEDFACTOR or 1),
            func = function()
                Multiverse.stop_video("bad_apple")
                Multiverse.end_animation("black_bg")
                return true
            end
        }))
    end,
}
SMODS.Consumable {
    key = "burger",
    set = "Tarot",
    atlas = "placeholder",
    pos = { x = 0, y = 1 },
    in_pool = function(self, args)
        return Multiverse.config["joke"]
    end,
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        Multiverse.start_animation("eating_burger")
        G.E_MANAGER:add_event(Event({
            trigger = "after",
            delay = 60 * (G.SPEEDFACTOR or 1),
            blockable = false,
            blocking = false,
            func = function()
                Multiverse.end_animation("eating_burger")
                if G.jokers then
                    SMODS.add_card({
                        key = "j_gros_michel",
                        edition = "e_negative"
                    })
                end
                return true
            end
        }))
    end
}
