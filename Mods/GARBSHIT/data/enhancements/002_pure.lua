return {
 SMODS.Enhancement {
	key = "pure",
	atlas = "GarbEnhancements",
	pos = {x = 1, y = 0},
	
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	
	config = {extra = { }},
	
	loc_vars = function(self, info_queue, card)
        return { vars = {  }}
    end,

  update = function(self, card)
    if card.debuff or card.perma_debuff then
      card.debuff = false
      card.perma_debuff = false
      return true
    end
  end
},

}