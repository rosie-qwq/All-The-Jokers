if not mf_config["John"] or Jen or not (Talisman and Big and Big.arrow) then
  return nil
end


SMODS.Consumable {
  key = "soul2",
  set = "Spectral",

  atlas = "mf_soul2",
  pos = { x = 0, y = 0 },
  soul_pos = { x = 1, y = 0 },

  unlocked = true,
  discovered = true,
  no_collection = true,

  hidden = {
    soul_rate = 0.000000003,
    can_repeat_soul = true,
  },
  
  can_use = function(self, card)
    return #G.jokers.cards < G.jokers.config.card_limit or self.area == G.jokers
  end,
  use = function(self, card, area, copier)
    local used_tarot = copier or card
    G.E_MANAGER:add_event(Event({
      func = function() 
        local n_card = create_card('Joker', G.jokers, nil, nil, nil, nil, "j_mf_johnbalatro", 'exp')
        n_card:add_to_deck()
        G.jokers:emplace(n_card)
        n_card:start_materialize()
        used_tarot:juice_up(0.3, 0.5)
        return true
      end}))   
  end,
}

SMODS.Rarity {
  key = "superlegendary",
  loc_txt = {
    name = "Superlegendary"
  },
  badge_colour = HEX("2852FF")
}

local joker = {
  name = "John Balala",
  config = {
    extra = {op=1,val=10,op_gain=2}
  },
  pos = {x = 0, y = 8},
  soul_pos = {x = 5, y = 5},
  rarity = "mf_superlegendary",
  cost = 9999999,
  unlocked = true,
  discovered = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  demicoloncompat = true,
  no_collection = true,
  loc_txt = {
    name = "{s:2}JOHN BALATRO",
    text = {
      "{X:dark_edition,C:white,s:2}#1##2#{} Mult",
      "Multiply operator by {X:dark_edition,C:white,s:2}#3#{} at end of round",
      "{C:red,s:2}Crashes the game{} if",
      "removed from deck"
    }
  },
  loc_vars = function(self, info_queue, center)
    local op_string = "{"..center.ability.extra.op.."}"
    if center.ability.extra.op <= 10 then
      op_string = string.rep("^", center.ability.extra.op)
    end
    return {
      vars = { op_string, center.ability.extra.val, center.ability.extra.op_gain }
    }
  end,
  calculate = function(self, card, context)
    if context.cardarea == G.jokers and context.joker_main then
      return {
        hypermult = { card.ability.extra.op, card.ability.extra.val }
      }
    end
    if context.end_of_round and not context.individual and not context.blueprint and not context.repetition then
      card.ability.extra.op = card.ability.extra.op * card.ability.extra.op_gain
      return {
        message = localize("k_upgrade_ex")
      }
    end
  end,
	remove_from_deck = function(self, card, from_debuff)
		G.crashthegame.lololol()
	end
}

return joker