return {
 SMODS.Joker {
  key = 'trumpets',
  loc_txt = {
    name = 'Too Many Trumpets',
    text = {
      "Required Chips to defeat blind",
      "increase by {C:attention}#4#%{} every {C:attention}#3#{} seconds",
      "Gains {X:mult,C:white} X#2# {} Mult after hand is played",
      "{C:inactive}(Currently {X:mult,C:white} X#1# {} {C:inactive}Mult)"
    }
  },
  config = { extra = { difficulty = 1.05, Xmult = 1, Xmult_gain = 0.25, seconds = 2 } },
  loc_vars = function(self, info_queue, card)
    return { vars = { card.ability.extra.Xmult, card.ability.extra.Xmult_gain, card.ability.extra.seconds, (card.ability.extra.difficulty-1)*100 } }
  end,

  rarity = 3,
  atlas = 'GarbJokers',
  pos = { x = 5, y = 5 },
  cost = 5,
    unlocked = true, 
    discovered = false, --whether or not it starts discovered
    blueprint_compat = true, --can it be blueprinted/brainstormed/other
    eternal_compat = true, --can it be eternal
    perishable_compat = true, --can it be perishable

    add_to_deck = function(self, card)
      clock = G.TIMERS.REAL
      create_champion_event = function()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.2,
            func = function()
                if G.hand_text_area.blind_chips and clock then
                    local new_chips = math.floor(G.GAME.blind.chips * card.ability.extra.difficulty)
                    local mod_text = number_format(
                        math.floor(G.GAME.blind.chips * card.ability.extra.difficulty) - G.GAME.blind.chips
                    )
                    G.GAME.blind.chips = new_chips
                    G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)

                    local chips_UI = G.hand_text_area.blind_chips
                    G.FUNCS.blind_chip_UI_scale(G.hand_text_area.blind_chips)
                    G.HUD_blind:recalculate()

                    attention_text({
                        text = '+' .. mod_text,
                        scale = 0.8,
                        hold = 0.7,
                        cover = chips_UI.parent,
                        cover_colour = G.C.RED,
                        align = 'cm'
                    })

                    chips_UI:juice_up()

                    play_sound('chips2')
                else
                    return false
                end
                return true
            end
        }))
        end
    end,

    update = function(self, card)
      if clock and next(SMODS.find_card("j_garb_trumpets")) and G.GAME.blind.in_blind and not G.SETTINGS.paused then
        if (clock + (card.ability.extra.seconds - 1) < G.TIMERS.REAL) then
          clock = G.TIMERS.REAL
          create_champion_event()
          return true
        end
      end
    end,

    calculate = function(self, card, context)
      if context.before then
        clock = nil
      end

      if context.after and not context.blueprint and not context.debuffed_hand then
        card.ability.extra.Xmult = card.ability.extra.Xmult + card.ability.extra.Xmult_gain
        return {
          message = 'Upgraded!',
          card = card
        }
      end

      if context.hand_drawn then
          clock = G.TIMERS.REAL
      end

      if context.end_of_round and not context.individual and not context.repetition then
        clock = nil
      end
      
      if context.joker_main and card.ability.extra.Xmult > 1 then
        return {
          Xmult_mod = card.ability.extra.Xmult,
          message = localize { type = 'variable', key = 'a_xmult', vars = { card.ability.extra.Xmult } },
          card = card
        }
      end

    end
  },

  }