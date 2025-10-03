SMODS.Joker {
    key = 'pot_of_greed',
    atlas = 'Jokers',
    pos = { x = 3, y = 1 },
    rarity = 1,
    cost = 4,
    unlocked = true,
    discovered = true,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    config =
    { extra = {
        draw_per_use = 2,
        currently_drawn = 0
    }
    },
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.draw_per_use, card.ability.extra.max_drawn } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.extra.currently_drawn = 0
        end

        if context.using_consumeable and G.hand and G.hand.cards and #G.hand.cards > 0 then
            card.ability.extra.currently_drawn = card.ability.extra.currently_drawn + card.ability.extra.draw_per_use
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up()
                    G.FUNCS.draw_from_deck_to_hand(card.ability.extra.draw_per_use)
                    return true
                end
            }))
            return {
                message = localize('k_hnds_IPLAYPOTOFGREED'),
                colour = G.C.GREEN,
                card = card
            }
        end
    end
}