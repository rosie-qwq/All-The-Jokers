SMODS.Enhancement {
    key = "calling_card",
    atlas = "calling_card",
    pos = { x = 0, y = 0 },
    config = { extra = { xmult = 2, boss_xmult = 3 } },
    replace_base_card = true,
    weight = 0,
    in_pool = function(self, args)
        return false
    end,
    update = function(self, card, dt)
        G.GAME.mul_call_card_anim_state = G.GAME.mul_call_card_anim_state or 0
        card.config.center.pos.x = math.floor(Multiverse.clamp(G.GAME.mul_call_card_anim_state, 0, 5))
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, card.ability.extra.boss_xmult } }
    end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if G.GAME.blind and G.GAME.blind.boss then
                return { xmult = card.ability.extra.boss_xmult }
            else
                return { xmult = card.ability.extra.xmult }
            end
        end
    end,
}
SMODS.Enhancement {
    key = "netherite",
    atlas = "placeholder_modifiers",
    pos = { x = 0, y = 0 },
    config = { h_x_mult = 2, h_dollars = 5, bonus = 75, h_chips = 75 },
    weight = 0,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus, card.ability.h_x_mult, card.ability.h_dollars } }
    end
}
SMODS.Enhancement {
    key = "normal",
    atlas = "placeholder_modifiers",
    pos = { x = 0, y = 0 },
    config = { bonus = 22 },
    weight = 5,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.bonus } }
    end
}
SMODS.Enhancement {
    key = "motivated",
    atlas = "placeholder_modifiers",
    pos = { x = 0, y = 0 },
    config = { extra = { retriggers = 1, odds = 4 } },
    weight = 5,
    loc_vars = function(self, info_queue, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, "mul_motivated")
        return { vars = { card.ability.extra.retriggers, num, denom } }
    end,
    calculate = function(self, card, context)
        if context.repetition then
            return {
                repetitions = card.ability.extra.retriggers
            }
        end
        if context.after and SMODS.pseudorandom_probability(card, "mul_motivated", 1, card.ability.extra.odds) then
            card:set_ability("c_base", nil, true)
        end
    end
}
SMODS.Enhancement {
    key = "waldo",
    atlas = "placeholder_modifiers",
    pos = { x = 0, y = 0 },
    config = { extra = { retrigger_inc = 1 } },
    weight = 0,
    always_scores = true,
    no_rank = true,
    no_suit = true,
    replace_base_card = true,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.retrigger_inc } }
    end,
    calculate = function(self, card, context)
        if context.repetition and context.cardarea == G.play then
            return {
                repetitions = card.ability.extra.retrigger_inc * #context.full_hand
            }
        end
    end
}
