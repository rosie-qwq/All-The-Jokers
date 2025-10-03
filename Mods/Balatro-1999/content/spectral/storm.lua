SMODS.Consumable {
	key = 'storm',
	set = 'Spectral',
	atlas = "spectr",
	pos = { x = 0, y = 0 },
	cost = 4,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "b1999_reverse", set = 'Other' }
	end,
	use = function (self, card, area)
		local oldJkr = G.jokers.highlighted[1]
		newJkr = nil
		for i, v in ipairs(B1999.SPECIL) do
            if oldJkr.config.center.key == v.base then
				newJkr = ""..v.reversed
			elseif oldJkr.config.center.key == v.reversed then
				newJkr = ""..v.base
			else
				rar = oldJkr.config.center.rarity
				if rar == 1 then
					rar = "Common"
				elseif rar == 2 then
					rar = "Uncommon"
				elseif rar == 3 then
					rar = "Rare"
				elseif rar == 4 then
					rar = "Legendary"
				end
			end
		end
		if newJkr ~= nil then
			oldJkr:start_dissolve()
			SMODS.add_card({key = ""..newJkr})
			newJkr = nil
		else
			oldJkr:start_dissolve()
			SMODS.add_card({set = "Joker", rarity = rar })
		end
	end,
	can_use = function(self, card)
			if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then
			return true else return false
		end
	end
}

SMODS.Rarity({
	key = "reversed",
	loc_txt = {name = "Reversed"},
	badge_colour = HEX("638fe1"),
})








