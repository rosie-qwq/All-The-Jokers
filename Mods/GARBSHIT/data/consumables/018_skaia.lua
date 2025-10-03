return {
 SMODS.Consumable {
    key = "skaia",
	  set = "Planet",
    loc_txt = {
      name = 'Skaia',
      text = {
					"{S:0.8}({S:0.8,V:1}lvl.#2#{S:0.8}){} Level up",
					"{C:attention}#1#",
					"{C:mult}+#3#{} Mult and",
					"{C:chips}+#4#{} chips",
}
    },
    
	config = { hand_type = "garb_str_fl_five", softlock = true },
	pos = { x = 2, y = 2 },
	atlas = "GarbConsumables",
	loc_vars = function(self, info_queue, center)
		return {
			vars = {
				localize("garb_str_fl_five", "poker_hands"),
				G.GAME.hands["garb_str_fl_five"].level,
				G.GAME.hands["garb_str_fl_five"].l_mult,
				G.GAME.hands["garb_str_fl_five"].l_chips,
				colours = {
					(
						(to_big(G.GAME.hands["garb_str_fl_five"].level) == to_big(1)) and G.C.UI.TEXT_DARK
					),
				},
			},
		}
	end,
  },


-- MISC CONSUMABLES

  }