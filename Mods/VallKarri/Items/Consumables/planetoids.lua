SMODS.Atlas {
    path = "planetoids.png",
    key = "oid",
    px = 65,
    py = 79,
}

SMODS.ConsumableType {
    key = "Planetoid",
    collection_rows = {6, 6},
    primary_colour = HEX("D3ECF4"),
    secondary_colour = HEX("508DA0"),
    shop_rate = 0.05,
    loc_txt = {
        collection = "Planetoid Cards",
        label = "planetoid",
        name = "Planetoid Cards",
        undiscovered = {
            name = "go turn on unlock all",
            text = {
                "this mod is intended to be used",
                "with unlock all enabled"
            }
        }
    },
    default = "c_valk_kerberos",
}

local function key_to_name(str)
    str = str:gsub("__", ".")
    str = str:gsub("_", " ")
    str = str:gsub("(%a)([%w%.]*)", function(first, rest) return first:upper() .. rest end)
    return str
end

local planetoid_cards = {

    { pos = { x = 0, y = 0 }, hand = "High Card", name = "Kerberos" },
    { pos = { x = 1, y = 0 }, hand = "Pair", name = "Icarus" },
    { pos = { x = 3, y = 2 }, hand = "Two Pair", name = "Miranda" },
    { pos = { x = 2, y = 0 }, hand = "Three of a Kind", name = "Daedalus" },
    { pos = { x = 1, y = 2 }, hand = "Straight", name = "Pan" },
    { pos = { x = 0, y = 2 }, hand = "Flush", name = "Amalthea" },
    { pos = { x = 3, y = 0 }, hand = "Full House", name = "Cardea" },
    { pos = { x = 4, y = 0 }, hand = "Four of a Kind", name = "Eureka" },
    { pos = { x = 2, y = 2 }, hand = "Straight Flush", name = "Despina" },
    { pos = { x = 1, y = 1 }, hand = "Five of a Kind", name = "Tyche" },
    { pos = { x = 2, y = 1 }, hand = "Flush House", name = "Artemis" },
    { pos = { x = 0, y = 1 }, hand = "Flush Five", name = "Ixion" },
    { pos = { x = 4, y = 2 }, hand = "valk_fullmansion", name = "Dalamud" },
    
    { pos = { x = 3, y = 1 }, hand = "cry_Bulwark", name = "Euphrosyne", dep = {"Cryptid"} },
    { pos = { x = 4, y = 1 }, hand = "cry_UltPair", name = "Hektor", dep = {"Cryptid"} },
    { pos = { x = 0, y = 3 }, hand = "cry_Clusterfuck", name = "Protoplanetary_Disk", dep = {"Cryptid"} },
    { pos = { x = 1, y = 3 }, hand = "cry_WholeDeck", name = "2015_TC25", dep = {"Cryptid"} },
    { pos = { x = 2, y = 3 }, hand = "cry_None", name = "Zero", dep = {"Cryptid"} },


}

for i,planetoid in ipairs(planetoid_cards) do
    SMODS.Consumable {
        set = "Planetoid",
        key = planetoid.name,
        loc_txt = { 
            name = planetoid.name,
            text = {
                "Level up {C:attention}#1#{}",
                "for each time {C:attention}#4#{} has been",
                "used this run",
                "{C:inactive}(Currently {C:attention}#2#{C:inactive})",
                credit("mailingway"),
            }
        },
        pos = planetoid.pos,
        atlas = "oid",
        display_size = {w=64, h=78},

        config = { extra = { handtype = planetoid.hand, increase = 1 } },

        loc_vars = function(self, info_queue, card)

            return {vars = { localize(card.ability.extra.handtype, "poker_hands"), 1+(times_used(self.key)*card.ability.extra.increase),
                            card.ability.extra.increase, localize{type = "name_text", set = self.set, key = self.key} }}
            
        end,
        can_use = function()
            return true
        end,
        use = function(self, card, area, copier)
            update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {handname = localize(card.ability.extra.handtype, "poker_hands")})
            level_up_hand(card, card.ability.extra.handtype, nil, 1+(times_used(self.key)*card.ability.extra.increase))
            vallkarri.reset_hand_text()
        end,
        in_pool = function(self)
            return (G.GAME.hands[self.config.extra.handtype].played > 0)
        end,
        dependencies = planetoid.dep,
    }
end

SMODS.Booster {
    key = "planetoid_pack_1",
    atlas = "oid",
    kind = "Planetoid",
    pos = {x=3, y=3},
    discovered = true,
    loc_txt = {
        name = "Planetoid Pack",
        text = {
            "Pick {C:attention}#1#{} of up to",
            "{C:attention}#2#{} {C:planet}Planetoid{} cards to",
            "use immediately"
        },
        group_name = "Planetoid Booster Pack"
    },

    draw_hand = false,
    config = {choose = 1, extra = 3},
    display_size = {w=64, h=78},
    loc_vars = function(self, info_queue, card) 
        return {vars = {card.ability.choose, card.ability.extra}}
    end,

    weight = 2,
    cost = 5,

    create_card = function(self, card, i)
        ease_background_colour(HEX("508DA0"))
        return create_card("Planetoid", G.pack_cards, nil, nil, true, nil, nil, "valk_planetoid_pack")
        

    end,
    in_pool = function()
        return G.GAME.round_resets.ante >= 4
    end
}

SMODS.Booster {
    key = "planetoid_pack_2",
    atlas = "oid",
    kind = "Planetoid",
    pos = {x=4, y=3},
    discovered = true,
    loc_txt = {
        name = "Planetoid Pack",
        text = {
            "Pick {C:attention}#1#{} of up to",
            "{C:attention}#2#{} {C:planet}Planetoid{} cards to",
            "use immediately"
        },
        group_name = "Planetoid Booster Pack"
    },

    draw_hand = false,
    config = {choose = 1, extra = 3},
    display_size = {w=64, h=78},
    loc_vars = function(self, info_queue, card) 
        return {vars = {card.ability.choose, card.ability.extra}}
    end,

    weight = 2,
    cost = 5,

    create_card = function(self, card, i)
        ease_background_colour(HEX("508DA0"))
        return create_card("Planetoid", G.pack_cards, nil, nil, true, nil, nil, "valk_planetoid_pack")
        

    end,
    in_pool = function()
        return G.GAME.round_resets.ante >= 4
    end
}