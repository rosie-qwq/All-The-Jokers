return {
 SMODS.Joker {
    key = 'hhgregg',
    loc_txt = {
      name = 'hhgregg',
      text = {
        "All cards in the shop",
        "are {C:attention}discounted{} by {C:money}$#1#"
    }
    },
    config = { extra = { discount = 2 } },
    loc_vars = function(self, info_queue, card)
      return {vars = {}}
    end,
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 5, y = 8 },
    cost = 7,
  
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.discount } }
    end,

    add_to_deck = function(self, card, from_debuff)
      if G.STATE == G.STATES.SHOP then
        for k, v in pairs(G.shop_jokers.cards) do
          G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.5, func = function()
          if v.cost - card.ability.extra.discount >= 0 then
            v.cost = v.cost - card.ability.extra.discount
            card:juice_up()            
            v:juice_up()
            play_sound("coin1", 1.2)
          elseif v.cost > 0 then
            v.cost = 0
            card:juice_up()
            v:juice_up()
            play_sound("coin1", 1.2)
          end
          return true end}))
        end
      end
    end,

    calculate = function(self, card, context)
      if context.starting_shop or context.reroll_shop and not context.blueprint then
        for k, v in pairs(G.shop_jokers.cards) do
          G.E_MANAGER:add_event(Event({trigger = "after", delay = 0.5, func = function()
          if v.cost - card.ability.extra.discount >= 0 then
            v.cost = v.cost - card.ability.extra.discount
            if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end            
            v:juice_up()
            play_sound("coin1", 1.2)
          elseif v.cost > 0 then
            v.cost = 0
            if context.blueprint_card then context.blueprint_card:juice_up() else card:juice_up() end
            v:juice_up()
            play_sound("coin1", 1.2)
          end
          return true end}))
        end
      end
    end
  },   
  }