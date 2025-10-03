function BPlus.round_vars.stone_carving_card(v, init)
  v = v or {}
  v.rank = "Ace"
  v.suit = "Spades"
  v.id = 14
  if init then
    return v
  end

  if G.playing_cards then
    local valid_cards = {}
    for _, card in ipairs(G.playing_cards) do
      if not SMODS.has_no_suit(card) and not SMODS.has_no_rank(card) then
        valid_cards[#valid_cards + 1] = card
      end
    end

    if next(valid_cards) then
      local card = pseudorandom_element(valid_cards, pseudoseed("j_bplus_stone_carving_card" .. G.GAME.round_resets.ante))
      v.rank = card.base.value
      v.suit = card.base.suit
      v.id = card.base.id
    end
  end

  return v
end

return {
  rarity = 2,
  cost = 7,

  blueprint_compat = false,

  loc_vars = function(_, infoq)
    infoq[#infoq + 1] = G.P_CENTERS.m_stone
    local card = G.GAME.current_round.bplus_stone_carving_card
    return {
      vars = {
        localize(card.rank, "ranks"),
        localize(card.suit, "suits_plural"),
        colours = {
          G.C.SUITS[card.suit],
        },
      },
    }
  end,
}
