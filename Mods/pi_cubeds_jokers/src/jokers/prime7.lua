SMODS.Joker { --Prime 7
    key = 'prime7',
    loc_txt = {
        name = "Prime 7",
        text = {
            "If hand is a single {C:attention}7{},",
            "it becomes {C:dark_edition}Negative{}"
        }
    },
    pronouns = 'she_her',
    rarity = 3,
    atlas = 'PiCubedsJokers',
    pos = { x = 7, y = 0 },
    soul_pos = { x = 3, y = 3},
    cost = 7,
    discovered = true,
    blueprint_compat = false,
    perishable_compat = true,
    eternal_compat = true,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = G.P_CENTERS['e_negative'].config.card_limit} }
        return {
            vars = { card.ability.max_highlighted }
        }
    end,
    
    calculate = function(self, card, context)
        if not context.blueprint and context.before then 
            if #context.full_hand == 1 then
                for k, v in ipairs(context.scoring_hand) do
                    if not v.debuff and v.base.value == '7' then 
                        v:set_edition('e_negative', false, true)
                        G.E_MANAGER:add_event(Event({
                            func = function()
                                v:juice_up()
                                return true
                            end
                        }))
                        return {
                            colour = G.C.PURPLE,
                            message = localize("k_picubeds_prime"),
                            card = card
                        }
                    end
                end
            end
        end
    end
}