SMODS.Atlas{key = "TOGASleeves", path = "togasleeves.png", px = 73, py = 95}
CardSleeves.Sleeve{
	key = "frog",
	atlas = "TOGASleeves",
	pos = { x = 0, y = 0 },
	config = { hands = 1, discards = 1, hand_size = -1 },
	loc_vars = function(self)
        return { vars = { self.config.hands, self.config.discards, self.config.hand_size } }
    end,
}

CardSleeves.Sleeve{
	key = "bluemountain",
	atlas = "TOGASleeves",
	pos = { x = 1, y = 0 },
	loc_vars = function(self)
        return { key = self.get_current_deck_key() == 'b_toga_srb2kartdeck' and self.key.."_kart" or self.get_current_deck_key() == 'b_toga_drunkdeck' and self.key.."_drunk" or self.key }
    end,
	apply = function(self, sleeve)
		if self.get_current_deck_key() == 'b_toga_srb2kartdeck' then G.GAME.modifiers.toga_reversedscore_special_kart = true
		else G.GAME.modifiers.toga_reversedscore_sleeve = true end
	end
}