SMODS.Joker({
	key = "printerinme",
	atlas = "tangent",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = false,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	dependencies = "tangent",
	loc_vars = function(self, info_queue, center)
	end,

	calculate = function(self, card, context)
        local crv = card.ability.extra
		if context.setting_blind and not context.blueprint then
if G.GAME.used_vouchers["v_crv_printerup"] == true and pseudorandom("ALLPRINTER") < G.GAME.probabilities.normal / 4  or G.GAME.used_vouchers["v_crv_printeruptier"] == true then
            for i = 1, G.jokers.config.card_limit do
				SMODS.add_card{
                    key = "j_tngt_friends",
                    editon = "e_negative"
                }
            end
			else
				if #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers then
                    for i = 1, G.jokers.config.card_limit - #G.jokers.cards do
                    SMODS.add_card{
                    key = "j_tngt_friends",
                    }
				end
			end
		end
    end
end
})