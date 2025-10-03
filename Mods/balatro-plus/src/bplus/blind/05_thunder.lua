return {
  mult = 1,
  boss = { min = 3 },
  boss_colour = HEX("ebad13"),

  set_blind = function()
    local blind = G.GAME.blind
    blind.chips = blind.chips + (blind.chips * #G.jokers.cards)
    blind.chip_text = number_format(blind.chips)
  end,

  disable = function()
    local blind = G.GAME.blind
    blind.chips = get_blind_amount(G.GAME.round_resets.ante) * blind.mult * G.GAME.starting_params.ante_scaling
    blind.chip_text = number_format(blind.chips)
  end,
}
