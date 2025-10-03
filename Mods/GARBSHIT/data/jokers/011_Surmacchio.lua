return {
 SMODS.Joker {
    key = 'Surmacchio',
    loc_txt = {
      name = 'Surmacchio',
      text = {
        "{C:green}#3# in #2#{} chance to",
        "create a {C:dark_edition}Negative Tag{}",
        "when shop is {C:attention}rerolled{}"
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {odds = 15} },
    rarity = 3,
    atlas = 'GarbJokers',
    pos = { x = 2, y = 3 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 10,
      loc_vars = function(self, info_queue, card)
      info_queue[#info_queue+1] = {set = "Tag", key = "tag_negative", specific_vars = {}}
      return { vars = { card.ability.extra.Xmult,card.ability.extra.odds, G.GAME.probabilities.normal} }
    end,
      
     calculate = function(self, card, context)
          if context.reroll_shop and pseudorandom('MioPadre') < G.GAME.probabilities.normal/card.ability.extra.odds then
              add_tag(Tag('tag_negative'))
              return {
                  card = card,
                  message = 'Surmacchio!',
                  colour = G.C.PURPLE
              }
          end
    end
  },
  
  }