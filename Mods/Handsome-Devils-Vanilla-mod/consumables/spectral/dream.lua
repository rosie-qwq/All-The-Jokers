SMODS.Consumable {
	key = 'dream',
	set = 'Spectral',
	config = {
		extra = {
			max_tags = 10
		}
	},
	loc_vars = function(self, info_queue, card)
		return { vars = { card.ability.extra.max_tags } }
	end,
	rarity = 4,
	hidden = true,
	soul_set = "Joker",
	atlas = 'Consumables',
	pos = { x = 1, y = 1 },
	cost = 4,
	use = function(self, card, context, copier)
		local used_consumable = copier or card
		local tags_to_make = card.ability.extra.max_tags
		G.E_MANAGER:add_event(Event({
			trigger = 'before',
			delay = 0.75,
			func = function()
				--empty event for timing purposes
				return true
			end
		}))
		for i = 1, tags_to_make do
			G.E_MANAGER:add_event(Event({
				trigger = 'before',
				delay = 0.5,
				func = function()
					used_consumable:juice_up()
					play_sound('generic1', 0.9 + math.random() * 0.1, 0.8)
					add_tag(HNDS.poll_tag("dream_",  HNDS.get_shop_joker_tags()))
					return true
				end
			}))
		end
	end,
	can_use = function(self, card)
		return true
	end,
}
