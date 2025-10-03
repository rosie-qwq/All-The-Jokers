local G_UIDEF_use_and_sell_buttons_ref = G.UIDEF.use_and_sell_buttons

function G.UIDEF.use_and_sell_buttons(card)
    local abc = G_UIDEF_use_and_sell_buttons_ref(card)
        
    -- Remove sell button from abysmal jokers
    if
        card.area
        and card.area.config.type == "joker"
        and card.config
        and card.config.center
        and card.config.center.rarity == "crp_abysmal"
    then
        table.remove(abc.nodes[1].nodes, 1)
    end
    
    return abc
end