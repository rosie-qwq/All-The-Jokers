sendInfoMessage("Loading Tags...", "TOGAPack")

SMODS.Tag{
	key = "togajokershop",
	atlas = "TOGATags",
	pos = { x = 0, y = 0 },
	config = { type = "store_joker_create" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("TOGAJKR", context.area, nil, nil, nil, nil, nil, "togajokertag")
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RED, function()
				card:start_materialize()
				card.ability.couponed = true
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
}

SMODS.Tag{
	key = "togajokerbooster",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togazipboosterpack
	end,
	atlas = "TOGATags",
	pos = { x = 1, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togazipboosterpack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag{
	key = "togajokerziparchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togaziparchivepack
	end,
	atlas = "TOGATags",
	pos = { x = 6, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togaziparchivepack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag{
	key = "thespbroll",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.c_toga_selfpropelledbomb
	end,
	atlas = "TOGATags",
	pos = { x = 2, y = 0 },
	config = { type = "immediate" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "immediate" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local card = create_card('Spectral', G.consumeables, nil, nil, nil, nil, "c_toga_selfpropelledbomb", "thespbrun")
				card:add_to_deck()
				G.consumeables:emplace(card)
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag{
	key = "guaranteedice",
	atlas = "TOGATags",
	pos = { x = 3, y = 0 },
	config = { type = "store_joker_create" },
	in_pool = function(self, args)
		if not togabalatro.config.ShowPower then return false end
		if #SMODS.find_card('j_oops', true) > 0 then return false
		else return true end
	end,
	min_ante = 3,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, nil, nil, nil, nil, "j_oops")
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RED, function()
				card:start_materialize()
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
	poweritem = true
}

SMODS.Tag{
	key = "thenet",
	atlas = "TOGATags",
	pos = { x = 4, y = 0 },
	config = { type = "immediate", odds = 15 },
	loc_vars = function(self, info_queue, card)
		return { key = Cryptid and self.key.."_cryptid" or self.key, vars = { SMODS.get_probability_vars(card or self, 1, card.ability.odds or self.config.odds) } }
	end,
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "immediate" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local card = create_card('Spectral', G.consumables, nil, nil, nil, nil, Cryptid and SMODS.pseudorandom_probability(self, 'toga_colorinverthole', 1, tag.ability.odds or self.config.odds, 'thenet') and "c_cry_white_hole" or "c_black_hole", "internetexplorer")
				card:add_to_deck()
				G.consumeables:emplace(card)
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end
}

SMODS.Tag{
	key = "controlexe",
	atlas = "TOGATags",
	pos = { x = 5, y = 0 },
	config = { type = "immediate" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "immediate" then
			if #G.jokers.cards > 0 then
				local jokerlist, itercount, iterlimit = G.jokers.cards, 0, 64
				local seljoker = pseudorandom_element(jokerlist, pseudoseed('controlpanel'))
				while seljoker.edition and itercount < iterlimit do
					itercount = itercount + 1
					seljoker = pseudorandom_element(jokerlist, pseudoseed('controlpanel'))
				end
				
				if not seljoker.edition then
					G.CONTROLLER.locks[lock] = true
					tag:yep('+', G.C.ORANGE,function() 
						local seledition = poll_edition('98se', nil, false, true)
						seljoker:set_edition(seledition, true)
						G.CONTROLLER.locks[lock] = nil
						return true
					end)
				else
					tag:nope()
				end
			else
				tag:nope()
			end
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag{
	key = "thelegend",
	atlas = "TOGATags",
	pos = { x = 7, y = 0 },
	config = { type = "store_joker_create" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	min_ante = 2,
	apply = function(self, tag, context)
		if context.type == "store_joker_create" then
			local card = create_card("Joker", context.area, true)
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.ORANGE, function()
				card:start_materialize()
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
	end,
	poweritem = true
}

SMODS.Tag{
	key = "togarararchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togararpack
	end,
	atlas = "TOGATags",
	pos = { x = 8, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togararpack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag{
	key = "togacardcabarchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togacardcabpack
	end,
	atlas = "TOGATags",
	pos = { x = 9, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function()
		return togabalatro.config.ShowPower
	end,
	poweritem = true,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togacardcabpack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}

SMODS.Tag{
	key = "togaxcopydnaarchive",
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.p_toga_togaxcopydnapack
	end,
	atlas = "TOGATags",
	pos = { x = 10, y = 0 },
	config = { type = "new_blind_choice" },
	in_pool = function(self, args)
		return true
	end,
	apply = function(self, tag, context)
		local lock = tag.ID
		if context.type == "new_blind_choice" then
			G.CONTROLLER.locks[lock] = true
			tag:yep('+', G.C.ORANGE,function() 
				local key = 'p_toga_togaxcopydnapack'
				local card = Card(G.play.T.x + G.play.T.w/2 - G.CARD_W*1.27/2,
				G.play.T.y + G.play.T.h/2-G.CARD_H*1.27/2, G.CARD_W*1.27, G.CARD_H*1.27, G.P_CARDS.empty, G.P_CENTERS[key], {bypass_discovery_center = true, bypass_discovery_ui = true})
				card.cost = 0
				card.from_tag = true
				G.FUNCS.use_card({config = {ref_table = card}})
				card:start_materialize()
				G.CONTROLLER.locks[lock] = nil
				return true
			end)
			tag.triggered = true
			return true
		end
	end,
}