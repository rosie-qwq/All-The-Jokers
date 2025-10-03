--Had to happen one day.

function RevosVault.check_enhancement(area, enhancement)
	local blss = 0
	if area and type(area) == "table" then
		for _, v in pairs(area) do
			if enhancement then
				if SMODS.has_enhancement(v, enhancement) then
					blss = blss + 1
				end
			else
				if v.ability.set == "Enhanced" then
					blss = blss + 1
				end
			end
		end
		return blss
	end
	return 0
end

function RevosVault.check_edition(area, edition)
	local blss = 0
	if area and type(area) == "table" then
		for _, v in pairs(area) do
			if edition then
				if v.edition and v.edition.key == edition then
					blss = blss + 1
				end
			else
				if v.edition then
					blss = blss + 1
				end
			end
		end
		return blss
	end
	return 0
end

function RevosVault.stencil(area, to_add, _edition)
	local tab = 0
	local total = G.jokers.config.card_limit - #G.jokers.cards
	local num = 0
	for k, v in pairs(area) do
		if _edition and v.edition then
			if v.edition.key == _edition then
				tab = tab + 1
			end
		end
		if v.config.center.key == to_add then
			if v.edition then
				if v.edition.key ~= _edition then
					tab = tab + 1
				end
			else
				tab = tab + 1
			end
		end
	end
	num = total + tab
	return num
end

function joker_add(jKey)
	if type(jKey) == "string" then
		local j = SMODS.create_card({
			key = jKey,
		})

		j:add_to_deck()
		G.jokers:emplace(j)
		-- (Credit to @AstroLighz for the deck codes) --My dumbass couldn't figure this out back then ;-;
		SMODS.Stickers["eternal"]:apply(j, true)
	end
end

function RevosVault.suitcheck(suit, area)
	local suitcheck = 0
	if G.playing_cards then
		for _, v in pairs(area) do
			if v:is_suit(suit, nil, true) then
				suitcheck = suitcheck + 1
			end
		end
		return suitcheck
	end
	return 0
end

