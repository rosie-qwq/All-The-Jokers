local surreal = {
    order = 1,
    object_type = "Joker",
    key = "surreal_joker",
    config = {
        qmult = 4
    },
    rarity = 1,
    cost = 3,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Meme"] = true },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                " "..card.ability.qmult
            },
        }
    end,
    calculate = function (self, card, context)
        if context.joker_main or context.forcetrigger then
            G.GAME.current_round.current_hand.mult = card.ability.qmult
            update_hand_text({delay = 0}, {chips = G.GAME.current_round.current_hand.chips and hand_chips, mult = card.ability.qmult})
            return {
                Eqmult_mod = not Entropy.BlindIs("bl_entr_theta") and card.ability.qmult,
                Eqchips_mod = Entropy.BlindIs("bl_entr_theta") and card.ability.qmult
            }
        end
    end
}

local tesseract = {
    order = 2,
    object_type = "Joker",
    key = "tesseract",
    config = {
        degrees = 90
    },
    rarity = 1,
    cost = 3,
    
    pools = { ["Meme"] = true },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 0 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.degrees)
            },
        }
    end,
}

local strawberry_pie = {
    order = 4,
    object_type = "Joker",
    key = "strawberry_pie",
    rarity = 3,
    cost = 10,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 2, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Food"] = true },
}

local recursive_joker = {
    order = 5,
    object_type = "Joker",
    key = "recursive_joker",
    config = {
        used_this_round = false
    },
    rarity = 1,
    cost = 4,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 3, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.used_this_round and "Inactive" or "Active"
            },
        }
    end,
    calculate = function(self, card, context)
        if context.end_of_round then
            card.ability.used_this_round = false
        end
        if (context.selling_card and context.card == card and not card.ability.used_this_round) or context.forcetrigger then
            card.ability.used_this_round = true
            local card = copy_card(card)
            if context.forcetrigger and card.ability.desync then
                card.ability.context = Entropy.RandomContext()
            end
            card:add_to_deck()
            G.jokers:emplace(card)
        end
    end
}
local dr_sunshine = {
    order = 6,
    object_type = "Joker",
    key = "dr_sunshine",
    config = {
        plus_asc = 0,
        plus_asc_mod = 0.25
    },
    rarity = 3,
    cost = 10,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 1 },
    atlas = "jokers",
    pools = { ["Sunny"] = true, },
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.plus_asc_mod),
                number_format(card.ability.plus_asc),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards and not context.blueprint or context.forcetrigger then
            
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "plus_asc", scalar_value = "plus_asc_mod", operation = function(ref_table, ref_value, initial, change)
                ref_table[ref_value] = initial + (context.removed and #context.removed or 1)*change
            end})
        end
        if (context.joker_main or context.forcetrigger) and to_big(card.ability.plus_asc) > to_big(0) then
            return {
                plus_asc = card.ability.plus_asc
            }
        end
    end
}

local sunny_joker = {
    order = 7,
    object_type = "Joker",
    key = "sunny_joker",
    config = {
        plus_asc = 2
    },
    rarity = 2,
    cost = 5,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 5, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Meme"] = true, ["Sunny"] = true, },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.plus_asc),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                plus_asc = card.ability.plus_asc
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local antidagger = {
    order = 8,
    object_type = "Joker",
    key = "antidagger",
    rarity = 3,
    cost = 8,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    immutable = true,
    eternal_compat = true,
    pos = { x = 6, y = 0 },
    atlas = "jokers",
    demicoloncompat = true,
    config = { extra = { odds = 6 } },
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator
            },
        }
    end,
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            local keys = {}
            for i, v in pairs(G.GAME.banned_keys) do
                keys[#keys+1]=i
            end
            if #keys > 0 then
                local key = pseudorandom_element(keys, pseudoseed("antidagger"))
                while not G.P_CENTERS[key] or G.P_CENTERS[key].set ~= "Joker" do
                    key = pseudorandom_element(keys, pseudoseed("antidagger"))
                end
                G.GAME.banned_keys[key] = nil
                local c = SMODS.create_card({
                    area = G.jokers,
                    set="Joker",
                    key = key
                })
                c:add_to_deck()
                G.jokers:emplace(c)
            end
            if SMODS.pseudorandom_probability(card, 'antidagger', 1, card.ability.extra.odds) then
                    G.GAME.banned_keys["j_entr_antidagger"] = true
                    SMODS.calculate_context({banishing_card = true, card = card, cardarea = card.area, banisher = card})
                    card:start_dissolve()
                    play_sound("slice1", 0.96 + math.random() * 0.08)
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"cassknows"}
    }
}

local solar_dagger = {
    order = 9,
    object_type = "Joker",
    key = "solar_dagger",
    rarity = 3,
    cost = 8,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 6, y = 1 },
    atlas = "jokers",
    demicoloncompat = true,
    config = { x_asc = 1 },
    pools = { ["Sunny"] = true, },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.x_asc)
            },
        }
    end,
    calculate = function(self, card, context)
        if (context.setting_blind and not (context.blueprint_card or self).getting_sliced) or context.forcetrigger then
            local check
            for i, v in pairs(G.jokers.cards) do
                if v == card and G.jokers.cards[i+1] and not SMODS.is_eternal(G.jokers.cards[i+1]) then check = i+1 end
            end
            if check then
                local sliced_card = G.jokers.cards[check]
                sliced_card.getting_sliced = true
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("ff9000") }, nil, 1.6)
                        play_sound("slice1", 0.96 + math.random() * 0.08)
                        return true
                    end,
                }))
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "x_asc", scalar_table = {sell_cost = sliced_card.sell_cost * 0.1}, scalar_value = "sell_cost"})
            end
        end
        if context.joker_main then
            return {
                asc = card.ability.x_asc
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"cassknows", "Strum"}
    }
}

local insatiable_dagger = {
    order = 10,
    object_type = "Joker",
    key = "insatiable_dagger",
    rarity = 3,
    cost = 8,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    immutable = true,
    pos = { x = 4, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.setting_blind and not (context.blueprint_card or self).getting_sliced) or context.forcetrigger then
            local check
            for i, v in pairs(G.jokers.cards) do
                if v == card and G.jokers.cards[i-1] then check = i-1 end
            end
            if check and not SMODS.is_eternal(G.jokers.cards[#G.jokers.cards]) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        local sliced_card = G.jokers.cards[#G.jokers.cards]
                        sliced_card.getting_sliced = true
                        card:juice_up(0.8, 0.8)
                        sliced_card:start_dissolve({ HEX("a800ff") }, nil, 1.6)
                        G.GAME.banned_keys[sliced_card.config.center.key] = true
                        eval_card(sliced_card, {banishing_card = true, banisher = card, card = sliced_card, cardarea = sliced_card.area})
                        play_sound("slice1", 0.96 + math.random() * 0.08)
                        local check2
                        if not Card.no(G.jokers.cards[check], "immutable", true) then
                            Cryptid.manipulate(G.jokers.cards[check], { value = sliced_card.sell_cost * 0.05 + 1 })
                            check2 = true
                        end
                        if check2 then
                            card_eval_status_text(
                                G.jokers.cards[check],
                                "extra",
                                nil,
                                nil,
                                nil,
                                { message = localize("k_upgrade_ex"), colour = G.C.GREEN }
                            )
                        end
                        return true
                    end,
                }))
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
	    art = {"Lyman"}
    }
}

local rusty_shredder = {
    order = 11,
    object_type = "Joker",
    key = "rusty_shredder",
    rarity = 2,
    cost = 5,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat=true,
    immutable = true,
    eternal_compat = true,
    pos = { x = 7, y = 1 },
    atlas = "jokers",
    config = {extra = {odds = 3}},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = {key = 'e_negative_playing_card', set = 'Edition', config = {extra = 1}}
        info_queue[#info_queue+1] = {key = "temporary", set = "Other"}
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator
            },
        }
    end,
    calculate = function (self, card, context)
        if (context.pre_discard) then
            for i, v in pairs(G.hand.highlighted) do
                if SMODS.pseudorandom_probability(card, 'rusty_shredder', 1, card.ability.extra.odds) then
                    local c = copy_card(v)
                    c.ability.temporary = true
                    c:add_to_deck()
                    G.hand:emplace(c)
                    c:set_edition("e_negative")
                end
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"LFMoth"}
    }
}

local chocolate_egg = {
    order = 12,
    object_type = "Joker",
    key = "chocolate_egg",
    rarity = 2,
    cost = 5,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Food"] = true, ["Candy"] = true, ["Sunny"]=true },
    calculate = function(self, card, context)
        if (context.banishing_card and context.cardarea == G.jokers) or context.forcetrigger then
            card_eval_status_text(
                card,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("entr_opened"), colour = G.C.GREEN }
            )
            card.ability.no_destroy = true
            local c = create_card("Joker", G.jokers, nil, (SMODS.Mods["Cryptid"] or {}).can_load and "cry_epic" or 3)
            c:add_to_deck()
            G.jokers:emplace(c)
            c:set_edition("e_entr_sunny")
        end
        if context.selling_self then card.ability.no_destroy = true end
        if context.card_being_destroyed and context.card == card then
            card_eval_status_text(
                self,
                "extra",
                nil,
                nil,
                nil,
                { message = localize("entr_opened"), colour = G.C.GREEN }
            )
            local c = create_card("Joker", G.jokers, nil, "Rare")
            c:add_to_deck()
            G.jokers:emplace(c)
            c:set_edition("e_entr_sunny")
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"missingnumber"}
    },
    loc_vars = function()
        return {
            key = (SMODS.Mods["Cryptid"] or {}).can_load and "j_entr_chocolate_egg" or "j_entr_chocolate_egg_cryptidless"
        }
    end
}

local lotteryticket = {
    order = 13,
    object_type = "Joker",
    key = "lotteryticket",
    rarity = 2,
    cost = 3,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat=true,
    demicoloncompat=true,
    eternal_compat = true,
    pos = { x = 9, y = 0 },
    atlas = "jokers",
    config = {extra = {odds = 5, odds2 = 5, lose=1, payoutsmall = 20, payoutlarge = 50}},
    loc_vars = function(self, info_queue, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        local numerator2, denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds * card.ability.extra.odds2)
        return {
            vars = {
                numerator,
                denominator,
                numerator2,
                denominator2,
                card.ability.extra.lose,
                card.ability.extra.payoutsmall,
                card.ability.extra.payoutlarge
            },
        }
    end,
    calculate = function (self, card, context)
        if context.end_of_round and not context.individual and not context.blueprint and not context.repetition then            
            if SMODS.pseudorandom_probability(card, 'lottery', 1, card.ability.extra.odds * card.ability.extra.odds2) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_dollars(card.ability.extra.payoutlarge-card.ability.extra.lose)
                        return true
                    end
                }))
                return {
                    message = localize("$")..number_format(card.ability.extra.payoutlarge),
                    colour = G.C.GOLD
                }
            elseif SMODS.pseudorandom_probability(card, 'lottery', 1, card.ability.extra.odds) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_dollars(card.ability.extra.payoutsmall-card.ability.extra.lose)
                        return true
                    end
                }))
                return {
                    message = localize("$")..number_format(card.ability.extra.payoutsmall),
                    colour = G.C.GOLD
                }
            else
                G.E_MANAGER:add_event(Event({
                    func = function()
                        ease_dollars(-card.ability.extra.lose)
                        return true
                    end
                }))
                return {
                    message = localize("k_nope_ex"),
                    colour = G.C.RED
                }
            end
        end
        if context.forcetrigger then
            ease_dollars(card.ability.extra.payoutlarge-card.ability.extra.lose)
        end
    end,
}

