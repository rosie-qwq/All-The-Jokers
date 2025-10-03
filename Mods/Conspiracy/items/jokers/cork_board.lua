SMODS.Joker {
    key = 'cork_board',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 0
    },
    rarity = 2,
    config = {
        extra = {
            Xmult = 2
        }
    },
    blueprint_compat = true,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.Xmult }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.other_consumeable and context.other_consumeable.ability.set == 'Conspiracy' then
            G.E_MANAGER:add_event(Event({
                func = function()
                    context.other_consumeable:juice_up()
                    return true;
                end
            }))
            return {
                x_mult = stg.Xmult,
                message_card = card
            }
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_cspy_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
