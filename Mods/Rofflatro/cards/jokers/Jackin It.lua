SMODS.Joker{
    key = 'jackin_it',
    atlas = 'roffers',
    pos = {x = 1, y = 1},
    rarity = 1, 
    cost = 3,
    blueprint_compat = true,
    perishable_compat = false,
    config = { extra = {mult = 0, mult_mod = 1} },
    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.mult_mod, card.ability.extra.mult} }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play and not context.blueprint then
            if context.other_card:get_id() == 11 then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
                return {
                    message = localize('k_upgrade_ex')
                }
            end
        elseif context.joker_main then
            return {
                mult = card.ability.extra.mult
            }
        end
    end,
	set_badges = function (self, card, badges)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
		badges[#badges+1] = create_badge(localize('k_roff_credit_l6_code'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
	end
}
