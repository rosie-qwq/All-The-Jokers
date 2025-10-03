return {
 SMODS.Joker {
    key = 'mercante',
    loc_txt = {
      name = 'Mercante in Fiera',
      text = {
        "Earn {C:money}$#1#{} if",
        "{C:attention}#2#{} of {V:1}#3#{} hasn't",
        "been drawn this round",
        "{s:0.8}Card changes every round"
      }
    },
    config = { extra = { dollars = 6 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.dollars, localize(G.GAME.current_round.idol_card.rank, 'ranks'), localize(G.GAME.current_round.idol_card.suit, 'suits_plural'), colours = {G.C.SUITS[G.GAME.current_round.idol_card.suit]} } }
    end,
  
    rarity = 1,
    atlas = 'GarbJokers',
    pos = { x = 4, y = 5 },
    cost = 5,

      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

    calculate = function(self,card,context)

      if context.first_hand_drawn then
        failed = false
        local eval = function() return not failed end
      end

      if context.hand_drawn or context.discard then
        for i = 1, #G.hand.cards do
          if G.hand.cards[i]:get_id() == G.GAME.current_round.idol_card.id and 
          G.hand.cards[i]:is_suit(G.GAME.current_round.idol_card.suit) then
            if not failed then 
              card_eval_status_text(card, 'extra', nil, nil, nil, {message = "Unlucky!"})
              for i = 1, 4 do
              play_sound('cancel', 0.7 + 0.05*i, 0.7)
              delay(0.4/i)
              end
            end
            failed = true
          end
        end
      end
    end,

    calc_dollar_bonus = function(self, card)
      local bonus = card.ability.extra.dollars
      if not failed then return bonus end
    end
  
  },

  }