function CardSpecies.Specie(tab)
    if tab.specie_table and tab.key then
        CardSpecies.badge_types[tab.key] = tab

        if tab.classification then
            for i, specie in pairs(tab.specie_table) do
                local nexti = #CardSpecies.classifications[tab.classification].species + 1
                CardSpecies.classifications[tab.classification].species[nexti] = specie
            end
        end

        -- incredibly simple
    else
        error("Failed to initialize specie: Missing specie_table or key")
    end
end

--may optionally contain a set of species that are part of it
function CardSpecies.SpecieClassification(tab)
    if tab.key then
        tab.species = tab.species or {}
        if not tab.exclude_shape then
            tab.species[#tab.species + 1] = "Shapeshifter"
        end
        CardSpecies.classifications[tab.key] = tab
        -- incredibly simple
    else
        error("Failed to initialize specie classification: Missing key")
    end
end

function CardSpecies.PlayingCardOverride(tab)
    if not tab.key then
        error("Missing key in PlayingCardOverride.")
    end

    if not tab.specie then
        error("Missing specie in PlayingCardOverride. Key: " .. tab.key)
    end

    if (not tab.suit) and (not tab.rank) and (not tab.enhancement) then
        error("Missing condition in PlayingCardOverride. Key: " .. tab.key .. "\nUse a 'suit', 'rank' or 'enhancement' value") 
    end

    CardSpecies.PlayingCardOverrides[tab.key] = tab
end