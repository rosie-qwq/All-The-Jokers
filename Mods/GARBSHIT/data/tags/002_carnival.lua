return {
    SMODS.Tag {
        key = 'carnival',
        loc_txt = {
          name = 'Carnival Tag',
          text = {
            "Shop has a {C:attention}duplicate{}",
            "of one of your",
            "{C:attention}non-legendary{} Jokers"
        }
        },
        atlas = 'GarbTags', 
        pos = { x = 1, y = 0 },
        in_pool = function()
		    return (G.GAME.round_resets.ante > 1)
	    end,
        apply = function(self, tag, context)
		if context.type == "store_joker_create" then
            local keys = {}
            if G.jokers then
                for k, v in pairs(G.jokers.cards) do
                    if type(v.config.center.rarity) == "number" and v.ability.set == 'Joker' and not (type(v.config.center.rarity) == "number" and v.config.center.rarity >= 4) then
                        table.insert(keys, v.config.center.key)
                    end
                end  
            end
            if not keys[1] then return false end
			local card
            local curKey = pseudorandom_element(keys, pseudoseed('JohnBalatro')) or "j_joker"
            if curKey == "j_ring_master" then check_for_unlock({ type = "doubleornothing" }) end
			card = create_card("Joker", context.area, nil, nil, nil, nil, curKey)
			create_shop_card_ui(card, "Joker", context.area)
			card.states.visible = false
			tag:yep("+", G.C.RED, function()
				card:start_materialize()
				card:set_cost()
				return true
			end)
			tag.triggered = true
			return card
		end
          end,
      }
    }