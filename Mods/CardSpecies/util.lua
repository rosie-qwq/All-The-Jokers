function CardSpecies.contains(table, check)
    for _, val in pairs(table) do
        if val == check then
            return true
        end
    end
    return false
end

function CardSpecies.overlap(table1, table2)
    local result = false

    for i, entry in pairs(table2) do
        if CardSpecies.contains(table1, entry) then
            return true
        end
    end
    return false
end

function CardSpecies.format(tab)
    local t = ""
    for i, entry in ipairs(tab) do
        t = t .. entry .. (tab[i + 1] and " " or "")
    end
    return t
end

function CardSpecies.get_available_species()
    local prns = {}

    for _, entry in pairs(CardSpecies.badge_types) do
        if entry.in_pool and entry.in_pool() then
            prns[#prns + 1] = entry
        end
    end
    return prns
end

function CardSpecies.badge_by_string(str)
    local n = 1
    local allowed = CardSpecies.get_available_species()

    for i = 1, #(str or "") do
        local code = string.byte(str, i, i)
        n = (code * i)
    end

    local randSpecie = pseudorandom_element(allowed, n + (G.GAME.pseudorandom.hashed_seed or 0)) --makes every card have a different gender every seed (basically every reincarnation theyll be different -Rosie)

    return randSpecie
end

function CardSpecies.badge_by_obj(obj)
    local badge = CardSpecies.badge_by_string(obj.key or (obj.center and obj.config.center.key))

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
        badge = CardSpecies.badge_by_string(res)

        for _,override in pairs(CardSpecies.PlayingCardOverrides) do
            local suit_pass = override.suit and (override.suit == suit.key) or (override.strict)
            local rank_pass = override.rank and (override.rank == rank.key) or (override.strict)
            local en_pass = override.enhancement and (override.enhancement == en) or (override.strict)
            if override.strict and (suit_pass and rank_pass and en_pass) or not override.strict and (suit_pass or rank_pass or en_pass) then
                badge = CardSpecies.badge_types[override.specie]
            end
        end
    end
    
    return badge
end

function CardSpecies.has(set, card)
    local check = CardSpecies.badge_types[CardSpecies.get(card)].specie_table
    local match = (CardSpecies.classifications[set] and CardSpecies.classifications[set].species) or {}
    return CardSpecies.overlap(check, match)
end

function CardSpecies.is(spcskey, card, strict)
    local species = CardSpecies.get(card)
    return (spcskey == species) or (not strict and species == "shape")
end

function CardSpecies.find_all(set, strict)
    local found = {}
    for _, cardarea in pairs(G.I.CARDAREA) do
        for __, card in pairs(cardarea.cards) do
            if strict then
                if CardSpecies.is(set, card, strict) then
                    found[#found + 1] = card
                end
            else
                if CardSpecies.has(set, card) then
                    found[#found + 1] = card
                end
            end
        end
    end

    return found
end

function CardSpecies.get(card)
    local species = CardSpecies.badge_by_obj(card).key
    if card.config and card.config.center and card.config.center.get_species then
        species = card.config.center:get_species(card)
    end

    if card.get_species and card.base_card then
        species = card:get_species(card.base_card)
    end
    return species
end

function CardSpecies.get_badge(card)
    -- functionally identical to get but it also gets the badge
    return CardSpecies.badge_types[CardSpecies.get(card)]
end

function CardSpecies.transform(card, specie)
    -- morphs cards
    card.config.center.species = specie
    return
end

get_adjacent_jokers = function(card) --stolen from pokermon xwx
  local jokers = {}
  if #G.jokers.cards > 1 then
    local pos = 0
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] == card then
        pos = i
        break
      end
    end
    if pos > 1 and G.jokers.cards[pos-1] then 
      table.insert(jokers, G.jokers.cards[pos-1])
    end
    if pos < #G.jokers.cards and G.jokers.cards[pos+1] then 
      table.insert(jokers, G.jokers.cards[pos+1])
    end
  end
  return jokers
end

get_non_adjacent_jokers = function(card) --modified this myself, hope it works -Rosie
  local jokers = {}
  if #G.jokers.cards > 1 then
    local pos = 0
    for i = 1, #G.jokers.cards do
      if G.jokers.cards[i] == card then
        pos = i
        break
      end
    end
    for i = 1, #G.jokers.cards do
      -- skip the card itself and its immediate neighbors
      if i ~= pos and i ~= pos - 1 and i ~= pos + 1 then
        table.insert(jokers, G.jokers.cards[i])
      end
    end
  end
  return jokers
end