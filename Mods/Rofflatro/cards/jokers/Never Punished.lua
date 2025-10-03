--Never Punished (Common) - Sell this Joker during a blind to create a glass face card and draw to hand. (It’s called skill.)


SMODS.Joker{
	key = 'never_punished',
	atlas = 'roffers',
	rarity = 1,
	cost = 2,
	blueprint_compat = true,
	eternal_compat = false,
	perishable_compat = false,
	pos = { x = 3, y = 3 },
	config = { extra = { isBossBlind = false } },
	loc_vars = function(self,info_queue,card)
		return {vars = {}}
	end,
	calculate = function(self,card,context)
		if G.GAME.blind:get_type() == 'Boss' and context.selling_self then
			local _rank = pseudorandom_element({'J', 'Q', 'K'}, pseudoseed('never_punished'))
            local _suit = pseudorandom_element({'S','H','D','C'}, pseudoseed('never_punished'))
			local _card = create_playing_card({
				front = G.P_CARDS[_suit..'_'.._rank],
				center = G.P_CENTERS.m_glass
			}, G.hand, false,false,nil)
			_card:add_to_deck()
			table.insert(G.playing_cards, _card)
			_card.states.visible = nil
			G.E_MANAGER:add_event(Event({
				func = function()
					_card:start_materialize()
					return true
				end
			})) 
		end
	end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_art'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_code'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
	end
}
