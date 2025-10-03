SMODS.Booster {
    
    atlas = 'boosters_atlas',
    pos =  { x = 0, y = 0 },
    key = 'arts_crafts_small_1',
    unlocked = true,
	discovered = true,
    group_key = "artb_arts_crafts_pack",
    kind = "Arts and Crafts",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    config = { extra = 2, choose = 1},

    create_card = function(self, card)
        local card = create_card('art',G.consumeables,false, nil, true, true, nil, 'art')
        return card
    end,

    draw_hand = true,
   

    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.020,
            scale = 0.1,
            initialize = true,
            lifespan = 2,
            speed = 0.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {HEX("7ad4c9"), lighten(HEX("7ad4c9"), 0.4), lighten(HEX("60b2be"), 0.2)},
            fill = true
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("be5e6e"))
        ease_background_colour{new_colour = HEX("a4455d"), special_colour = HEX("be5e6e"), contrast = 2}
    end,

    weight = 2,

    cost = 4,

    in_pool = function() return true end
}

SMODS.Booster {
    
    atlas = 'boosters_atlas',
    pos =  { x = 1, y = 0 },
    key = 'arts_crafts_small_2',
    unlocked = true,
	discovered = true,
    group_key = "artb_arts_crafts_pack",
    kind = "Arts and Crafts",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    config = { extra = 2, choose = 1},

    create_card = function(self, card)
        local card = create_card('art',G.consumeables,false, nil, true, true, nil, 'art')
        return card
    end,

    draw_hand = true,
   

    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.020,
            scale = 0.1,
            initialize = true,
            lifespan = 2,
            speed = 0.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {HEX("7ad4c9"), lighten(HEX("7ad4c9"), 0.4), lighten(HEX("60b2be"), 0.2)},
            fill = true
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("be5e6e"))
        ease_background_colour{new_colour = HEX("a4455d"), special_colour = HEX("be5e6e"), contrast = 2}
    end,

    weight = 2,

    cost = 4,

    in_pool = function() return true end
}

SMODS.Booster {
    
    atlas = 'boosters_atlas',
    pos =  { x = 0, y = 1 },
    key = 'arts_crafts_jumbo',
    unlocked = true,
	discovered = true,
    group_key = "artb_arts_crafts_pack",
    kind = "Arts and Crafts",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    config = { extra = 4, choose = 1},

    create_card = function(self, card)
        local card = create_card('art',G.consumeables,false, nil, true, true, nil, 'art')
        return card
    end,

    draw_hand = true,
   

    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.020,
            scale = 0.1,
            initialize = true,
            lifespan = 2,
            speed = 0.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {HEX("7ad4c9"), lighten(HEX("7ad4c9"), 0.4), lighten(HEX("60b2be"), 0.2)},
            fill = true
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("be5e6e"))
        ease_background_colour{new_colour = HEX("a4455d"), special_colour = HEX("be5e6e"), contrast = 2}
    end,

    weight = 2,

    cost = 6,

    in_pool = function() return true end
}

SMODS.Booster {
    
    atlas = 'boosters_atlas',
    pos =  { x = 1, y = 1 },
    key = 'arts_crafts_mega',
    unlocked = true,
	discovered = true,
    group_key = "artb_arts_crafts_pack",
    kind = "Arts and Crafts",

    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.choose, card.ability.extra } }
    end,
    config = { extra = 4, choose = 2},

    create_card = function(self, card)
        local card = create_card('art',G.consumeables,false, nil, true, true, nil, 'art')
        return card
    end,

    draw_hand = true,
   

    particles = function(self)
        G.booster_pack_sparkles = Particles(1, 1, 0,0, {
            timer = 0.020,
            scale = 0.1,
            initialize = true,
            lifespan = 2,
            speed = 0.1,
            padding = -1,
            attach = G.ROOM_ATTACH,
            colours = {HEX("7ad4c9"), lighten(HEX("7ad4c9"), 0.4), lighten(HEX("60b2be"), 0.2)},
            fill = true
        })
    end,
    ease_background_colour = function(self)
        ease_colour(G.C.DYN_UI.MAIN, HEX("be5e6e"))
        ease_background_colour{new_colour = HEX("a4455d"), special_colour = HEX("be5e6e"), contrast = 2}
    end,

    weight = 2,

    cost = 8,

    in_pool = function() return true end
}