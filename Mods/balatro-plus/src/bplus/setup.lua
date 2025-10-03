BPlus = {
  u = require("bplus.utils"),
  mod = SMODS.current_mod,
  path = SMODS.current_mod.path:gsub("/$", ""),
  round_vars = {},
  config = SMODS.current_mod.config,
  config_ui = {
    { label = "Replace Splash Logo", type = "toggle", mod_config = "replace_splash_logo" },
  },
}

SMODS.Atlas {
  key = "balatro_plus",
  path = "balatro_plus.png",
  px = G.ASSET_ATLAS.balatro.px,
  py = G.ASSET_ATLAS.balatro.py,
}

SMODS.Atlas {
  key = "modicon",
  path = "modicon.png",
  px = 39,
  py = 39,
}

function BPlus.update_splash_logo()
  local key = "balatro"
  if BPlus.config.replace_splash_logo then
    key = "bplus_balatro_plus"
  end

  if G.SPLASH_LOGO then
    G.SPLASH_LOGO.atlas = G.ASSET_ATLAS[key]
  end
end

function BPlus.apply_metatable_to_probabilities(go)
  go.real_probabilities = go.probabilities
  go.probabilities = setmetatable({}, {
    __index = function(_, k)
      if G.GAME and G.GAME.blind and not G.GAME.blind.disabled and G.GAME.blind.name == "bl_bplus_thirteen" then
        return 0
      end
      return G.GAME.real_probabilities[k]
    end,
    __newindex = function(_, k, v)
      go.real_probabilities[k] = v
    end,
    __pairs = function()
      return next, G.GAME.real_probabilities, nil
    end,
  })
end

function BPlus.food_jokers_tooltip()
  local nodes = {}
  local centers = {}
  for _, center in pairs(G.P_CENTERS) do
    if center.bplus_food_joker then
      centers[#centers + 1] = center
    end
  end

  local text = {}
  local function add_line(line)
    local parts = {}
    for _, part in ipairs(line) do
      parts[#parts + 1] = { n = G.UIT.T, config = { text = part[1], colour = part[2] or G.C.GREY, scale = 0.33 } }
    end
    text[#text + 1] = {
      n = G.UIT.R,
      config = { align = "cm" },
      nodes = parts,
    }
  end

  local cur_line = {}
  local cur_length = 0
  for i, center in ipairs(centers) do
    local name = localize { type = "name_text", set = "Joker", key = center.key }
    cur_line[#cur_line + 1] = { name, G.C.ORANGE }
    cur_length = cur_length + #name + 2

    if i == #centers then
      break
    end

    if cur_length > 20 then
      cur_line[#cur_line + 1] = { "," }
      add_line(cur_line)
      cur_line = {}
      cur_length = 0
    else
      cur_line[#cur_line + 1] = { ", " }
    end
  end

  if #cur_line > 0 then
    add_line(cur_line)
  end

  nodes[#nodes + 1] = {
    n = G.UIT.C,
    nodes = text,
  }

  return nodes
end

function BPlus.create_food_joker(seed_key)
  local _pool, _pool_key = get_current_pool("Joker", nil, nil, seed_key)
  local keys = {}
  for _, key in ipairs(_pool) do
    if key ~= "UNAVAILABLE" then
      local center = G.P_CENTERS[key]
      if center.bplus_food_joker then
        keys[#keys + 1] = center.key
      end
    end
  end

  if not next(keys) then
    keys = { "j_popcorn" }
  end

  return create_card("Joker", G.jokers, nil, nil, nil, nil, pseudorandom_element(keys, pseudoseed(_pool_key)), "top")
end
