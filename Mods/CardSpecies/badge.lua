local makeBadge = SMODS.create_mod_badges
last_hovered_card = nil
function SMODS.create_mod_badges(obj, badges)
    makeBadge(obj, badges)
    if not obj then
        return
    end
    if obj.is_rank or obj.is_suit then
        return
    end

    -- print(obj.key)
    -- last_hovered_card = obj

    local badge = nil

    if obj.mod and G.P_CENTERS[obj.key] and G.P_CENTERS[obj.key].original_mod and (obj.mod ~= G.P_CENTERS[obj.key].original_mod) then
        return
    end

    if G.P_CENTERS[obj.key] and G.P_CENTERS[obj.key].species and not (obj.base_card and obj.base_card.base and obj.base_card.base.id) then
        badge = CardSpecies.badge_types[G.P_CENTERS[obj.key].species]
    end

    if obj.get_species then
        badge = CardSpecies.get_badge(obj)
    end
    badge = badge or CardSpecies.get_badge(obj)
    


    
    

    badges[#badges + 1] = {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
            {
                n = G.UIT.R,
                config = {
                    align = "cm",
                    colour = badge.colour,
                    r = 0.1,
                    minw = 2,
                    minh = 0.36,
                    emboss = 0.05,
                    padding = 0.027,
                },
                nodes = {
                    { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText({
                                string = CardSpecies.format(badge.specie_table),
                                colours = { badge.text_colour or G.C.WHITE },
                                silent = true,
                                float = true,
                                shadow = true,
                                offset_y = -0.03,
                                spacing = 1,
                                scale = 0.33 * 0.9,
                            }),
                        },
                    },
                    { n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
                },
            },
        },
    }
end