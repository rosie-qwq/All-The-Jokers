SMODS.Joker {
    key = 'red_yarn',
    atlas = 'Placeholder',
    pos = {
        x = 0,
        y = 0
    },
    rarity = 1,
    config = {
        extra = {
            gain = 5
        }
    },
    blueprint_compat = true,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.gain, G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.conspiracy * stg.gain or 0 }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra
        if context.joker_main and G.GAME.consumeable_usage_total and G.GAME.consumeable_usage_total.conspiracy > 0 then
            return {
                mult = G.GAME.consumeable_usage_total.conspiracy * stg.gain
            }
        end

        if not context.blueprint and context.using_consumeable and context.consumeable.ability.set == "Conspiracy" then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.calculate_effect(
                        { message = localize { type = 'variable', key = 'a_mult', vars = { G.GAME.consumeable_usage_total.conspiracy * stg.gain } } },
                        card)
                    if next(SMODS.find_mod('Maximus')) then
                        SMODS.calculate_context({ scaling_card = true })
                    end
                    return true
                end
            }))
            return nil, true
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_cspy_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
