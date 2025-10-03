-- This specific hook exits a lot in my current code. Im not planning to remove them nor move them just yet but the future ones will be implemented here under the same hook

local cardhighold = Card.highlight
function Card:highlight(is_highlighted)
	self.highlighted = is_highlighted
	if self.highlighted and string.find(self.ability.set, "crv_Gems") and self.area == G.consumeables then --this doenst fucking existafjkasyhfasmdlşaslj
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = RevosVault.buttons_edit(self, {
				sell = true,
			}),
			config = {
				align = "cr",
				offset = {
					x = -0.4,
					y = 0,
				},
				parent = self,
			},
		})
	elseif self.highlighted and string.find(self.ability.set, "crv_testing1") and self.area == G.consumeables then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = RevosVault.custom_button_set_1(self, {
				sell = true,
				use = true,
			}),
			config = {
				align = "cr",
				offset = {
					x = -0.4,
					y = 0,
				},
				parent = self,
			},
		})
	elseif
		self.highlighted
		and (string.find(self.ability.set, "Default") or string.find(self.ability.set, "Enhanced") or string.find(
			self.ability.set,
			"Playing Card"
		))
		and self.area == G.hand
		and (#SMODS.find_card("j_crv_holoface") > 0)
		and self:is_face()
	then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = RevosVault.custom_button_set_2(self, {
				use = true,
			}),
			config = {
				align = "cr",
				offset = {
					x = -2.8,
					y = 0,
				},
				parent = self,
			},
		})
	elseif self.highlighted and string.find(self.ability.set, "Gem") and self.area == G.shop_vouchers then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = RevosVault.custom_button_set_3(self, {
				sell = true,
				use = true,
			}),
			config = {
				align = "cr",
				offset = {
					x = -1.6,
					y = 1.1,
				},
				parent = self,
			},
		})
	else
		cardhighold(self, is_highlighted)
	end
end

RevosVault.buttons_edit = function(card, args)
	local args = args or {}
	local use = nil
	local sell = nil

	local args = args or {}
	if args.sell then
		sell = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						one_press = true,
						button = "sell_card",
						func = "can_sell_card",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_sell"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("$"),
												colour = G.C.WHITE,
												scale = 0.4,
												shadow = true,
											},
										},
										{
											n = G.UIT.T,
											config = {
												ref_table = card,
												ref_value = "sell_cost_label",
												colour = G.C.WHITE,
												scale = 0.55,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	if args.use then
		use = nil
		use = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						maxw = 1.25,
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						minh = 0,
						hover = true,
						shadow = true,
						colour = G.C.RED,
						button = "crv_modee",
						func = "can_change_mode",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("crv_mode"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("crv_mode2"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = -0.5,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	return {
		n = G.UIT.ROOT,
		config = {
			align = "cr",
			padding = 0,
			colour = G.C.CLEAR,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = 0.15,
					align = "cl",
				},
				nodes = {
					sell and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { sell },
					} or nil,
					use and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { use },
					} or nil,
				},
			},
		},
	}
end

RevosVault.custom_button_set_1 = function(card, args)
	local args = args or {}
	local use = nil
	local sell = nil

	local args = args or {}
	if args.sell then
		sell = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						one_press = true,
						button = "sell_card",
						func = "can_sell_card",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_sell"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("$"),
												colour = G.C.WHITE,
												scale = 0.4,
												shadow = true,
											},
										},
										{
											n = G.UIT.T,
											config = {
												ref_table = card,
												ref_value = "sell_cost_label",
												colour = G.C.WHITE,
												scale = 0.55,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	if args.use then
		use = nil
		use = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						maxw = 1.25,
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						minh = 0,
						hover = true,
						shadow = true,
						colour = G.C.RED,
						button = "crv_test",
						func = "can_can_test",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = "f",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	return {
		n = G.UIT.ROOT,
		config = {
			align = "cr",
			padding = 0,
			colour = G.C.CLEAR,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = 0.15,
					align = "cl",
				},
				nodes = {
					sell and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { sell },
					} or nil,
					use and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { use },
					} or nil,
				},
			},
		},
	}
end