local devilled_suns = {
    order = 14,
    object_type = "Joker",
    key = "devilled_suns",
    rarity = 2,
    cost = 3,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat=true,
    demicoloncompat=true,
    eternal_compat = true,
    pos = { x = 1, y = 2 },
    atlas = "jokers",
    pools = { ["Sunny"] = true, ["Meme"] = true},
    config = { base = 1, per_sunny = 1},
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_entr_sunny
        return {
            vars = {
                card.ability.base,
                card.ability.per_sunny
            },
        }
    end,
    calculate = function (self, card, context)
        if (context.individual and context.other_card.config.center.key == "m_gold" and context.cardarea == G.play) or context.forcetrigger then
            local sunnys = 0
            for i, v in pairs(G.jokers.cards) do
                if v:is_sunny() and v ~= card then sunnys = sunnys + 1 end
            end
            return {
                plus_asc = card.ability.base + card.ability.per_sunny * sunnys
            }
        end
    end,
    entr_credits = {
        art = {"Grahkon"},
        idea = {"Grahkon"}
    }
}

local eden = {
    order = 15,
    object_type = "Joker",
    key = "eden",
    name="entr-eden",
    config = {
        asc=3
    },
    rarity = 2,
    cost = 4,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 2, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Sunny"] = true, ["Meme"] = true },
    loc_vars = function(self, info_queue, center)
        if not center.edition or (center.edition and center.edition.key ~= "e_entr_sunny") then
			info_queue[#info_queue + 1] = G.P_CENTERS.e_entr_sunny
		end
        return {
            vars = {
                number_format(center.ability.asc)
            },
        }
    end,
    calculate = function(self, card, context)
		if
			(context.other_joker
			and context.other_joker.edition
			and context.other_joker:is_sunny()
			and card ~= context.other_joker)
		then
			if not Talisman or not Talisman.config_file.disable_anims then
				G.E_MANAGER:add_event(Event({
					func = function()
						context.other_joker:juice_up(0.5, 0.5)
						return true
					end,
				}))
			end
			return {
				plus_asc = lenient_bignum(card.ability.asc),
			}
		end
		if context.individual and context.cardarea == G.play then
			if context.other_card.edition and context.other_card:is_sunny() then
				return {
					plus_asc = lenient_bignum(card.ability.asc),
					card = card,
				}
			end
		end
		if
			(context.individual
			and context.cardarea == G.hand
			and context.other_card.edition
			and context.other_card:is_sunny()
			and not context.end_of_round)
		then
			if context.other_card.debuff then
				return {
					message = localize("k_debuffed"),
					colour = G.C.RED,
					card = card,
				}
			else
				return {
					plus_asc = lenient_bignum(card.ability.asc),
					card = card,
				}
			end
		end
        if context.forcetrigger then
            return {
                plus_asc = lenient_bignum(card.ability.asc),
                card = card,
            }
        end
	end
}

local seventyseven = {
    order = 16,
    object_type = "Joker",
    key = "seventyseven",
    config = {
        chips=100
    },
    rarity = 1,
    cost = 4,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 3, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Meme"] = true, },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.chips)
            },
        }
    end,
    calculate = function(self, card, context)
		if context.joker_main or context.forcetrigger then
            return {
                eq_chips = card.ability.chips
            }
        end
	end
}

local skullcry = {
    order = 17,
    object_type = "Joker",
    key = "skullcry",
    config = {
        base=10,
        percent = 5
    },
    rarity = 3,
    cost = 10,
    
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 8, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = { ["Meme"] = true, },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.base),
                number_format(center.ability.percent)
            },
        }
    end,
    calculate = function(self, card, context)
		if context.game_over and to_big(G.GAME.chips) > to_big(math.log(G.GAME.blind.chips, card.ability.base)) then
            G.GAME.saved_message = localize("k_saved_skullcry")
            if to_big(math.abs(G.GAME.chips - math.log(G.GAME.blind.chips, card.ability.base))) > to_big(math.log(G.GAME.blind.chips, card.ability.base) * card.ability.percent/100) then
                G.E_MANAGER:add_event(Event({
                    func = function()
                        card:start_dissolve()
                        return true
                    end
                }))
            end
            return {
                message = localize('k_saved_ex'),
                saved = "k_saved_skullcry",
                colour = G.C.RED
            }
        end
	end,
    entr_credits = {
        custom = {key="wish", text="denserver10"}
    }
}
local dating_simbo = {
    order = 18,
    object_type = "Joker",
    key = "dating_simbo",
    config = {
        chips = 0
    },
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 9, y = 2 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.chips)
            },
        }
    end,
    calculate = function(self, card, context)
        if context.destroying_card and not context.blueprint and context.cardarea == G.play then
            if context.destroying_card:is_suit("Hearts") then
                local card2 = context.destroying_card
                G.E_MANAGER:add_event(Event({
					trigger = "after",
					func = function()
                        card2:juice_up()
                        return true
                    end
                }))
                card.ability.chips = card.ability.chips + math.max(context.destroying_card.base.nominal + (context.destroying_card.ability.bonus or 0), 0)
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "chips", scalar_table = context.destroying_card.base, scalar_value = "nominal"})
                if context.destroying_card.ability.bonus then
                    SMODS.scale_card(card, {ref_table = card.ability, ref_value = "chips", scalar_table = context.destroying_card.ability, scalar_value = "bonus", no_message = true})
                end
                return { remove = not SMODS.is_eternal(context.destroying_card) }
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.chips
            }
        end
	end,
    entr_credits = {
        idea = {"CapitalChirp"},
        art = {"Lyman"}
    }
}

local sweet_tooth = {
    order = 19,
    object_type = "Joker",
    key = "sweet_tooth",
    config = {
        chips = 20,
        chip_exp = 1.1
    },
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.chips),
                number_format(center.ability.chip_exp)
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.chips
            }
        end
        if context.ending_shop and not context.blueprint then
            local check
            for i, v in ipairs(G.jokers.cards) do
                if Cryptid.safe_get(v.config.center, "pools", "Candy") or v:is_food() then
                    v:start_dissolve()
                    check = true
                end
            end
            if check then
                card.ability.chips = to_big(card.ability.chips) ^ to_big(card.ability.chip_exp)
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "chips", scalar_value = "chip_exp", operation = function(ref_table, ref_value, initial, change)
                    ref_table[ref_value] = initial ^ change
                end})
            end
        end
	end,
    entr_credits = {
        idea = {"Lyman"},
        art = {"Lyman"}
    }
}


local bossfight = {
    order = 20,
    object_type = "Joker",
    key = "bossfight",
    config = {
        chips = 20,
        cards = 4
    },
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 3 },
    soul_pos = {x = 2, y = 3},
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(math.floor(center.ability.cards)),
                number_format(center.ability.chips)
            },
        }
    end,
    calculate = function(self, card, context)
        if context.after or context.forcetrigger then
            local cards = #G.play.cards
            if cards == math.floor(card.ability.cards) or context.forcetrigger then
                Entropy.FlipThen(G.hand.cards, function(card2)
                    card2.ability.bonus = (card2.ability.bonus or 0) + card.ability.chips
                end)
            end
        end
	end,
    entr_credits = {
        idea = {"CapitalChirp"},
        art = {"Lyman"}
    }
}

local phantom_shopper = {
    order = 21,
    object_type = "Joker",
    key = "phantom_shopper",
    config = {
        rarity = "Common",
        progress = 0,
        needed_progress = 4
    },
    rarity = 2,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    pos = { x = 3, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                localize("k_"..string.lower(center.ability.rarity)),
                number_format(center.ability.needed_progress),
                number_format(center.ability.needed_progress - center.ability.progress),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self or context.forcetrigger then
            SMODS.add_card{
                set="Joker",
                area = G.jokers,
                rarity = card.ability.rarity,
                legendary = card.ability.rarity == "Legendary",
                key_append = "entr_phantom_shopper"
            }
        end
        if (context.ending_shop and not context.blueprint and not context.retrigger_joker) or context.forcetrigger then
            card.ability.progress = card.ability.progress + 1
            if card.ability.progress >= card.ability.needed_progress then
                card.ability.progress = 0
                card.ability.rarity = ({
                    Common = "Uncommon",
                    Uncommon = "Rare",
                    Rare = "cry_epic",
                    cry_epic = "Legendary"
                })[card.ability.rarity] or card.ability.rarity
            else
                card_eval_status_text(
                    card,
                    "extra",
                    nil,
                    nil,
                    nil,
                    { message = number_format(card.ability.progress).."/"..number_format(card.ability.needed_progress), colour = G.C.FILTER }
                )
            end
        end
	end,
    entr_credits = {
        idea = {"Lyman"},
        art = {"Lyman"}
    }
}

local sunny_side_up = {
    order = 21,
    object_type = "Joker",
    key = "sunny_side_up",
    config = {
        asc = 12,
        asc_mod = 2
    },
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_misc_jokers"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 5, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = {
        ["Sunny"] = true,
        ["Food"] = true
    },
    loc_vars = function(self, info_queue, center)
        return {
            vars = {
                number_format(center.ability.asc),
                number_format(center.ability.asc_mod),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            local asc = card.ability.asc
            card.ability.asc = card.ability.asc - card.ability.asc_mod
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "asc", scalar_value = "asc_mod", operation = "-"})
            if to_big(card.ability.asc) > to_big(0) then
                return {
                    plus_asc = asc
                }
            else    
				SMODS.destroy_cards(card, nil, nil, true)
            end
        end
	end,
    entr_credits = {
        idea = {"footlongdingledong"},
        art = {"footlongdingledong"}
    }
}

