return {
 SMODS.Enhancement {
	key = "jump",
	atlas = "GarbEnhancements",
	pos = {x = 2, y = 0},
	
    replace_base_card = false,
    no_suit = false,
    no_rank = false,
    always_scores = false,
	
	config = {extra = { }},
	
	loc_vars = function(self, info_queue, card)
        return { vars = {  }}
    end
},

}