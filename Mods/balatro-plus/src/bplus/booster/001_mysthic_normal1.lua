return {
  weight = 0.4,
  cost = 6,
  config = { extra = 2, choose = 1 },
  draw_hand = true,
  kind = "sigil",
  group_key = "k_bplus_mysthic_pack",

  loc_vars = function(self)
    return { vars = { self.config.choose, self.config.extra } }
  end,

  ease_background_colour = function(self)
    ease_background_colour { new_colour = darken(G.C.SECONDARY_SET.sigil, 0.2) }
  end,

  create_card = function(self)
    return SMODS.create_card {
      set = "sigil",
      area = G.pack_cards,
      skip_materialize = true,
      soulable = true,
      key_append = "p_mysthic_normal1_card",
    }
  end,
}
