Partner_API.Partner({
	key = "pprinter",
	name = "Minirinter",
	unlocked = false,
	discovered = true,
        individual_quips = true,
	pos = { x = 0, y = 0 },
	loc_txt = {},
	atlas = "partners",
	config = { extra = { related_card = "j_crv_defaultprinter", odds = 4 } },
	loc_vars = function(self, info_queue, card)
		local benefits = 1
		if next(SMODS.find_card("j_crv_defaultprinter")) then
			benefits = 2
		end
		return { vars = { card.ability.extra.odds / benefits, (G.GAME.probabilities.normal or 1) } }
	end,
	calculate = function(self, card, context)
		local benefits = 1
		if next(SMODS.find_card("j_crv_defaultprinter")) then   
			benefits = 2
		end
		if
			context.partner_main
			and pseudorandom("printer") < G.GAME.probabilities.normal / (card.ability.extra.odds / benefits)
		then
			local jokers = {}
			local jokercount = 0
			for i = 1, #G.jokers.cards do
				if G.jokers.cards[i] ~= card then
					jokers[#jokers + 1] = G.jokers.cards[i]
					jokercount = jokercount + 1
				end
			end
			if jokercount > 0 then
			if G.GAME.used_vouchers["v_crv_printerup"] == true and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4  or G.GAME.used_vouchers["v_crv_printeruptier"] == true then
					local copied = copy_card(jokers[1], nil)
					copied:add_to_deck()
					copied:set_edition({ negative = true }, true)
					G.jokers:emplace(copied)
					card_eval_status_text(card, "extra", nil, nil, nil, { message = "Copied!" })
				else
					local copied = copy_card(jokers[1], nil)
					copied:add_to_deck()
					G.jokers:emplace(copied)
					card_eval_status_text(card, "extra", nil, nil, nil, { message = "Copied!" })
				end
			end
		end
	end,
	check_for_unlock = function(self, args)
		for _, v in pairs(G.P_CENTER_POOLS["Joker"]) do
			if v.key == "j_crv_defaultprinter" then
				if get_joker_win_sticker(v, true) >= 8 then
					return true
				end
				break
			end
		end
	end,
})
