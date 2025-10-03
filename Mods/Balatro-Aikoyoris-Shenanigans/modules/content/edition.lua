SMODS.Edition{
    key = "texelated",
    shader = "akyrs_texelated",
    config = {
        extra = {
            x_chip = 0.8,
            x_mult = 2;
        }
    },
    
    calculate =  function (self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            return {
                mult = card.edition.extra.x_chip,
                Xmult = card.edition.extra.x_mult
            }
        end
        if context.pre_joker and (context.cardarea == G.jokers)  then
            return {
                mult = card.edition.extra.x_chip,
                Xmult = card.edition.extra.x_mult
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                self.config.extra.x_chip,
                self.config.extra.x_mult,
            }
        }
    end,
    sound = { sound = "akyrs_texelated_sfx", per = 1.2, vol = 0.4 },
    in_shop = true,
    weight = 7,
}

SMODS.Edition{
    key = "noire",
    shader = "akyrs_noire",
    config = {
        extra ={
            x_mult = 0.75,
        },
        card_limit = 2
    },
    calculate =  function (self, card, context)
        if context.main_scoring and (context.cardarea == G.hand or context.cardarea == G.play)  then
            return {
                Xmult = card.edition.extra.x_mult
            }
        end
        if context.pre_joker and (context.cardarea == G.jokers)  then
            return {
                Xmult = card.edition.extra.x_mult
            }
        end
    end,
    loc_vars = function (self, info_queue, card)
        return {
            vars = {
                self.config.card_limit,
                self.config.extra.x_mult,
            }
        }
    end,
    sound = { sound = "akyrs_noire_sfx", per = 0.8, vol = 0.3 },
    in_shop = true,
    weight = 3,
}

SMODS.Edition{
    key = "sliced",
    shader = "akyrs_sliced",
    config = {
        extra = {
            mod_mult = 0.5,
        },
        akyrs_card_extra_triggers = 1
    },
    disable_base_shader = true,
    sound = { sound = "akyrs_sliced_sfx", per = 0.8, vol = 0.3 },
    in_shop = true,
    on_apply = function (card)
        if not card.akyrs_upgrade_sliced then
            local x = AKYRS.deep_copy(card.config.center)
            AKYRS.mod_card_values(card.ability,{multiply = 0.5, reference = x, unkeywords = AKYRS.blacklist_mod})
            card.akyrs_upgrade_sliced = true
        end
    end,
    on_remove = function (card)
        card:set_ability(card.config.center)
        card.akyrs_upgrade_sliced = false
    end,
    weight = 5,
}

SMODS.Edition{
    key = "burnt",
    shader = "akyrs_burnt",
    config = {
        extras = {
            odds = 7,
        },
        name = "akyrs_burnt"
    },
    disable_base_shader = true,
    sound = { sound = "akyrs_burnt_sfx", per = 1.2, vol = 0.3 },
    in_shop = false,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS["m_akyrs_ash_card"]
        info_queue[#info_queue+1] = G.P_CENTERS["j_akyrs_ash_joker"]
        local n,d = SMODS.get_probability_vars(card,1,self.config.extras.odds,"akyrs_burnt_edition")
        return {
            vars = {
                n,d
            }
        }
    end,
    calculate = function (self, card, context)
        
    end,
    weight = 0,
}

SMODS.Edition{
    key = "enchanted",
    shader = "akyrs_enchanted",
    config = {
        name = "akyrs_enchanted"
    },
    sound = { sound = "akyrs_enchanted", per = 1, vol = 0.7 },
    in_shop = false,
    loc_vars = function (self, info_queue, card)
        return {
        }
    end,
    calculate = function (self, card, context)
    end,
    weight = 0,
}