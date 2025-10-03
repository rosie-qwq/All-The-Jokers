local sun = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 0,
	name = "entr-scarlet-sun",
	key = "scarlet_sun",
	pos = { x = 0, y = 1 },
	atlas = "blinds",
	boss_colour = HEX("FF0000"),
    mult=2,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	}
}

local baracuda ={
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 1,
	key = "burgundy_baracuda",
	pos = { x = 0, y = 2 },
	atlas = "blinds",
	boss_colour = HEX("FF0000"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
			if
				context.destroy_card
				and (context.cardarea == G.play or context.cardarea == "unscored")
				and not G.GAME.blind.disabled
				and pseudorandom("baracuda") < 0.5
			then
				return {remove=true}
			end
	end
}

local dawn = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 2,
	key = "diamond_dawn",
	pos = { x = 0, y = 3 },
	atlas = "blinds",
	boss_colour = HEX("00d5ff"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	config = {
		extra = {
			hand_size = -1
		}
	},
	calculate = function(self, blind, context)
		if context.pre_discard and not G.GAME.blind.disabled then
			Entropy.FlipThen(G.hand.highlighted, function(card, area)
				SMODS.change_base(card, "entr_nilsuit", "entr_nilrank")
			end)
		end
	end,
	set_blind = function(self)
        if not G.GAME.blind.disabled then G.hand:change_size(self.config.extra.hand_size) end
	end,
	defeat = function(self)
        if not G.GAME.blind.disabled then G.hand:change_size(-self.config.extra.hand_size) end
    end,
    disable = function(self)
        G.hand:change_size(-self.config.extra.hand_size)
        G.FUNCS.draw_from_deck_to_hand(-self.config.extra.hand_size)
    end
}

local orchard = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 3,
	key = "olive_orchard",
	pos = { x = 0, y = 4 },
	atlas = "blinds",
	boss_colour = HEX("55ae29"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
		if context.pre_discard and not G.GAME.blind.disabled then
			Entropy.FlipThen(G.hand.cards, function(card, area)
				if not card.highlighted then
					card:set_ability(G.P_CENTERS.m_entr_disavowed)
				end
			end)
		end
		if context.final_scoring_step and not G.GAME.blind.disabled then
			Entropy.FlipThen(G.hand.cards, function(card, area)
				card:set_ability(G.P_CENTERS.m_entr_disavowed)
			end)
		end
	end,
}

local comet = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 4,
	key = "citrine_comet",
	pos = { x = 0, y = 5 },
	atlas = "blinds",
	boss_colour = HEX("ffee00"),
    mult=3,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
		if context.check and not G.GAME.blind.disabled then 
			for i, v in pairs(G.hand.cards) do if not v.highlighted then v.destroy_adjacent = false;v.destroyed_adjacent = false end end
			for i, v in pairs(G.hand.highlighted) do
				v.destroy_adjacent = true
			end
			local remove = {}
			for i, v in pairs(G.hand.cards) do
				if v.destroy_adjacent and not v.destroyed_adjacent then
					if G.hand.cards[i-1] and pseudorandom("citrine") < (Entropy.IsEE() and 0.2 or 0.5) then
						G.hand.cards[i-1]:start_dissolve()
						G.hand.cards[i-1].ability.temporary2 = true
						remove[#remove+1]=G.hand.cards[i-1]
					end
					if G.hand.cards[i+1] and pseudorandom("citrine") < (Entropy.IsEE() and 0.2 or 0.5) then
						G.hand.cards[i+1]:start_dissolve()
						G.hand.cards[i+1].ability.temporary2 = true
						remove[#remove+1]=G.hand.cards[i+1]
					end
					v.destroy_adjacent = false
					v.destroyed_adjacent = true
				end
			end
			if #remove >0 then
				SMODS.calculate_context({remove_playing_cards = true, removed=remove})
			end
		end
	end,
}
-- Entropy.EEBlacklist = {
-- 	bl_cry_obsidian_orb=true,
-- 	bl_entr_endless_entropy_phase_one=true,
-- 	bl_entr_endless_entropy_phase_two=true,
-- 	bl_entr_endless_entropy_phase_three=true,
-- 	bl_entr_endless_entropy_phase_four=true,
-- 	bl_cry_lemon_trophy = true,
-- 	bl_cry_lavender_loop=true,
-- 	bl_cry_vermillion_virus=true,
-- 	bl_cry_turquoise_tornado=true,
-- 	bl_mf_violet_vessel_dx = true,
-- 	bl_mf_cerulean_bell_dx = true,
-- 	bl_mf_needle_dx = true,
-- 	bl_mf_manacle_dx = true,
-- 	bl_mf_pillar_dx = true,
-- 	bl_mf_serpent_dx = true,
-- 	bl_mf_club_dx = true,
-- 	bl_mf_goad_dx = true,
-- 	bl_mf_window_dx = true,
-- 	bl_mf_head_dx = true,
-- 	bl_mf_arm_dx = true,
-- 	bl_mf_wheel_dx = true,
-- 	bl_mf_house_dx = true,
-- 	bl_mf_psychic_dx = true,
-- 	bl_mf_hook_dx = true,
-- }

SMODS.Shader({
    key="entropic_vortex",
    path="splash.fs"
})

local phase1 = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 663,
	key = "endless_entropy_phase_one",
	pos = { x = 0, y = 6 },
	atlas = "blinds",
	boss_colour = HEX("000000"),
    mult=2,
	no_ee = true,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true,
	in_pool = function() return false end,
	next_phase = "bl_entr_endless_entropy_phase_three",
	calculate = function(self, blind, context)
		if to_big(G.GAME.chips) > to_big(G.GAME.blind.chips) then
			G.GAME.chips = 0
			G.GAME.round_resets.lost = true
			G.E_MANAGER:add_event(Event({
				func = function()
					G.GAME.blind:set_blind(G.P_BLINDS[self.next_phase])
					Entropy.ChangePhase()
					G.GAME.blind:juice_up()
					ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
					ease_discard(
						math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards) - G.GAME.current_round.discards_left
					)
					G.FUNCS.draw_from_discard_to_deck()
					return true
				end
			}))
		end
	end,
	set_blind = function()
		G.GAME.EE_R = nil
		if not G.SPLASH_EE then
			G.SPLASH_EE = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 9999, y = 0})
			G.GAME.EE_FADE = 0
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				blocking = false,
				blockable = false,
				delay = 1 * G.SETTINGS.GAMESPEED,
				func = function()
					G.GAME.EE_FADE = 0
					G.SPLASH_EE:define_draw_steps({{
						shader = 'entr_entropic_vortex',
						send = {
							{name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
							{name = 'vort_speed', val = 1},
							{name = 'colour_1', ref_table = G.C, ref_value = 'BLUE'},
							{name = 'colour_2', ref_table = G.C, ref_value = 'WHITE'},
							{name = 'mid_flash', val = 0},
							{name = 'transgender', ref_table = G.GAME, ref_value = "EE_FADE"},
							{name = 'vort_offset', val = (2*90.15315131*os.time())%100000},
						}}}
					)
					return true
				end
			})
		end
	end
}

