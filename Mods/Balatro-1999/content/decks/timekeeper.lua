SMODS.Back{
    name = "Timekeeper's Deck",
    key = "td",
	atlas = "ba",
    pos = {x = 0, y = 0},
    apply = function(self)
		G.E_MANAGER:add_event(Event({
			func = function()
				if G.jokers then
					SMODS.add_card{key="j_b1999_fm"}:set_eternal(true)
				end
				return true
			end,
		}))
    end
}

