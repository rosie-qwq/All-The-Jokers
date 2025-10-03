return {
 SMODS.Joker {
    key = 'jimboss',
    loc_txt = {
      name = 'Jimboss',
      text = {
      "{X:chips,C:white} HP: {C:attention} #1# {}/{C:attention} #3#{}",
      "{C:money}+#2#${} when {C:attention}defeated{}",
      "{s:0.8}(Chips Scored = DMG)",
        "{C:inactive}(HP and reward also",
      "{C:inactive}increase when defeated)"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {HP = 1000, money = 5, maxHP = 1000, scale = 10} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 5 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 9,
      loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.HP, card.ability.extra.money, card.ability.extra.maxHP} }
    end,
        
     calculate = function(self, card, context)
      
      if context.end_of_round and context.cardarea == G.jokers then
        play_sound('garb_jimboss_hit', 1.3 + math.random()*0.1, 0.8)
        card.ability.extra.HP = to_big(card.ability.extra.HP) - to_big(G.GAME.chips)
        if card.ability.extra.HP <= to_big(0) then
          play_sound('coin1')
          play_sound('garb_jimboss_defeat', 0.9 + math.random()*0.1, 0.8)
          card.ability.extra.maxHP = card.ability.extra.maxHP * card.ability.extra.scale
          -- ease_dollars(card.ability.extra.money, true)    
          card.ability.extra.money = card.ability.extra.money + card.ability.extra.scale/2
          card.ability.extra.HP = card.ability.extra.maxHP
          if card.ability.extra.money == 30 then check_for_unlock({ type = "mustdie" }) end
          return {
            message = "Defeated!",
            dollars = card.ability.extra.money-card.ability.extra.scale/2,
            colour = G.C.MONEY,
            card = card
          }
        end    
        return {
          message = "Damage!",
          card = card
        }
    end
  
    end
  },
  
  }