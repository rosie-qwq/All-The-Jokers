SMODS.Joker {
    key = 'hush_money',
    atlas = 'Placeholder',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    config = {
        extra = {
            money = 20,
            reduction = 2
        }
    },
    blueprint_compat = false,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return {
            vars = { stg.money, stg.reduction }
        }
    end,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.using_consumeable and context.consumeable.ability.set == 'Conspiracy' and not context.blueprint then
            stg.money = stg.money - stg.reduction
            return {
                message = '-' .. localize('$') .. stg.reduction,
                colour = G.C.RED,
                func = function()
                    if stg.money <= 0 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:start_dissolve()
                                return true;
                            end
                        }))
                    end
                end
            }
        end

        if context.selling_card and context.card.ability.set == 'Conspiracy' and not context.blueprint then
            stg.money = stg.money - stg.reduction
            return {
                message = '-' .. localize('$') .. stg.reduction,
                colour = G.C.RED,
                func = function()
                    if stg.money <= 0 then
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                card:start_dissolve()
                                return true;
                            end
                        }))
                    end
                end
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        local stg = card.ability.extra
        return stg.money
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_cspy_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
