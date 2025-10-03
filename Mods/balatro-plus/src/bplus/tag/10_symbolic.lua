local function calculate_dollars(self, tag)
  local dollars = 0
  local suit = tag.ability.bplus_symbolic_tag_suit
  for _, card in ipairs(G.playing_cards) do
    if card:is_suit(suit) then
      dollars = dollars + self.config.dollars
    end
  end
  return math.min(dollars, self.config.max)
end

return {
  config = { dollars = 1, max = 30, type = "immediate" },

  loc_vars = function(self, _, tag)
    local suit = tag and tag.ability.bplus_symbolic_tag_suit
    local dollars = 0

    if G.playing_cards then
      dollars = tag and calculate_dollars(self, tag) or 0
    end

    return {
      vars = {
        self.config.dollars,
        suit and localize(suit, "suits_plural") or "[" .. localize("k_suit") .. "]",
        dollars,
        self.config.max,
        colours = {
          suit and G.C.SUITS[suit] or G.C.ORANGE,
        },
      },
    }
  end,

  set_ability = function(_, tag)
    tag.ability.bplus_symbolic_tag_suit = "Spades"
    local valid_cards = {}
    for _, card in ipairs(G.playing_cards) do
      if not SMODS.has_no_suit(card) then
        valid_cards[#valid_cards + 1] = card
      end
    end
    if next(valid_cards) then
      tag.ability.bplus_symbolic_tag_suit =
        pseudorandom_element(valid_cards, pseudoseed("tag_bplus_symbolic_card" .. G.GAME.round_resets.ante)).base.suit
    end
  end,

  apply = function(self, tag, ctx)
    if ctx.type == "immediate" then
      local money = calculate_dollars(self, tag)
      if money > 0 then
        tag:yep("+", G.C.MONEY, function()
          return true
        end)
        ease_dollars(money)
        tag.triggered = true
        return true
      end
    end
  end,
}