local phase2 = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 664,
	key = "endless_entropy_phase_three",
	pos = { x = 0, y = 7 },
	atlas = "blinds",
	boss_colour = HEX("000000"),
    mult=3,
	no_ee = true,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true,
	in_pool = function() return false end,
	next_phase = "bl_entr_endless_entropy_phase_two",
	loc_vars = function(self, info_queue, card)
		return { vars = { get_blind_amount(G.GAME.round_resets.ante) * 3 * G.GAME.starting_params.ante_scaling } } -- no bignum?
	end,
	collection_loc_vars = function(self)
		return { vars = { localize("entr_nadir_placeholder") } }
	end,
	set_blind = function()
		G.GAME.EE_R = nil
		if not G.SPLASH_EE then
			G.SPLASH_EE = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 9999, y = 0})
			G.GAME.EE_FADE = 0
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				blocking = false,
				blockable = false,
				delay = 1 * G.SETTINGS.GAMESPEED,
				func = function()
					G.GAME.EE_FADE = 0
					G.SPLASH_EE:define_draw_steps({{
						shader = 'entr_entropic_vortex',
						send = {
							{name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
							{name = 'vort_speed', val = 1},
							{name = 'colour_1', ref_table = G.C, ref_value = 'BLUE'},
							{name = 'colour_2', ref_table = G.C, ref_value = 'WHITE'},
							{name = 'mid_flash', val = 0},
							{name = 'transgender', ref_table = G.GAME, ref_value = "EE_FADE"},
							{name = 'vort_offset', val = (2*90.15315131*os.time())%100000},
						}}}
					)
					return true
				end
			})
		end
	end
}

