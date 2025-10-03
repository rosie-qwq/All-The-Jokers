if Ortalab then
    local use_zoc = use_zodiac
    ---@param Card Card
    function use_zodiac(card)
        SMODS.calculate_context({akyrs_ortalab_zodiac_used = true, zodiac_card = card, zodiac_proto = G.ZODIACS[card.ability.extra.zodiac]})
        return use_zoc(card)
    end
end