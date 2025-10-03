SMODS.Consumable {
    key = '5g',
    set = 'Conspiracy',
    atlas = 'Placeholder',
    pos = {
        x = 1,
        y = 2
    },
    config = {
        extra = {
            odds = 5,
            cards = 3
        }
    },
    cost = 4,
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        info_queue[#info_queue + 1] = G.P_CENTERS['c_cspy_conspiracy_dummy']
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil

        local consp_count = 0
        if G.consumeables then
            for k, v in pairs(G.consumeables.cards) do
                if v.ability.set == 'Conspiracy' then
                    consp_count = consp_count + 1
                end
            end
        end

        return { vars = { SMODS.get_probability_vars(card, consp_count, stg.odds, '5g'), stg.cards } }
    end,
    use = function(self, card, area, copier)
        local stg = card.ability.extra

        local consp_count = 1
        for k, v in pairs(G.consumeables.cards) do
            if v.ability.set == 'Conspiracy' then
                consp_count = consp_count + 1
            end
        end

        if SMODS.pseudorandom_probability(card, '5g', consp_count, stg.odds) then
            for k, v in pairs(G.hand.highlighted) do
                v:set_edition({ foil = true })
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = 0.2,
                    func = function()
                        card:juice_up()
                        return true;
                    end
                }))
            end
            delay(0.5)
        else
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 0.4,
                        func = function()
                            attention_text({
                                text = localize('k_nope_ex'),
                                scale = 1.3,
                                hold = 1.4,
                                major = card,
                                backdrop_colour = G.C.SECONDARY_SET.Tarot,
                                align = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and
                                    'tm' or 'cm',
                                offset = { x = 0, y = (G.STATE == G.STATES.TAROT_PACK or G.STATE == G.STATES.SPECTRAL_PACK or G.STATE == G.STATES.SMODS_BOOSTER_OPENED) and -0.2 or 0 },
                                silent = true
                            })
                            G.E_MANAGER:add_event(Event({
                                trigger = 'after',
                                delay = 0.06 * G.SETTINGS.GAMESPEED,
                                blockable = false,
                                blocking = false,
                                func = function()
                                    play_sound('tarot2', 0.76, 0.4); return true
                                end
                            }))
                            play_sound('tarot2', 1, 0.4)
                            card:juice_up(0.3, 0.5)
                            return true
                        end
                    }))
                    return true;
                end
            }))
        end
    end,
    can_use = function(self, card)
        local stg = card.ability.extra

        return #G.hand.highlighted <= stg.cards and #G.hand.highlighted > 0
    end,
    set_badges = function(self, card, badges)
        if self.discovered then
            badges[#badges + 1] = create_badge(localize('k_cspy_artist') .. ': anerdymous', G.C.BLACK, G.C.WHITE, 1)
        end
    end
}
