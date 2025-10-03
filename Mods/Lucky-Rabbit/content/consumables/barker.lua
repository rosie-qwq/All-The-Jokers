if LR_CONFIG and LR_CONFIG.enhancements_enabled then
    SMODS.Consumable {
        key = "barker",
        set = "Silly",
        config = {
            max_highlighted = 2,
            mod_conv = "m_fmod_raffle_card",
        },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS.m_fmod_raffle_card
            return { vars = { card.ability.max_highlighted } }
        end,
        atlas = "Consumables",
        pos = { x = 4, y = 2 },
        cost = 3,
    }
end
