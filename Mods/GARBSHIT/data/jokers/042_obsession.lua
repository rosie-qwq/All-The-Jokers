return {
 SMODS.Joker {
    key = 'obsession',
    loc_txt = {
      name = "Obsession",
      text = {
        "Prevents Death",
        "if only {C:attention}1{} hand type",
        "has been played",
        "this round",
        "{C:red}self-destructs"
      }
    },
    
      unlocked = true, 
      discovered = false, --whether or not it starts discovered
      blueprint_compat = false, --can it be blueprinted/brainstormed/other
      eternal_compat = false, --can it be eternal
      perishable_compat = true, --can it be perishable
  
    config = { extra = { first_hand = "" } },
    rarity = 2,
    atlas = 'GarbJokers',
    pos = { x = 1, y = 8 },
    cost = 6,
    loc_vars = function(self, info_queue, card)
      if config.on_card_credits then
        info_queue[#info_queue+1] = {set = "Other", key = "credits", specific_vars = {"Valoky"}} 
      end
      return { vars = { } }
    end,
    
     calculate = function(self, card, context)
      if context.setting_blind then
        val_obsessed = true
        card.ability.extra.first_hand = ""
      end

      if context.after then
        if card.ability.extra.first_hand == ""  then card.ability.extra.first_hand = context.scoring_name end
        if val_obsessed and card.ability.extra.first_hand ~= context.scoring_name then val_obsessed = false end
      end

      if context.game_over and val_obsessed and not context.blueprint then
        G.E_MANAGER:add_event(Event({
          func = function()
            G.hand_text_area.blind_chips:juice_up()
            G.hand_text_area.game_chips:juice_up()
            play_sound('tarot1')  
            card:start_dissolve()
            return true
          end
        })) 
      return {
        message = localize('k_saved_ex'),
        saved = true,
        colour = G.C.RED
      }
      end
    end
  },
  
  
  }