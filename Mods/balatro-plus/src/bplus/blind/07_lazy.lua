function BPlus.bl_lazy_trigger(card)
  if card then
    card_eval_status_text(card, "debuff", nil, nil, nil, {
      message = localize("k_bplus_no_retrigger"),
    })
  end
  G.GAME.blind:wiggle()
end

return {
  boss = { min = 4 },
  boss_colour = HEX("1662f0"),
}
