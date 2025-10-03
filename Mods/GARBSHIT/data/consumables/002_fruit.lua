return {
 SMODS.Consumable {
  key = 'fruit',
  set = 'Stamp',
  loc_txt = {
    name = 'Fruit',
    text = {
      "Exchange selected Joker",
      "for {C:attention}+#1#{} hand size",
      "next round"
    }
  },
    atlas = 'Stamps', pos = { x = 1, y = 0 },

    config = {extra = { max_highlighted = 1, h_size = 3}},
    
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.h_size }}
    end,

    can_use = function(self, card)
      if #G.jokers.highlighted == 1 and not G.jokers.highlighted[1].ability.eternal then return true else return false end
    end,
  
    use = function(self, card, area, copier)
      play_sound('timpani')
      _card = G.jokers.highlighted[1]
      _card:start_dissolve(nil, false)
      G.hand:change_size(card.ability.extra.h_size)
      G.GAME.round_resets.temp_handsize = (G.GAME.round_resets.temp_handsize or 0) + card.ability.extra.h_size
      delay(0.6)
    end

},

}