SMODS.Joker {
    key = 'apophenia',
    atlas = 'Placeholder',
    pos = {
        x = 2,
        y = 0
    },
    rarity = 3,
    blueprint_compat = true,
    cost = 5,
    calculate = function(self, card, context)
        local stg = card.ability.extra

        if context.before and next(context.poker_hands["Straight"]) then
            G.E_MANAGER:add_event(Event({
                func = function()
                    SMODS.add_card({set='Conspiracy', edition = 'e_negative'})
                    card:juice_up()
                    return true;
                end
            }))
        end
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_cspy_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
