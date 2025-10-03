SMODS.Joker{
   key = 'thumbnail',
   atlas = 'roffers',
   rarity = 1,
   cost = 5,
   blueprint_compat = true,
   eternal_compat = true,
   pos = { x = 5, y = 5 },
   soul_pos = {x = 0, y = 3},
   config = { extra = {
      Xmult = 3,
      requirement = 3
      }
   },
   loc_vars = function(self,info_queue,card)
      return {vars = {card.ability.extra.Xmult, card.ability.extra.requirement}}
   end,
   calculate = function(self,card,context)
      if context.joker_main then
         if #G.jokers.cards == card.ability.extra.requirement then
            return {
            x_mult = card.ability.extra.Xmult
            }
	 end
      end
   end,
   set_badges = function (self, card, badges)
      badges[#badges+1] = create_badge(localize('k_roff_credit_uhadme_art'), ROFF.C.credits.uhadme, G.C.WHITE, 0.8)
      badges[#badges+1] = create_badge(localize('k_roff_credit_canicao_code'), ROFF.C.credits.canicao, ROFF.C.credits.canicao_text, 0.8)
   end
}
