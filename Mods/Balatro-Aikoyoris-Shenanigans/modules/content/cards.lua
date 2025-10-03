--SMODS.Enhancement{
--    key = "null",
--    atlas = 'cardUpgrades',
--    pos = {x = 0, y = 0},
--    loc_txt =  	{
--        name = 'Null',
--        text = { 'No Base Chips' },
--    },
--    replace_base_card = true,
--    no_rank = true,
--    no_suit = true,
--    always_scores = true,
--    weight = 0,
--    config = {
--        bonus = 0,
--        bonus_chips = 0,
--        mult = 0,
--    }
--}


SMODS.Enhancement{
    key = "brick_card",
    atlas = 'cardUpgrades',
    pos = {x = 1, y = 0},
    loc_vars = function (self, info_queue, card)
        return { vars = {
            card.ability.extra.mult
        } }
    end,
    config = {
        extra = {
            mult = 10
        }
    },
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    replace_base_card = true,
}



SMODS.Enhancement{
    key = "scoreless",
    atlas = 'cardUpgrades',
    pos = {x = 0, y = 0},
    loc_vars = function (self, info_queue, card)
        return { vars = {
        } }
    end,
    in_pool = function (self, args)
        return false
    end,
    never_scores = true,
    replace_base_card = false,
}


SMODS.Enhancement{
    key = "ash_card",
    atlas = 'cardUpgrades',
    pos = {x = 2, y = 0},
    loc_vars = function (self, info_queue, card)
        
        if AKYRS.bal("absurd") then
            return {
                key = self.key .. "_absurd",
                vars = {
                    card.ability.extras.echips,
                }
            }
        end
        local n,d = SMODS.get_probability_vars(card,1,card.ability.extras.odds,"akyrs_ash_card")
        return { vars = {
            card.ability.extras.chips,
            n,d
        } }
    end,
    config = {
        extras = {
            chips = 35,
            echips = 2,
            odds = 4
        }
    },
    in_pool = function (self, args)
        return false
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return AKYRS.bal_val({
                chips = card.ability.extras.chips
            }, {
                echips = card.ability.extras.echips
            })
        end
    end,
    no_rank = true,
    no_suit = true,
    always_scores = true,
    replace_base_card = true,
}

SMODS.Enhancement{
    key = "hatena",
    atlas = 'cardUpgrades',
    pos = {x = 3, y = 0},
    no_rank = true,
    no_suit = true,
    always_scores = true,
    replace_base_card = true,
    config = {
        extras = {
            odds_d = 2,
            d = 1, 
            odds_d10 = 10,
            d10 = 10,
            nom_mults = 4,
            denom_mults = 5,
            mult_init = 6,
            xmult_retrig = 1.3
        }
    },
    loc_vars = function (self, info_queue, card)
        local n_dollar_1, d_dollar_1 = SMODS.get_probability_vars(card,1,card.ability.extras.odds_d,"akyrs_hatena_d1") -- odds of getting 1 money
        local n_dollar_10, d_dollar_10 = SMODS.get_probability_vars(card,1,card.ability.extras.odds_d10,"akyrs_hatena_d10") -- odds of getting 10 money
        local n_dollar_mult, d_dollar_mult = SMODS.get_probability_vars(card,card.ability.extras.nom_mults,card.ability.extras.denom_mults,"akyrs_hatena_mults") -- odds of getting mults
        return {
            vars = {
                n_dollar_1, d_dollar_1,card.ability.extras.d,
                n_dollar_10, d_dollar_10,card.ability.extras.d10,
                n_dollar_mult, d_dollar_mult,card.ability.extras.mult_init,card.ability.extras.xmult_retrig,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card,"akyrs_hatena_d1",1,card.ability.extras.odds_d) then
                return {
                    dollars = card.ability.extras.d
                }
            end
            if SMODS.pseudorandom_probability(card,"akyrs_hatena_d10",1,card.ability.extras.odds_d10) then
                return {
                    dollars = card.ability.extras.d10
                }
            end
            if SMODS.pseudorandom_probability(card,"akyrs_hatena_mults",card.ability.extras.nom_mults,card.ability.extras.denom_mults) then
                if card.akyrs_triggered then
                    return {
                        xmult = card.ability.extras.xmult_retrig
                    }
                else
                    return {
                        mult = card.ability.extras.mult_init,
                        func = function()
                            card.akyrs_triggered = true
                        end
                    }
                end
            end
            if context.final_scoring_step then
                return {
                    func = function()
                        card.akyrs_triggered = nil
                    end
                }
            end
        end
    end
}


SMODS.Enhancement{
    key = "item_box",
    atlas = 'cardUpgrades',
    pos = {x = 4, y = 0},
    no_rank = true,
    no_suit = true,
    always_scores = true,
    replace_base_card = true,
    config = {
        extras = {
        }
    },
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                message = localize("k_akyrs_item_box_trigger"),
                func = function ()
                    AKYRS.simple_event_add(
                        function ()
                            --[[
                            -- this is just me being stupid
                            if AKYRS.has_room(G.consumeables) then
                                card.ability.akyrs_triggered = true
                                local k, lim = nil, 0
                                repeat
                                    lim = lim + 1
                                    k = pseudorandom_element(G.P_CENTER_POOLS.Consumeables,pseudoseed("akyrs_item_box_consumable_pick"))
                                until (not k.hidden and (not k.in_pool or k:in_pool({})) and not G.GAME.banned_keys[k.key]) or lim >= #G.P_CENTER_POOLS.Consumeables
                                if not lim >= #G.P_CENTER_POOLS.Consumeables then
                                    SMODS.add_card{key = k.key}
                                end
                            end
                            ]]
                            if AKYRS.has_room(G.consumeables) then
                                SMODS.add_card{set = "Consumeables", area = G.consumeables}
                            end
                            return true
                        end, 0
                    )
                end
            }
        end
    end
}