RevosVault.custom_button_set_2 = function(card, args)
	local args = args or {}
	local use = nil
	local sell = nil

	if args.use then
		use = nil
		use = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "bm",
						maxw = 1.3,
						padding = 0.1,
						r = 0.08,
						minw = 1.1,
						minh = 0.03,
						hover = true,
						shadow = true,
						colour = G.C.RED,
						button = "crv_change",
						func = "crv_can_change",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = -0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = "Swap",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.5,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	return {
		n = G.UIT.ROOT,
		config = {
			align = "cr",
			padding = 0,
			colour = G.C.CLEAR,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = -0.30,
					align = "cl",
				},
				nodes = {
					sell and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { sell },
					} or nil,
					use and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { use },
					} or nil,
				},
			},
		},
	}
end

--[[G.FUNCS.button_templace = function(e)
	local card = e.config.ref_table
	if a then
		e.config.colour = G.C.RED
		e.config.button = "crv_modee"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.button_template2 = function(e)
	local card = e.config.ref_table

end]]

--[[G.FUNCS.can_can_test = function(e)
	local card = e.config.ref_table
	if card.config.center:can_testing() then
		e.config.colour = G.C.RED
		e.config.button = "crv_test"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.crv_test = function(e)
	local card = e.config.ref_table
	card.config.center:testing()
end]]

G.FUNCS.crv_can_change = function(e)
	local card = e.config.ref_table
	if true then
		e.config.colour = G.C.RED
		e.config.button = "crv_change"
	end
end

G.FUNCS.crv_change = function(e)
	local card = e.config.ref_table
	if card:is_face() then
		local face = pseudorandom_element(RevosVault.facepool(card.base.value)).key
		card:flip()
		G.E_MANAGER:add_event(Event({
			trigger = "before",
			delay = 0.5,
			func = function()
				return true
			end,
		}))
		G.E_MANAGER:add_event(Event({
			trigger = "after",
			delay = 0.5,
			func = function()
				SMODS.change_base(card, nil, face)
				card:flip()
				return true
			end,
		}))
	end
end

local card_highlighted_ref12 = Card.highlight
function Card:highlight(is_highlighted)
	self.highlighted = is_highlighted
	if self.highlighted and string.find(self.ability.name, "j_crv_thed6") and self.area == G.jokers then
		if self.children.use_button then
			self.children.use_button:remove()
			self.children.use_button = nil
		end

		self.children.use_button = UIBox({
			definition = RevosVault.create_sell_and_switch_buttons11(self, {
				sell = true,
				use = true,
			}),
			config = {
				align = "cr",
				offset = {
					x = -0.4,
					y = 0,
				},
				parent = self,
			},
		})
	else
		card_highlighted_ref12(self, is_highlighted)
	end
end

RevosVault.create_sell_and_switch_buttons11 = function(card, args)
	local args = args or {}
	local sell = nil
	local use = nil

	if args.sell then
		sell = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						hover = true,
						shadow = true,
						colour = G.C.UI.BACKGROUND_INACTIVE,
						one_press = true,
						button = "sell_card",
						func = "can_sell_card",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("b_sell"),
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = localize("$"),
												colour = G.C.WHITE,
												scale = 0.4,
												shadow = true,
											},
										},
										{
											n = G.UIT.T,
											config = {
												ref_table = card,
												ref_value = "sell_cost_label",
												colour = G.C.WHITE,
												scale = 0.55,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	if args.use then
		use = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						align = "cr",
						maxw = 1.25,
						padding = 0.1,
						r = 0.08,
						minw = 1.25,
						minh = 0,
						hover = true,
						shadow = true,
						colour = G.C.RED,
						button = "use_card",
						func = "can_reroll_cards",
					},
					nodes = {
						{
							n = G.UIT.B,
							config = {
								w = 0.1,
								h = 0.6,
							},
						},
						{
							n = G.UIT.C,
							config = {
								align = "tm",
							},
							nodes = {
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = "Reroll",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.4,
												shadow = true,
											},
										},
									},
								},
								{
									n = G.UIT.R,
									config = {
										align = "cm",
										maxw = 1.25,
									},
									nodes = {
										{
											n = G.UIT.T,
											config = {
												text = "Selected",
												colour = G.C.UI.TEXT_LIGHT,
												scale = 0.3,
												shadow = true,
											},
										},
									},
								},
							},
						},
					},
				},
			},
		}
	end

	return {
		n = G.UIT.ROOT,
		config = {
			align = "cr",
			padding = 0,
			colour = G.C.CLEAR,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = 0.15,
					align = "cl",
				},
				nodes = {
					sell and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { sell },
					} or nil,
					use and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { use },
					} or nil,
				},
			},
		},
	}
end