local phase3 = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 665,
	key = "endless_entropy_phase_two",
	pos = { x = 0, y = 8 },
	atlas = "blinds",
	boss_colour = HEX("000000"),
    mult=1,
	no_ee = true,
    dollars = 8,
	boss = {
		min = 32,
		max = 32,
	},
	no_disable=true,
	in_pool = function() return false end,
	next_phase = "bl_entr_endless_entropy_phase_four",
	calculate = function(self, blind, context)
		if to_big(G.GAME.chips) > to_big(G.GAME.blind.chips) then
			G.GAME.chips = 0
			G.GAME.blind:set_blind(G.P_BLINDS[self.next_phase])
			Entropy.ChangePhase()
			G.GAME.blind:juice_up()
			ease_hands_played(G.GAME.round_resets.hands-G.GAME.current_round.hands_left)
			ease_discard(
				math.max(0, G.GAME.round_resets.discards + G.GAME.round_bonus.discards) - G.GAME.current_round.discards_left
			)
			G.FUNCS.draw_from_discard_to_deck()
			G.jokers:load(G.GAME.EE_JOKERS)
			G.GAME.hands = copy_table(G.GAME.EE_HANDS)
			G.GAME.EE_HANDS = nil
			G.GAME.EE_JOKERS = nil
		end
	end,
	set_blind = function()
		G.GAME.EE_JOKERS = G.jokers:save()
		G.GAME.EE_HANDS = copy_table(G.GAME.hands)
		for i, v in pairs(G.GAME.hands) do
			v.mult = v.s_mult
			v.chips = v.s_chips
			v.level = 1
			G.GAME.hands[i] = v
		end
		G.E_MANAGER:add_event(Event{
			func = function()
				for i, v in pairs(G.jokers.cards) do
					local c = v
					G.E_MANAGER:add_event(Event{
						trigger = "after",
						delay = 0.15 * G.SETTINGS.GAMESPEED,	
						func = function()
							c:juice_up()
							c.debuff = true
							play_sound("multhit1")
							return true
						end
					})
				end
				G.E_MANAGER:add_event(Event{
					trigger = "after",
					delay = 0.4 * G.SETTINGS.GAMESPEED,
					func = function()
						for i, v in pairs(G.jokers.cards) do
							v:start_dissolve()
						end
						play_sound("glass6")
						return true
					end
				})
				G.E_MANAGER:add_event(Event{
					trigger = "after",
					func = function()
						save_run()
						return true
					end
				})
				return true
			end
		})
		G.GAME.blind.chips = 900
		G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
		G.HUD_blind:recalculate()
		G.GAME.EE_R = nil
		if not G.SPLASH_EE then
			G.SPLASH_EE = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 9999, y = 0})
			G.GAME.EE_FADE = 0
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				blocking = false,
				blockable = false,
				delay = 1 * G.SETTINGS.GAMESPEED,
				func = function()
					G.GAME.EE_FADE = 0
					G.SPLASH_EE:define_draw_steps({{
						shader = 'entr_entropic_vortex',
						send = {
							{name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
							{name = 'vort_speed', val = 1},
							{name = 'colour_1', ref_table = G.C, ref_value = 'BLUE'},
							{name = 'colour_2', ref_table = G.C, ref_value = 'WHITE'},
							{name = 'mid_flash', val = 0},
							{name = 'transgender', ref_table = G.GAME, ref_value = "EE_FADE"},
							{name = 'vort_offset', val = (2*90.15315131*os.time())%100000},
						}}}
					)
					return true
				end
			})
		end
	end
}

