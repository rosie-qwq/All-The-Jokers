SMODS.Joker {
    key = "animblue",
    loc_txt = {
        name = "{C:blue}Blue{}",
        text = {
            "Increase the values of all {C:attention}Food Jokers{} by {C:attention}X#1#{}",
            "at end of round",
            credit("Scraptake")
        }
    },

    loc_vars = function(self, info_queue, card )
        return {vars = {card.ability.extra.change}}
    end,
    
    config = { extra = {change = 1.1} },
    rarity = 3,
    atlas = "main",
    pos = {x=5, y=3},
    soul_pos = {x=6, y=3},
    immutable = true,
    cost = 10,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.end_of_round and context.main_eval) then

            for i,joker in ipairs(G.jokers.cards) do
                
                local res = Cryptid.safe_get(joker.config.center, "pools", "Food")
                for j,pool in pairs(G.P_CENTER_POOLS) do
                    for k,pooljoker in pairs(pool) do
                        res = res or (pooljoker.key == joker.key)
                    end
                end

                if res then
                    Cryptid.manipulate(joker, {value=card.ability.extra.change})
                end
            
            end

        end
    end
}

SMODS.Joker {
    key = "animyellow",
    loc_txt = {
        name = "{C:money}Yellow{}",
        text = {
            "Create a {C:dark_edition}Negative{} {C:attention}Consumable{} when any",
            "{C:tarot}Tarot{} card is sold",
            credit("Scraptake")
        }
    },

    loc_vars = function(self, info_queue, card )
        
    end,
    
    config = { extra = {} },
    rarity = 3,
    atlas = "main",
    pos = {x=5, y=7},
    soul_pos = {x=6, y=7},
    immutable = true,
    cost = 12,
    demicoloncompat = true,
    calculate = function(self, card, context)
        
        if (context.selling_card and context.card.ability and context.card.ability.set == "Tarot") or context.forcetrigger then

            local not_a_codecard = SMODS.create_card({set = "Consumeables", edition = "e_negative"})
            not_a_codecard:add_to_deck()
            G.consumeables:emplace(not_a_codecard)
        end

    end
}

SMODS.Joker {
    key = "animorange",
    loc_txt = {
        name = "{C:attention}Orange{}",
        text = {
            "Create a random {C:dark_edition}Negative{} {C:attention}Consumable{} for each unscoring card played",
            credit("Scraptake")
        }
    },

    loc_vars = function(self, info_queue, card )

    end,
    
    config = { extra = {} },
    rarity = "valk_renowned",
    atlas = "main",
    pos = {x=5, y=5},
    soul_pos = {x=6, y=5},
    immutable = true,
    cost = 12,
    calculate = function(self, card, context)

        if context.before then
            local amount = (#context.full_hand - #context.scoring_hand)
            for i=1,amount do
                local c = SMODS.create_card({set = "Consumeables", edition = "e_negative"})
                c:add_to_deck()
                G.consumeables:emplace(c)
            end

        end

    end
}