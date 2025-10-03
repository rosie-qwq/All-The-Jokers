--[[ -- none of the stakes are applying stakes below them and i've had trouble getting any help anywhere through either the modding community, smods docs, or other mods
SMODS.Stake {
	key = "violet",
	name = "Violet Stake",
	applied_stakes = { "cry_diamond" },
	atlas = "crp_stake",
	pos = { x = 1, y = 0 },
	shiny = true,
	colour = HEX("8a71e1"),
	above_stake = "cry_diamond",
	modifiers = function()
		G.GAME.starting_params.ante_scaling = 2
	end,
	crp_credits = {
		idea = { "Unknown" },
		art = { "Grahkon" },
		code = { "wilfredlam0418" }
	}
}

SMODS.Stake {
	key = "square",
	name = "Square Stake",
	applied_stakes = { "cry_diamond" },
	atlas = "crp_stake",
	pos = { x = 0, y = 0 },
	shiny = true,
	modifiers = function()
		G.E_MANAGER:add_event(Event({
			func = function()
				if not G.hand then 
					return false
				end
				G.hand.config.highlighted_limit = G.hand.config.highlighted_limit - 1
				return true
			end
		}))
	end,
	crp_credits = {
		idea = { "Unknown" },
		code = { "wilfredlam0418" }
	}
}

SMODS.Stake {
	key = "stencil",
	name = "Stencil Stake",
	applied_stakes = { "crp_square" },
	atlas = "crp_stake",
	pos = { x = 2, y = 0 },
	shiny = true,
	colour = HEX("bccacc"),
	modifiers = function()
		G.E_MANAGER:add_event(Event({
			func = function()
				if not G.jokers then 
					return false
				end
				G.jokers.config.card_limit = G.jokers.config.card_limit - 1
				return true
			end
		}))
	end,
	crp_credits = {
		idea = { "Unknown" },
		art = { "Grahkon" },
		code = { "wilfredlam0418" }
	}
}
]]--