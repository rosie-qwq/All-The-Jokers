SMODS.Consumable {
	key = 'acoustica',
	set = 'Spectral',
    soul_set = 'Tarot',
	atlas = "spectr",
	pos = { x = 1, y = 0 },
    soul_pos = { x = 2, y = 0 },
    hidden = true,
    soul_rate = 0.003,
    can_repeat_soul = true,
	cost = 4,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = { key = "b1999_acoustica", set = 'Other' }
	end,
	use = function (self, card, area)
		local oldJkr = G.jokers.highlighted[1]
		for i, v in ipairs(B1999.ACOUSTICA) do
            if oldJkr.config.center.key == v.base then
				SMODS.add_card({key = v.acoustica})
            end
        end
	end,
	can_use = function(self, card)
		if #G.jokers.highlighted == 1 then 
            for i, v in ipairs(B1999.ACOUSTICA) do
                if v.base == G.jokers.highlighted[1].config.center.key then return true end
            end
        end
        return false
	end,
	in_pool = function(self, card)
		local elligible = nil
		for i=1, #G.jokers.cards do
			elligible = G.jokers.cards[i]
            for i, v in ipairs(B1999.ACOUSTICA) do
                if v.base == elligible.config.center.key then return true end
            end
        end
        return false
	end,
}