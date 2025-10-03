SMODS.Joker {
    key = "csp_suicide_pact",
    loc_txt = {
        name = "Suicide Pact",
        text = {
            "{C:attention}Destroys scored playing cards{}",
            "of the {C:attention}same Pronouns{} as",
            "the {C:attention}Joker{} to the {C:attention}right{}.",
            "(Current Pronouns: [pronoun_set])",
            "Gains {C:attention}+5 Mult{} for each {C:attention}card/joker{}",
            "{C:attention}destroyed{} by these effects.",
            "(Currently: {C:attention}[plus_mult] Mult{})"
        }
    },
    rarity = 3,
    atlas = 'csp_jokers',
    pos = { x = 1, y = 0 },
    cost = 4,
    update = function(self, card, dt)
    if G.jokers then
        local adjacent_jokers = get_adjacent_jokers(card)
        local non_adjacent_jokers = get_non_adjacent_jokers(card)

        -- transform this card to kitty
        CardSpecies.transform(card, "kitty")

        -- adjacent jokers to morphed kitties
        for i = 1, #adjacent_jokers do
            local j = adjacent_jokers[i]
            CardSpecies.transform(j, "m_kitty")
            j._is_kittybrained = true  -- remember that this joker became m_kitty
            j._is_m_shapeless = nil -- remove shapeless tag
        end

        -- non-adjacent jokers to shapeless if they were morphed kitties before
        for i = 1, #non_adjacent_jokers do
            local j = non_adjacent_jokers[i]
            if j._is_kittybrained then
                CardSpecies.transform(j, "shapeless")
                j._is_kittybrained = nil  -- reset flag after transformation
                j._is_m_shapeless = true -- make shapeless
            end
        end
    end
end
}