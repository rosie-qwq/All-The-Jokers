-- Epic Fail Tarot
SMODS.Atlas{
    key = 'epicfail',
    path = 'EpicFail.png',
    px = 71,
    py = 95,
}

SMODS.Consumable {
    set = "Tarot",
    key = "kaliimoddy_epicfail",
    atlas = "epicfail",
    config = {
        max_highlighted = 2,
        extra = 'faketp',
    },
    loc_vars = function(self, info_queue, card)
        -- Tooltip for enhancement
        info_queue[#info_queue+1] = G.P_CENTERS["m_kaliimoddy_faketp"]
        return { vars = { (card.ability or self.config).max_highlighted } }
    end,
    loc_txt = {
        name = 'Epic Fail',
        text = {
            "Select {C:attention}#1#{} cards to give a",
            "{C:red}Fake Transparent PNG Background{}."
        }
    },
    cost = 4,
    pos = { x = 0, y = 0 },

    can_use = function(self, card)
        return #G.hand.highlighted == (card.ability or self.config).max_highlighted
    end,

    use = function(self, card, area, copier)
        for i = 1, math.min(#G.hand.highlighted, (card.ability or self.config).max_highlighted) do
            G.E_MANAGER:add_event(Event({
                func = function()
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))

            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.1,
                func = function()
                    -- Apply the enhancement to the card
                    play_sound('kaliimoddy_XP')
                    G.hand.highlighted[i]:set_ability('m_kaliimoddy_faketp', nil, true)
                    return true
                end
            }))

            delay(0.5)
        end

        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                G.hand:unhighlight_all()
                return true
            end
        }))
    end
}
