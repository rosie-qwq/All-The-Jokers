SMODS.ConsumableType {
    key = "mul_Myth",
    primary_colour = HEX("C5CC41"),
    secondary_colour = HEX("89C41B"),
    collection_rows = { 3, 4 },
    shop_rate = 2,
    default = "c_mul_holy_grail"
}
---@type table<string, {key: string, other: table<string, fun(): nil>}>
Multiverse.transmutations = {
    ["j_joker"] = {
        key = "j_mul_ren_amamiya",
        other = {
            grail = function ()
                for i = 1, 3 do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            SMODS.add_card({
                                key = "c_emperor",
                                edition = "e_negative",
                                key_append = "mul_holy_grail"
                            })
                            return true
                        end
                    }))
                end
            end,
        }
    },
    ["j_mul_villager"] = {
        key = "j_mul_steve",
        other = {
            grail = function ()
                for i = 1, 3 do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card_pool = { "c_tower", "c_chariot", "c_devil" }
                            SMODS.add_card({
                                key = pseudorandom_element(card_pool, "mul_holy_grail"),
                                edition = "e_negative",
                                key_append = "mul_holy_grail"
                            })
                            return true
                        end
                    }))
                end
            end,
        }
    },
    ["j_mul_hammer_bro"] = {
        key = "j_mul_gerson",
        other = {
            grail = function ()
                for i = 1, 3 do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card_pool = { "c_deja_vu", "c_mul_chair", }
                            SMODS.add_card({
                                key = pseudorandom_element(card_pool, "mul_holy_grail"),
                                edition = "e_negative",
                                key_append = "mul_holy_grail"
                            })
                            return true
                        end
                    }))
                end
            end
        }
    },
    ["j_pareidolia"] = {
        key = "j_mul_waldo",
        other = {
            grail = function ()
                for i = 1, 3 do
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local card_pool = { "c_lovers", "c_strength", "c_death" }
                            SMODS.add_card({
                                key = pseudorandom_element(card_pool, "mul_holy_grail"),
                                edition = "e_negative",
                                key_append = "mul_holy_grail"
                            })
                            return true
                        end
                    }))
                end
            end
        }
    }
}
SMODS.Consumable {
    key = "philosophers_stone",
    set = "mul_Myth",
    atlas = "p_stone",
    anim_info = { anim_time = .9, frames = 18, anim_progress = 0 },
    update = function(self, card, dt)
        Multiverse.update_card_anim(card, G.real_dt)
    end,
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1 },
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, {
            set = "Other",
            key = "mul_transmutable"
        })
        return { vars = { card.ability.max_highlighted } }
    end,
    in_pool = function(self, args)
        for _, c in ipairs(G.jokers.cards) do
            if c.ability.mul_transmutable then
                return true
            end
        end
        return false
    end,
    can_use = function(self, card)
        return (G.jokers.highlighted[1] and G.jokers.highlighted[1].ability or {}).mul_transmutable and
            #G.jokers.cards <=
            (G.jokers.config.card_limit - ((G.jokers.highlighted[1].edition or {}).negative and 1 or 0))
    end,
    use = function(self, card, area, copier)
        local joker_to_transmute = G.jokers.highlighted[1]
        local transmute_key = joker_to_transmute.config.center.key
        SMODS.destroy_cards(joker_to_transmute, true)
        local new_card = SMODS.add_card({
            set = "Joker",
            key = Multiverse.transmutations[transmute_key].key,
            no_edition = true,
            key_append = "mul_philosophers_stone"
        })
    end
}
SMODS.Consumable {
    key = "holy_grail",
    set = "mul_Myth",
    atlas = "holy_grail",
    anim_info = { anim_time = .9, frames = 18, anim_progress = 0 },
    update = function(self, card, dt)
        Multiverse.update_card_anim(card, G.real_dt)
    end,
    pos = { x = 0, y = 0 },
    config = { max_highlighted = 1, extra = { num_consumables = 3 } },
    discovered = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.num_consumables } }
    end,
    can_use = function(self, card)
        return (
            G.jokers.highlighted[1] and
            G.jokers.highlighted[1].ability and
            type(G.jokers.highlighted[1].ability.extra) == "table" and
            G.jokers.highlighted[1].ability.extra.transmute_req
        )
        -- in order to register a joker as transmutable,
        -- the joker must have transmute_req as a field in ability.extra
    end,
    use = function(self, card, area, copier)
        local j_key = G.jokers.highlighted[1].config.center.key
        if Multiverse.transmutations[j_key].other.grail then
            Multiverse.transmutations[j_key].other.grail()
        end
    end
}
