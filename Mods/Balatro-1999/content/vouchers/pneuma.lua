local analysis = false
local limbob = false

SMODS.Voucher {
	key = 'pneuma',
	atlas = 'vouch',
	pos = { x = 0, y = 0 },
	cost = 10,
	config = { extra = { ante_thing = -1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ante_thing } }
	end,
	redeem = function (self, card)
		analysis = true
	end,
	calculate = function (self, card, context)
		if context.setting_blind and G.GAME.blind:get_type() == 'Boss' and analysis == true then
			G.GAME.blind.chips = G.GAME.blind.chips * 2
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			analysis = false
			ease_ante(card.ability.extra.ante_thing)
		end
	end
}

SMODS.Voucher {
	key = 'limbo',
	atlas = 'vouch',
	pos = { x = 0, y = 1 },
	cost = 10,
	config = { extra = { ante_thing = -1 } },
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.ante_thing } }
	end,
	requires = {'v_b1999_pneuma'},
	redeem = function (self, card)
		local limbossy = pseudorandom('biggering', 1, 5)
		limbob = true
		if limbossy >= 1 and limbossy < 2 then
		G.GAME.round_resets.blind_choices.Boss = "bl_final_acorn"
		elseif limbossy >= 2 and limbossy < 3 then
		G.GAME.round_resets.blind_choicesm.Boss = "bl_final_bell"
		elseif limbossy >= 3 and limbossy < 4 then
		G.GAME.round_resets.blind_choices.Boss = "bl_final_leaf"
		elseif limbossy >= 4 and limbossy < 5 then
		G.GAME.round_resets.blind_choices.Boss = "bl_final_vessel"
		else
		G.GAME.round_resets.blind_choices.Boss = "bl_final_heart"
		end
	end,
	calculate = function (self, card, context)
		if context.setting_blind and G.GAME.blind:get_type() == 'Boss' and limbob == true then
			G.GAME.blind.chips = G.GAME.blind.chips * 2
			G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
			limbob = false
			ease_ante(card.ability.extra.ante_thing)
		end
	end,
}