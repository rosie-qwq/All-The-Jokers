SMODS.Joker {
    key = 'stone_mask',
    atlas = 'Jokers',
    pos = { x = 5, y = 1 },
    rarity = 3,
    cost = 8,
    unlocked = true,
    discovered = true,
    blueprint_compat = false,
    eternal_compat = true,
    perishable_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_foil
        info_queue[#info_queue + 1] = G.P_CENTERS.e_holo
        info_queue[#info_queue + 1] = G.P_CENTERS.e_polychrome
        info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = G.P_CENTERS['e_negative'].config.card_limit}}
        return {
            vars = { card.ability.max_highlighted }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.play and context.individual and #context.full_hand == 1 and G.GAME.current_round.hands_played == 0 then
            if context.other_card and context.other_card.ability.set == "Enhanced" and not context.other_card.edition and not context.repetition then
                local othercard = context.other_card
                G.E_MANAGER:add_event(Event({
                    func = function()
                        othercard:set_edition(poll_edition('tag', nil, false, true,
                            {
                                { name = 'e_foil',       weight = 32, },
                                { name = 'e_holo',       weight = 32, },
                                { name = 'e_polychrome', weight = 32, },
                                { name = 'e_negative',   weight = 4, }
                            }), true)
                        return true
                    end
                }))
            end
            return {
                message = localize('k_hnds_awaken'),
                colour = G.C.GREY,
                card = card
            }
        end
    end
}
