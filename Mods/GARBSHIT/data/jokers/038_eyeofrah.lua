return {
 SMODS.Joker {
    key = 'eyeofrah',
    loc_txt = {
      name = 'Eye of Rah',
      text = {
        "If {C:attention}Boss Blind{} is won in {C:attention}1{} hand,",
        "create a {C:tarot}Charm Tag{}",
      }
    },
    -- Extra is empty, because it only happens once. If you wanted to copy multiple cards, you'd need to restructure the code and add a for loop or something.
    config = { extra = {} },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 0, y = 8 },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable
      cost = 4,
      loc_vars = function(self, info_queue, card)
        info_queue[#info_queue+1] = {set = "Tag", key = "tag_charm", specific_vars = {}}
        return { vars = { card.ability.extra.mult } }
    end,
      
      calculate = function(self, card, context)
        if context.end_of_round and G.GAME.blind.boss and context.main_eval and G.GAME.current_round.hands_played == 1 then
          add_tag(Tag('tag_charm'))
          play_sound('garb_gong', 0.9 + math.random()*0.1, 0.8)
          return {
              card = card,
              message = 'Rah!',
              colour = G.C.TAROT
          }
        end
      end
  },

  }