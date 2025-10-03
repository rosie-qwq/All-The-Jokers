local joker = {
  name = "Blahaj",
  config = {},
  pos = {x = 8, y = 6},
  rarity = 1,
  cost = 1,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  calculate = function(self, card, context)
    if context.forcetrigger or (context.cardarea == G.jokers and context.joker_main) then
      return {
        swap = true,
        message = localize("k_swap_ex")
      }
    end
  end
}

return joker