local phase4 = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 666,
	key = "endless_entropy_phase_four",
	pos = { x = 0, y = 9 },
	atlas = "blinds",
	boss_colour = HEX("000000"),
    mult=1,
	no_ee = true,
    dollars = 8,
	no_disable=true,
	boss = {
		min = 32,
		max = 32,
	},
	exponent = {
		1, 1.5
	},
	in_pool = function() return false end,
	calculate = function(self, blind, context)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.calculate then
				s:calculate(blind, context)
			end
		end
	end,
	set_blind = function(self, reset, silent)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.set_blind then
				s:set_blind(reset, silent)
			end
			if s.name == "The Eye" and not reset then
				G.GAME.blind.hands = {
					["Flush Five"] = false,
					["Flush House"] = false,
					["Five of a Kind"] = false,
					["Straight Flush"] = false,
					["Four of a Kind"] = false,
					["Full House"] = false,
					["Flush"] = false,
					["Straight"] = false,
					["Three of a Kind"] = false,
					["Two Pair"] = false,
					["Pair"] = false,
					["High Card"] = false,
				}
			end
			if s.name == "The Mouth" and not reset then
				G.GAME.blind.only_hand = false
			end
			if s.name == "The Fish" and not reset then
				G.GAME.blind.prepped = nil
			end
			if s.name == "The Water" and not reset then
				G.GAME.blind.discards_sub = G.GAME.current_round.discards_left
				ease_discard(-G.GAME.blind.discards_sub)
			end
			if s.name == "The Needle" and not reset then
				G.GAME.blind.hands_sub = G.GAME.round_resets.hands - 1
				ease_hands_played(-G.GAME.blind.hands_sub)
			end
			if s.name == "The Manacle" and not reset then
				G.hand:change_size(-1)
			end
			if s.name == "Amber Acorn" and not reset and #G.jokers.cards > 0 then
				G.jokers:unhighlight_all()
				for k, v in ipairs(G.jokers.cards) do
					v:flip()
				end
				if #G.jokers.cards > 1 then
					G.E_MANAGER:add_event(Event({
						trigger = "after",
						delay = 0.2,
						func = function()
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 0.85)
									return true
								end,
							}))
							delay(0.15)
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 1.15)
									return true
								end,
							}))
							delay(0.15)
							G.E_MANAGER:add_event(Event({
								func = function()
									G.jokers:shuffle("aajk")
									play_sound("cardSlide1", 1)
									return true
								end,
							}))
							delay(0.5)
							return true
						end,
					}))
				end
			end

			--add new debuffs
			for _, v in ipairs(G.playing_cards) do
				if self:recalc_debuff(v, true) then v:set_debuff(true) end
			end
			for _, v in ipairs(G.jokers.cards) do
				if not reset then
					if self:recalc_debuff(v, true) then v:set_debuff(true) end
				end
			end
		end
		G.GAME.EE_R = nil
		if not G.SPLASH_EE then
			G.SPLASH_EE = Sprite(-30, -13, G.ROOM.T.w+60, G.ROOM.T.h+22, G.ASSET_ATLAS["ui_1"], {x = 9999, y = 0})
			G.GAME.EE_FADE = 0
			G.E_MANAGER:add_event(Event{
				trigger = "after",
				blocking = false,
				blockable = false,
				delay = 1 * G.SETTINGS.GAMESPEED,
				func = function()
					G.GAME.EE_FADE = 0
					G.SPLASH_EE:define_draw_steps({{
						shader = 'entr_entropic_vortex',
						send = {
							{name = 'time', ref_table = G.TIMERS, ref_value = 'REAL'},
							{name = 'vort_speed', val = 1},
							{name = 'colour_1', ref_table = G.C, ref_value = 'BLUE'},
							{name = 'colour_2', ref_table = G.C, ref_value = 'WHITE'},
							{name = 'mid_flash', val = 0},
							{name = 'transgender', ref_table = G.GAME, ref_value = "EE_FADE"},
							{name = 'vort_offset', val = (2*90.15315131*os.time())%100000},
						}}}
					)
					return true
				end
			})
		end
	end,
	defeat = function(self, silent)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			if G.P_BLINDS[k].defeat then
				G.P_BLINDS[k]:defeat(silent)
			end
			if G.P_BLINDS[k].name == "The Manacle" and not self.disabled then
				G.hand:change_size(1)
			end
		end
		G.GAME.EEBeaten = true
		if G.GAME.EEBuildup then
			Entropy.WinEE()
		end
		G.GAME.EEBuildup = false
		check_for_unlock({ type = "beat_ee" })

		G.GAME.EE_R = true
		G.E_MANAGER:add_event(Event{
			blocking = false,
			blockable = false,
			func = function()
				if not G.GAME.EE_FADE or not G.SPLASH_EE then return end
				if G.GAME.EE_FADE <= 0 and G.SPLASH_EE then
					G.SPLASH_EE:remove()
					G.SPLASH_EE = nil
					return true
				end
			end
		})
	end,
	press_play = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.press_play then
				s:press_play()
			end
			if s.name == "The Hook" then
				G.E_MANAGER:add_event(Event({
					func = function()
						local any_selected = nil
						local _cards = {}
						for k, v in ipairs(G.hand.cards) do
							_cards[#_cards + 1] = v
						end
						for i = 1, 2 do
							if G.hand.cards[i] then
								local selected_card, card_key = pseudorandom_element(_cards, pseudoseed("ObsidianOrb"))
								G.hand:add_to_highlighted(selected_card, true)
								table.remove(_cards, card_key)
								any_selected = true
								play_sound("card1", 1)
							end
						end
						if any_selected then
							G.FUNCS.discard_cards_from_highlighted(nil, true)
						end
						return true
					end,
				}))
				G.GAME.blind.triggered = true
				delay(0.7)
			end
			if s.name == "Crimson Heart" then
				if G.jokers.cards[1] then
					G.GAME.blind.triggered = true
					G.GAME.blind.prepped = true
				end
			end
			if s.name == "The Fish" then
				G.GAME.blind.prepped = true
			end
			if s.name == "The Tooth" then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						for i = 1, #G.play.cards do
							G.E_MANAGER:add_event(Event({
								func = function()
									G.play.cards[i]:juice_up()
									return true
								end,
							}))
							ease_dollars(-1)
							delay(0.23)
						end
						return true
					end,
				}))
				G.GAME.blind.triggered = true
			end
		end
	end,
	modify_hand = function(self, cards, poker_hands, text, mult, hand_chips)
		local new_mult = mult
		local new_chips = hand_chips
		local trigger = false
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.modify_hand then
				local this_trigger = false
				new_mult, new_chips, this_trigger = s:modify_hand(cards, poker_hands, text, new_mult, new_chips)
				trigger = trigger or this_trigger
			end
			if s.name == "The Flint" then
				G.GAME.blind.triggered = true
				new_mult = math.max(math.floor(new_mult * 0.5 + 0.5), 1)
				new_chips = math.max(math.floor(new_chips * 0.5 + 0.5), 0)
				trigger = true
			end
		end
		return new_mult or mult, new_chips or hand_chips, trigger
	end,
	debuff_hand = function(self, cards, hand, handname, check)
		G.GAME.blind.debuff_boss = nil
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.debuff_hand and s:debuff_hand(cards, hand, handname, check) then
				G.GAME.blind.debuff_boss = s
				return true
			end
			if s.debuff then
				G.GAME.blind.triggered = false
				if s.debuff.hand and next(hand[s.debuff.hand]) then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.debuff.h_size_ge and #cards < s.debuff.h_size_ge then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.debuff.h_size_le and #cards > s.debuff.h_size_le then
					G.GAME.blind.triggered = true
					G.GAME.blind.debuff_boss = s
					return true
				end
				if s.name == "The Eye" then
					if G.GAME.blind.hands[handname] then
						G.GAME.blind.triggered = true
						G.GAME.blind.debuff_boss = s
						return true
					end
					if not check then
						G.GAME.blind.hands[handname] = true
					end
				end
				if s.name == "The Mouth" then
					if s.only_hand and s.only_hand ~= handname then
						G.GAME.blind.triggered = true
						G.GAME.blind.debuff_boss = s
						return true
					end
					if not check then
						s.only_hand = handname
					end
				end
			end
			if s.name == "The Arm" then
				G.GAME.blind.triggered = false
				if to_big(G.GAME.hands[handname].level) > to_big(1) then
					G.GAME.blind.triggered = true
					if not check then
						level_up_hand(G.GAME.blind.children.animatedSprite, handname, nil, -1)
						G.GAME.blind:wiggle()
					end
				end
			end
			if s.name == "The Ox" then
				G.GAME.blind.triggered = false
				if handname == G.GAME.current_round.most_played_poker_hand then
					G.GAME.blind.triggered = true
					if not check then
						ease_dollars(-G.GAME.dollars, true)
						G.GAME.blind:wiggle()
					end
				end
			end
		end
		return false
	end,
	drawn_to_hand = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.drawn_to_hand then
				s:drawn_to_hand()
			end
			if s.name == "Cerulean Bell" then
				local any_forced = nil
				for k, v in ipairs(G.hand.cards) do
					if v.ability.forced_selection then
						any_forced = true
					end
				end
				if not any_forced then
					G.hand:unhighlight_all()
					local forced_card = pseudorandom_element(G.hand.cards, pseudoseed("ObsidianOrb"))
					if focred_card then
						forced_card.ability.forced_selection = true
						G.hand:add_to_highlighted(forced_card)
					end
				end
			end
			if s.name == "Crimson Heart" and G.GAME.blind.prepped and G.jokers.cards[1] then
				local jokers = {}
				for i = 1, #G.jokers.cards do
					if not G.jokers.cards[i].debuff or #G.jokers.cards < 2 then
						jokers[#jokers + 1] = G.jokers.cards[i]
					end
					G.jokers.cards[i]:set_debuff(false)
				end
				local _card = pseudorandom_element(jokers, pseudoseed("ObsidianOrb"))
				if _card then
					_card:set_debuff(true)
					_card:juice_up()
					G.GAME.blind:wiggle()
				end
			end
		end
	end,
	stay_flipped = function(self, area, card)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.stay_flipped and s:stay_flipped(area, card) then
				return true
			end
			if area == G.hand then
				if
					s.name == "The Wheel"
					and pseudorandom(pseudoseed("ObsidianOrb")) < G.GAME.probabilities.normal / 7
				then
					return true
				end
				if
					s.name == "The House"
					and G.GAME.current_round.hands_played == 0
					and G.GAME.current_round.discards_used == 0
				then
					return true
				end
				if s.name == "The Mark" and card:is_face(true) then
					return true
				end
				if s.name == "The Fish" and G.GAME.blind.prepped then
					return true
				end
			end
		end
	end,
	recalc_debuff = function(self, card, from_blind)
		if card and type(card) == "table" and card.area then
			for k, _ in pairs(Entropy.GetEEBlinds()) do
				s = G.P_BLINDS[k]
				if s.debuff_card then
					s:debuff_card(card, from_blind)
				end
				if s.recalc_debuff then
					s:recalc_debuff(card, from_blind)
				end
				if s.debuff and not G.GAME.blind.disabled and card.area ~= G.jokers then
					--this part is buggy for some reason
					if s.debuff.suit and Card.is_suit(card, s.debuff.suit, true) then
						card:set_debuff(true)
						return
					end
					if s.debuff.is_face == "face" and Card.is_face(card, true) then
						card:set_debuff(true)
						return
					end
					if s.name == "The Pillar" and card.ability.played_this_ante then
						card:set_debuff(true)
						return
					end
					if s.debuff.value and s.debuff.value == card.base.value then
						card:set_debuff(true)
						return
					end
					if s.debuff.nominal and s.debuff.nominal == card.base.nominal then
						card:set_debuff(true)
						return
					end
				end
				if s.name == "Crimson Heart" and not G.GAME.blind.disabled and card.area == G.jokers then
					return
				end
				if s.name == "Verdant Leaf" and not G.GAME.blind.disabled and card.area ~= G.jokers then
					card:set_debuff(true)
					return
				end
			end
		end
	end,
	cry_before_play = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.cry_before_play then
				s:cry_before_play()
			end
		end
	end,
	cry_after_play = function(self)
		for k, _ in pairs(Entropy.GetEEBlinds()) do
			s = G.P_BLINDS[k]
			if s.cry_after_play then
				s:cry_after_play()
			end
		end
	end,
}

