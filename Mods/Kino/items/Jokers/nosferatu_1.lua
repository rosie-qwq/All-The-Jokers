SMODS.Joker {
    key = "nosferatu_1",
    order = 1,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            a_mult = 4,
            stacked_mult = 0
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 0 },
    cost = 2,
    blueprint_compat = true,
    perishable_compat = false,
    kino_joker = {
        id = 653,
        budget = 0,
        box_office = 0,
        release_date = "1900-01-01",
        runtime = 90,
        country_of_origin = "US",
        original_language = "en",
        critic_score = 100,
        audience_score = 100,
        directors = {},
        cast = {},
    },
    is_vampire = true,
    pools, k_genre = {"Horror", "Silent"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.a_mult,
                card.ability.extra.stacked_mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.cardarea == G.jokers then
            if context.before and not context.blueprint then
                -- Add mult and drain
                local enhanced = {}
                for k, v in ipairs(context.scoring_hand) do
                    if v.config.center ~= G.P_CENTERS.c_base and not v.debuff and not v.vampired then
                        enhanced[#enhanced+1] = v
                        v.vampired = true
                        v:set_ability(G.P_CENTERS.c_base, nil, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                v.vampired = nil
                                return true
                            end
                        }))
                    end
                end

                if #enhanced > 0 then
                    card.ability.extra.stacked_mult = card.ability.extra.stacked_mult + card.ability.extra.a_mult * #enhanced
                    return {
                        extra = { focus = card,
                        message = localize({type='variable', key='a_mult', vars = {card.ability.extra.stacked_mult}}),
                        colour = G.C.MULT,
                        card = card
                        }
                    }
                end
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.extra.stacked_mult
            }
        end
    end
}