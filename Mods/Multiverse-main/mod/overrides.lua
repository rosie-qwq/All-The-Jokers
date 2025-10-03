SMODS.Joker:take_ownership("joker", {
    transmutable_compat = true,
    config = { extra = { mult = 4, tarots_used = { n = 0 }, transmute_req = Multiverse.set_transmute_requirements(15) } },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, {
            set = "Other", key = "mul_joker_hint"
        })
        return { vars = { card.ability.extra.mult, card.ability.extra.tarots_used.n, card.ability.extra.transmute_req } }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return { mult = card.ability.extra.mult }
        end
        if context.using_consumeable and not context.blueprint and context.consumeable.ability.set == "Tarot" then
            if not card.ability.extra.tarots_used[context.consumeable.config.center.key] then
                card.ability.extra.tarots_used[context.consumeable.config.center.key] = true
                card.ability.extra.tarots_used.n = card.ability.extra.tarots_used.n + 1
            end
            if card.ability.extra.tarots_used.n >= card.ability.extra.transmute_req then
                -- note to self: when adding modded stickers, must add mod prefix before sticker key
                card:add_sticker("mul_transmutable", true)
                -- another note to self: pass in true as 2nd argument to card:add_sticker()
            end
        end
    end
}, true)
SMODS.Joker:take_ownership("pareidolia", {
    transmutable_compat = true,
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, {
            set = "Other", key = "mul_pareidolia_hint"
        })
        return { vars = { card.ability.extra.hands_played.n, card.ability.extra.transmute_req } }
    end,
    config = { extra = { hands_played = { n = 0 }, transmute_req = Multiverse.set_transmute_requirements(5) } },
    calculate = function(self, card, context)
        if context.before and not context.blueprint then
            if not card.ability.extra.hands_played[context.scoring_name] then
                card.ability.extra.hands_played[context.scoring_name] = true
                card.ability.extra.hands_played.n = card.ability.extra.hands_played.n + 1
            end
            if card.ability.extra.hands_played.n >= card.ability.extra.transmute_req then
                card:add_sticker("mul_transmutable", true)
            end
        end
    end
}, true)
