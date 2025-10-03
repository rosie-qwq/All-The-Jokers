--Main Channel (Rare) - 1 in 25 chance to multiply a value in all owned Jokers by x1.5 when playing a hand. (Wait, he has a main channel?) [see below for explanation]



SMODS.Joker{
	key = 'MainChannel',
	atlas = 'roffers',
	rarity = 3,
	cost = 9,
	blueprint_compat = true,
	eternal_compat = false,
	pos = { x = 5, y = 6 },
	config = { extra = {
		odds = 15
	}
},
loc_vars = function(self,info_queue,card)
	return {vars = {G.GAME.probabilities.normal,card.ability.extra.odds}}
end,
calculate = function(self,card,context)
	
	--compat to add
	--perkeo
	--marbel
	--
	
	if context.end_of_round and context.cardarea == G.jokers then 
		local SHRIMPSPECIAL = pseudorandom('6 DOLLAR SHRIMP SPECIAL')
		local _card = card
		if SHRIMPSPECIAL < G.GAME.probabilities.normal / card.ability.extra.odds then
				
				for i = 1, #G.jokers.cards do
					local exclude_extra = {"Canio","Castle","Constellation","Flash Card","Glass Joker","Hiker","Hologram","Lucky Cat","Obelisk","Red Card","Ride the Bus","Runner","Square Joker","Spare Trousers","Vampire","Wee Joker","Yorick","Invisible Joker","Madness","Popcorn","Rough Gem",}
					local doExclude = false
					for e = 1 , #exclude_extra do
						if G.jokers.cards[i].ability.name == exclude_extra[e]then
							doExclude = true
						end
					end
					
					if G.jokers.cards[i].ability.name ~= "j_roff_MainChannel"then
						if doExclude then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 1.5,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									extra = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Ramen" then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 1.5,
								x_protect = true,
								unkeywords = {
									Xmult = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Loyalty Card" then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 1.5,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true,
									loyalty_remaining = true,
									every = true
								}
							})
						elseif G.jokers.cards[i].ability.name == "Campfire" or G.jokers.cards[i].ability.name == "Hit the Road" then
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 1.5,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true
								}
							})
						else
							ROFF.funcs.mod_card_values(G.jokers.cards[i].ability,{
								multiply = 1.5,
								x_protect = true,
								unkeywords = {
									odds = true,
									Xmult_mod = true,
									mult_mod = true,
									chips_mod = true,
									hand_add = true,
									discard_sub = true,
									h_mod = true,
									size = true,
									chip_mod = true,
									h_size = true,
									increase = true
								}
							})
						end
					end
				end	

				if context.blueprint then
					_card = context.blueprint_card
				end
				if _card then
					G.E_MANAGER:add_event(Event({
						func = function()
							play_sound('tarot1')
							_card.T.r = -0.2
							_card:juice_up(0.3, 0.4)
							_card.states.drag.is = true
							_card.children.center.pinch.x = true
							-- This part destroys the card.
							G.E_MANAGER:add_event(Event({
								trigger = 'after',
								delay = 0.3,
								blockable = false,
								func = function()
									G.jokers:remove_card(_card)
									_card:remove()
									_card = nil
									return true;
								end
							}))
							return true
						end
					}))							
				end
					

				

			return{
				message = localize("k_roff_mainchannel_upgrade")
			}
			elseif not (SHRIMPSPECIAL < G.GAME.probabilities.normal / card.ability.extra.odds )then
				return{
					message = localize("k_nope_ex")
				}
			end
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_art'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
	end
}