local endless_entropy = {
    object_type = "Joker",
    key = "eecc",
    order = 10^300,
    rarity = "entr_zenith",
    cost = 10,
    atlas = "ee_atlas",
    pos = {x=0, y=0},
    soul_pos = {x = 4, y = 3, extra = {x=0,y=1}},
    no_doe = true,
    no_collection = true,
	in_pool = function()
		return false
	end
}

local alabaster = {
	dependencies = {
        items = {
          "set_entr_blinds"
        }
    },
	object_type = "Blind",
    order = 0,
	name = "entr-alabaster_anchor",
	key = "alabaster_anchor",
	pos = { x = 0, y = 10 },
	atlas = "blinds",
	boss_colour = HEX("cebea8"),
    mult=2,
    dollars = 8,
	boss = {
		min = 3,
		max = 10,
		showdown = true,
	},
	calculate = function(self, blind, context)
		if context.after or context.pre_discard then
			for i = 1, #G.jokers.cards do
				Cryptid.manipulate(G.jokers.cards[i], { value = 0.95 })
				G.jokers.cards[i].config.cry_multiply = (G.jokers.cards[i].config.cry_multiply or 1) * 0.95
			end
		end
	end
}

local highlight_ref = Card.highlight
function Card:highlight(is_highlighted)
	if Entropy.BlindIs("bl_entr_alabaster_anchor") and self.area == G.hand and G.hand then
		for i = 1, #G.jokers.cards do
			Cryptid.manipulate(G.jokers.cards[i], { value = 0.95 })
			G.jokers.cards[i].config.cry_multiply = (G.jokers.cards[i].config.cry_multiply or 1) * 0.95
		end
	end
	highlight_ref(self, is_highlighted)
end

if not (SMODS.Mods["Cryptid"] or {}).can_load then
	local er = end_round
	function end_round()
		er()
		for i = 1, #G.jokers.cards do
			if G.jokers.cards[i].config.cry_multiply then
				m = G.jokers.cards[i].config.cry_multiply
				Cryptid.manipulate(G.jokers.cards[i], { value = 1 / m })
				G.jokers.cards[i].config.cry_multiply = nil
			end
		end
	end
end

return {
	items = {
		sun,
		baracuda,
		dawn,
		orchard,
		comet,
		phase1,
		phase2,
		phase3,
		phase4,
		endless_entropy,
		alabaster
	}
}