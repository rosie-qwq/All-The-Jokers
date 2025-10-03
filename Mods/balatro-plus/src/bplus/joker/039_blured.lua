function BPlus.round_vars.blured_suit(v, init)
  v = v or {}
  local last_suit = v.to
  v.from = "Spades"
  v.to = "Hearts"
  if init then
    return v
  end

  local valid_cards = {}
  for _, card in ipairs(G.playing_cards) do
    if not SMODS.has_no_suit(card) then
      valid_cards[#valid_cards + 1] = card
    end
  end
  if next(valid_cards) then
    v.from = pseudorandom_element(valid_cards, pseudoseed("j_bplus_blured_from_suit" .. G.GAME.round_resets.ante)).base.suit
  end

  local suits = {}
  for suit, _ in pairs(G.C.SUITS) do
    suits[#suits + 1] = suit
  end

  if last_suit then
    for i, suit in ipairs(suits) do
      if suit == last_suit then
        table.remove(suits, i)
        break
      end
    end
  end

  for i, suit in ipairs(suits) do
    if suit == v.from then
      table.remove(suits, i)
      break
    end
  end

  local seed = pseudoseed("j_bplus_blured_to_suit" .. G.GAME.round_resets.ante)
  v.to = pseudorandom_element(suits, seed)

  return v
end

return {
  rarity = 1,
  cost = 4,

  blueprint_compat = false,

  loc_vars = function()
    local transform = G.GAME.current_round.bplus_blured_suit
    local from, to = transform.from, transform.to
    return {
      vars = {
        localize(from, "suits_plural"),
        localize(to, "suits_plural"),
        colours = {
          G.C.SUITS[from],
          G.C.SUITS[to],
        },
      },
    }
  end,
}