function RevosVault.discard(ammount, area)
	G.E_MANAGER:add_event(Event({
		trigger = "before",
		delay = 1,
		func = function()
			local any_selected = nil
			local _cards = {}
			for i = 1, #area do
				_cards[#_cards + 1] = area[i]
			end
			RevosVault.discard_limit(ammount)
			for i = 1, ammount do
				if #area > 0 then
					local selected_card, card_key = pseudorandom_element(_cards, pseudoseed("hook"))
					G.hand:add_to_highlighted(selected_card, true)
					table.remove(_cards, card_key)
					any_selected = true
					play_sound("card1", 1)
				end
			end
			if any_selected then
				G.FUNCS.discard_cards_from_highlighted(nil, true)
				RevosVault.discard_limit(-ammount)
			end
			return true
		end,
	}))
	G.E_MANAGER:add_event(Event({
		trigger = "after",
		delay = 1,
		func = function()
			if ammount > #area then
				for i = 1, #area do
					draw_card(G.deck, G.hand, i * 100 / #area, "up", true)
				end
			elseif ammount <= #area then
				for i = 1, ammount do
					draw_card(G.deck, G.hand, i * 100 / ammount, "up", true)
				end
			end
			return true
		end,
	}))
end

--what the fuck is this
function RevosVault.draw_new_hand()
	local put = 0
	for i = 1, #G.hand.cards do
		draw_card(G.hand, G.discard, 1, "up", true)
		put = put + 1
	end
	for i = 1, G.hand.config.card_limit do
		draw_card(G.deck, G.hand, 1, "up", true)
	end
	for i = 1, put do
		draw_card(G.discard, G.deck, 1, "up", true)
	end
end

--Silent discard and play increase (idk if exists)
--Taken straight from SMODS

function RevosVault.discard_limit(mod)
	G.GAME.starting_params.discard_limit = G.GAME.starting_params.discard_limit + mod
	if G.GAME.starting_params.discard_limit < 0 then
		sendErrorMessage("Discard limit is less than 0", "HandLimitAPI")
	end
	G.hand.config.highlighted_limit =
		math.max(G.GAME.starting_params.discard_limit, G.GAME.starting_params.play_limit, 5)
end

function RevosVault.play_limit(mod)
	G.GAME.starting_params.play_limit = G.GAME.starting_params.play_limit + mod
	if G.GAME.starting_params.play_limit < 1 then
		sendErrorMessage("Play limit is less than 1", "HandLimitAPI")
	end
	G.hand.config.highlighted_limit =
		math.max(G.GAME.starting_params.discard_limit, G.GAME.starting_params.play_limit, 5)
end

function RevosVault.total_limit(mod, silent)
	if silent then
		RevosVault.discard_limit(mod)
		RevosVault.play_limit(mod)
	else
		SMODS.change_discard_limit(mod)
		SMODS.change_play_limit(mod)
	end
end

function RevosVault.joker_limit(mod) end

function RevosVault.defeat()
	G.E_MANAGER:add_event(Event({
		blocking = false,
		func = function()
			if G.STATE == G.STATES.SELECTING_HAND then
				G.GAME.chips = G.GAME.blind.chips
				G.STATE = G.STATES.HAND_PLAYED
				G.STATE_COMPLETE = true
				end_round()
				return true
			end
		end,
	}))
end

function RevosVault.find_lowest(area, reverse, card)
	if not card then
		if reverse then
			local low = 1
			local key = nil
			for i = 1, #area do
				if low <= area[i].base.id then
					low = area[i].base.id
					key = area[i]
				end
			end
			return key
		else
			local high = 15
			local key = nil
			for i = 1, #area do
				if high >= area[i].base.id then
					high = area[i].base.id
					key = area[i]
				end
			end
			return key
		end
	else
		if not reverse then
			local high = 0
			local key

			for i = 1, #area do
				local rcard = area
				if rcard[i].base.times_played > high then
					high = rcard[i].base.times_played
					key = rcard[i]
				end
			end
			return key
		else
			local high = 15
			local key

			for i = 1, #area do
				local rcard = area
				if rcard[i].base.times_played < high then
					high = rcard[i].base.times_played
					key = rcard[i]
				end
			end
			return key
		end
	end
end

function RevosVault.add_tag(random, ammount, key)
	if random and ammount then
		local tags = {}
		for k, v in pairs(G.P_TAGS) do
			table.insert(tags, v.key)
		end
		play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
		play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
		for i = 1, ammount do
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag(pseudorandom_element(tags, pseudoseed("jud_add_tag"))))
					return true
				end,
			}))
		end
	elseif key then
		play_sound("generic1", 0.9 + math.random() * 0.1, 0.8)
		play_sound("holo1", 1.2 + math.random() * 0.1, 0.4)
		for i = 1, ammount do
			G.E_MANAGER:add_event(Event({
				func = function()
					add_tag(Tag(key))
					return true
				end,
			}))
		end
	end
end