local sunflower_seeds = {
    order = 23,
    object_type = "Joker",
    key = "sunflower_seeds",
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        needed = 3,
        left = 3
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 7, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = {
        ["Sunny"] = true,
        ["Food"] = true
    },
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = G.P_CENTERS.e_entr_sunny
        return {
            vars = {
                number_format(card.ability.needed),
                number_format(card.ability.left)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and ((G.GAME.current_round.current_hand.cry_asc_num or 0) + (G.GAME.asc_power_hand or 0)) ~= 0 then
            card.ability.left = card.ability.left - 1
            if card.ability.left <= 0 then
                local cards = {}
                for i, v in ipairs(G.jokers.cards) do
                    if not v.edition and v ~= card then cards[#cards+1] = v end
                end
                local jcard = pseudorandom_element(cards, pseudoseed("code_m"))
                Entropy.FlipThen({jcard}, function(card)
                    card:set_edition("e_entr_sunny")
                end)
                SMODS.destroy_cards(card, nil, nil, true)
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
            end
            return {
                message = number_format(card.ability.needed-card.ability.left).."/"..number_format(card.ability.needed),
                colour = G.C.GOLD,
            }
        end
	end,
    in_pool = function()
		if G.GAME.cry_asc_played and G.GAME.cry_asc_played > 0 then
			return true
		end
        return false
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local tenner = {
    order = 23,
    object_type = "Joker",
    key = "tenner",
    rarity = 1,
    cost = 4,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        dollars = 10
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 8, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.dollars),
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                trigger = "after",
                delay = 0.3,
                blockable = false,
                func = function()
                    G.GAME.dollars = 0
                    ease_dollars(card.ability.dollars)
                    return true
                end
            }))
            return {
                message = localize("$").." = "..number_format(card.ability.dollars),
                colour = G.C.GOLD,
            }
        end
	end,
    entr_credits = {
        art = {"missingnumber"},
        idea = {"missingnumber", "cassknows"}
    }
}


local sticker_sheet = {
    order = 24,
    object_type = "Joker",
    key = "sticker_sheet",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        per_sticker = 2
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 9, y = 3 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.per_sticker),
                number_format(card.ability.per_sticker * Entropy.CountStickers())
            }
        }
    end,
    calculate = function(self, card2, context)
        if context.joker_main or context.forcetrigger then
            local stickers = {
                "eternal",
                "banana",
                "perishable",
                "cry_rigged",
                "cry_global_sticker",
                "rental",
                "entr_hotfix",
                "scarred",
                "pinned",
                "entr_pseudorandom",
                "entr_pure",
                "desync"
            }
            local card = pseudorandom_element(G.play.cards, pseudoseed("sticker_sheet"))
            local sticker = pseudorandom_element(stickers, pseudoseed("sticker_sheet_sticker"))
            card.ability[sticker] = true
            if sticker == "perishable" then card.ability.perish_tally = 5 end
            card:juice_up()
            return {
                mult = card2.ability.per_sticker * Entropy.CountStickers()
            }
        end
	end,
}


local fourbit = {
    order = 25,
    object_type = "Joker",
    key = "fourbit",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        needed = 16,
        left = 16
    },
    blueprint_compat = false,
    eternal_compat = true,
    pos = { x = 1, y = 4 },
    pixel_size = { w = 53, h = 53 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                number_format(card.ability.needed),
                number_format(card.ability.left)
            }
        }
    end,
    calculate = function(self, card2, context)
        if context.joker_main and not context.blueprint then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, card in pairs(scoring_hand) do
                card2.ability.left = card2.ability.left - 1
                if to_big(card2.ability.left) <= to_big(0) then
                    card2.ability.left = card2.ability.needed
                    Entropy.FlipThen({card}, function(card)
                        card:set_ability(Entropy.Get4bit())
                    end)
                    card_eval_status_text(
                        card2,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = localize("k_upgrade_ex"), colour = G.C.GREEN }
                    )
                else
                    card_eval_status_text(
                        card2,
                        "extra",
                        nil,
                        nil,
                        nil,
                        { message = number_format(card2.ability.needed - card2.ability.left) .."/"..number_format(card2.ability.needed), colour = G.C.GREEN }
                    )
                end
            end
        end
	end,
}

local crimson_flask = {
    order = 26,
    object_type = "Joker",
    key = "crimson_flask",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 7, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        xmult = 1,
        xmult_joker = 0.25,
        xmult_card = 0.05
    },
    loc_vars = function(self, q, card) return {vars = {number_format(card.ability.xmult_joker), number_format(card.ability.xmult_card), number_format(card.ability.xmult)}} end,
    calculate = function(self, card, context)
        if context.joker_debuffed or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xmult", scalar_value = "xmult_joker", message_key = "a_xmult", message_colour = G.C.RED})
        end
        if context.debuffed_card_drawn or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xmult", scalar_value = "xmult_card", message_key = "a_xmult", message_colour = G.C.RED})
        end
        if context.setting_blind or context.forcetrigger then
            local cards = {}
            for i, v in pairs(G.jokers.cards) do if v ~= card then cards[#cards+1] = v end end
            if #cards > 0 then
                pseudorandom_element(cards, pseudoseed("crimson_flask_card")):set_debuff(true)
            end
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.xmult
            }
        end
    end,
    entr_credits = {
        idea = {"cassknows"},
        art = {"missingnumber"}
    }
}

local card_dissolveref = Card.start_dissolve
function Card:start_dissolve(...)
    self.dissolved = true
    return card_dissolveref(self, ...)
end

local card_sellref = Card.sell_card
function Card:sell_card(...)
    self.dissolved = true
    G.GAME.last_sold_card = self.config.center.key
    return card_sellref(self, ...)
end

local card_debuffref = Card.set_debuff
function Card:set_debuff(debuff)
    if self.area == G.jokers and (debuff or (self.ability.perishable and (self.ability.perish_tally or 0) <= 0)) and self.config.center.set == "Joker" and not self.debuff and not self.dissolved then
        SMODS.calculate_context{joker_debuffed = true, card = self}
    end
    return card_debuffref(self, debuff)
end

local cardarea_emplaceref = CardArea.emplace
function CardArea:emplace(card, ...)
    if self == G.hand and G.hand and self.debuff then
        SMODS.calculate_context{debuffed_card_drawn = true, card = self}
    end
    return cardarea_emplaceref(self, card, ...)
end

local grotesque_joker = {
    order = 27,
    object_type = "Joker",
    key = "grotesque_joker",
    rarity = 3,
    cost = 10,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "m_entr_flesh"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 1, y = 6 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        xmult = 1,
        xmult_mod = 0.1,
        xchips = 1,
        xchips_mod = 0.1
    },
    loc_vars = function(self, q, card) return {vars = {
        number_format(card.ability.xmult_mod), 
        number_format(card.ability.xchips_mod), 
        number_format(card.ability.xmult),
        number_format(card.ability.xchips)
    }} 
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards then
            for i, v in pairs(context.removed) do
                if v.config.center.key == "m_entr_flesh" then
                    SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xchips", scalar_value = "xchips_mod", message_key = "a_xchips", message_colour = G.C.BLUE})
                end
            end
        end
        if context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xchips", scalar_value = "xchips_mod", message_key = "a_xchips", message_colour = G.C.BLUE})
        end
        if (context.setting_ability and not context.unchanged and context.new == "m_entr_flesh") or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xmult", scalar_value = "xmult_mod", message_key = "a_xmult", message_colour = G.C.RED})
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.xmult,
                xchips = card.ability.xchips
            }
        end
    end,
    entr_credits = {
        idea = {"crabus"},
        art = {"LFMoth", "Lil. Mr. Slipstream"}
    }
}

local dog_chocolate = {
    order = 28,
    object_type = "Joker",
    key = "dog_chocolate",
    rarity = SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load and "cry_candy" or 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "tag_entr_dog"
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 4, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    pools = {Food = true},
    calculate = function(self, card, context)
        if (context.tags_merged and (context.first_tag.key == "tag_entr_dog" or context.first_tag.key == "tag_entr_ascendant_dog")) or context.forcetrigger then
            if SMODS.Mods.Cryptid and SMODS.Mods.Cryptid.can_load then
                local card = SMODS.add_card{
                    set="Joker",
                    rarity="cry_candy",
                    area=G.jokers,
                    key_append = "entr_dog_chocolate"
                }
            else    
                local card = SMODS.add_card{
                    set="Food",
                    area=G.jokers,
                    key_append = "entr_dog_chocolate"
                }
            end
            if context.first_tag.key == "tag_entr_ascendant_dog" then
                card:set_edition("e_negative")
            end
            return true
        end
    end,
}

local nucleotide = {
    order = 29,
    object_type = "Joker",
    key = "nucleotide",
    rarity = 3,
    cost = 10,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 8, y = 6 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            G.GAME.current_round.discarded_cards = 0
            local eval = function() return G.GAME.current_round.discarded_cards == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.pre_discard and (G.GAME.current_round.discarded_cards or 0) <= 0 then
            local card 
            for i, v in pairs(G.hand.cards) do
                if v.highlighted then card = v; break end
            end
            G.E_MANAGER:add_event(Event({
                func = function()
                    local new_card = SMODS.create_card{
                        key = card.config.center.key,
                        set = card.config.center.set
                    }
                    SMODS.change_base(new_card, Entropy.GetInverseSuit(card.base.suit), Entropy.GetInverseRank(card.base.id))
                    local jkr = card
                    local found_index = 1
                    if jkr.edition then
                        for i, v in ipairs(G.P_CENTER_POOLS.Edition) do
                            if v.key == jkr.edition.key then
                                found_index = i
                                break
                            end
                        end
                    end
                    found_index = found_index + 1
                    if found_index > #G.P_CENTER_POOLS.Edition then
                        found_index = found_index - #G.P_CENTER_POOLS.Edition
                    end
                    new_card:set_edition(G.P_CENTER_POOLS.Edition[found_index].key)
                    G.hand:emplace(new_card)
                    table.insert(G.playing_cards, new_card)
                    card:start_dissolve()
                    card.ability.temporary2 = true
                    return true
                end
            }))
            G.GAME.current_round.discarded_cards = (G.GAME.current_round.discarded_cards or 0) + #G.hand.highlighted
        end
    end,
}

local afterimage = {
    order = 30,
    object_type = "Joker",
    key = "afterimage",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 5, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        extra = {
            odds = 3
        }
    },
    loc_vars = function(self, q, card)
        q[#q+1] = {set="Other", key="perishable", vars={5, 5}}
        q[#q+1] = {set="Other", key="banana", vars={1, 10}}
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                numerator,
                denominator
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after then
            local text, loc_disp_text, poker_hands, scoring_hand, disp_text =
            G.FUNCS.get_poker_hand_info(G.play.cards)
            for i, v in pairs(scoring_hand) do
                local old_card = v
                if SMODS.pseudorandom_probability(card, 'afterimage', 1, card.ability.extra.odds) then
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            local new_card = copy_card(old_card)
                            new_card.ability.banana = true
                            new_card.ability.perishable = true
                            new_card.ability.perish_tally = 5
                            G.hand:emplace(new_card)
                            table.insert(G.playing_cards, new_card)
                            return true
                        end
                    }))
                end
            end
        end
    end,
    entr_credits = {
        idea = {"cassknows"}
    }
}

local qu = {
    order = 31,
    object_type = "Joker",
    key = "qu",
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 6, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.first_hand_drawn or context.forcetrigger then
            local card = pseudorandom_element(G.hand.cards, pseudoseed("qu_card"))
            Entropy.FlipThen({card}, function(card)
                local elem = pseudorandom_element(Entropy.FlipsidePureInversions, pseudoseed("qu_twisted"))
                card:set_ability(G.P_CENTERS[elem])
            end)
            G.E_MANAGER:add_event(Event({
                blocking = false,
                trigger = "after",
                func = function()
                    save_run()
                    return true
                end
            }))
            return {
                message = localize("k_upgrade_ex")
            }
        end
    end,
}

