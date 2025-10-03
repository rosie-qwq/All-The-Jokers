local scale = 1.4

SMODS.Joker {
	key = "reghabi",
	config = { extra = {  } },
	loc_vars = function(self, info_queue, card)
		return { vars = {  } }
	end,
	rarity = 2,
	atlas = "svrd_atlas",
	pos = { x = 4, y = 2 },
	cost = 5,
	-- unlocked = true,
	-- discovered = true,
	calculate = function(self, card, context)
		if context.setting_blind
			and not context.getting_sliced
			and not card.debuff
			and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit
		then
			local _card = create_card('Tarot', G.consumeables, nil, nil, nil, nil, 'c_svrd_reintegration')
			card:juice_up(0.3, 0.4)
			_card:add_to_deck()
			G.consumeables:emplace(_card)
		end
	end,
	load = function(self, card, card_table, other_card)
		card.T.h = G.CARD_H / scale
        card.T.w = G.CARD_W
	end,
	set_ability = function(self, card, initial, delay_sprites)
		card.T.h = card.T.h / 1.4
	end,
	set_sprites = function(self, card, front)
        card.children.center.scale.y = card.children.center.scale.y / scale
    end,
}