G.FUNCS.can_reroll_cards = function(e)
	local card = e.config.ref_table
	if card.ability.extra.can_roll == true then
		e.config.colour = G.C.RED
		e.config.button = "reroll_cards"
	else
		e.config.colour = G.C.UI.BACKGROUND_INACTIVE
		e.config.button = nil
	end
end

G.FUNCS.reroll_cards = function(e)
	local card = e.config.ref_table
	Card:reroll_cards()
end

function Card:reroll_cards()
	SMODS.calculate_context({ reroll_cards = true })
end


-- All gems stuff until "--"

RevosVault.custom_button_set_3 = function(card, args)
	local args = args or {}
	local use = nil

	if args.use then
		use = {
			n = G.UIT.C,
			config = {
				align = "cr",
			},
			nodes = {
				{
					n = G.UIT.C,
					config = {
						ref_table = card,
						minw = 1.1,
						maxw = 1.3,
						padding = 0.1,
						align = "bm",
						colour = G.C.GREEN,
						shadow = true,
						r = 0.08,
						minh = 0.94,
						func = "can_redeem_gem",
						one_press = true,
						button = "use_card",
						hover = true,
					},
					nodes = {
						{ n = G.UIT.T, config = { text = "Activate", colour = G.C.WHITE, scale = 0.4 } },
					},
				},
			},
		}
	end

	return {
		n = G.UIT.ROOT,
		config = {
			align = "cr",
			padding = 0,
			colour = G.C.CLEAR,
		},
		nodes = {
			{
				n = G.UIT.C,
				config = {
					padding = 0.15,
					align = "cl",
				},
				nodes = {
					sell and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { sell },
					} or nil,
					use and {
						n = G.UIT.R,
						config = {
							align = "cl",
						},
						nodes = { use },
					} or nil,
				},
			},
		},
	}
end


