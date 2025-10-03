if shenanigans_mod_config.temple_deck then
	SMODS.ConsumableType {
		key = "temple_game",
		primary_colour = G.C.CYAN,
		secondary_colour = G.C.CYAN,
		collection_rows = { 4, 3 },
		shop_rate = 0,
		loc_txt = {},
		default = "c_shen_temple_after_egypt",
		can_stack = false,
		can_divide = false,
		rarities = {
			{ key = 'shen_temple_common', },
			{ key = 'shen_temple_divine', },
		},
	}

	SMODS.Voucher {
		key = "balance",
		atlas = 'shenVouchers',
		discovered = true,
		unlocked = true,
		requires = {},
		pos = { x = 0, y = 0 },
		config = { extra = {
			rate = 1,
		} },
		redeem = function(self, card, area, copier)
			G.E_MANAGER:add_event(Event({
				func = (function()
					if G.GAME.temple_game_rate then
						G.GAME.temple_game_rate = G.GAME.temple_game_rate + card.ability.extra.rate
					else
						G.GAME.temple_game_rate = card.ability.extra.rate
					end
					G.GAME.shen_temple_divine_mod = 0
					G.GAME.used_temple_games = {}
					return true
				end)
			}))
		end
	}

	SMODS.Voucher {
		key = "power",
		atlas = 'shenVouchers',
		discovered = true,
		unlocked = true,
		requires = { 'v_shen_balance' },
		pos = { x = 1, y = 0 },
		config = { extra = {
			rate = 0.08,
		} },
		redeem = function(self, card, area, copier)
			G.E_MANAGER:add_event(Event({
				func = (function()
					G.GAME.shen_temple_divine_mod = G.GAME.shen_temple_divine_mod + card.ability.extra.rate
					return true
				end)
			}))
		end
	}

	SMODS.Rarity {
		key = 'shen_temple_common',
		default_weight = 1,
		badge_colour = HEX('FFFFFF'),
	}

	SMODS.Rarity {
		key = 'shen_temple_divine',
		default_weight = 1,
		badge_colour = HEX('00AAAA'),
	}

	local function set_temple_game_rarity_badge(self, card, badges)
		if card.area and card.area == G.jokers or card.config.center.discovered then
			local function calc_scale_fac(text)
				local size = 0.9
				local font = G.LANG.font
				local max_text_width = 2 - 2 * 0.05 - 4 * 0.03 * size - 2 * 0.03
				local calced_text_width = 0
				-- Math reproduced from DynaText:update_text
				for _, c in utf8.chars(text) do
					local tx = font.FONT:getWidth(c) * (0.33 * size) * G.TILESCALE * font.FONTSCALE
						+ 2.7 * 1 * G.TILESCALE * font.FONTSCALE
					calced_text_width = calced_text_width + tx / (G.TILESIZE * G.TILESCALE)
				end
				local scale_fac = calced_text_width > max_text_width and max_text_width / calced_text_width or 1
				return scale_fac
			end
			local col = G.C.BLACK
			local strings = {}
			if self.rarity == "shen_temple_common" then
				strings = { "Common" }
				col = G.C.GREY
			elseif self.rarity == "shen_temple_divine" then
				strings = { "Divine" }
				col = G.C.LIGHT_CYAN
			end

			local text_colour = G.C.WHITE
			local scale_fac = {}
			local min_scale_fac = 0.4
			for i = 1, #strings do
				scale_fac[i] = calc_scale_fac(strings[i])
				min_scale_fac = math.min(min_scale_fac, scale_fac[i])
			end
			local ct = {}
			for i = 1, #strings do
				ct[i] = {
					string = strings[i],
				}
			end
			badges[#badges + 1] = {
				n = G.UIT.R,
				config = { align = "cm" },
				nodes = {
					{
						n = G.UIT.R,
						config = {
							align = "cm",
							colour = col,
							r = 0.1,
							minw = 1 / min_scale_fac,
							minh = 0.36,
							emboss = 0.05,
							padding = 0.03 * 0.9,
						},
						nodes = {
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = ct or "ERROR",
										colours = { text_colour },
										silent = true,
										float = true,
										shadow = true,
										offset_y = -0.03,
										spacing = 1,
										scale = 0.33 * 0.9,
									}),
								},
							},
							{ n = G.UIT.B, config = { h = 0.1, w = 0.03 } },
						},
					},
				},
			}
		end
	end

	function temple_add_to_deck(self, card)
		self.use(self)
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = 0.3,
			blockable = false,
			func = function()
				G.jokers:remove_card(self)
				card:remove()
				card = nil
				return true;
			end
		}))
	end

	SMODS.Consumable {
		key = "temple_after_egypt",
		set = "temple_game",
		atlas = 'shenTempleGames',
		cost = 15,
		pos = { x = 0, y = 0 },
		config = { stackable = true },
		discovered = true,
		can_use = function(self, card)
			return false
		end,
		use = function(self, card, area, copier)
			G.GAME.used_temple_games[self.key] = true
			play_sound('shen_temple', 1, 1)
			ease_discard(1)
		end,
		rarity = 'shen_temple_common',
		set_badges = set_temple_game_rarity_badge,
		add_to_deck = temple_add_to_deck
	}

	SMODS.Consumable {
		key = "temple_battle_lines",
		set = "temple_game",
		atlas = 'shenTempleGames',
		pos = { x = 1, y = 0 },
		config = { stackable = true },
		cost = 15,
		discovered = true,
		can_use = function(self, card)
			return false
		end,
		use = function(self, card, area, copier)
			G.GAME.used_temple_games[self.key] = true
			play_sound('shen_temple', 1, 1)
			G.E_MANAGER:add_event(Event({
				func = function()
					change_shop_size(1)
					return true
				end
			}))
		end,
		rarity = 'shen_temple_common',
		set_badges = set_temple_game_rarity_badge,
		add_to_deck = temple_add_to_deck
	}

	SMODS.Consumable {
		key = "temple_bomber_golf",
		set = "temple_game",
		atlas = 'shenTempleGames',
		cost = 15,
		pos = { x = 2, y = 0 },
		config = { stackable = true },
		discovered = true,
		can_use = function(self, card)
			return false
		end,
		use = function(self, card, area, copier)
			G.GAME.used_temple_games[self.key] = true
			play_sound('shen_temple', 1, 1)
			G.E_MANAGER:add_event(Event({
				func = function()
					G.consumeables.config.card_limit = G.consumeables.config.card_limit + 1
					return true
				end
			}))
		end,
		rarity = 'shen_temple_common',
		set_badges = set_temple_game_rarity_badge,
		add_to_deck = temple_add_to_deck
	}

	SMODS.Consumable {
		key = "temple_eagle_dive",
		set = "temple_game",
		atlas = 'shenTempleGames',
		cost = 15,
		pos = { x = 3, y = 0 },
		config = { stackable = true },
		discovered = true,
		can_use = function(self, card)
			return false
		end,
		use = function(self, card, area, copier)
			G.GAME.used_temple_games[self.key] = true
			play_sound('shen_temple', 1, 1)
			ease_hands_played(1)
		end,
		rarity = 'shen_temple_common',
		set_badges = set_temple_game_rarity_badge,
		add_to_deck = temple_add_to_deck
	}

	SMODS.Consumable {
		key = "temple_strut",
		set = "temple_game",
		atlas = 'shenTempleGames',
		cost = 15,
		pos = { x = 4, y = 0 },
		config = { stackable = false },
		discovered = true,
		can_use = function(self, card)
			return false
		end,
		use = function(self, card, area, copier)
			G.GAME.used_temple_games[self.key] = true
			play_sound('shen_temple', 1, 1)
			G.GAME.temple_score_balance = true
		end,
		rarity = 'shen_temple_divine',
		set_badges = set_temple_game_rarity_badge,
		add_to_deck = temple_add_to_deck
	}

	SMODS.Consumable {
		key = "temple_varoom",
		set = "temple_game",
		atlas = 'shenTempleGames',
		cost = 15,
		pos = { x = 5, y = 0 },
		config = { stackable = true },
		discovered = true,
		can_use = function(self, card)
			return false
		end,
		use = function(self, card, area, copier)
			G.GAME.used_temple_games[self.key] = true
			play_sound('shen_temple', 1, 1)
			G.E_MANAGER:add_event(Event({
				func = function()
					if G.jokers then
						G.jokers.config.card_limit = G.jokers.config.card_limit + 1
					end
					return true
				end
			}))
		end,
		rarity = 'shen_temple_divine',
		set_badges = set_temple_game_rarity_badge,
		add_to_deck = temple_add_to_deck
	}

	SMODS.Consumable {
		key = "temple_zone_out",
		set = "temple_game",
		atlas = 'shenTempleGames',
		cost = 15,
		pos = { x = 6, y = 0 },
		config = { stackable = true },
		discovered = true,
		can_use = function(self, card)
			return false
		end,
		use = function(self, card, area, copier)
			G.GAME.used_temple_games[self.key] = true
			play_sound('shen_temple', 1, 1)
			G.hand:change_size(1)
		end,
		rarity = 'shen_temple_common',
		set_badges = set_temple_game_rarity_badge,
		add_to_deck = temple_add_to_deck
	}
end
