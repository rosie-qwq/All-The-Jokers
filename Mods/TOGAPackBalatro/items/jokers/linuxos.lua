sendInfoMessage("Loading Jokers - Linux OS...", "TOGAPack")

SMODS.Joker{
	key = 'linux_ubuntu',
	config = { extra = { percentage = 0.1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { 100*card.ability.extra.percentage, 1/card.ability.extra.percentage } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersLinux',
	pos = { x = 0, y = 0 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		local curcard = context.other_joker or context.other_consumeable or nil
		if curcard and curcard ~= card and curcard.sell_cost*card.ability.extra.percentage > 0 then
			local xmultval = curcard and curcard.sell_cost*card.ability.extra.percentage or 0
			return { xmult = xmultval > 0 and 1+xmultval or 1, message_card = curcard or context.blueprint_card or card }
		end
	end,
	pixel_size = { w = 69, h = 69 },
}

SMODS.Joker{
	key = 'linux_debian',
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersLinux',
	pos = { x = 1, y = 0 },
	cost = 4,
	blueprint_compat = false,
	perishable_compat = false,
	calculate = function(self, card, context)
		if context.mod_probability and not context.blueprint then
			return { numerator = context.numerator / 2 }
		end
	end,
	pixel_size = { w = 69, h = 94 }
}

SMODS.Joker{
	key = 'linux_slackware',
	config = { extra = { persuit = 0.2 } },
	loc_vars = function(self, info_queue, card)
		local uniquesuits, suitcount, diffkey = {}, 0, false
		if (G.play and G.play.cards and #G.play.cards > 0) and (G.hand and G.hand.cards and #G.hand.cards > 0) then
			local curtarget = #G.play.cards > 0 and G.play.cards or G.hand.cards and #G.hand.highlighted > 0 and G.hand.highlighted
			if curtarget[1] then
				for i = 1, #curtarget do
					if curtarget[i] and not uniquesuits[curtarget[i].base.suit] then uniquesuits[curtarget[i].base.suit] = true; suitcount = suitcount + 1 end
				end
			end
		end
		if suitcount-1 > 0 then diffkey = true end
		local persuitval = card.ability.extra.persuit*(togabalatro.config.UseNerfed and 0.5 or 1)
		return { key = diffkey and self.key.."_cardsel" or self.key, vars = { persuitval, 1+(suitcount-1)*persuitval > 0 and 1+(suitcount-1)*persuitval or 0 } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersLinux',
	pos = { x = 2, y = 0 },
	cost = 6,
	blueprint_compat = true,
	calculate = function(self, card, context)
		if context.individual and context.cardarea == G.play then
			local uniquesuits, suits = {}, 0
			for i = 1, #G.play.cards do
				if G.play.cards[i] and not uniquesuits[G.play.cards[i].base.suit] then uniquesuits[G.play.cards[i].base.suit] = true; suits = suits + 1 end
			end
			return { xmult = suits > 1 and 1+(suits-1)*(card.ability.extra.persuit*(togabalatro.config.UseNerfed and 0.5 or 1)) }
		end
	end,
	pixel_size = { w = 69, h = 62 },
	set_badges = function(self, card, badges)
		if togabalatro.config.UseNerfed then badges[#badges+1] = create_badge(localize('toga_nerfedver'), G.C.UI.TEXT_DARK, G.C.WHITE, 1 ) end
	end,
}

SMODS.Joker{
	key = 'linux_redhat',
	config = { extra = { phandscale = 0.1, xmbonus = 0} },
	loc_vars = function(self, info_queue, card)
		card.ability.extra.xmbonus = math.max(card.ability.extra.xmbonus, 0)
		local phands, diffkey = 0, false
		if (G.play and G.play.cards and #G.play.cards > 0) and (G.hand and G.hand.cards and #G.hand.cards > 0 and G.hand.highlighted and #G.hand.highlighted > 0) then
			local curtarget = #G.play.cards > 0 and G.play.cards or G.hand.cards and #G.hand.highlighted > 0 and G.hand.highlighted
			if curtarget and curtarget[1] then
				local curpokhand = evaluate_poker_hand(curtarget)
				for k, v in pairs(curpokhand) do
					if k ~= 'High Card' and next(v) ~= nil then phands = phands + 1 end
				end
			end
		end
		if phands > 0 then diffkey = true end
		return { key = diffkey and self.key.."_cardsel" or self.key, vars = { card.ability.extra.phandscale, 1+card.ability.extra.xmbonus, phands } }
	end,
	unlocked = true,
	rarity = 2,
	atlas = 'TOGAJokersLinux',
	pos = { x = 3, y = 0 },
	cost = 5,
	blueprint_compat = true,
	demicolon_compat = true,
	calculate = function(self, card, context)
		if context.before and context.poker_hands then
			card.ability.extra.xmbonus = math.max(card.ability.extra.xmbonus, 0)
			local phands = 0
			for k, v in pairs(context.poker_hands) do
				if k ~= 'High Card' and next(v) ~= nil then phands = phands + 1 end
			end
			if phands > 0 then
				SMODS.scale_card(card, {
					ref_table = card.ability.extra,
					ref_value = "xmbonus",
					scalar_value = "phandscale",
					operation = function(ref_table, ref_value, initial, change)
						ref_table[ref_value] = initial + phands*change
					end,
					scaling_message = {
						message = phands > 1 and localize('k_upgrade_ex').." x"..phands or localize('k_upgrade_ex'),
					}
				})
				return nil, true
			end
		end
		
		if context.joker_main or context.forcetrigger then return { xmult = 1+math.max(card.ability.extra.xmbonus, 0) } end
	end,
	pixel_size = { w = 69, h = 84 }
}