local joker = {
  name = "Joke Merge Valley",
  config = {},
  pos = {x = 8, y = 4},
  rarity = 2,
  cost = 6,
  unlocked = true,
  discovered = true,
  blueprint_compat = false,
  eternal_compat = true,
  perishable_compat = true,
  calculate = function(self, card, context)
    if context.pre_discard and context.cardarea == G.jokers then
      if #context.full_hand ~= 3 then return nil end

      local last_card = context.full_hand[3]

      local new_stats = {
        perma_bonus = 0,
        perma_mult = 0,
        perma_x_chips = 0,
        perma_x_mult = 0,

        perma_h_chips = 0,
        perma_h_mult = 0,
        perma_h_x_chips = 0,
        perma_h_x_mult = 0,
        
        perma_p_dollars = 0,
        perma_h_dollars = 0,
      }

      local enhancement = nil
      local edition = nil
      local seal = nil

      for _, v in pairs(context.full_hand) do
        if v.base.value ~= last_card.base.value then return nil end

        for k, _ in pairs(new_stats) do -- the devious reverse iterator?
          new_stats[k] = new_stats[k] + v.ability[k]
        end

        if v ~= last_card then new_stats.perma_bonus = new_stats.perma_bonus + v.base.nominal end

        if v.config.center ~= G.P_CENTERS.c_base then enhancement = v.config.center end
        if v.seal then seal = v.seal end
        if v.edition then edition = v.edition end
      end

      if enhancement and enhancement ~= last_card.config.center then
        last_card:set_ability(enhancement)
      end
      if edition and edition ~= last_card.edition then
        last_card:set_edition(edition)
      end
      if seal and seal ~= last_card.seal then
        last_card:set_seal(seal)
      end
      for k, _ in pairs(new_stats) do
        last_card.ability[k] = new_stats[k]
      end

      local destroyed_cards = {}

      for _, v in pairs(context.full_hand) do
        if v ~= last_card then 
          destroyed_cards[#destroyed_cards + 1] = v
          v:start_dissolve({HEX("57ecab")}, nil, 1.6)
          v:remove_from_deck()
        end
      end
      
      for i = 1, #G.jokers.cards do
        G.jokers.cards[i]:calculate_joker({remove_playing_cards = true, removed = destroyed_cards})
      end

      return {
        message = localize("k_merged_ex")
      }
    end
  end
}

return joker
