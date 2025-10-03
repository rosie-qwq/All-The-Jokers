SMODS.Atlas { key = 'consumeables', path = 'consumeables.png', px = 71, py = 95 }

SMODS.Consumable{
	key = 'Perkt_o_nium',
	set = 'Planet',
	atlas = 'consumeables',
	pos = {x = 0, y = 0},
	loc_vars = function (self, info_queue, card)
		if not G.GAME.perktonium_levels then
			G.GAME.perktonium_levels = 1
		end
		return {
			vars = {
				G.GAME.perktonium_levels
			}
		}
	end,
	can_use = function (self,card)
		return true
	end,
	use = function (self, card, area)
		if not G.GAME.perktonium_levels then
			G.GAME.perktonium_levels = 1
		end
		local tempplayed = 0
		local hand
		for k, v in pairs(G.GAME.hands) do
			if v.played > tempplayed and v.visible then
				tempplayed = v.played
				hand = k
			end
		end
		update_hand_text({sound = 'button', volume = 0.7, pitch = 0.8, delay = 0.3}, {handname= hand ,chips = '...', mult = '...', level=''})
		level_up_hand(card, hand, false, G.GAME.perktonium_levels)
		G.GAME.perktonium_levels = G.GAME.perktonium_levels + 1
		update_hand_text({sound = 'button', volume = 0.7, pitch = 1.1, delay = 0}, {mult = 0, chips = 0, handname = '', level = ''})
		
	end
}