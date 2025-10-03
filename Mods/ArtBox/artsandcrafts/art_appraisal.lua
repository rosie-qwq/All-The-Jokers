SMODS.Consumable ({
    object_type = "Consumable",
     atlas = 'arts_atlas',
	key = 'art_appraisal',
	set = 'art',
	name = 'Appraisal',
    config = {
        mod_conv = "c_artb_joker_collectable",
      extra = {
        money=0
      }
    },
	pos = { x = 1, y = 1 },
	cost = 4,
	unlocked = true,
	discovered = true,
    can_use = function(self, card)
		return true
	end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS[self.config.mod_conv]

        local sell_cost = 0
        if G.consumeables and G.consumeables.cards then
      for i = 1, #G.consumeables.cards do
        if G.consumeables.cards[i] ~= card and (G.consumeables.cards[i].area and G.consumeables.cards[i].area == G.consumeables) then
          sell_cost = sell_cost + G.consumeables.cards[i].sell_cost
          if sell_cost>30 then
            sell_cost=30
          end
        end
      end
      card.ability.extra.money = sell_cost
    end
    return {
      vars = {
        G.GAME.probabilities.normal,
        card.ability.extra.money
      }
    }
    end,

    use = function(self, card, area)
        local sell_cost = 0
        if G.consumeables and G.consumeables.cards then
      for i = 1, #G.consumeables.cards do
        if G.consumeables.cards[i] ~= card and (G.consumeables.cards[i].area and G.consumeables.cards[i].area == G.consumeables) then
          sell_cost = sell_cost + G.consumeables.cards[i].sell_cost
          if sell_cost>30 then
            sell_cost=30
          end
        end
      end
      card.ability.extra.money = sell_cost
      end


      G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
            play_sound('timpani')
            card:juice_up(0.3, 0.5)
            ease_dollars(card.ability.extra.money, true)
            return true end }))

    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 0.4, func = function()
       if pseudorandom("appraisal") < 0.05 then
                    local new_card = create_card("collectable", G.consumables, nil, nil, nil, nil, 'c_artb_limited_edition_collectable')
                  new_card:add_to_deck()
                  G.consumeables:emplace(new_card)
                else
                    local new_card = create_card("collectable", G.consumables, nil, nil, nil, nil, 'c_artb_joker_collectable')
                  new_card:add_to_deck()
                  G.consumeables:emplace(new_card)
                end
       return true end }))
    end

    
})