SMODS.Consumable {
    key = "eternity",
    set = "Spectral",
    atlas = "placeholder",
    pos = { x = 1, y = 1 },
    loc_vars = function(self, info_queue, card)
        table.insert(info_queue, {
            set = "Other",
            key = "eternal"
        })
        local has_incompat = false
        if G.jokers then
            for _, j in ipairs(G.jokers.cards) do
                if not j.config.center.eternal_compat then
                    has_incompat = true
                    break
                end
            end
        end
        return { key = (has_incompat and "c_mul_eternity_alt") or nil, vars = { 1 } }
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards >= 1 and #G.hand.highlighted == 1
    end,
    use = function(self, card, area, copier)
        local cards_to_destroy = {}
        for _, playing_card in ipairs(G.hand.cards) do
            if not playing_card.highlighted then
                cards_to_destroy[#cards_to_destroy + 1] = playing_card
            end
        end
        for _, joker in ipairs(G.jokers.cards) do
            if not joker.config.center.eternal_compat then
                cards_to_destroy[#cards_to_destroy + 1] = joker
            else
                joker:set_eternal(true)
            end
        end
        Multiverse.start_animation("lightning")
        G.E_MANAGER:add_event(Event({
            func = function()
                SMODS.destroy_cards(cards_to_destroy)
                return true
            end
        }))
    end
}