local memento_mori = {
    order = 32,
    object_type = "Joker",
    key = "memento_mori",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 8, y = 4 },
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.setting_blind and not context.repetition and not context.blueprint then
            local eval = function() return not card.ability.triggered and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.destroy_card then
            if not card.ability.triggered then
                local dcard = G.play.cards[1]
                if dcard and dcard == context.destroy_card then
                    card.ability.triggered = true
                    return {remove = not SMODS.is_eternal(dcard)}
                end
            end
        end
        if context.end_of_round and not context.individual then card.ability.triggered = false end
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}


local broadcast = {
    order = 33,
    object_type = "Joker",
    key = "broadcast",
    rarity = 3,
    cost = 10,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    blueprint_compat = true,
    eternal_compat = true,
    pos = { x = 0, y = 5 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        extra = 1
    },
    immutable = true,
    loc_vars = function(self, q, card)
        local suffix = "th"
        if card.ability.extra == 1 then suffix = "st" end
        if card.ability.extra == 2 then suffix = "nd" end
        if card.ability.extra == 3 then suffix = "rd" end
        local other_joker = G.jokers and G.jokers.cards[card.ability.extra]
        local compatible = other_joker and other_joker ~= card and other_joker.config.center.blueprint_compat
        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", minh = 0.4 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = {
                            ref_table = card,
                            align = "m",
                            colour = compatible and mix_colours(G.C.GREEN, G.C.JOKER_GREY, 0.8)
                                or mix_colours(G.C.RED, G.C.JOKER_GREY, 0.8),
                            r = 0.05,
                            padding = 0.06,
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = " "
                                        .. localize("k_" .. (compatible and "compatible" or "incompatible"))
                                        .. " ",
                                    colour = G.C.UI.TEXT_LIGHT,
                                    scale = 0.32 * 0.8,
                                },
                            },
                        },
                    },
                },
            },
        }
        return {
            vars = {
                card.ability.extra,
                suffix
            },
            main_end = main_end
        }
    end,
    calculate = function(self, card, context)
        if context.after and not context.blueprint and not context.repetition then
            card.ability.extra = card.ability.extra + 1
            if card.ability.extra > #G.jokers.cards then
                card.ability.extra = 1
            end
        elseif G.jokers.cards[card.ability.extra] then 
            local ret = SMODS.blueprint_effect(card, G.jokers.cards[card.ability.extra], context)
            return ret
        end
    end,
}

local milk_chocolate = {
    order = 34,
    object_type = "Joker",
    key = "milk_chocolate",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    pos = { x = 3, y = 6 },
    atlas = "jokers",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = { key = 'tag_coupon', set = 'Tag' }
        return { vars = { localize { type = 'name_text', set = 'Tag', key = 'tag_coupon' } } }
    end,
    pools = {["Food"] = true},
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.selling_self or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    add_tag(Tag('tag_coupon'))
                    play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}

local insurance_fraud = {
    order = 35,
    object_type = "Joker",
    key = "insurance_fraud",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "set_entr_inversions"
        }
    },
    eternal_compat = true,
    pos = {x = 9, y = 7},
    atlas = "jokers",
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.selling_card and context.card.config.center.set == "Tarot") or context.forcetrigger then
            G.E_MANAGER:add_event(Event({
                func = (function()
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 1  then
                        SMODS.add_card{
                            set="Fraud",
                            area = G.consumeables,
                            key_append = "entr_insurance_fraud"
                        }
                    end
                    return true
                end)
            }))
            return nil, true -- This is for Joker retrigger purposes
        end
    end,
}

local free_samples = {
    order = 36,
    object_type = "Joker",
    key = "free_samples",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 4, y = 6 },
    atlas = "jokers",
    config = {
        extra = {
            odds = 4
        }
    },
    loc_vars = function(self, q, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card and card.ability.extra and card.ability.extra.odds or 4)
        return {vars = {
            numerator,
            denominator,
        }} 
    end,
    calculate = function(self, card, context)
        if context.open_booster then
            if SMODS.pseudorandom_probability(
                card,
                "entr_free_samples",
                1,
                card and card.ability.extra.odds or self.config.extra.odds
            ) and (not context.card.area or context.card.area ~= G.consumeables) then
                G.E_MANAGER:add_event(Event({
                    func = (function()
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 1  then
                            SMODS.add_card{
                                key=context.card.config.center.key,
                                area = G.consumeables,
                                key_append = "entr_free_samples"
                            }
                        end
                        return true
                    end)
                }))
            end
        end
    end,
}

local fused_lens = {
    order = 37,
    object_type = "Joker",
    key = "fused_lens",
    rarity = 2,
    cost = 5,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
            "set_entr_inversions"
        }
    },
    eternal_compat = true,
    pos = {x = 1, y = 8},
    atlas = "jokers",
    config = {
        extra = {
            odds = 4
        }
    },
    loc_vars = function(self, q, card)
        local numerator, denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {vars = {
            numerator,
            denominator,
        }} 
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.after and SMODS.pseudorandom_probability(
            card,
            "entr_fused_lens",
            1,
            card and card.ability.extra.odds or self.config.extra.odds
        )) or context.forcetrigger then
            local star_card
            for i, v in pairs(G.P_CENTER_POOLS.Star) do
                if v.config.handname == context.scoring_name then
                    star_card = v.key
                end
            end
            G.E_MANAGER:add_event(Event({
                func = (function()
                    if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit + 1  then
                        SMODS.add_card{
                            key=star_card,
                            set = "Star",
                            area = G.consumeables,
                            key_append = "entr_fused_lens"
                        }
                    end
                    return true
                end)
            }))
            return {
                message = "+1 "..localize("k_star")
            }
        end
    end,
}

local opal = {
    order = 38,
    object_type = "Joker",
    key = "opal",
    rarity = 2,
    cost = 7,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 5, y = 6 },
    atlas = "jokers",
    calculate = function(self, card, context)
        if context.repetition
        and SMODS.has_no_suit(context.other_card, true)
        then
            return {
                message = localize("k_again_ex"),
                repetitions = 1,
                card = card,
            }
        end
    end,
}

local inkbleed = {
    order = 39,
    object_type = "Joker",
    key = "inkbleed",
    rarity = 2,
    cost = 4,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 7, y = 6 },
    atlas = "jokers",
    entr_credits = {
        art = {"LFMoth"}
    }
}

local roulette = {
    order = 40,
    object_type = "Joker",
    key = "roulette",
    rarity = 3,
    cost = 9,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    config = {
        mult_gain = 3,
        extra = {
            odds = 3,
        },
        card = 6,
        immutable = {
            curr_card = 0
        }
    },
    eternal_compat = true,
    pos = {x = 0, y = 8},
    atlas = "jokers",
    loc_vars = function(self, q, card)
        local num, denom = SMODS.get_probability_vars(card, 1, card.ability.extra.odds)
        return {
            vars = {
                num,
                denom,
                number_format(card.ability.mult_gain),
                number_format(math.floor(card.ability.card))
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(
                card,
                "entr_roulette",
                1,
                card and card.ability.extra.odds or self.config.extra.odds
            ) then
                context.other_card.ability.perma_mult = context.other_card.ability.perma_mult + card.ability.mult_gain
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.RED
                }
            end
        end
        if context.after then
            local check
            for i, v in pairs(G.play.cards) do
                card.ability.immutable.curr_card = card.ability.immutable.curr_card + 1
                if to_big(card.ability.immutable.curr_card) == to_big(math.floor(card.ability.card)) then
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            card.ability.immutable.curr_card = 0
                            v:start_dissolve()
                            v.ability.temporary2 = true
                            return true
                        end
                    })
                    check = true
                end
            end
            if check then
                return {
                    message = localize("k_destroyed_ex"),
                    colour = G.C.RED
                }
            end
        end
    end
}

local debit_card = {
    order = 41,
    object_type = "Joker",
    key = "debit_card",
    rarity = 2,
    cost = 7,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 6, y = 6 },
    atlas = "jokers",
    config = {
        amount = 1,
        needed = 25,
        current_spent = 0,
        current = 0
    },
    demicoloncompat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.amount),
                number_format(card.ability.needed),
                number_format(card.ability.needed-card.ability.current_spent),
                number_format(card.ability.current),
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.money_altered and to_big(context.amount) < to_big(0) and not context.blueprint and context.from_shop then
            card.ability.current_spent = card.ability.current_spent - context.amount
            local check 
            while to_big(card.ability.current_spent) >= to_big(card.ability.needed) do
                card.ability.current_spent = card.ability.current_spent - card.ability.needed
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "current", scalar_value = "amount"})
                check = true
            end
            if not check then
                return {
                    message = number_format(card.ability.current_spent).."/"..number_format(card.ability.needed)
                }
            end
        end
        if context.forcetrigger then
            ease_dollars(card.ability.current)
        end
    end,
    calc_dollar_bonus = function(self, card)
        if to_big(card.ability.current) > to_big(0) then
            return card.ability.current
        end
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}

local birthday_card = {
    order = 42,
    object_type = "Joker",
    key = "birthday_card",
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_misc_jokers",
        }
    },
    eternal_compat = true,
    pos = { x = 9, y = 6 },
    atlas = "jokers",
    config = {
        xmult = 2,
        consumables = 2
    },
    demicoloncompat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.xmult),
                number_format(card.ability.consumables),
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if Overflow then
            if context.joker_main and G.consumeables:get_total_count() >= card.ability.consumables then
                return {
                    xmult = card.ability.xmult
                }
            end
        else
            if context.joker_main and #G.consumeables.cards >= card.ability.consumables then
                return {
                    xmult = card.ability.xmult
                }
            end
        end
        if context.forcetrigger then
            return {
                xmult = card.ability.xmult
            }
        end
    end,
}

local ruby = {
    object_type = "Joker",
    key = "ruby",
    order = 300,
    rarity = 4,
    cost = 20,
    atlas = "ruby_atlas",
    pos = {x=0, y=0},
    soul_pos = {x = 1, y = 0},
    config = {
        xmult = 1,
        xmult_mod = 2
    },
    demicoloncompat = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.entr_path_changed and not context.blueprint then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xmult", scalar_value = "xmult_mod"})
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.xmult
            }
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.xmult_mod),
                number_format(card.ability.xmult)
            }
        }
    end
}

local slipstream = {
    object_type = "Joker",
    key = "slipstream",
    order = 301,
    rarity = 4,
    cost = 20,
    atlas = "ruby_atlas",
    pos = {x=0, y=1},
    soul_pos = {x = 1, y = 1},
    config = {
        xmult = 2,
    },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.setting_blind then
            if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        G.GAME.consumeable_buffer = 0
                        SMODS.add_card{
                            set = "Omen",
                            area = G.consumeables,
                            key_append = "entr_slipstream"
                        }         
                        return true
                    end
                })
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                return {
                    message = "+1 "..localize("k_omen")
                }
            end
        end
        if context.joker_main or context.forcetrigger then
            for i, v in pairs(G.consumeables.cards) do
                if v.config.center.set == "Omen" then 
                    local num = v.getQty and v:getQty() or 1
                    for i = 1, num do
                        G.E_MANAGER:add_event(Event{
                            func = function()
                                card:juice_up()
                                return true
                            end
                        })
                    end
                    SMODS.calculate_effect({xmult = card.ability.xmult}, v)
                end
            end
            return nil, true
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.xmult)
            }
        }
    end,
    entr_credits = {art = {"Lil. Mr. Slipstream"}}
}

