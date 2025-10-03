SMODS.Sticker({
	key = "vamp",
	badge_colour = HEX("830000"),
	atlas = "enh",
	pos = {
		x = 2,
		y = 2,
	},
	sets = {
		Joker = true,
	},
	rate = 0.3,
	needs_enable_flag = true,
	calculate = function(self, card, context)
		if context.setting_blind then
			local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					rr = i
					break
				end
			end
			if G.jokers.cards[rr + 1] == nil or G.jokers.cards[rr - 1] == nil and not context.blueprint then
				card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			end
		end
	end,
})

SMODS.Sticker({
	key = "haunted",
	badge_colour = HEX("232323"),
	atlas = "enh",
	pos = {
		x = 3,
		y = 2,
	},
	sets = {
		Joker = true,
	},
	rate = 0.06,
	needs_enable_flag = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			card:start_dissolve({ HEX("57ecab") }, nil, 1.6)
		end
	end,
})

SMODS.Sticker({
	key = "radioactive",
	badge_colour = HEX("008c24"),
	atlas = "enh",
	pos = {
		x = 4,
		y = 2,
	},
	sets = {
		Joker = true,
	},
	rate = 0.1,
	needs_enable_flag = true,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			local rr = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then
					rr = i
					break
				end
			end
			local lc = { "Left", "Right" }
			local choosencard = pseudorandom_element(lc, pseudoseed("radioactive"))
			if choosencard == "Left" and G.jokers.cards[rr - 1] ~= nil then
				G.jokers.cards[rr - 1]:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			elseif choosencard == "Right" and G.jokers.cards[rr + 1] ~= nil then
				G.jokers.cards[rr + 1]:start_dissolve({ HEX("57ecab") }, nil, 1.6)
			end
		end
	end,
})

SMODS.Sticker({
	key = "absolute",
	badge_colour = HEX("ffe9b5"),
	atlas = "enh",
	pos = {
		x = 2,
		y = 3,
	},
	sets = {
		Joker = true,
	},
	rate = 0.06,
	needs_enable_flag = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { G.GAME.probabilities.normal },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and not context.blueprint then
			if pseudorandom("absolute") < G.GAME.probabilities.normal / 4 then
				local rr = nil
				for i = 1, #G.jokers.cards do
					if G.jokers.cards[i] == card then
						rr = i
						break
					end
				end
				local card2 = G.jokers.cards[rr].config.center_key
				SMODS.add_card({
					area = G.jokers,
					key = card2,
				})
			end
		end
	end,
})

SMODS.Sticker({
	key = "continuity",
	badge_colour = HEX("96a0ff"),
	atlas = "enh",
	pos = {
		x = 5,
		y = 1,
	},
	sets = {
		Joker = true,
	},
	rate = 0.06,
	needs_enable_flag = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval then
			local table = {}
			table[#table + 1] = card
			RevosVault.replacecards(table, nil, nil, true, nil)
			card_eval_status_text(card, "extra", nil, nil, nil, { message = "Change!" })
		end
		if card.ability.set == "Enhanced" or card.ability.set == "Default" or card.ability.set == "Playing Card" then
			if context.final_scoring_step and context.cardarea == G.play then
				G.E_MANAGER:add_event(Event({
					trigger = "after",
					delay = 0.2,
					func = function()
						local table = {}
						table[#table + 1] = card
						RevosVault.replacecards(table, nil, nil, true, nil)
						return true
					end,
				}))
			end
		end
	end,
})

SMODS.Sticker({
	key = "overtime",
	badge_colour = HEX("fdffa8"),
	atlas = "enh",
	pos = {
		x = 5,
		y = 2,
	},
	sets = {
		Joker = true,
	},
	config = {
		ad = {
			timer = 3,
		},
	},
	rate = 0.06,
	needs_enable_flag = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { self.config.ad.timer },
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and context.main_eval and self.config.ad.timer == 1 then
			local table = {}
			table[#table + 1] = card
			RevosVault.replacecards(table, nil, nil, true, nil)
			card_eval_status_text(card, "extra", nil, nil, nil, { message = "Change!" })
			SMODS.Stickers["crv_overtime"]:apply(card, false)
			self.config.ad.timer = self.config.ad.timer - 1
		elseif context.end_of_round and context.main_eval and self.config.ad.timer > 0 then
			self.config.ad.timer = self.config.ad.timer - 1
		end
	end,
})

SMODS.Sticker({
	key = "temp",
	badge_colour = SMODS.Gradients["crv_temp"],
	atlas = "enh",
	pos = {
		x = 5,
		y = 3,
	},
	sets = {
		Joker = true,
	},
	rate = 0.01,
	needs_enable_flag = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = {},
		}
	end,
	calculate = function(self, card, context)
		if context.end_of_round and not context.blueprint and context.main_eval then
			card:start_dissolve()
		end
	end,
})

--[[SMODS.Sticker({ overflow crash
	key = "blessed",
	badge_colour = SMODS.Gradients["crv_blessed_g"],
	atlas = "enh",
	pos = {
		x = 6,
		y = 1,
	},
	sets = {
		Joker = true,
	},
	config = {
		timer = 0,
		max_timer = 1,
	},
	rate = 0.04,
	needs_enable_flag = true,
	loc_vars = function(self, info_queue, card)
		return {
			vars = { self.config.timer, self.config.max_timer },
		}
	end,
	calculate = function(self, card, context)
		if context.crv_joker_destroyed and context.crv_destroyedj == card then
			self.trigger = true
			print("removing?")
			if self.trigger then
				self.trigger = nil
				if self.config.timer < self.config.max_timer - 1 then
					print("clone the card")
					SMODS.Stickers["crv_blessed"]:apply(card, false)
					local acard = copy_card(card)
					local area = card.area
					card:add_to_deck()
					area:emplace(card)
					SMODS.calculate_effect({ message = "Blessed!" }, card)
				else
					self.config.timer = self.config.timer + 1
					print("add and clone the card")
					local acard = copy_card(card)
					local area = card.area
					card:add_to_deck()
					area:emplace(card)
					SMODS.calculate_effect({ message = "Blessed!" }, card)
				end
			end
		end
	end,
})]]