--Gem tab function to show the gems in a new tab in run info.
function G.UIDEF.used_gems()
	local silent = false
	local keys_used = {}
	local area_count = 0
	local voucher_areas = {}
	local voucher_tables = {}
	local voucher_table_rows = {}
	for k, v in ipairs(G.GAME.used_gems or {}) do
		keys_used[#keys_used + 1] = G.P_CENTERS[v]
	end
	for k, v in ipairs(keys_used) do
		if next(v) then
			area_count = area_count + 1
		end
	end
	for k, v in ipairs(keys_used) do
		if next(v) then
			if #voucher_areas == 5 or #voucher_areas == 10 then
				table.insert(
					voucher_table_rows,
					{ n = G.UIT.R, config = { align = "cm", padding = 0, no_fill = true }, nodes = voucher_tables }
				)
				voucher_tables = {}
			end
			voucher_areas[#voucher_areas + 1] = CardArea(
				G.ROOM.T.x + 0.2 * G.ROOM.T.w / 2,
				G.ROOM.T.h,
				(#v == 1 and 1 or 1.33) * G.CARD_W,
				(area_count >= 10 and 0.75 or 1.07) * G.CARD_H,
				{ card_limit = 2, type = "voucher", highlight_limit = 0 }
			)

			local center = v
			local card = Card(
				voucher_areas[#voucher_areas].T.x + voucher_areas[#voucher_areas].T.w / 2,
				voucher_areas[#voucher_areas].T.y,
				G.CARD_W,
				G.CARD_H,
				nil,
				center,
				{ bypass_discovery_center = true, bypass_discovery_ui = true, bypass_lock = true }
			)
			card:start_materialize(nil, silent)
			silent = true
			voucher_areas[#voucher_areas]:emplace(card)

			card.ability.order = v.order

			table.insert(voucher_tables, {
				n = G.UIT.C,
				config = { align = "cm", padding = 0, no_fill = true },
				nodes = {
					{ n = G.UIT.O, config = { object = voucher_areas[#voucher_areas] } },
				},
			})
		end
	end
	table.insert(
		voucher_table_rows,
		{ n = G.UIT.R, config = { align = "cm", padding = 0, no_fill = true }, nodes = voucher_tables }
	)

	local t = silent
			and {
				n = G.UIT.ROOT,
				config = { align = "cm", colour = G.C.CLEAR },
				nodes = {
					{
						n = G.UIT.R,
						config = { align = "cm" },
						nodes = {
							{
								n = G.UIT.O,
								config = {
									object = DynaText({
										string = { localize("ph_active_gems") },
										colours = { G.C.UI.TEXT_LIGHT },
										bump = true,
										scale = 0.6,
									}),
								},
							},
						},
					},
					{ n = G.UIT.R, config = { align = "cm", minh = 0.5 }, nodes = {} },
					{
						n = G.UIT.R,
						config = { align = "cm", colour = G.C.BLACK, r = 1, padding = 0.15, emboss = 0.05 },
						nodes = {
							{ n = G.UIT.R, config = { align = "cm" }, nodes = voucher_table_rows },
						},
					},
				},
			}
		or {
			n = G.UIT.ROOT,
			config = { align = "cm", colour = G.C.CLEAR },
			nodes = {
				{
					n = G.UIT.O,
					config = {
						object = DynaText({
							string = { localize("no_gems") },
							colours = { G.C.UI.TEXT_LIGHT },
							bump = true,
							scale = 0.6,
						}),
					},
				},
			},
		}
	return t
end

local function voucher_ui()
	local gems = {}

	for k, v in pairs(G.P_CENTER_POOLS.Gem) do
		gems[#gems + 1] = v
	end

	return SMODS.card_collection_UIBox(gems, { 5, 5 }, {
		snap_back = true,
		hide_single_page = true,
		collapse_single_page = true,
		h_mod = 1.18,
		back_func = "your_collection_other_gameobjects",
	})
end

G.FUNCS.your_collection_crv_gems = function()
	G.SETTINGS.paused = true
	G.FUNCS.overlay_menu({
		definition = voucher_ui(),
	})
end

RevosVault.custom_collection_tabs = function()
	return {
		UIBox_button({
			button = "your_collection_crv_gems",
			id = "your_collection_crv_gems",
			label = { localize("b_gems") },	
			minw = 5,
			minh = 1,
		}),
	}
end

G.FUNCS.can_redeem_gem = function(e)
	local card = e.config.ref_table
if to_big(card.config.center.cost) > to_big(G.GAME.dollars) - to_big(G.GAME.bankrupt_at) then
      e.config.colour = G.C.UI.BACKGROUND_INACTIVE
      e.config.button = nil
  else
    e.config.colour = G.C.GREEN
    e.config.button = 'redeem_gem'
  end
end

G.FUNCS.redeem_gem = function(e)
	local card = e.config.ref_table
	
	card.config.center:apply_gem()

	

	SMODS.add_card{
		key = card.config.center.key,
		area = G.vouchers
	}

	


	G.GAME.used_gems[#G.GAME.used_gems + 1] = card.config.center.key

	 if card.ability.set == "Gem" then
        stop_use()
        if not card.config.center.discovered then
            discover_card(card.config.center)
        end

        card.states.hover.can = false
        local top_dynatext = nil	
        local bot_dynatext = nil
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
                top_dynatext = DynaText({string = localize{type = 'name_text', set = card.config.center.set, key = card.config.center.key}, colours = {G.C.WHITE}, rotate = 1,shadow = true, bump = true,float=true, scale = 0.9, pop_in = 0.6/G.SPEEDFACTOR, pop_in_rate = 1.5*G.SPEEDFACTOR})
                bot_dynatext = DynaText({string = localize('b_gem_act'), colours = {G.C.WHITE}, rotate = 2,shadow = true, bump = true,float=true, scale = 0.9, pop_in = 1.4/G.SPEEDFACTOR, pop_in_rate = 1.5*G.SPEEDFACTOR, pitch_shift = 0.25})
                card:juice_up(0.3, 0.5)
                play_sound('card1')
                play_sound('coin1')
                card.children.top_disp = UIBox{
                    definition =    {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
                                        {n=G.UIT.O, config={object = top_dynatext}}
                                    }},
                    config = {align="tm", offset = {x=0,y=0},parent = card}
                }
                card.children.bot_disp = UIBox{
                        definition =    {n=G.UIT.ROOT, config = {align = 'tm', r = 0.15, colour = G.C.CLEAR, padding = 0.15}, nodes={
                                            {n=G.UIT.O, config={object = bot_dynatext}}
                                        }},
                        config = {align="bm", offset = {x=0,y=0},parent = card}
                    }
            return true end }))
        ease_dollars(-card.config.center.cost)

        delay(0.6)


        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 2.6, func = function()
            top_dynatext:pop_out(4)
            bot_dynatext:pop_out(4)
            return true end }))
        
        G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
            card.children.top_disp:remove()
            card.children.top_disp = nil
            card.children.bot_disp:remove()
            card.children.bot_disp = nil
			SMODS.destroy_cards(card, true)
        return true end }))
    end
end


--