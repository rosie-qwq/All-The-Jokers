sendInfoMessage("Loading Blinds...", "TOGAPack")

SMODS.Blind{
	key = 'dialupmodem',
	atlas = 'TOGADialUpBlind',
	boss_colour = HEX('404080'),
	pos = { x = 0, y = 0 },
	vars = { reducedhandsel = 1, activated = false },
	dollars = 6,
	mult = 2.8,
	boss = { min = 4 },
	loc_vars = function(self)
		return { vars = { -self.vars.reducedhandsel } }
	end,
	collection_loc_vars = function(self)
		return { vars = { -self.vars.reducedhandsel  } }
	end,
	set_blind = function(self)
		self.vars.activated = true
		togabalatro.handlimitchange(-self.vars.reducedhandsel)
		--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit - self.vars.reducedhandsel, 1)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Decreased card selection limit to "..G.hand.config.highlighted_limit..".", "TOGAPack") end
	end,
	disable = function(self)
		if self.vars.activated then
			self.vars.activated = false
			togabalatro.handlimitchange(self.vars.reducedhandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + self.vars.reducedhandsel, 5)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Disabled, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
		end
	end,
	defeat = function(self)
		if self.vars.activated then
			togabalatro.handlimitchange(self.vars.reducedhandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + self.vars.reducedhandsel, 5)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Defeated, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
		end
	end
}

SMODS.Blind{
	key = 'worldwideweb',
	atlas = 'TOGAWWWBlind',
	boss_colour = HEX('aafdff'),
	pos = { x = 0, y = 0 },
	vars = { increasehandsel = 3, activated = false },
	dollars = 6,
	mult = 14.4,
	boss = { min = 3.11, showdown = true },
	in_pool = function(self)
		return G.GAME.dialupmodem or false
	end,
	loc_vars = function(self)
		return { vars = { self.vars.increasehandsel } }
	end,
	collection_loc_vars = function(self)
		return { key = self.key.."_collection" }
	end,
	set_blind = function(self)
		self.vars.activated = true
		togabalatro.handlimitchange(self.vars.increasehandsel)
		--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + self.vars.increasehandsel, 1)
		G.hand:change_size(self.vars.increasehandsel)
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Changed card selection limit to "..G.hand.config.highlighted_limit..".", "TOGAPack") end
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Changed hand size to "..G.hand.config.card_limit..".", "TOGAPack") end
	end,
	disable = function(self)
		if self.vars.activated then
			self.vars.activated = false
			togabalatro.handlimitchange(-self.vars.increasehandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit - self.vars.increasehandsel, 5)
			G.hand:change_size(-self.vars.increasehandsel)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Disabled, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Disabled, changed hand size to "..G.hand.config.card_limit..".", "TOGAPack") end
		else
			if togabalatro.config.SFXWhenTriggered then play_sound("toga_failsfx", 1, 0.5) end
		end
	end,
	defeat = function(self)
		if self.vars.activated then
			self.vars.activated = false
			togabalatro.handlimitchange(-self.vars.increasehandsel)
			--G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit - self.vars.increasehandsel, 5)
			G.hand:change_size(-self.vars.increasehandsel)
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Defeated, card selection limit is "..G.hand.config.highlighted_limit..".", "TOGAPack") end
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Defeated, changed hand size to "..G.hand.config.card_limit..".", "TOGAPack") end
		end
		ease_dollars(50)
	end
}

-- You have given me how many hours of trouble?
SMODS.Blind{
	key = 'joystick',
	atlas = 'TOGAJoyStickBlind',
	boss_colour = HEX('76992b'),
	pos = { x = 0, y = 0 },
	dollars = 8,
	mult = 2.5,
	boss = { min = 3 },
	calculate = function(self, card, context)
		if not G.GAME.blind.disabled then
			if context.first_hand_drawn then
				for i = 1, #G.hand.cards do
					G.hand.highlighted[#G.hand.highlighted+1] = G.hand.cards[i]
					G.hand.cards[i]:highlight(true)
				end
				G.FUNCS.play_cards_from_highlighted()
			end
		end
	end,
}