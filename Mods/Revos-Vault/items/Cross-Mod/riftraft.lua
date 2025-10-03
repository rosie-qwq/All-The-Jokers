SMODS.Joker({
	key = "riftrinter",
	atlas = "riftr",
	rarity = "crv_p",
	cost = 10,
	unlocked = true,
	discovered = false,
	blueprint_compat = true,
	eternal_compat = true,
	perishable_compat = false,
	pos = {
		x = 0,
		y = 0,
	},
	config = {
		extra = {
			mult = 0,
			mult_gain = 15,
		},
	},
	loc_vars = function(self, info_queue, card)
		return {
			vars = { card.ability.extra.mult, card.ability.extra.mult_gain },
		}
	end,
	calculate = function(self, card, context)
		if context.setting_blind then
					SMODS.add_card({
                        set = "Rift",
						area = G.consumeables,
						edition = "e_negative",
					})
                end
	end,
    draw = function(self, card, layer)
		card.children.center:draw_shader("negative", nil, card.ARGS.send_to_shader)
		card.children.center:draw_shader("negative_shine", nil, card.ARGS.send_to_shader)
	end,
	in_pool = function(self, wawa, wawa2)
		return true
	end,
    dependencies = "RiftRaft",
})

SMODS.Consumable{
    key = "archive",
    set = "Rift",
    atlas = "riftr",
    loc_txt = {
        name = "Abyssal Archive",
        text = {
            "Add {C:attention}#1#{} random {C:attention}Contracts{}",
            "to the {C:riftraft_void}Void{}",
        }
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.amount,
            }
        }
    end,
    config = {
        extra = {amount = 3},
    },
    pos = {x = 1, y = 0},
    cost = 1,
    can_use = function(self, card)
        return true
    end,
	add_to_deck = function(self, card, from_debuff)
		card:set_edition({ negative = true }, true)
	end,
    draw = function(self, card, layer)
		card.children.center:draw_shader("negative", nil, card.ARGS.send_to_shader)
		card.children.center:draw_shader("negative_shine", nil, card.ARGS.send_to_shader)
	end,
    use = function(self, card, area)
        local added = {}
        for i=1, card.ability.extra.amount do
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.2, func = function()
                play_sound('timpani')
                local new_card = SMODS.create_card{set = 'EnchancedDocuments', area = G.riftraft_rifthand, key_append = 'archive', discover = true}
                new_card:set_edition({negative = true}, true, true)
                G.riftraft_rifthand:emplace(new_card)
                card:juice_up(0.3, 0.5)
                table.insert(added, new_card)
                return true
            end}))
        end
        G.E_MANAGER:add_event(Event({trigger = 'immediate', func = function()
            SMODS.calculate_context({add_to_void = true, added = added})
            return true 
        end}))
        if not RIFTRAFT.in_void_pack() then
            G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.5, func = function()
                for i,v in ipairs(G.riftraft_rifthand.cards) do
                    draw_card(G.riftraft_rifthand, G.riftraft_void, nil,'down', nil, v, 0.08)
                end
                return true
            end}))
        end
    end,
    dependencies = "RiftRaft",
}