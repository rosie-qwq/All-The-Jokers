function BPlus.round_vars.newspaper_rank(v, init)
  v = v or {}
  v.rank = "Ace"
  v.id = 14
  if init then
    return v
  end

  if G.playing_cards then
    local valid_cards = {}
    for _, card in ipairs(G.playing_cards) do
      if not SMODS.has_no_rank(card) then
        valid_cards[#valid_cards + 1] = card
      end
    end

    if next(valid_cards) then
      local card = pseudorandom_element(valid_cards, pseudoseed("j_bplus_newspaper_rank" .. G.GAME.round_resets.ante))
      v.rank = card.base.value
      v.id = card.base.id
    end
  end

  return v
end

return {
  config = { extra = 8 },
  rarity = 1,

  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return {
      vars = {
        localize(G.GAME.current_round.bplus_newspaper_rank.rank, "ranks"),
        card.ability.extra,
      },
    }
  end,

  calcualte = function(_, card, ctx)
    if ctx.individual and ctx.cardarea == G.play and ctx.other_card:get_id() == G.GAME.current_round.bplus_newspaper_rank.id then
      return {
        mult = card.ability.extra,
        card = card,
      }
    end
  end,
}
