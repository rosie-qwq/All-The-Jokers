local all_sets = {}
for i,k in pairs(G.P_CENTER_POOLS) do
    all_sets[i] = true
end

SMODS.Sticker{
    key = "self_destructs",
    default_compat = true,
    atlas = "aikoyoriStickers",
    pos = {x = 0, y = 0},
    rate = 0,
    badge_colour = G.C.RED,
    sets =  all_sets,
    calculate = function(self, card, context)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        card:set_cost()
    end
}

SMODS.Seal{
    key = "carmine",
    atlas = 'aikoyoriStickers',
    pos = {x = 1, y = 0},
    badge_colour = HEX('91777c'),
    sound = { sound = 'generic1', per = 1.2, vol = 0.4 },

    calculate = function(self, card, context)
        if context.cardarea == G.hand and context.before and G.GAME.current_round.hands_played == 0 then
            card:set_debuff(false)
        end
    end,
}


SMODS.Sticker{
    key = "sigma",
    default_compat = true,
    atlas = "aikoyoriStickers",
    pos = {x = 3, y = 0},
    rate = 0,
    badge_colour = HEX("ee36ff"),
    sets =  all_sets,
    calculate = function(self, card, context)
    end,
    apply = function(self, card, val)
        card.ability[self.key] = val
        card.ability.akyrs_stay_sigma = true
        card:set_cost()
    end,
    
    draw = function (self, card, layer)
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_stickers[self.key]:draw_shader('akyrs_texelated', nil, card.ARGS.send_to_shader, nil, card.children.center)
        G.shared_stickers[self.key]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}

AKYRS.copper_stickers = {
}



SMODS.Sticker{
    key = "oxidising",
    default_compat = true,
    atlas = "aikoyoriStickers",
    pos = {x = 5, y = 0},
    rate = 0,
    badge_colour = HEX("b74912"),
    sets =  all_sets,
    should_apply = function (self, card, center, area, bypass_reroll)
        if true then
            if G.GAME.modifiers.akyrs_spawn_oxidising and pseudorandom((area == G.pack_cards and 'akyrs_packs_oxi_' or 'akyrs_oxi_')..G.GAME.round_resets.ante) > 0.7 then
                card.ability.akyrs_oxidising = 1
                return true
            end
        end
        return false
    end,
    loc_vars = function (self, info_queue, card)
        info_queue[#info_queue+1] = AKYRS.DescriptionDummies["dd_akyrs_copper_scrape_tip"]
        return {
            key = AKYRS.compare(card.ability[self.key],">=", 4) and self.key.."_full" or self.key,
            vars = {
                (card.ability[self.key] - 1) * 25,
                localize("k_akyrs_copper_oxidation_stage_"..card.ability[self.key]+1),
                card.ability.akyrs_oxidising_round,
                card.ability.akyrs_oxidising_round ~= 1 and localize("k_akyrs_round_plural") or localize("k_akyrs_round_singular"),
                25
            }
        }
    end,
    apply = function(self, card, val)
        if val == true then val = 1 end
        card.ability[self.key] = val
        card.ability.akyrs_oxidising_round = 2
        card.cost = math.floor(card.cost / 2)
    end,
    calculate = function (self, card, context)
        if context.akyrs_copper_end_of_round then
            return {
                akyrs_ignore_copper_calculation = true,
                func = function ()
                    card.ability.akyrs_oxidising_round = card.ability.akyrs_oxidising_round - 1
                    if AKYRS.compare(card.ability.akyrs_oxidising_round,"<=", 0) and AKYRS.compare(card.ability[self.key],"<", 4) then
                        SMODS.calculate_effect({
                            func = function ()
                                card.ability[self.key] = card.ability[self.key] + 1
                                card.ability.akyrs_oxidising_round = 2
                            end
                        }, card)
                    end
                end,
                message = localize("k_akyrs_oxidise_ex"),
                colour = HEX("337a57")
            }
        end
        if context.using_consumeable then
            return {
                akyrs_ignore_copper_calculation = true,
                func = function ()
                    local psrd = pseudorandom(pseudoseed("akyrs_oxidising_scrape_"..card.config.center_key))
                    local cond = AKYRS.compare(card.ability[self.key],">", 1) or AKYRS.compare(card.ability.akyrs_oxidising_round,"<", 2)
                    if cond and psrd >= 0.75 then
                        SMODS.calculate_effect(
                            {
                                akyrs_ignore_copper_calculation = true,
                                func = function ()
                                    AKYRS.simple_event_add(
                                        function ()
                                            card.ability[self.key] = (card.ability[self.key] or 4) - 1
                                            card.ability.akyrs_oxidising_round = 2
                                            return true
                                        end, 0
                                    )
                                end,
                                message = localize("k_akyrs_scrape_ex"),
                                colour = HEX("994433")
                            }, card
                        )
                    elseif cond then
                        SMODS.calculate_effect(
                            {
                                akyrs_ignore_copper_calculation = true,
                                message = localize("k_nope_ex"),
                                colour = G.C.PURPLE
                            }, card
                        )
                    end
                end,
            }
        end
    end,
    draw = function (self, card, layer)
        local val = card.ability.akyrs_oxidising and math.min(4,math.max(1,card.ability.akyrs_oxidising)) or 1
        
        AKYRS.copper_stickers[val] = AKYRS.copper_stickers[val] or Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS["akyrs_aikoyoriStickers"], { x = 4 + val, y = 0})
        AKYRS.copper_stickers[val].role.draw_major = card
        AKYRS.copper_stickers[val]:draw_shader('dissolve', nil, nil, nil, card.children.center)
    end
}



SMODS.Sticker{
    key = "attention",
    default_compat = true,
    atlas = "aikoyoriStickers",
    pos = {x = 0, y = 1},
    rate = 0,
    badge_colour = HEX("FF6D6D"),
    sets =  all_sets,
    apply = function(self, card, val)
        card.ability[self.key] = val
    end,
    calculate = function (self, card, context)
        if context.destroy_card and context.cardarea == G.play then
            if card == context.destroy_card then
                return {
                    remove = true
                }
            end
        end
    end,
    draw = function (self, card, layer)
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_stickers[self.key]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}


SMODS.Sticker{
    key = "concealed",
    default_compat = true,
    atlas = "aikoyoriStickers",
    pos = {x = 1, y = 1},
    rate = 0,
    badge_colour = HEX("6394ff"),
    sets =  all_sets,
    should_apply = function (self, card, center, area, bypass_reroll)
        if true then
            if G.GAME.modifiers.akyrs_spawn_concealed and pseudorandom((area == G.pack_cards and 'akyrs_packs_concealed_' or 'akyrs_concealed_')..G.GAME.round_resets.ante) > 0.7 then
                card.ability.akyrs_concealed = true
                card:set_ability(card.config.center)
                card:set_sprites(card.config.center, card.config.base)
                card.cost = 5
                card.sell_cost = 3
                return true
            end
        end
        return false
    end,
    calculate = function(self, card, context)
    end,    
    draw = function (self, card, layer)
        G.shared_stickers[self.key].role.draw_major = card
        G.shared_stickers[self.key]:draw_shader('dissolve', nil, nil, nil, card.children.center)
        G.shared_stickers[self.key]:draw_shader('voucher', nil, card.ARGS.send_to_shader, nil, card.children.center)
    end
}
