return {
 SMODS.Booster {
        key = "stamp_booster_m",
        kind = "Joker",
        atlas = "GarbBoosters",
        group_key = "stamp_booster",
        pos = {x = 3, y = 0},
        config = {
            extra = 5,
            choose = 2
        },
        cost = 7,
        order = 1,
        weight = 0.5,
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