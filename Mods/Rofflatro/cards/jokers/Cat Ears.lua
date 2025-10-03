SMODS.Joker{
   key = 'cat_ears',
   atlas = 'roffers',
   rarity = 2,
   cost = 6,
   blueprint_compat = true,
   perishable_compat = false,
   pos = { x = 3, y = 7 },
   config = { extra = { chips = 0, chip_mod = 8 } },
   loc_vars = function(self, info_queue, card)
      return {vars = { card.ability.extra.chip_mod, card.ability.extra.chips }}
   end,
   calculate = function(self, card, context)
      if context.before and not context.blueprint and #context.scoring_hand > 1 then
         local list, hold, result = {}, {}, {}
         for k, v in ipairs(context.scoring_hand) do
            if SMODS.has_enhancement(v, 'm_wild') then
               table.insert(list, "wildcats!")
            else
               table.insert(list, v:get_id()..v.base.suit)
            end
         end
         for k, v in ipairs(list) do
            if not hold[v] then
               result[ #result + 1 ] = v
               hold[v] = true
            end
         end
         if #result > 1 then
            card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod
            if pseudorandom('catears') > 0.3 then
               return {
               message = '+'..card.ability.extra.chip_mod,
               colour = G.C.CHIPS
               }
            else
               return {
               message = '+:3',
               colour = G.C.CHIPS
               }
            end
         end
      elseif context.joker_main then
         return {
            chips = card.ability.extra.chips
         }
      end
   end,
   set_badges = function (self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_l6_art'), ROFF.C.credits.Lucky6, G.C.WHITE, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}