SMODS.Enhancement{
    key = "insolate_card",
    atlas = 'cardUpgrades',
    pos = {x = 5, y = 0},
    config = {
        extras = {
            xmult = 1,
            xmult_add = 0.2,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.xmult_add,
                card.ability.extras.xmult,
            }
        }
    end,
    calculate = function (self, card, context)
        if context.before then
        end
        if context.main_scoring and context.cardarea == G.play then
            local r = AKYRS.get_suit_freq_from_cards(G.play.cards,true)
            local s = true
            for k,v in pairs(r) do
                if v > 1 then
                    s = false
                    break
                end
            end
            if s then
                SMODS.calculate_effect({
                    message = localize("k_upgrade_ex"),
                    func = function ()
                        card.ability.extras.xmult = card.ability.extras.xmult + card.ability.extras.xmult_add
                    end
                }, card)
            end
            return {
                xmult = card.ability.extras.xmult
            }
        end
    end
}

SMODS.Enhancement{
    key = "canopy_card",
    atlas = 'cardUpgrades',
    pos = {x = 6, y = 0},
    loc_vars = function (self, info_queue, card)
        return {
        }
    end,
    calculate = function (self, card, context)
        if context.after and context.cardarea == G.hand then
            return {
                func = function ()
                    AKYRS.simple_event_add(
                        function ()
                            card:akyrs_flip_y()
                            AKYRS.simple_event_add(
                                function ()
                                    card:akyrs_flip_y()
                                    card = SMODS.modify_rank(card, -1)
                                    return true
                                end
                            )
                            return true
                        end
                    )
                end
            }
        end
    end
}
SMODS.Enhancement{
    key = "thai_tea_card",
    atlas = 'cardUpgrades',
    pos = {x = 7, y = 0},
    config = {
        extras = {
            xmult = 1.6,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.xmult
            }
        }
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if AKYRS.bal("absurd") and AKYRS.checkBlindKey("bl_mouth") and #G.play.cards == 1 then
                SMODS.calculate_effect(
                    {
                        func = function ()
                            G.GAME.blind:set_blind(G.P_BLINDS['bl_water'])
                        end
                    },card
                )
            end
            return {
                xmult = card.ability.extras.xmult
            }
        end
    end
}
SMODS.Enhancement{
    key = "matcha_card",
    atlas = 'cardUpgrades',
    pos = {x = 8, y = 0},
    config = {
        extras = {
            xchips = 1.4,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.xchips
            }
        }
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                xchips = card.ability.extras.xchips
            }
        end
    end
}
SMODS.Enhancement{
    key = "earl_grey_tea_card",
    atlas = 'cardUpgrades',
    pos = {x = 9, y = 0},
    config = {
        extras = {
            dollars = 3,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.dollars
            }
        }
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == 'unscored' then
            return {
                dollars = card.ability.extras.dollars
            }
        end
    end
}

SMODS.Enhancement{
    key = "zap_card",
    atlas = 'cardUpgrades',
    pos = {x = 0, y = 1},
    config = {
        extras = {
            trigger_triggered = 0,
            trigger_needed = 3,
        }
    },
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                card.ability.extras.trigger_needed,
                card.ability.extras.trigger_triggered
            }
        }
    end,
    calculate = function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                func = function ()
                    card.ability.extras.trigger_triggered = card.ability.extras.trigger_triggered + 1
                    if card.ability.extras.trigger_triggered >= card.ability.extras.trigger_needed then
                        SMODS.calculate_effect({
                            message = localize("k_duplicated_ex"),
                            func = function ()
                                card.ability.extras.trigger_triggered = 0
                                local c2 = AKYRS.copy_p_card(card,nil,nil,nil,nil,G.hand)
                                c2:set_ability(G.P_CENTERS.c_base)
                            end
                        }, card)
                    end
                end,
                message = localize("k_upgrade_ex")
            }
        end
    end
}
