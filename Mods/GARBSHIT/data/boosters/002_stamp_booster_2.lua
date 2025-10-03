return {
 SMODS.Booster {
        key = "stamp_booster_2",
        kind = "Joker",
        atlas = "GarbBoosters",
        group_key = "stamp_booster",
        pos = {x = 1, y = 0},
        config = {
            extra = 3,
            choose = 1
        },
        cost = 4,
        order = 1,
        weight = 1,
        unlocked = true,
        discovered = false,
        create_card = function(self, card)
            return create_card("Stamp", G.pack_cards, nil, nil, true, true, nil, nil)
        end,
        ease_background_colour = function(self)
            ease_colour(G.C.DYN_UI.MAIN, G.C.SET.Stamp)
            ease_background_colour({ new_colour = G.C.SET.Stamp, special_colour = G.C.BLACK, contrast = 2 })
        end,
    },

    }