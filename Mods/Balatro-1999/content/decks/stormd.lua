SMODS.Back{
    name = "Storm Deck",
    key = "stormy",
	atlas = "ba",
    pos = {x = 0, y = 0},
    calculate = function (self, back, context)
		local oldJkr = nil
		local newJkr = nil
		local rar = nil
        if context.b1999_ante_change then
            if #G.jokers.cards == 0 then
                ease_dollars(-5)
            end
            if #G.jokers.cards > 0 then
				oldJkr = G.jokers.cards[1]
            if not oldJkr.ability.eternal and #G.jokers.cards > 0 then
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
			end
			if not oldJkr.ability.eternal then
				if newJkr ~= nil then
					oldJkr:start_dissolve()
					SMODS.add_card({key = ""..newJkr})
					newJkr = nil
				elseif newJkr == nil then
					oldJkr:start_dissolve()
					SMODS.add_card({set = "Joker", rarity = rar })
				end
			else
				ease_dollars(-5)
			end
		end
		end
	end
}
