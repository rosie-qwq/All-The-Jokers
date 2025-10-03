return {
  boss = { min = 2 },
  boss_colour = HEX("b3143e"),

  get_loc_debuff_text = function()
    return G.GAME.blind.loc_debuff_text .. (G.GAME.current_round.bplus_the_brake_last_act and "[Must discard first]" or "")
  end,

  debuff_hand = function()
    if G.GAME.blind.disabled then
      return
    end

    local last_act = G.GAME.current_round.bplus_the_brake_last_act
    if last_act == "play" then
      return true
    end
  end,

  defeat = function()
    G.GAME.current_round.bplus_the_brake_last_act = nil
  end,
}
