SMODS.Edition({
	key = "sunbleached",
	shader = "sunwashed",
	config = {
			odds  = 3
	},
    loc_vars = function(self, info_queue, card)
		return {
			vars = {
                (G.GAME.probabilities.normal or 1),
				self.config.odds
			},
		}
	end,
	calculate = function(self,card,context)
		if context.other_card == card and ((context.repetition and context.cardarea == G.play) or (context.retrigger_joker_check and not context.retrigger_joker)) then
			if pseudorandom("sunbleached") < G.GAME.probabilities.normal / self.config.odds then
			return {
				repetitions = 1,
			}
		end
	end
end
})

SMODS.Shader({
	key = "sunwashed",
	path = "sunwashed.fs",
})


SMODS.Edition({
	key = "pastel",
	shader = "pastel_shader",
	config = {
		odds = 3,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				(G.GAME.probabilities.normal or 1),
				self.config.odds,
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
			return {
				p_mult = 50,
			}
		end
	end,
})

SMODS.Shader({
	key = "pastel_shader",
	path = "pastel_shader.fs",
})

SMODS.Edition({
	key = "bloom_edition",
	shader = "bloom",
	config = {
		odds = 3,
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				(G.GAME.probabilities.normal or 1),
				self.config.odds,
			},
		}
	end,
	calculate = function(self, card, context)
		if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
			return {
				p_chips = 60,
			}
		end
	end,
})

SMODS.Shader({
	key = "bloom",
	path = "bloom.fs",
})

SMODS.Edition({
	key = "magnetised_edition",
	shader = "magnetised",
	config = {
		odds = 0.2,
	},
	loc_vars = function(self, info_queue, card)
		if G.jokers and G.jokers.cards and G.playing_cards then
			local areas = {}
			for k, v in pairs(G.jokers.cards) do
				areas[#areas+1] = v
			end
			for k, v in pairs(G.playing_cards) do
				areas[#areas+1]=  v
			end
			return {
				vars = {
					RevosVault.check_edition(areas),
					self.config.odds,
					RevosVault.check_edition(areas) * self.config.odds + 1,
				},
			}
		else
			return {
				vars = {
					1,
					self.config.odds,
					1,
				},
			}
		end
	end,
	calculate = function(self, card, context)
		if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
			local areas = {}
			for k, v in pairs(G.jokers.cards) do
				areas[#areas+1] = v
			end
			for k, v in pairs(G.playing_cards) do
				areas[#areas+1]=  v
			end
			return {
				xmult = RevosVault.check_edition(areas) * self.config.odds + 1
			}
		end
	end,
})

SMODS.Shader({
	key = "magnetised",
	path = "magnetised.fs",
})


SMODS.Edition({
	key = "antichrome_edition",
	shader = "antichrome",
	config = {
		odds = 0.5,
	},
	loc_vars = function(self, info_queue, card)
		local cards = {}
		if G.jokers and G.jokers.cards then
			return {
				vars = {
					#G.jokers.cards,
					self.config.odds,
					RevosVault.stencil(G.jokers.cards,"j_stencil","e_crv_antichrome_edition") * self.config.odds,
				},
			}
		else
			return {
				vars = {
					1,
					self.config.odds,
					0.5,
				},
			}
		end
	end,
	calculate = function(self, card, context)
		if (context.main_scoring and context.cardarea == G.play) or context.post_joker then
			return {
				xmult = RevosVault.stencil(G.jokers.cards,"j_stencil","e_crv_antichrome_edition") * self.config.odds
			}
		end
	end,
})

SMODS.Shader({
	key = "antichrome",
	path = "antichrome.fs",
})