local cass = {
    object_type = "Joker",
    key = "cass",
    order = 302,
    rarity = 4,
    cost = 20,
    atlas = "ruby_atlas",
    pos = {x=0, y=2},
    soul_pos = {x = 1, y = 2},
    config = {
        hand_size = 0,
        selection_limit = 0,
        hands = 0,
        discards = 0,
        consumable_slots = 0,
        shop_slots = 0,
        mod = 0.5
    },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.using_consumeable and (context.consumeable.config.center.set == "Planet" or context.consumeable.config.center.set == "Star") then
            card.ability.mod = math.min(card.ability.mod, 20)
            local result = pseudorandom(pseudoseed("entr_cass"), 1, 6)
            if result == 1 then
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "hand_size", scalar_value = "mod"})
                G.hand:handle_card_limit(card.ability.hand_size)
            elseif result == 2 then
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "selection_limit", scalar_value = "mod"})
                Entropy.ChangeFullCSL(card.ability.mod)
            elseif result == 3 then 
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "hands", scalar_value = "mod"})
                G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.mod
                ease_hands_played(card.ability.mod)
            elseif result == 4 then
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "discards", scalar_value = "mod"})
                G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.mod
                ease_discard(card.ability.mod)
            elseif result == 5 then
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "consumable_slots", scalar_value = "mod"})
                G.consumeables:handle_card_limit(card.ability.consumable_slots)
            elseif result == 6 then
                if to_big(card.ability.shop_slots) < to_big(4) then
                    SMODS.scale_card(card, {ref_table = card.ability, ref_value = "shop_slots", scalar_value = "mod"})
                    if to_big(card.ability.shop_slots) > to_big(4) then
                        card.ability.shop_slots = 4
                    else
                        local diff = math.min(card.ability.mod, 4-card.ability.mod)
                        G.E_MANAGER:add_event(Event({
                            func = function() --card slot
                                -- why is this in an event?
                                change_shop_size(to_number(math.min(diff, 20)))
                                return true
                            end,
                        }))
                    end
                end
            end
        end
    end,
    remove_from_deck = function(self, card)        
        G.hand:handle_card_limit(-card.ability.hand_size)
        Entropy.ChangeFullCSL(-card.ability.selection_limit)
        if to_big(card.ability.hands) > to_big(0) then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands - card.ability.hands
            ease_hands_played(-card.ability.hands)
        end
        if to_big(card.ability.discards) > to_big(0) then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards - card.ability.discards
            ease_discard(-card.ability.discards)
        end
        G.consumeables:handle_card_limit(-card.ability.consumable_slots)        
        G.E_MANAGER:add_event(Event({
            func = function() --card slot
                -- why is this in an event?
                change_shop_size(-to_number(math.min(card.ability.shop_slots, 10)))
                return true
            end,
        }))
    end,
    add_to_deck = function(self, card)
        G.hand:handle_card_limit(card.ability.hand_size)
        Entropy.ChangeFullCSL(card.ability.selection_limit)
        if to_big(card.ability.hands) > to_big(0) then
            G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.hands
            ease_hands_played(card.ability.hands)
        end
        if to_big(card.ability.discards) > to_big(0) then
            G.GAME.round_resets.discards = G.GAME.round_resets.discards + card.ability.discards
            ease_discard(card.ability.discards)
        end
        G.consumeables:handle_card_limit(card.ability.consumable_slots)
        G.E_MANAGER:add_event(Event({
            func = function() --card slot
                -- why is this in an event?
                change_shop_size(to_number(math.min(card.ability.shop_slots, 20)))
                return true
            end,
        }))
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.hand_size),
                number_format(card.ability.selection_limit),
                number_format(card.ability.hands),
                number_format(card.ability.discards),
                number_format(card.ability.consumable_slots),
                number_format(card.ability.shop_slots),
                number_format(math.min(card.ability.mod, 20)),
            }
        }
    end,
    entr_credits = {art = {"Lil. Mr. Slipstream"}}
}

local crabus = {
    object_type = "Joker",
    key = "crabus",
    order = 303,
    rarity = 4,
    cost = 20,
    atlas = "ruby_atlas",
    pos = {x=0, y=3},
    soul_pos = {x = 1, y = 3},
    config = {
        x_chips = 1,
        x_chips_mod = 0.05
    },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.before and not context.repetition and not context.blueprint then
            local cards = {}
            for i, v in pairs(context.full_hand) do
                if not SMODS.in_scoring(v, context.scoring_hand) then cards[#cards+1] = v end
            end
            Entropy.FlipThen(cards, function(card)
                card:set_ability(G.P_CENTERS.m_entr_dark)
            end)
        end
        if context.setting_ability and not context.unchanged and context.new == "m_entr_dark" then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "x_chips",
                scalar_value = "x_chips_mod"
            })
        end
        if context.individual and context.cardarea == G.play and SMODS.has_enhancement(context.other_card, "m_entr_dark") then
			local cards = {}
			local suits = {}
			for i, v in ipairs(G.play.cards) do
				if v.config.center.key == "m_cry_abstract" or v.config.center.key == "m_stone" or v.config.center.key == "m_wild" then
					if not suits[v.config.center.key] then
						suits[v.config.center.key] = true
						cards[#cards+1]=true
					end
				else
					if not suits[v.base.suit] then
						suits[v.base.suit] = true
						cards[#cards+1]=true
					end
				end
			end
			for i, v in ipairs(cards) do
				card_eval_status_text(
					context.other_card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
				context.other_card.ability.xchips = context.other_card.ability.xchips + context.other_card.ability.xchip_mod
				delay(0.3)
			end
        end
        if context.joker_main then return {x_chips = card.ability.x_chips} end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.x_chips_mod),
                number_format(card.ability.x_chips),
            }
        }
    end,
    entr_credits = {art = {"Lil. Mr. Slipstream"}}
}

local sandpaper = {
    order = 43,
    object_type = "Joker",
    key = "sandpaper",
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_runes",
        }
    },
    eternal_compat = true,
    pos = { x = 0, y = 7 },
    atlas = "jokers",
    demicoloncompat = true,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_stone
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.after then
            local stones = {}
            for i, v in pairs(G.play.cards) do
                if v.config.center.key == "m_stone" then
                    stones[#stones+1] = v
                end
            end
            if #stones > 0 then
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    blocking = false,
                    func = function()
                        for i, v in pairs(stones) do v:start_dissolve(); v.ability.temporary2 = true end
                        if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                            SMODS.add_card{
                                set = "Rune",
                                area = G.consumeables,
                                key_append = "entr_sandpaper"
                            }
                        end
                        return true
                    end
                })
                return {
                    message = "+1 "..localize("k_rune")
                }
            end
        end
        if context.forcetrigger then
            G.E_MANAGER:add_event(Event{
                trigger = "after",
                blocking = false,
                func = function()
                    for i, v in pairs(stones) do v:start_dissolve(); v.ability.temporary2 = true end
                    SMODS.add_card{
                        set = "Rune",
                        area = G.consumeables,
                        key_append = "entr_sandpaper"
                    }
                    return true
                end
            })
        end
    end,
}

local purple_joker = {
    order = 44,
    object_type = "Joker",
    key = "purple_joker",
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {
            "set_entr_runes",
        }
    },
    eternal_compat = true,
    pos = { x = 1, y = 7 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        xmult_mod = 0.2,
        xmult = 1
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.xmult_mod),
                number_format(card.ability.xmult)
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.rune_triggered and not context.blueprint then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xmult", scalar_value = "xmult_mod", message_key = "a_xmult", message_colour = G.C.RED})
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.xmult
            }
        end
    end,
}

function Entropy.sum_pacts()
    local total = 0
    for i, v in pairs(G.GAME.runes or {}) do
        if G.P_RUNES[v.key].is_pact then
            total = total + v.ability.count or 1
        end
    end
    return total
end

local chalice_of_blood = {
    order = 45,
    object_type = "Joker",
    key = "chalice_of_blood",
    rarity = 3,
    cost = 12,
    dependencies = {
        items = {
            "set_entr_runes",
            "set_entr_inversions"
        }
    },
    eternal_compat = true,
    pos = { x = 2, y = 7 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        xmult_mod = 0.75,
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.xmult_mod),
                number_format(1 + card.ability.xmult_mod * Entropy.sum_pacts())
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                xmult = 1 + card.ability.xmult_mod * Entropy.sum_pacts()
            }
        end
    end,
}

local torn_photograph = {
    order = 46,
    object_type = "Joker",
    key = "torn_photograph",
    rarity = 2,
    cost = 8,
    dependencies = {
        items = {            
            "set_entr_inversions"
        }
    },
    eternal_compat = true,
    pos = { x = 3, y = 7 },
    pixel_size = { h = 95 / 1.2 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        xmult_mod = 0.2,
        xmult = 1
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.xmult_mod),
                number_format(card.ability.xmult)
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.selling_card and Entropy.is_inverted(context.card) and not context.blueprint then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "xmult", scalar_value = "xmult_mod", message_key = "a_xmult", message_colour = G.C.RED})
        end
        if context.joker_main or context.forcetrigger then
            return {
                xmult = card.ability.xmult
            }
        end
    end,
}

local chuckle_cola = {
    order = 47,
    object_type = "Joker",
    key = "chuckle_cola",
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {            
            "set_entr_inversions"
        }
    },
    eternal_compat = true,
    pos = { x = 4, y = 7 },
    atlas = "jokers",
    demicoloncompat = true,
    config = {
        triggers = 20,
        xchip_mod = 2
    },
    pools = {Food = true},
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.xchip_mod),
                number_format(card.ability.triggers)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not card.eaten then
            card.ability.triggers = card.ability.triggers - 1
            context.other_card.ability.bonus = (context.other_card.ability.bonus or 0) + context.other_card:get_chip_bonus() * (card.ability.xchip_mod - 1)
            if card.ability.triggers <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                card.eaten = true
				return {
					message = localize("k_eaten_ex"),
					colour = G.C.FILTER,
				}
            else
                return {
                    message = localize("k_upgrade_ex"),
                    colour = G.C.BLUE,
                    card = context.other_card
                }
            end
        end
    end,
    entr_credits = {
        art = {"Lyman"},
        idea = {"Lyman"}
    }
}

local antiderivative = {
    order = 48,
    object_type = "Joker",
    key = "antiderivative",
    rarity = 3,
    cost = 10,
    dependencies = {
        items = {            
            "set_entr_inversions"
        }
    },
    eternal_compat = true,
    pos = { x = 5, y = 7 },
    atlas = "jokers",
}

