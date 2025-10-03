function CardPronouns.contains(table, check)
    for _, val in pairs(table) do
        if val == check then
            return true
        end
    end
    return false
end

function CardPronouns.overlap(table1, table2)
    local result = false

    for i, entry in pairs(table2) do
        if CardPronouns.contains(table1, entry) then
            return true
        end
    end
    return false
end

function CardPronouns.format(tab)
    local t = ""
    for i, entry in ipairs(tab) do
        t = t .. entry .. (tab[i + 1] and "/" or "")
    end
    return t
end

function CardPronouns.get_available_pronouns()
    local prns = {}

    for _, entry in pairs(CardPronouns.badge_types) do
        if entry.in_pool and entry.in_pool() then
            prns[#prns + 1] = entry
        end
    end
    return prns
end

function CardPronouns.badge_by_string(str)
    local n = 1
    local allowed = CardPronouns.get_available_pronouns()

    for i = 1, #(str or "") do
        local code = string.byte(str, i, i)
        n = (code * i)
    end

    local randPronoun = pseudorandom_element(allowed, n + (G.GAME.pseudorandom.hashed_seed or 0)) --makes every card have a different gender every seed (basically every reincarnation theyll be different -Rosie)

    return randPronoun
end

function CardPronouns.badge_by_obj(obj)
    local badge = CardPronouns.badge_by_string(obj.key or (obj.center and obj.config.center.key))

    local en = nil
    local suit = nil
    local rank = nil
    if obj.base_card and obj.base_card.base and obj.base_card.base.id then
        en = next(SMODS.get_enhancements(obj.base_card))
        suit = SMODS.Suits[obj.base_card.base.suit]
        rank = SMODS.Ranks[obj.base_card.base.value]
    end

    if obj.base and obj.base.id then
        en = next(SMODS.get_enhancements(obj))
        suit = SMODS.Suits[obj.base.suit]
        rank = SMODS.Ranks[obj.base.value]
    end

    if en or suit or rank then
        local res = suit.key .. rank.key .. (en or "")
        badge = CardPronouns.badge_by_string(res)

        for _,override in pairs(CardPronouns.PlayingCardOverrides) do
            local suit_pass = override.suit and (override.suit == suit.key) or (override.strict)
            local rank_pass = override.rank and (override.rank == rank.key) or (override.strict)
            local en_pass = override.enhancement and (override.enhancement == en) or (override.strict)
            if override.strict and (suit_pass and rank_pass and en_pass) or not override.strict and (suit_pass or rank_pass or en_pass) then
                badge = CardPronouns.badge_types[override.pronoun]
            end
        end
    end
    
    return badge
end

function CardPronouns.has(set, card)
    local check = CardPronouns.badge_types[CardPronouns.get(card)].pronoun_table
    local match = (CardPronouns.classifications[set] and CardPronouns.classifications[set].pronouns) or {}
    return CardPronouns.overlap(check, match)
end

function CardPronouns.is(prnskey, card, strict)
    local pronouns = CardPronouns.get(card)
    return (prnskey == pronouns) or (not strict and pronouns == "any_all")
end

function CardPronouns.find_all(set, strict)
    local found = {}
    for _, cardarea in pairs(G.I.CARDAREA) do
        for __, card in pairs(cardarea.cards) do
            if strict then
                if CardPronouns.is(set, card, strict) then
                    found[#found + 1] = card
                end
            else
                if CardPronouns.has(set, card) then
                    found[#found + 1] = card
                end
            end
        end
    end

    return found
end

function CardPronouns.get(card)
    local pronouns = CardPronouns.badge_by_obj(card).key
    if card.config and card.config.center and card.config.center.get_pronouns then
        pronouns = card.config.center:get_pronouns(card)
    end

    if card.get_pronouns and card.base_card then
        pronouns = card:get_pronouns(card.base_card)
    end
    return pronouns
end

function CardPronouns.get_badge(card)
    -- functionally identical to get but it also gets the badge
    return CardPronouns.badge_types[CardPronouns.get(card)]
end