function RevosVault.random_joker(area, exclude_card)
	local jokers = {}
	for i = 1, #area do
		if area[i] ~= exclude_card then
			jokers[#jokers + 1] = area[i]
		end
	end
	local result = pseudorandom_element(jokers, pseudoseed("jud_random_joker"))
	return result
end

function RevosVault.wheeloffortune(odds, area)
	local jokas = {}
	if pseudorandom("wof") < G.GAME.probabilities.normal / odds then
		for i = 1, #area do
			if not area[i].edition then
				jokas[#jokas + 1] = area[i]
			end
		end
		RevosVault.random_joker(jokas):set_edition(poll_edition("wheel_of_fortune", nil, true, true))
	end
end

function RevosVault.level_up_hand(hand, level)
	update_hand_text({ sound = "button", volume = 0.7, pitch = 0.8, delay = 0.3 }, {
		handname = localize(hand, "poker_hands"),
		chips = G.GAME.hands[hand].chips,
		mult = G.GAME.hands[hand].mult,
		level = G.GAME.hands[hand].level,
	})
	level_up_hand(used_consumable, hand, nil, level)
	update_hand_text({ sound = "button", volume = 0.7, pitch = 1.1, delay = 0 }, {
		mult = 0,
		chips = 0,
		handname = localize(hand, "poker_hands"),
		level = G.GAME.hands[hand].level,
	})
end

function RevosVault.most_played()
	local _hand, _tally = nil, -1
	for k, v in ipairs(G.handlist) do
		if G.GAME.hands[v].visible and G.GAME.hands[v].played > _tally then
			_hand = v
			_tally = G.GAME.hands[v].played
		end
	end
	return _hand
end

function RevosVault.create_booster(pack)
	local key = pack
	local card = Card(
		G.play.T.x + G.play.T.w / 2 - G.CARD_W * 1.27 / 2,
		G.play.T.y + G.play.T.h / 2 - G.CARD_H * 1.27 / 2,
		G.CARD_W * 1.27,
		G.CARD_H * 1.27,
		G.P_CARDS.empty,
		G.P_CENTERS[key],
		{ bypass_discovery_center = true, bypass_discovery_ui = true }
	)
	card.cost = 0
	G.FUNCS.use_card({ config = { ref_table = card } })
	card:start_materialize()
	return true
end

function RevosVault.facepool(exclude)
	if not exclude then
		exclude = "1"
	end
	local faces = {}
	for _, v in ipairs(SMODS.Rank.obj_buffer) do
		local r = SMODS.Ranks[v]
		if r.face and r.key ~= exclude then
			table.insert(faces, r)
		end
	end
	return faces
end

function RevosVault.remove_all(area)
	for _, v in pairs(area) do
		if #area > 0 then
			SMODS.destroy_cards(v)
		end
	end
end

function RevosVault.crash()
	G.E_MANAGER:add_event(Event({
		trigger = "immediate",
		func = function()
			error(message or "Force Crash")
		end,
	}))
end

function RevosVault.shop_card(with, replace, set, keep, rarity, specific)
	local c = false
	if replace and set or rarity then
		local inshop = {}
		if set then
			for i = 1, #G.shop_jokers.cards do
				if G.shop_jokers.cards[i].ability.set == set then
					inshop[#inshop + 1] = G.shop_jokers.cards[i]
				end
			end
		elseif rarity then
			for i = 1, #G.shop_jokers.cards do
				if G.shop_jokers.cards[i].config.center.rarity == rarity then
					inshop[#inshop + 1] = G.shop_jokers.cards[i]
				end
			end
		end
		if #inshop > 0 then
			if keep then
				if not specific then
					local ca = pseudorandom_element(inshop)
					ca:juice_up()
					ca:set_ability(with.key)
				else
					local ca = pseudorandom_element(inshop)
					ca:juice_up()
					ca:set_ability(with)
				end
			else
				SMODS.destroy_cards(pseudorandom_element(inshop), true, true)
			end
			c = true
		else
			c = false
		end
	end
	if not replace then
		local carde = SMODS.create_card({
			key = with.key,
			area = G.shop_jokers,
			skip_materialize = true,
		})
		create_shop_card_ui(carde, "Joker", G.shop_jokers)
		carde.states.visible = false
		carde:start_materialize()
		carde.ability.couponed = true
		carde:set_cost()
		G.shop_jokers:emplace(carde)
	end
end

function RevosVault.index(table, cards)
	for i, v in ipairs(table) do
		if v == cards then
			return i
		end
	end
	return nil
end

--ok you see nothing. there is nothing for 241 lines
-- _flip does nothing currently
function RevosVault.replacecards(area, replace, bypass_eternal, keep, keeporiginal, _flip) --Cards not keeping editions/seals/stickers is intended. //Probably extremely inefficient /// Like why tf did i make the keep n entire seperate section. I probably wont even use "replace" or teh destruction part of this like ever.
	if G.shop_booster and area == G.shop_booster.cards or G.shop_vouchers and area == G.shop_vouchers.cards then --Setting the area as these 2 disables the entire thing below and will not have a support for them anytime soon cause NONE of the jokers does anything with destroyed booster PACKS and VOUCHERS. Including mods
		if area == G.shop_booster.cards then
			for i = 1, #area do
				local tab = {}
				for i = 1, #G.P_CENTER_POOLS.Booster do
					tab[#tab + 1] = G.P_CENTER_POOLS.Booster[i].key
				end
				if area[i] ~= keeporiginal and area[i].ability.set == "Booster" then
					area[i]:juice_up()
					area[i]:set_ability(pseudorandom_element(tab))
				end
				tab = {}
			end
		end
		if area == G.shop_vouchers.cards then
			for i = 1, #area do
				local tab = {}
				for i = 1, #G.P_CENTER_POOLS.Voucher do
					tab[#tab + 1] = G.P_CENTER_POOLS.Voucher[i].key
				end
				if area[i] ~= keeporiginal and area[i].ability.set == "Voucher" then
					area[i]:juice_up()
					area[i]:set_ability(pseudorandom_element(tab))
				end
				tab = {}
			end
		end
	else
		if keep then
			for i = 1, #area do
				if area[i].config.center.rarity then
					local b
					local rarity
					if not replace then
						for k, v in pairs(G.P_JOKER_RARITY_POOLS) do
							if area[i].config.center.rarity == k then
								rarity = k
								b = k
							end
						end
						if rarity == 1 then
							rarity = "Common"
						elseif rarity == 2 then
							rarity = "Uncommon"
						elseif rarity == 3 then
							rarity = "Rare"
						elseif rarity == 4 then
							rarity = "Legendary"
						end
						local set = area[i].ability.set
						local tab = {}
						for i = 1, #G.P_CENTER_POOLS.Joker do
							if G.P_CENTER_POOLS.Joker[i].rarity == b then
								tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
							end
						end
						if area[i] ~= keeporiginal then
							area[i]:juice_up()
							area[i]:set_ability(pseudorandom_element(tab))
							tab = {}
						end
					else
						local set = area[i].ability.set
						local rarity = SMODS.poll_rarity(set)
						local b = rarity
						if rarity == 1 then
							rarity = "Common"
						elseif rarity == 2 then
							rarity = "Uncommon"
						elseif rarity == 3 then
							rarity = "Rare"
						elseif rarity == 4 then
							rarity = "Legendary"
						end
						local tab = {}
						for i = 1, #G.P_CENTER_POOLS.Joker do
							if G.P_CENTER_POOLS.Joker[i].rarity == b then
								tab[#tab + 1] = G.P_CENTER_POOLS.Joker[i].key
							end
						end
						if area[i] ~= keeporiginal then
							area[i]:juice_up()
							area[i]:set_ability(pseudorandom_element(tab))
						end
						tab = {}
					end
				elseif area[i].ability.set then
					local set = area[i].ability.set
					local tab = {}
					if
						area[i].ability.set == "Enhanced"
						or area[i].ability.set == "Default"
						or area[i].ability.set == "Playing Card"
						or area == G.hand.cards
					then
						area[i]:juice_up()
						local _suit, _rank =
							pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
						SMODS.change_base(area[i], _suit, _rank)
						area[i]:set_ability(SMODS.poll_enhancement())
						area[i]:set_edition(poll_edition())
					else
						for i = 1, #G.P_CENTER_POOLS.Consumeables do
							if G.P_CENTER_POOLS.Consumeables[i].set == set then
								tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
							end
						end
					end
					if area[i] ~= keeporiginal then
						area[i]:juice_up()
						area[i]:set_ability(pseudorandom_element(tab))
					end
				end
			end
		else
			if replace then --Doesnt stick to joker rarities
				for i = 1, #area do
					if bypass_eternal then
						if area[i].ability.set and area[i] ~= keeporiginal then
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					else
						if area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					end
				end
			else
				for i = 1, #area do
					if bypass_eternal then
						if area[i].config.center.rarity and area[i] ~= keeporiginal then --Reroll them while keeping the same rarity
							local rarity
							if area[i].config.center.rarity == 1 then
								rarity = "Common"
							elseif area[i].config.center.rarity == 2 then
								rarity = "Uncommon"
							elseif area[i].config.center.rarity == 3 then
								rarity = "Rare"
							elseif area[i].config.center.rarity == 4 then
								rarity = "Legendary"
							else
								rarity = area[i].config.center.rarity
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								rarity = rarity,
								area = G.pack_cards,
							})
						elseif area[i].ability.set and area[i] ~= keeporiginal then
							if
								area[i].ability.set == "Enhanced"
								or area[i].ability.set == "Default"
								or area[i].ability.set == "Playing Card"
								or area == G.hand.cards
							then
								area[i]:juice_up()
								local _suit, _rank =
									pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
								SMODS.change_base(area[i], _suit, _rank)
								area[i]:set_ability(SMODS.poll_enhancement())
								area[i]:set_edition(poll_edition())
							else
								for i = 1, #G.P_CENTER_POOLS.Consumeables do
									if G.P_CENTER_POOLS.Consumeables[i].set == set then
										tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
									end
								end
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i], true)
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					else
						if area[i].config.center.rarity and not area[i].ability.eternal and area[i] ~= keeporiginal then
							local rarity
							if area[i].config.center.rarity == 1 then
								rarity = "Common"
							elseif area[i].config.center.rarity == 2 then
								rarity = "Uncommon"
							elseif area[i].config.center.rarity == 3 then
								rarity = "Rare"
							elseif area[i].config.center.rarity == 4 then
								rarity = "Legendary"
							else
								rarity = area[i].config.center.rarity
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								rarity = rarity,
								area = G.pack_cards,
							})
						elseif area[i].ability.set and not area[i].ability.eternal and area[i] ~= keeporiginal then
							if
								area[i].ability.set == "Enhanced"
								or area[i].ability.set == "Default"
								or area[i].ability.set == "Playing Card"
								or area == G.hand.cards
							then
								area[i]:juice_up()
								local _suit, _rank =
									pseudorandom_element(SMODS.Suits).key, pseudorandom_element(SMODS.Ranks).card_key
								SMODS.change_base(area[i], _suit, _rank)
								area[i]:set_ability(SMODS.poll_enhancement())
								area[i]:set_edition(poll_edition())
							else
								for i = 1, #G.P_CENTER_POOLS.Consumeables do
									if G.P_CENTER_POOLS.Consumeables[i].set == set then
										tab[#tab + 1] = G.P_CENTER_POOLS.Consumeables[i].key
									end
								end
							end
							local set = area[i].ability.set
							SMODS.destroy_cards(area[i])
							SMODS.add_card({
								set = set,
								area = G.pack_cards,
							})
						end
					end
				end
			end
		end
	end
end

-- Nothing to see here

function RevosVault.check(check, area)
	if check == "inblind" then
		return G.STATE == G.STATES.SELECTING_HAND
	elseif check == "hasjoker" then
		if #G.jokers.cards > 0 then
			return true
		end
	elseif check == "inshop" then
		return G.STATE == G.STATES.SHOP
	elseif check == "highlight" then
		if #area.highlighted > 0 then
			return #area.highlighted
		end
	end
end

--Sadly this requires manually adding/removing cards. :((
function RevosVault.modify_rarity(card, by)
	local shouldgo = true
	local rarity_order = {
		1,
		2,
		3,
		4,
		"crv_p",
	}

	if RevosVault.config.vault_enabled then
		table.insert(rarity_order, 6, "crv_va")
	end
	if Cryptid then
		table.insert(rarity_order, 1, "cry_candy")
		table.insert(rarity_order, 5, "cry_epic")
		table.insert(rarity_order, "cry_exotic")
	end
	if RevosVault.config.chaos_enabled then
		table.insert(rarity_order, "crv_chaos")
	end
	if card and by then
		local current_rarity = card.config.center.rarity or card.rarity
		local future_rarity = nil
		for i = 1, #rarity_order do
			if rarity_order[i] == current_rarity then
				if rarity_order[i + by] ~= nil then
					future_rarity = rarity_order[i + by]
				else
					sendWarnMessage("No next or previous rarity found", "RevosVault")
					shouldgo = nil
				end
			end
		end
		if shouldgo then
			local new_card = pseudorandom_element(G.P_JOKER_RARITY_POOLS[future_rarity]).key
			card:juice_up()
			card:set_ability(new_card)
		end
	else
		return rarity_order -- if you leave it with nothing it returns the table itself >:D
	end
end

function RevosVault.printer_apply(enhancement, upgraded_enhancement, edition, area, odds)
	if not odds then
		odds = 4
	end --Default odds
	if not area then
		area = G.hand
	end --Default area
	local ecards = {}
	local emcards = {}
	local card
	for i = 1, #area.cards do
		if not area.cards[i].edition then
			ecards[#ecards + 1] = area.cards[i]
		end
		if area.cards[i].ability.effect == "Base" then
			emcards[#emcards + 1] = area.cards[i]
		end
	end
	if enhancement then
		card = pseudorandom_element(emcards, pseudoseed("printer_apply"))
	elseif edition then
		card = pseudorandom_element(ecards, pseudoseed("printer_apply"))
	end
	if not edition then
		if #emcards > 0 then
			if pseudorandom("enh_printers") < G.GAME.probabilities.normal / odds then
				if upgraded_enhancement then
					card:set_ability(upgraded_enhancement)
					return upgraded_enhancement
				else
					card:set_ability(enhancement)
					return enhancement
				end
			else
				if enhancement then
					card:set_ability(enhancement)
					return enhancement
				end
			end
		end
	else
		if #ecards > 0 then
			card:set_edition(edition)
			return edition
		end
	end
end

function RevosVault.stickercheck(area, stickers)
	local st = 0
	if area then
		for _, v in pairs(area) do
			for i = 1, #stickers do
				if v.stickers then
				end
			end
		end
		return st
	end
	return 0
end

function RevosVault.get_name(key, set)
	local name
	name = localize({ type = "name_text", key = key, set = set })
	return name
end

--idk made an advanced searcg

function RevosVault.joker_search(key, name, rarity, cost, edition, stickers, debuff, area)
	if not area then
		area = G.jokers.cards
	end
	local cards = {}
	for i = 1, #area do
		cards[#cards + 1] = area[i]
	end
	if key then
		for k, v in pairs(cards) do
			print(#cards)
			if v.config.center.key ~= key then
				local i = RevosVault.index(cards, v)
				table.remove(cards, i)
			end
		end
	end
	if name then
		for k, v in pairs(cards) do
			local vsname = localize({ type = "name_text", key = v.config.center.key, set = "Joker" })
			for i = 1, #name do
				if not string.find(vsname, name[i]) then
					local i = RevosVault.index(cards, v)
					table.remove(cards, i)
				end
			end
		end
	end
	if rarity then
		for k, v in pairs(cards) do
			if v.config.center.rarity ~= rarity then
				local i = RevosVault.index(cards, v)
				table.remove(cards, i)
			end
		end
	end
	if cost then
		for k, v in pairs(cards) do
			if v.cost ~= cost then
				local i = RevosVault.index(cards, v)
				table.remove(cards, i)
			end
		end
	end
	if edition then
		for k, v in pairs(cards) do
			if v.edition and not v.edition.key ~= edition then
				local i = RevosVault.index(cards, v)
				table.remove(cards, i)
			end
		end
	end
	if stickers then
		for k, v in pairs(cards) do
			for i = 1, #stickers do
				if v.ability[stickers[i]] then
					break
				else
					local i = RevosVault.index(cards, v)
					table.remove(cards, i)
				end
			end
		end
	end
	if debuff then
		for k, v in pairs(cards) do
			for i = 1, #stickers do
				if v.debuff then
					local i = RevosVault.index(cards, v)
					table.remove(cards, i)
				end
			end
		end
	end
	return cards
end

--I aint risking my shit istg fuck talisman

to_big = to_big or function(x)
	return x
end

function RevosVault.factorial(mod)
	if to_big(mod) <= to_big(0) then
		return 1
	else
		return to_big(mod) * RevosVault.factorial(to_big(mod) - to_big(1))
	end
end

function RevosVault.perc(mod, perc)
	local per = (to_big(mod) / 100) * perc
	return per
end

function RevosVault.remove_gem(key)
	local index = RevosVault.index(G.GAME.used_gems, key)
	table.remove(G.GAME.used_gems, index)
	for k, v in pairs(G.vouchers.cards) do
		if v.config.center.key == key then
			v:start_dissolve(nil, true)
		end
	end
end

function RevosVault.add_gem(key, set)
	local acard
	if key then
		acard = SMODS.add_card({ key = key, set = "Gem", area = G.shop_vouchers })
		create_shop_card_ui(acard)
	else
		acard = SMODS.add_card({ set = "Gem", area = G.shop_vouchers })
		create_shop_card_ui(acard)
	end
end

--I tried some stuff don't question this part. Is this efficent? probably not.
function RevosVault.values(card, num, extra, only_extra)
	if num == 0 then
		num = 0.1
	end
	if not only_extra then
		for k, v in pairs(card.ability) do
			if
				k ~= "x_mult"
				and k ~= "x_chips"
				and k ~= "order"
				and v ~= 0
				and k ~= "h_x_chips" -- ?
				and k ~= "cry_prob" -- ?
			then
				if type(v) == "number" then
					card.ability[k] = card.ability[k] * num
				end
			end
		end
	end
	if extra and card.ability.extra then
		if type(card.ability.extra) == "table" then
			for l, m in pairs(card.ability.extra) do
				if type(m) == "number" then
					card.ability.extra[l] = card.ability.extra[l] * num
				end
			end
		end
	end
end

-- Fcked up random bullshit
function RevosVault.table_check(card)
	local full_table = {}
	for k, v in pairs(card.ability) do
		if
			k ~= "x_mult"
			and k ~= "x_chips"
			and k ~= "order"
			and v ~= 0
			and k ~= "h_x_chips" -- ?
			and k ~= "cry_prob" -- ?
		then
			if type(v) == "number" then
				full_table[#full_table + 1] = k
				full_table[#full_table + 1] = v
			end
		end
	end
	if card.ability.extra then
		if type(card.ability.extra) == "table" then
			for l, m in pairs(card.ability.extra) do
				if type(m) == "number" then
					full_table[#full_table + 1] = l
					full_table[#full_table + 1] = m
				end
			end
		end
	end
	return full_table
end

--Surely there is a better way to do this but im too lazy to check it sakdjnsdaskdaslkdagagahjgfah
function RevosVault.combine_table(areas,w)
	local full_tab = {}
	if type(areas) == "table" then
		for i = 1, #areas do
			if type(areas[i]) == "table" then
			for k, v in pairs(areas[i]) do 
				full_tab[#full_tab+1] = v
			end
			else
				sendWarnMessage(tostring(areas[i]) .. " is not a table","RevosVault")
			end
		end
	else
		sendWarnMessage(tostring(areas) .. " is not a table","RevosVault")
	end
	if #full_tab > 0 then
		return full_tab
	elseif #full_tab == 0 and w then
		sendWarnMessage("Nothing to return!","RevosVault")
	end 
end