function Entropy.get_suit_id(suit)
    if suit == "Diamonds" then return 11 end
    if suit == "Clubs" then return 12 end
    if suit == "Hearts" then return 13 end
    if suit == "Spades" then return 14 end
    for i, v in pairs(SMODS.Suit.obj_buffer) do
        if v == suit then return 15-i end 
    end
end

local is_faceref = Card.is_face
function Card:is_face(...)
    if next(SMODS.find_card("j_entr_antiderivative")) then
        local suit = self.base.suit
        if suit == "Diamonds" or suit == "Clubs" or suit == "Hearts" then return true end
    end
    return is_faceref(self, ...)
end

local get_idref = Card.get_id
function Card:get_id(...)
    if not self.antiderivative_bypass and next(SMODS.find_card("j_entr_antiderivative")) then
        if SMODS.has_no_suit(self) then return -9999 end
        return Entropy.get_suit_id(self.base.suit)
    end
    return get_idref(self,...)
end

local is_suitref = Card.is_suit
function Card:is_suit(suit, ...)
    if next(SMODS.find_card("j_entr_antiderivative")) then
        self.antiderivative_bypass = true
        local ret = type(self.get_id) == "function" and self:get_id() == Entropy.get_suit_id(suit) or nil
        self.antiderivative_bypass = nil
        return ret
    end
    return is_suitref(self, suit, ...)
end

if SpectrumAPI then
    SMODS.PokerHandPart:take_ownership("spa_spectrum_part", {
        func = function(hand)
            if next(SMODS.find_card("j_entr_antiderivative")) then
                local eligible_cards = {}
                local suits = {}
                local num_suits = 0
                for i, card in ipairs(hand) do
                    card.antiderivative_bypass = true
                    if not suits[card:get_id()] and not SMODS.has_no_rank(card) then --card.ability.name ~= "Gold Card"
                        suits[card:get_id()] = true
                        num_suits = num_suits + 1
                    end
                    card.antiderivative_bypass = nil
                    eligible_cards[#eligible_cards + 1] = card
                end
                local num = 5
                if SpectrumAPI.configuration.misc.four_fingers_spectrums then
                    num = SMODS.four_fingers() or 5
                end
                if num_suits >= num then
                    return { eligible_cards }
                end
                return {}
            else    
                local eligible_cards = {}
                local suits = {}
                local num_suits = 0
                for i, card in ipairs(hand) do
                    if not suits[SpectrumAPI.get_suit(card)] and not SMODS.has_no_suit(card) then --card.ability.name ~= "Gold Card"
                        suits[SpectrumAPI.get_suit(card)] = true
                        num_suits = num_suits + 1
                    end
                    eligible_cards[#eligible_cards + 1] = card
                end
                local num = 5
                if SpectrumAPI.configuration.misc.four_fingers_spectrums then
                    num = SMODS.four_fingers() or 5
                end
                if num_suits >= num then
                    return { eligible_cards }
                end
                return {}
            end
        end
    }, true)
end

local get_flushref = get_flush
function get_flush(hand)
    if next(SMODS.find_card("j_entr_antiderivative")) then
        local ret = {}
        local four_fingers = SMODS.four_fingers()
            local suits = {}
            suits[#suits + 1] = 'cry_abstract'
            
            for i,v in pairs(SMODS.Rank.obj_table) do
                suits[#suits + 1] = v.id
            end
        if #hand < four_fingers then return ret else
        for j = 1, #suits do
            local t = {}
            local suit = suits[j]
            local flush_count = 0
            for i=1, #hand do
                hand[i].antiderivative_bypass = true
                if hand[i]:get_id() == suit and not SMODS.has_no_rank(hand[i]) then flush_count = flush_count + 1;  t[#t+1] = hand[i] end
                hand[i].antiderivative_bypass = nil
            end
            if flush_count >= four_fingers then
            table.insert(ret, t)
            return ret
            end
        end
        return {}
        end
    end
    return get_flushref(hand)
end

local alles = {
    order = 49,
    object_type = "Joker",
    key = "alles",
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {            
            "set_entr_inversions"
        }
    },
    config = {
        dollars = 8
    },
    eternal_compat = true,
    pos = { x = 6, y = 7 },
    pixel_size = {h = 46},
    atlas = "jokers",
    calculate = function(self, card, context)
        if context.setting_blind then
            card.ability.hands_played = nil
        end
        if context.before then
            card.ability.hands_played = (card.ability.hands_played or 0) + 1
        end
    end,
    calc_dollar_bonus = function(self, card)
        if (card.ability.hands_played or 0) > 1 then
            return card.ability.dollars
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.dollars)
            }
        }
    end
}

local feynman_point = {
    order = 50,
    object_type = "Joker",
    key = "feynman_point",
    rarity = 3,
    cost = 8,
    dependencies = {
        items = {            
            "set_entr_inversions"
        }
    },
    config = {
        nearest = 0.1,
        nearest_mod = 0.05
    },
    eternal_compat = true,
    pos = { x = 7, y = 7 },
    atlas = "jokers",
    loc_vars = function(self, q, card)
        return {
            vars = {
                number_format(card.ability.nearest),
                number_format(card.ability.nearest_mod)
            }
        }
    end,
    calculate = function(self, card, context)
        if context.pseudorandom_result and context.result and not context.blueprint then
            if not context.trigger_obj or (context.trigger_obj.config.center or {}).key ~= "j_cry_boredom" then
                SMODS.scale_card(card, {ref_table = card.ability, ref_value = "nearest", scalar_value = "nearest_mod", message_colour = G.C.GREEN})
            end
        end
    end
}

local calculate_jokerref = Card.calculate_joker
function Card:calculate_joker(...)
    local ret = calculate_jokerref(self, ...)
    if next(SMODS.find_card("j_entr_feynman_point")) and self.config.center.key ~= "j_entr_feynman_point" and not self.config.center.immutable and self.area == G.jokers then
        local highest = 0
        for i, v in pairs(SMODS.find_card("j_entr_feynman_point")) do
            if to_big(v.ability.nearest) > to_big(highest) then
                highest = v.ability.nearest
            end
        end
        if to_big(highest) > to_big(0) then
            Cryptid.manipulate(self, {
                func = function(num, args, is_big, name)
                    if to_big(num) <= to_big(1) then return num end
                    local nnum = is_big and highest * math.floor(to_big(num) / highest) or (highest * math.floor(num / highest))
                    if to_big(nnum) < to_big(num) then return nnum + highest end
                    if to_big(nnum) < to_big(highest) then return highest end
                    return nnum
                end,
                dont_stack = true,
                no_deck_effects = true
            })
        end
    end
    return ret
end

local set_abilityref = Card.set_ability
function Card:set_ability(...)
    set_abilityref(self, ...)
    if self.config.center.set == "Joker" and self.config.center.key ~= "j_entr_feynman_point" then
        if next(SMODS.find_card("j_entr_feynman_point")) then
            local highest = 0
            for i, v in pairs(SMODS.find_card("j_entr_feynman_point")) do
                if to_big(v.ability.nearest) > to_big(highest) then
                    highest = v.ability.nearest
                end
            end
            if to_big(highest) > to_big(0) then
                G.E_MANAGER:add_event(Event{
                    trigger = "after",
                    blocking = false,
                    func = function()
                        Cryptid.manipulate(self, {
                            func = function(num, args, is_big, name)
                                if to_big(num) <= to_big(1) then return num end
                                local nnum = is_big and highest * math.floor(to_big(num) / highest) or (highest * math.floor(num / highest))
                                if to_big(nnum) < to_big(num) then return nnum + highest end
                                if to_big(nnum) < to_big(highest) then return highest end
                                return nnum
                            end,
                            dont_stack = true,
                            no_deck_effects = true
                        })
                        return true
                    end
                })
            end
        end
    end
end

local neuroplasticity = {
    order = 51,
    object_type = "Joker",
    key = "neuroplasticity",
    rarity = 2,
    cost = 8,
    dependencies = {
        items = {            
            "set_entr_inversions"
        }
    },    
    eternal_compat = true,
    pos = {x = 3, y = 8},
    atlas = "jokers",
    add_to_deck = function(self, card, from_debuff)
        if not G.GAME.randomised_hand_map then
            local map = {}
            local blacklist = {cry_Declare0 = true, cry_Declare1 = true, cry_Declare2 = true, cry_Clusterfuck = true, cry_WholeDeck = true}
            for i, v in pairs(G.handlist) do
                if not blacklist[v] then                    
                    map[#map+1] = v
                end
            end
            G.GAME.randomised_hand_map = {}
            local map_shuffled = copy_table(map)
            pseudoshuffle(map_shuffled, pseudoseed("entr_neuroplasticity"))
            for i, v in pairs(map) do
                G.GAME.randomised_hand_map[v] = map_shuffled[i]
            end
        end
    end,
    remove_from_deck = function(self, card)
        for i,v in pairs(SMODS.find_card("j_entr_neuroplasticity")) do
            if v ~= card then return end
        end
        G.GAME.randomised_hand_map = {}
    end,
    calculate = function(self, card, context)
        if context.end_of_round then
            local map = {}
            local blacklist = {cry_Declare0 = true, cry_Declare1 = true, cry_Declare2 = true, cry_Clusterfuck = true, cry_WholeDeck = true}
            for i, v in pairs(G.handlist) do
                if not blacklist[v] then                    
                    map[#map+1] = v
                end
            end
            G.GAME.randomised_hand_map = {}
            local map_shuffled = copy_table(map)
            pseudoshuffle(map_shuffled, pseudoseed("entr_neuroplasticity"))
            for i, v in pairs(map) do
                G.GAME.randomised_hand_map[v] = map_shuffled[i]
            end
        end
    end,
    entr_credits = {
        art = {"Lil. Mr. Slipstream"}
    }
}

local dragonfruit = {
    order = 52,
    object_type = "Joker",
    key = "dragonfruit",
    rarity = 2,
    cost = 6,
    dependencies = {
        items = {            
            "set_entr_inversions"
        }
    },    
    eternal_compat = true,
    pos = {x = 2, y = 8},
    atlas = "jokers",
    config = {
        left = 5,
        left_mod = 1
    },
    pools = {Food = true},
    add_to_deck = function(self, card, from_debuff)
        Entropy.ChangeFullCSL(card.ability.left)
    end,
    remove_from_deck = function(self, card, from_debuff)
        Entropy.ChangeFullCSL(-card.ability.left)
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.left,
                card.ability.left_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.after and not context.repetition and not context.blueprint then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "left", scalar_value = "left_mod", operation = "-", no_message = true})
            Entropy.ChangeFullCSL(- card.ability.left_mod)
            if card.ability.left <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex"),
                    colour = G.C.FILTER,
                }
            end
            if not msg or type(msg) == "string" then
                return {
                    message = msg or "-"..number_format(card.ability.left_mod),
                    colour = G.C.RED,
                }
            end
        end
    end
}


