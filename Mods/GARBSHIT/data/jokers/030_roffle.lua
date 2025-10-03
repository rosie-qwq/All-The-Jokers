return {
 SMODS.Joker {
    key = 'roffle',
    loc_txt = {
      name = 'Roffle',
      text = {
        "{X:mult,C:white} X#1# {} Mult if",
        "first played {C:attention}face{} card",
        "is {C:attention}retriggered"
      },
      unlock = {
        "Win a run on at least", 
        "{E:1,C:attention}Gold Stake{} difficulty"
      }
    },
    config = { extra = { Xmult = 3 } },
    loc_vars = function(self, info_queue, card)
      return { vars = { card.ability.extra.Xmult } }
    end,
  
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 6, y = 5 },
    cost = 6,

      unlocked = false, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = true, --can it be blueprinted/brainstormed/other
      eternal_compat = true, --can it be eternal
      perishable_compat = true, --can it be perishable

      check_for_unlock = function(self, args)
        if args.type == "win_stake" then
          if get_deck_win_stake() == 8 then return true else return false end
        end
      end, 

    calculate = function(self,card,context)
      if context.individual and context.cardarea == G.play then
        for i = 1, #context.scoring_hand do
          if context.scoring_hand[i] == context.other_card and faces[1] == context.other_card and no_retrigger == i then roffle_mult = true end
          if context.scoring_hand[i] == context.other_card then no_retrigger = i end
        end
      end

      if context.before then
        faces = {}
        roffle_mult = false
        for i = 1, #context.scoring_hand do
          local _card = context.scoring_hand[i]
          if _card:is_face() then 
            faces[#faces+1] = _card
          end
        end
      end

      if context.joker_main then
        no_retrigger = -1
        if roffle_mult == true then
            return {
              Xmult_mod = card.ability.extra.Xmult,
              message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
              card = card
            }
        end
      end

    end
  },

  }