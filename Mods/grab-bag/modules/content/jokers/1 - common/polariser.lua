SMODS.Joker {
	key = 'polariser',
	loc_txt = {
		name = 'Polariser',
		text = {
			"{C:mult}+#1#{} Mult if played hand",
			"contains a {C:attention}Bonus Card{}",
			"{C:chips}+#2#{} Chips if played hand",
			"contains a {C:attention}Mult Card{}",
		}
	},
	config = { extra = { mult = 12, chips = 90 } },
	rarity = 1,
	atlas = 'gb_Jokers',
	pos = { x = 4, y = 0 },
	cost = 4,
	blueprint_compat = true,
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS.m_bonus
		info_queue[#info_queue + 1] = G.P_CENTERS.m_mult
		return { vars = { card.ability.extra.mult, card.ability.extra.chips } }
	end,
    calculate = function(self, card, context)
        if context.joker_main then
			local has_bonus = 0
			local has_mult = 0
			for _, playing_card in ipairs(context.full_hand or {}) do
				if SMODS.has_enhancement(playing_card, 'm_bonus') then
					has_bonus = 1
				end
				if SMODS.has_enhancement(playing_card, 'm_mult') then
					has_mult = 1
				end
			end
			return {
				mult = has_bonus * card.ability.extra.mult,
				chips = has_mult * card.ability.extra.chips
			}
		end
	end,
	in_pool = function(self, args)
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_mult') or SMODS.has_enhancement(playing_card, 'm_bonus') then
                return true
            end
        end
        return false
    end
}