local jestradiol = {
    order = 53,
    object_type = "Joker",
    key = "jestradiol",
    rarity = 2,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 4, y = 8},
    atlas = "jokers",
    config = {
        left = 3,
        left_mod = 1
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.left,
                card.ability.left_mod
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.blueprint and not context.individual and G.GAME.blind_on_deck == "Boss" and not context.repetition) or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "left", scalar_value = "left_mod", scaling_message = {message = "+"..number_format(card.ability.left_mod)}})
        end
    end,
    use_key = "b_transition",
    can_use = function(self, card)
        return to_big(card.ability.left) > to_big(0)
    end,
    use = function(self, card)
        local cards = {}
        for i, v in pairs(G.hand.highlighted) do
            if to_big(card.ability.left) > to_big(0) then
                cards[#cards+1] = v
                card.ability.left = card.ability.left - 1
            end
        end
        Entropy.FlipThen(cards, function(card)
            SMODS.change_base(card, nil, "Queen")
        end)
        G.hand:unhighlight_all()
    end
}

local penny = {
    order = 54,
    object_type = "Joker",
    key = "penny",
    rarity = 3,
    cost = 10,   
    eternal_compat = true,
    pos = {x = 5, y = 8},
    atlas = "jokers",
    config = {
        extra = {
            chips = 8
        }
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.extra.chips
            }
        }
    end,
    pixel_size = { w = 32, h = 32 },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.blueprint and not context.individual and G.GAME.blind_on_deck == "Boss" and not context.repetition) or context.forcetrigger then
            card.ability.extra.chips = to_big(card.ability.extra.chips) * 2
            SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = "chips",
                scalar_table = {mod = 2},
                scalar_value = "mod"  
            })
            return {
                message = localize("k_upgrade_ex"),
                chips = context.forcetrigger and card.ability.extra.chips or nil
            }
        end
        if context.joker_main then
            return {
                chips = card.ability.extra.chips
            }
        end
    end,
}

local slothful_joker = {
    order = 55,
    object_type = "Joker",
    key = "slothful_joker",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 6, y = 8},
    atlas = "jokers",
    config = {
        smult = 3
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.smult
            }
        }
    end,
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.individual and Entropy.true_suitless(context.other_card) and context.cardarea == G.play) or context.forcetrigger then
            return {
                mult = card.ability.smult
            }
        end
    end,
}

local radar = {
    order = 56,
    object_type = "Joker",
    key = "radar",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 7, y = 8},
    atlas = "jokers",
    config = {
        dollar_mult = 1
    },
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.dollar_mult,
                card.ability.dollar_mult * Entropy.played_hands(5)
            }
        }
    end,
    demicoloncompat = true,
    calc_dollar_bonus = function(self, card)
        return card.ability.dollar_mult * Entropy.played_hands(5)
    end
}

local abacus = {
    order = 57,
    object_type = "Joker",
    key = "abacus",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 8, y = 8},
    atlas = "jokers",
    config = {
        dollar_mult = 1
    },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.individual and context.other_card.base.nominal and to_big(context.other_card.base.nominal) > to_big(0) and context.cardarea == G.play) or context.forcetrigger then
            local id = context.other_card:get_id()
            if id <= 10 or id > 14 and not SMODS.has_no_rank(context.other_card) then
                return {
                    mult = math.ceil(context.other_card.base.nominal / 2)
                }
            end
        end
    end
}

local matryoshka_dolls = {
    order = 58,
    object_type = "Joker",
    key = "matryoshka_dolls",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 9, y = 8},
    atlas = "jokers",
    config = {
        mult = 4
    },
    demicoloncompat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.mult
            }
        end
        if context.setting_blind then
            if G.GAME.joker_buffer + #G.jokers.cards < G.jokers.config.card_limit then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        local ncard = SMODS.add_card{
                            key = "j_entr_matryoshka_dolls",
                            area = G.jokers
                        }
                        ncard.ability.mult = card.ability.mult - 1
                        G.GAME.joker_buffer = 0
                        return true
                    end
                })
                G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                return nil, true
            end
        end
    end,
    entr_credits = {
        idea = {"Corobo"}
    }
}

local menger_sponge = {
    order = 59,
    object_type = "Joker",
    key = "menger_sponge",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 0, y = 9},
    atlas = "jokers",
    config = {
        chips = 10,
        chips_mod = 3,
        base_chips = 10
    },
    demicoloncompat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.chips,
                card.ability.chips_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            local chips = card.ability.chips
            return {
                chips = card.ability.chips
            }
        end
        if (context.end_of_round and not context.individual and not context.repetition) then
            if G.GAME.blind_on_deck == "Boss" then
                card.ability.chips = card.ability.base_chips
                return {
                    message = localize("k_reset")
                }
            else    
                SMODS.scale_card(card, {
                    ref_table = card.ability,
                    ref_value = "chips",
                    scalar_value = "chips_mod",
                    operation = "X"
                })
                return {
                    message = localize("k_upgrade_ex")
                }
            end
        end
    end,
}

local arbitration = {
    order = 60,
    object_type = "Joker",
    key = "arbitration",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 1, y = 9},
    atlas = "jokers",
    config = {
        chips = 10,
        chips_mod = 3,
        base_chips = 10
    },
    demicoloncompat = true,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.c_judgement
        q[#q+1] = G.P_CENTERS.m_glass
    end,
    calculate = function(self, card, context)
        if context.remove_playing_cards or context.forcetrigger then
            local glasses = 0
            for k, v in ipairs(context.removed) do
                if v.shattered then
                    if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
                        G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                        G.E_MANAGER:add_event(Event{
                            func = function()
                                SMODS.add_card{
                                    area = G.consumeables,
                                    key = "c_judgement"
                                }
                                G.GAME.consumeable_buffer = 0
                                return true
                            end
                        })
                    end
                end
            end
            return nil, true
        end
    end,
}

local masterful_gambit = {
    order = 60,
    object_type = "Joker",
    key = "masterful_gambit",
    rarity = 1,
    cost = 4,   
    eternal_compat = true,
    pos = {x = 2, y = 9},
    atlas = "jokers",
    config = {
        dollars = 2
    },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if (context.joker_main and #G.play.cards == 1) or context.forcetrigger then
            return {
                dollars = card.ability.dollars
            }
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.dollars
            }
        }
    end,
}

local fourty_benadryls = {
    order = 61,
    object_type = "Joker",
    key = "fourty_benadryls",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 3, y = 9},
    atlas = "jokers",
    config = {
        chip_mod = 15
    },
    pixel_size = { h = 95 / 1.2 },
    demicoloncompat = true,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            return {
                chips = card.ability.chip_mod * G.GAME.round_resets.ante
            }
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.chip_mod,
                card.ability.chip_mod * G.GAME.round_resets.ante
            }
        }
    end,
}

local red_fourty = {
    order = 62,
    object_type = "Joker",
    key = "red_fourty",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 4, y = 9},
    atlas = "jokers",
    config = {
        mult = 20,
        mult_mod = 2
    },
    demicoloncompat = true,
    blueprint_compat = true,
    pools = {["Food"] = true},
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.mult,
                card.ability.mult_mod
            }
        }
    end,
    calculate = function(self, card, context)
        if context.money_altered and context.from_shop and to_big(context.amount) < to_big(0) then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "mult", scalar_value = "mult_mod", operation = "-", no_message = true})
            if card.ability.mult <= 0 then
                SMODS.destroy_cards(card, nil, nil, true)
                return {
                    message = localize("k_eaten_ex"),
                    colour = G.C.FILTER,
                }
            end
            if not msg or type(msg) == "string" then
                return {
                    message = msg or "-"..number_format(card.ability.mult_mod),
                    colour = G.C.RED,
                }
            end
        end
        if context.joker_main then
            return {
                mult = card.ability.mult
            }
        end
    end
}

local promotion = {
    order = 63,
    object_type = "Joker",
    key = "promotion",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 5, y = 9},
    atlas = "jokers",
    config = {
        mult = 20,
        mult_mod = 2
    },
    demicoloncompat = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.individual and not context.repetition) or context.forcetrigger then
            if G.GAME.blind_on_deck == "Boss" or context.forcetrigger then
                if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
                    G.E_MANAGER:add_event(Event{
                        func = function()
                            SMODS.add_card{
                                set = "Booster",
                                area = G.consumeables,
                                key_append = "entr_promotion"
                            }
                            G.GAME.consumeable_buffer = 0
                            return true
                        end
                    })
                    G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                end
                return nil, true
            end
        end
    end
}

local offbrand = {
    order = 64,
    object_type = "Joker",
    key = "offbrand",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 7, y = 9},
    atlas = "jokers",
    config = {
        mult = 6,
        dollars = 6
    },
    pools = {["Food"] = true},
    demicoloncompat = true,
    blueprint_compat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.mult,
                card.ability.dollars
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            if context.forcetrigger then
                ease_dollars(card.ability.dollars)
            end
            return {
                mult = -card.ability.mult
            }
        end
    end,
    calc_dollar_bonus = function(self, card)
        return card.ability.dollars
    end
}

local girldinner = {
    order = 65,
    object_type = "Joker",
    key = "girldinner",
    rarity = 1,
    cost = 4,   
    eternal_compat = true,
    pos = {x = 8, y = 9},
    atlas = "jokers",
    config = {
        mult = 3,
        chips = 40
    },
    pools = {["Food"] = true},
    demicoloncompat = true,
    blueprint_compat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.mult,
                card.ability.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 12 and (not card.ability.used or card.ability.used == context.other_card) then
            card.ability.used = context.other_card
            return {
                mult = card.ability.mult,
                chips = card.ability.chips
            }
        end
        if (context.end_of_round and not context.individual and not context.repetition) then
            card.ability.used = nil
        end
    end,
    entr_credits = {
        idea = {
            "casknows"
        }
    }
}

local recycling_bin = {
    order = 66,
    object_type = "Joker",
    key = "recycling_bin",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 9, y = 9},
    atlas = "jokers",
    config = {
        mult = 0,
        mult_mod = 1
    },
    demicoloncompat = true,
    blueprint_compat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.mult_mod,
                card.ability.mult,
            }
        }
    end,
    calculate = function(self, card, context)
        if context.discard then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "mult",
                scalar_value = "mult_mod",
                message_key = "a_mult",
                message_colour = G.C.RED
            })
        end
        if context.joker_main or context.forcetrigger then
            return {
                mult = card.ability.mult,
            }
        end
        if (context.end_of_round and not context.individual and not context.repetition) then
            card.ability.mult = 0
            return {
                message = localize("k_reset")
            }
        end
    end,
    entr_credits = {
        idea = {"Youh !"}
    }
}

