local function is_blackjack(cards)
  local aces = 0
  local total = 0
  for _, card in ipairs(cards) do
    local id = card:get_id()
    local value = 0
    if id > 10 and id < 14 then
      value = 10
    elseif id == 14 then
      value = 11
      aces = aces + 1
    elseif id > 1 and id < 11 then
      value = id
    end

    if card.debuff then
      value = 0
    end

    total = total + value
  end

  while total > 21 and aces > 0 do
    total = total - 10
    aces = aces - 1
  end

  return total == 21
end

return {
  rarity = 1,
  cost = 5,
  config = { extra = { chips = 0, chip_mod = 21 } },

  perishable_compat = false,
  blueprint_compat = true,

  loc_vars = function(_, _, card)
    return { vars = { card.ability.extra.chip_mod, card.ability.extra.chips } }
  end,

  calculate = function(_, card, ctx)
    if ctx.joker_main then
      if card.ability.extra.chips > 0 then
        return {
          message = localize {
            type = "variable",
            key = "a_chips",
            vars = { card.ability.extra.chips },
          },
          chip_mod = card.ability.extra.chips,
          colour = G.C.CHIPS,
        }
      end
    elseif ctx.before and ctx.cardarea == G.jokers and not ctx.blueprint then
      if is_blackjack(ctx.full_hand) then
        card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
        return {
          message = localize("k_upgrade_ex"),
          colour = G.C.CHIPS,
          card = card,
        }
      end
    end
  end,
}
