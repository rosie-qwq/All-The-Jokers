local lua_pairs = pairs
function pairs(t)
  local mt = getmetatable(t)
  if mt and mt.__pairs then
    return mt.__pairs(t)
  else
    return lua_pairs(t)
  end
end

local game_init_game_object = Game.init_game_object
function Game:init_game_object()
  local ret = game_init_game_object(self)

  BPlus.apply_metatable_to_probabilities(ret)

  for key, value in pairs(BPlus.round_vars) do
    ret.current_round["bplus_" .. key] = value(nil, true)
  end

  return ret
end

local cardarea_emplace = CardArea.emplace
function CardArea:emplace(card, location, stay_flipped)
  if G.jokers then
    for _, j in ipairs(G.jokers.cards) do
      j:calculate_joker { bplus_card_added = true, other_card = card, cardarea = self }
    end
  end
  for _, t in ipairs(G.GAME.tags or {}) do
    t:apply_to_run { type = "card_added", card = card, cardarea = self }
  end
  return cardarea_emplace(self, card, location, stay_flipped)
end

local balatro_add_tag = add_tag
function add_tag(tag)
  local ret = balatro_add_tag(tag)
  if tag.key ~= "tag_bplus_recycle" then
    G.GAME.tag_bplus_recycle_last_tag = tag.key
  end
  return ret
end

local g_funcs_evaluate_play = G.FUNCS.evaluate_play
function G.FUNCS.evaluate_play(e)
  local ret = g_funcs_evaluate_play(e)
  G.GAME.blind:hand_played()
  return ret
end

function Blind:hand_played()
  if self.config.blind.hand_played then
    if self.config.blind.hand_played(self) then
      G.E_MANAGER:add_event(Event {
        trigger = "immediate",
        func = function()
          SMODS.juice_up_blind()
          G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.06 * G.SETTINGS.GAMESPEED,
            blockable = false,
            blocking = false,
            func = function()
              play_sound("tarot2", 0.76, 0.4)
              return true
            end,
          })
          play_sound("tarot2", 1, 0.4)
          return true
        end,
      })
      delay(0.4)
    end
  end
end

local card_is_suit = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
  local opt
  local first_pass
  local res
  local orig_suit = self.base.suit
  if not G.bplus_card_is_suit_opt then
    G.bplus_card_is_suit_opt = {}
    first_pass = true
  end
  opt = G.bplus_card_is_suit_opt

  if self.debuff and not bypass_debuff then
    return
  end

  if not res and not opt.stone_carving and SMODS.has_enhancement(self, "m_stone") and next(find_joker("j_bplus_stone_carving")) then
    opt.stone_carving = true
    local orig_center = self.config.center
    self.config.center = G.P_CENTERS.c_base
    self.base.suit = G.GAME.current_round.bplus_stone_carving_card.suit
    res = self:is_suit(suit, bypass_debuff, flush_calc)
    self.config.center = orig_center
    self.base.suit = orig_suit
  end

  if not res and not opt.blured and next(find_joker("j_bplus_blured")) then
    opt.blured = true
    local transform = G.GAME.current_round.bplus_blured_suit
    if self:is_suit(transform.from, bypass_debuff, flush_calc) then
      self.base.suit = transform.to
    end
    res = self:is_suit(suit, bypass_debuff, flush_calc)
    self.base.suit = orig_suit
    res = res or self:is_suit(suit, bypass_debuff, flush_calc)
  end

  if first_pass then
    G.bplus_card_is_suit_opt = nil
  end
  if res ~= nil then
    return res
  end
  return card_is_suit(self, suit, bypass_debuff, flush_calc)
end

local card_get_id = Card.get_id
function Card:get_id()
  if SMODS.has_enhancement(self, "m_stone") and not self.debuff and next(find_joker("j_bplus_stone_carving")) then
    return G.GAME.current_round.bplus_stone_carving_card.id
  end
  return card_get_id(self)
end

local card_calculate_joker = Card.calculate_joker
function Card:calculate_joker(ctx)
  local ret = card_calculate_joker(self, ctx)
  if not ret then
    return
  end
  if ret == true then
    return ret
  end

  if ret.repetitions and not G.GAME.blind.disabled and G.GAME.blind.name == "bl_bplus_lazy" then
    BPlus.bl_lazy_trigger(ret.card or self)
    ret = nil
  end

  return ret
end

local card_calculate_seal = Card.calculate_seal
function Card:calculate_seal(ctx)
  local ret = card_calculate_seal(self, ctx)
  if not ret then
    return
  end

  if ret.repetitions and not G.GAME.blind.disabled and G.GAME.blind.name == "bl_bplus_lazy" then
    BPlus.bl_lazy_trigger(ret.card or self)
    ret = nil
  end

  return ret
end

local old_localize = localize
function localize(args, misc_cat)
  if type(args.key) == "table" and args.key.bplus_custom then
    return args.key.bplus_custom(args, misc_cat)
  end

  if args.key == "bplus_food_jokers" then
    if args.nodes then
      args.nodes[#args.nodes + 1] = BPlus.food_jokers_tooltip()
      return
    else
      return "Food Jokers"
    end
  else
    return old_localize(args, misc_cat)
  end
end

local center_overrides = {
  j_gros_michel = { bplus_food_joker = true },
  j_egg = { bplus_food_joker = true },
  j_ice_cream = { bplus_food_joker = true },
  j_cavendish = { bplus_food_joker = true },
  j_turtle_bean = { bplus_food_joker = true },
  j_popcorn = { bplus_food_joker = true },
  j_ramen = { bplus_food_joker = true },
}

for key, override in pairs(center_overrides) do
  for field, value in pairs(override) do
    G.P_CENTERS[key][field] = value
  end
end
