local flesh = {
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	order = 10000+1,
	object_type = "Enhancement",
	key = "flesh",
	atlas = "enhancements",
	pos = { x = 0, y = 0 },
    config = {
		extra = {
            numerator = 3,
			odds = 4,
		},
	},
	weight = 2,
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.cry_rigged and card.ability.extra.odds or (G.GAME.probabilities.normal*(card.ability.extra.numerator or 3)),
				card.ability.extra.odds,
            }
		}
	end,
	calculate = function(self, card, context)
        if (context.pre_discard and context.cardarea == G.hand and card.highlighted
        and pseudorandom("flesh") < (card.ability.cry_rigged and card.ability.extra.odds or G.GAME.probabilities.normal*(card.ability.extra.numerator/card.ability.extra.odds))) then 
            card.ability.temporary2 = true
			card:remove_from_deck()
            card:start_dissolve()
			SMODS.calculate_context({remove_playing_cards = true, removed={card}})
        end
		if context.forcetrigger then
			card.ability.temporary2 = true
			card:remove_from_deck()
            card:start_dissolve()
			SMODS.calculate_context({remove_playing_cards = true, removed={card}})
		end
	end,
	entr_credits = {
		art = {"Lil. Mr. Slipstream"}
	}
}
local disavowed = {
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	order = 10000+2,
	object_type = "Enhancement",
	key = "disavowed",
	atlas = "enhancements",
	pos = { x = 1, y = 0 },
	weight = 0,
	no_doe = true,
	set_ability = function(self,card) 
		card.ability.disavow = true
	end
}

local prismatic = {
	dependencies = {
        items = {
          "set_entr_entropics"
        }
    },
	order = 10000+4,
	object_type = "Enhancement",
	key = "prismatic",
	atlas = "enhancements",
	pos = { x = 0, y = 1 },
    config = {
		extra = {
            eemult = 1,
			eemult_mod = 0.25
		},
	},
	no_doe = true,
	upgrade_order = 9999,
	no_code = true,
	in_pool = function()
		return false
	end,
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.extra.eemult,
				card.ability.extra.eemult_mod
            }
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.play and context.main_scoring then
			card.ability.extra.eemult = card.ability.extra.eemult + card.ability.extra.eemult_mod
			return {
				emult = card.ability.extra.eemult
			}
		end
	end,
	entr_credits = {
		art = {"Lil. Mr. Slipstream"}
	}
}

local dark = {
	dependencies = {
        items = {
          "set_entr_inversions"
        }
    },
	order = 10000+3,
	object_type = "Enhancement",
	key = "dark",
	atlas = "enhancements",
	pos = { x = 1, y = 1 },
    config = {
		xchips = 1,
		xchip_mod = 0.025
	},
	loc_vars = function(self, info_queue, card)
		return {
            vars = {
                card.ability.xchip_mod,
				card.ability.xchips
            }
		}
	end,
	calculate = function(self, card, context)
		if context.cardarea == G.hand and context.main_scoring then
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
					card,
					"extra",
					nil,
					nil,
					nil,
					{ message = localize("k_upgrade_ex"), colour = G.C.GREEN }
				)
				card.ability.xchips = card.ability.xchips + card.ability.xchip_mod
				delay(0.3)
			end
			return {
				xchips = card.ability.xchips
			}
		end
	end,
}

local ceramic = {
	dependencies = {
        items = {
          "set_entr_misc"
        }
    },
	order = 10000+5,
	object_type = "Enhancement",
	key = "ceramic",
	atlas = "enhancements",
	pos = { x = 2, y = 0 },
	specific_rank = "entr_ceramic",
	shatters = true,
	force_no_face = true,
	config = {
		extra = {
			survive = false
		}
	},
	overrides_base_rank = true, --enhancement do not generate in grim, incantation, etc...
	replace_base_card = true, --So no base chips and no image
	calculate = function(self, card, context)
		if context.final_scoring_step
		and context.cardarea == G.play
		and not context.repetition
		and not SMODS.is_eternal(card)
		and not (card.will_shatter or card.destroyed or card.shattered) and not card.activated then
			if (#G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit) then
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						SMODS.add_card{
							area=G.consumeables,
							set = "Consumeables",
							key_append = "entr_ceramic"
						}
						card:juice_up(0.9, 0.9)
						card:shatter()
						card.ability.temporary2 = true
						return true
					end,
				}))
			else
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						card:juice_up(0.9, 0.9)
						card:shatter()
						card.ability.temporary2 = true
						return true
					end,
				}))
			end
			card.activated = true
		end
		if context.destroying_card and context.destroying_card == card and not card.activated then
			if (#G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit) then
				G.E_MANAGER:add_event(Event({
					trigger = "immediate",
					func = function()
						SMODS.add_card{
							area=G.consumeables,
							set = "Consumeables",
							key_append = "entr_ceramic"
						}
						return true
					end
				}))
				card.ability.temporary2 = true
			end
			card.activated = true
		end
		if context.remove_playing_cards and not card.activated then
			local check
			for i, v in pairs(context.removed) do
				if v == card then check = true end
			end
			if check then
				if (#G.consumeables.cards + G.GAME.consumeable_buffer <= G.consumeables.config.card_limit) then
					G.E_MANAGER:add_event(Event({
						trigger = "immediate",
						func = function()
							SMODS.add_card{
								area=G.consumeables,
								set = "Consumeables",
								key_append = "entr_ceramic"
							}
							return true
						end
					}))
				end
				card.ability.temporary2 = true
				card.activated = true
			end
		end
	end,
	entr_credits = {
		art = {"gudusername_53951"}
	}
}

local is_suitref = Card.is_suit
function Card:is_suit(...)
	if self.config.center.key == "m_entr_ceramic" then return true end
	return is_suitref(self, ...)
end

local kiln = {
    key = "kiln",
    set = "Tarot",
    atlas = "consumables2",
    object_type = "Consumable",
    order = -1000,
    dependencies = {
        items = {
            "set_entr_misc",
			"m_entr_ceramic"
        }
    },
    config = {
        select = 1
    },
    pos = {x=0,y=0},
    use = function(self, card2)
        local cards = Entropy.GetHighlightedCards({G.hand}, card2, 1, card2.ability.select)
        Entropy.FlipThen(cards, function(card)
            card:set_ability(G.P_CENTERS.m_entr_ceramic)
            G.hand:remove_from_highlighted(card)
        end)
            
    end,
    can_use = function(self, card)
        local num = #Entropy.GetHighlightedCards({G.hand}, card, 1, card.ability.select)
        return num > 0 and num <= card.ability.select
    end,
    loc_vars = function(self, q, card)
        q[#q+1] = G.P_CENTERS.m_entr_ceramic
        return {
            vars = {
                card.ability.select
            }
        }
    end,
    entr_credits = {
        art = {"aduckted"}
    },
    demicoloncompat = true,
    force_use = function(self, card)
        self:use(card)
    end
}
return {
    items = {
        flesh,
        disavowed,
		prismatic,
		dark,
		ceramic,
		kiln
    }
}