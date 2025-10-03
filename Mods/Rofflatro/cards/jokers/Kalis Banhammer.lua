--Kali’s Banhammer (Uncommon) - Sell this Joker to destroy adjacent Jokers and create a Spectral card for each Joker destroyed (must have room). (Fastest ban in the west!)

SMODS.Joker{
	key = 'kali',
	atlas = 'roffers',
	rarity = 2,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = false,
	pos = { x = 2, y = 6 },
	loc_vars = function(self,info_queue,card)
		return {vars = {}}
	end,
	calculate = function(self,card,context)
		if context.selling_self and not context.blueprint then
			local my_pos = nil
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] == card then my_pos = i; break end
			end
			
			if my_pos and G.jokers.cards[my_pos+1] and not card.getting_sliced and not G.jokers.cards[my_pos+1].ability.eternal then 
			
				local sliced_card = G.jokers.cards[my_pos+1]
				sliced_card.getting_sliced = true
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({func = function()
					G.GAME.joker_buffer = 0
					G.GAME.consumeable_buffer = 0
					sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
					play_sound('slice1', 0.96+math.random()*0.08)
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						SMODS.add_card({set= 'Spectral'})
					else
						SMODS.calculate_effect({message = localize('k_no_room_ex')}, card)
					end
					
				return true end }))
				
			end
			if my_pos and G.jokers.cards[my_pos-1] and not card.getting_sliced and not G.jokers.cards[my_pos-1].ability.eternal and not G.jokers.cards[my_pos-1].getting_sliced then 
				
				local sliced_card = G.jokers.cards[my_pos-1]
				sliced_card.getting_sliced = true
				G.GAME.joker_buffer = G.GAME.joker_buffer - 1
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
				G.E_MANAGER:add_event(Event({func = function()
					G.GAME.joker_buffer = 0
					G.GAME.consumeable_buffer = 0
					sliced_card:start_dissolve({HEX("57ecab")}, nil, 1.6)
					play_sound('slice1', 0.96+math.random()*0.08)
					if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
						SMODS.add_card({set= 'Spectral'})
					else
						SMODS.calculate_effect({message = localize('k_no_room_ex')}, card)
					end
				return true end }))
				
			end
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_art'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
	end
}