local gold_bar = {
    order = 67,
    object_type = "Joker",
    key = "gold_bar",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 0, y = 10},
    atlas = "jokers",
    config = {
        dollars = 8,
        dollars_mod = 1
    },
    pools = {["Food"] = true},
    demicoloncompat = true,
    blueprint_compat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.dollars,
                card.ability.dollars_mod,
            }
        }
    end,
    calc_dollar_bonus = function(self, card)
        local dollars = card.ability.dollars
        SMODS.scale_card(card, {
            ref_table = card.ability,
            ref_value = "dollars",
            scalar_value = "dollars_mod",
            operation = "-",
            scaling_message = {
                message = dollars == card.ability.dollars_mod and localize("k_eaten_ex") or "-"..number_format(card.ability.dollars_mod),
                colour = dollars >= card.ability.dollars_mod and G.C.RED or G.C.FILTER
            }
        })
        if to_big(card.ability.dollars) <= to_big(0) then
            SMODS.destroy_cards(card, nil, nil, true)
        end
        return dollars
    end
}

local scribbled_joker = {
    order = 68,
    object_type = "Joker",
    key = "scribbled_joker",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 1, y = 10},
    atlas = "jokers",
    config = {
        chips = 60
    },
    demicoloncompat = true,
    blueprint_compat = true,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.chips
            }
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main or context.forcetrigger then
            local enhanced = 0
            for i, v in pairs(context.full_hand) do
                if SMODS.in_scoring(v, context.scoring_hand) and v.config.center.set == "Enhanced" then
                    enhanced = enhanced + 1
                end
            end
            if enhanced > 0 or context.forcetrigger then
                return {
                    chips = card.ability.chips
                }
            end
        end
    end,
    entr_credits = {
        idea = {"crabus"}
    }
}

local jokers_against_humanity = {
    order = 68,
    object_type = "Joker",
    key = "jokers_against_humanity",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 2, y = 10},
    atlas = "jokers",
    config = {
        chips = 15,
        mult = 2
    },
    demicoloncompat = true,
    blueprint_compat = true,
    loc_vars = function(self, q, card)
        q[#q+1] = {set = "Other", key = "eternal"}
        return {
            vars = {
                card.ability.chips,
                card.ability.mult
            }
        }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play then
            if not card.ability.used then
                context.other_card.ability.eternal = true
                context.other_card:juice_up()
                card.ability.used = true
            end
            if context.other_card.ability.eternal then
                return {
                    chips = card.ability.chips,
                    mult = card.ability.mult
                }
            end
        end
        if context.after then
            card.ability.used = nil
        end
    end,
    entr_credits = {
        idea = {"crabus"}
    }
}

local blind_collectible_pack = {
    order = 69,
    object_type = "Joker",
    key = "blind_collectible_pack",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 3, y = 10},
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if context.selling_self or context.forcetrigger then
            if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                G.E_MANAGER:add_event(Event{
                    func = function()
                        SMODS.add_card{
                            set = "CBlind",
                            area = G.consumeables,
                            key_append = "entr_bcp"
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                })
            end
        end
    end,
    entr_credits = {
        idea = {"crabus"}
    }
}

local prayer_card = {
    order = 70,
    object_type = "Joker",
    key = "prayer_card",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 4, y = 10},
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    config = {
        amount = 100
    },
    calculate = function(self, card, context)
        if context.setting_blind or context.forcetrigger then
            card.gone = false
			G.GAME.blind.chips = G.GAME.blind.chips - card.ability.amount * G.GAME.round_resets.ante
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			G.HUD_blind:recalculate()
            return nil, true
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.amount,
                card.ability.amount * G.GAME.round_resets.ante
            }
        }
    end,
    entr_credits = {
        idea = {"crabus"}
    }
}

local desert = {
    order = 71,
    object_type = "Joker",
    key = "desert",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 5, y = 10},
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    config = {
        asc = 0,
        asc_mod = 0.05
    },
    calculate = function(self, card, context)
        if context.before and #G.play.cards == 1 then
            SMODS.scale_card(card, {
                ref_table = card.ability,
                ref_value = "asc",
                scalar_value = "asc_mod"
            })
        end
        if context.joker_main then
            return {
                plus_asc = card.ability.asc
            }
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.asc_mod,
                card.ability.asc
            }
        }
    end,
}

local rugpull = {
    order = 72,
    object_type = "Joker",
    key = "rugpull",
    rarity = 1,
    cost = 4,   
    eternal_compat = true,
    pos = {x = 6, y = 10},
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    config = {
        multiplier = 1.25
    },
    loc_vars = function(self, q, card)
        return {
            vars = {card.ability.multiplier}
        }
    end
}

local grape_juice = {
    order = 73,
    object_type = "Joker",
    key = "grape_juice",
    rarity = 1,
    cost = 6,   
    eternal_compat = true,
    pos = {x = 7, y = 10},
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    config = {
        left = 3,
        left_mod = 1
    },
    loc_vars = function(self, q, card)
        return {
            vars = {card.ability.left, card.ability.left_mod}
        }
    end,
    can_use = function(self, card) return to_big(card.ability.left) > to_big(0) and #G.hand.cards > 0 end,
    use = function(self, card)
        card.ability.left = card.ability.left - 1
        local card = pseudorandom_element(G.hand.cards, pseudoseed("entr_grape_juice"))
        local enhancement = pseudorandom_element({"m_bonus", "m_wild", "m_mult"}, pseudoseed("entr_grape_juice"))
        Entropy.FlipThen({card}, function(card) card:set_ability(G.P_CENTERS[enhancement]) end)
    end,
    calculate = function(self, card, context)
        if (context.end_of_round and not context.blueprint and not context.individual and G.GAME.blind_on_deck == "Boss" and not context.repetition) or context.forcetrigger then
            SMODS.scale_card(card, {ref_table = card.ability, ref_value = "left", scalar_value = "left_mod", scaling_message = {message = "+"..number_format(card.ability.left_mod)}})
        end
    end,
}

local petrichor = {
    order = 74,
    object_type = "Joker",
    key = "petrichor",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 8, y = 10},  
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    config = {
        chips = 25
    },
    loc_vars = function(self, q, card)
        return {
            vars = {card.ability.chips}
        }
    end,
    calculate = function(self, card, context)
        if (context.individual and context.cardarea == "unscored") or context.forcetrigger then
            return {
                chips = card.ability.chips
            }
        end
    end,
}

local otherworldly_joker = {
    order = 75,
    object_type = "Joker",
    key = "otherworldly_joker",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 9, y = 10},  
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if (context.skipping_booster) or context.forcetrigger then
            if G.GAME.consumeable_buffer + #G.consumeables.cards < G.consumeables.config.card_limit then
                G.E_MANAGER:add_event(Event{
                    func = function()
                        SMODS.add_card{
                            area = G.consumeables,
                            set = "Twisted",
                            key_append = "entr_otherworldly"
                        }
                        G.GAME.consumeable_buffer = 0
                        return true
                    end
                })
                G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
            end
            return {
                message = localize({ type = "variable", key = "a_twisted", vars = { 1 } }),
                colour = G.C.RED
            }
        end
    end,
}

local error_joker = {
    order = 76,
    object_type = "Joker",
    key = "error",
    rarity = 1,
    cost = 4,   
    eternal_compat = true,
    pos = {x = 0, y = 11},  
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
}

local thirteen_of_stars = {
    order = 77,
    object_type = "Joker",
    key = "thirteen_of_stars",
    rarity = 1,
    cost = 5,   
    eternal_compat = true,
    pos = {x = 1, y = 11},  
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    calculate = function(self, card, context)
        if (context.joker_main) or context.forcetrigger then
            local text = G.FUNCS.get_poker_hand_info(G.play.cards)
            if text and G.GAME.hands[text] then
                return {
                    plus_asc = G.GAME.hands[text].level/4
                }
            end
        end
    end,
}

local diode = {
    order = 78,
    object_type = "Joker",
    key = "diode",
    rarity = 1,
    cost = 6,
    eternal_compat = true,
    pos = {x = 2, y = 11},  
    atlas = "jokers",
    demicoloncompat = true,
    blueprint_compat = true,
    config = {
        mult = 6,
        chips = 40
    },
    calculate = function(self, card, context)
        if context.after then
            card.ability.blue = not card.ability.blue
            return {
                message = localize("k_switch_ex"),
                colour = G.C.dark_edition
            }
        end
        if (context.joker_main) or context.forcetrigger then
            return {
                chips = card.ability.blue and card.ability.chips or nil,
                mult = not card.ability.blue and card.ability.mult or nil
            }
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.blue and card.ability.chips or card.ability.mult
            },
            key = card.ability.blue and "j_entr_diode_blue" or "j_entr_diode_red"
        }
    end
}

local prismatic_shard = {
    order = 79,
    object_type = "Joker",
    key = "prismatic_shard",
    rarity = 1,
    cost = 6,
    eternal_compat = true,
    pos = {x = 0, y = 0},
    soul_pos = {x = 0, y = 1},
    atlas = "prismatic_shard",
    demicoloncompat = true,
    blueprint_compat = true,
    config = {
        mult = 2,
        chips = 10,
        plus_asc = 0.25
    },
    calculate = function(self, card, context)
        if (context.individual and context.cardarea == G.play) or context.forcetrigger then
            local etype = pseudorandom_element({"mult", "chips", "plus_asc"}, pseudoseed("prismatic_shard"))
            return {
                [etype] = card.ability[etype]
            }
        end
    end,
    loc_vars = function(self, q, card)
        return {
            vars = {
                card.ability.mult,
                card.ability.chips,
                card.ability.plus_asc
            }
        }
    end
}

return {
    items = {
        surreal,
        solarflare,
        strawberry_pie,
        recursive_joker,
        dr_sunshine,
        sunny_joker,
        antidagger,
        solar_dagger,
        insatiable_dagger,
        rusty_shredder,
        chocolate_egg,
        lotteryticket,
        devilled_suns,
        eden,
        seventyseven,
        tesseract,
        skullcry,
        dating_simbo,
        bossfight,
        sweet_tooth,
        phantom_shopper,
        sunny_side_up,
        code_m,
        sunflower_seeds,
        tenner,
        sticker_sheet,
        fourbit,
        crimson_flask,
        grotesque_joker,
        dog_chocolate,
        nucleotide,
        afterimage,
        qu,
        memento_mori,
        broadcast,
        milk_chocolate,
        insurance_fraud,
        free_samples,
        fused_lens,
        opal,
        inkbleed,
        roulette,
        debit_card,
        birthday_card,
        ruby,
        slipstream,
        cass,
        crabus,
        sandpaper,
        purple_joker,
        chalice_of_blood,
        torn_photograph,
        chuckle_cola,
        antiderivative,
        alles,
        feynman_point,
        neuroplasticity,
        dragonfruit,
        jestradiol,
        penny,
        slothful_joker,
        radar,
        abacus,
        matryoshka_dolls,
        menger_sponge,
        arbitration,
        masterful_gambit,
        fourty_benadryls,
        red_fourty,
        promotion,
        offbrand,
        girldinner,
        recycling_bin,
        gold_bar,
        scribbled_joker,
        jokers_against_humanity,
        blind_collectible_pack,
        prayer_card,
        desert,
        rugpull,
        grape_juice,
        petrichor,
        otherworldly_joker,
        error_joker,
        thirteen_of_stars,
        diode,
        prismatic_shard
    }
}
