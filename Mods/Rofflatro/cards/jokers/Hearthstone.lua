SMODS.Joker{
	key = 'hearthstone',
	atlas = 'roffers',
	rarity = 2,
	cost = 4,
	blueprint_compat = true,
	eternal_compat = true,
	pos = { x = 3, y = 4 },
	loc_vars = function(self,info_queue,card)
		info_queue[#info_queue+1] = G.P_CENTERS.m_wild
	end,
	calculate = function(self,card,context)
		if context.before and not context.blueprint then
            for _, c in pairs(context.scoring_hand) do
                if c.config.center == G.P_CENTERS.m_wild and not c.seal then
                    c:set_seal(SMODS.poll_seal({guaranteed = true}))
                    G.E_MANAGER:add_event(Event({
                        func = function()
                            c:juice_up()
                            return true
                        end
                    })) 
                end
            end
        end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end,
	in_pool = function(self, args) 
        for _, playing_card in ipairs(G.playing_cards or {}) do
            if SMODS.has_enhancement(playing_card, 'm_wild') then
                return true
            end
        end
        return false
    end
}
