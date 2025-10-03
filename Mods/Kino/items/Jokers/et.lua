SMODS.Joker {
    key = "et",
    order = 27,
    generate_ui = Kino.generate_info_ui,
    config = {
        extra = {
            planets_created = 2
        }
    },
    rarity = 1,
    atlas = "kino_atlas_1",
    pos = { x = 0, y = 5},
    cost = 10,
    blueprint_compat = true,
    perishable_compat = true,
    kino_joker = {
        id = 601,
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
    pools, k_genre = {"Family", "Sci-fi"},

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.planets_created
            }
        }
    end,
    calculate = function(self, card, context)
        -- When you defeat a boss blind, create two negative planets
        if context.end_of_round and context.cardarea == G.jokers 
        and not context.individual and G.GAME.blind.boss then
            for i = 1, card.ability.extra.planets_created do
                G.E_MANAGER:add_event(Event({
                    func = function() 
                        local card = create_card("Planet",G.consumeables, nil, nil, nil, nil, nil, "et")
                        card:set_edition({negative = true}, true)
                        card:add_to_deck()
                        G.consumeables:emplace(card) 
                        return true
                    end}))
                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = localize('k_et')})
            end
        end
    end
}