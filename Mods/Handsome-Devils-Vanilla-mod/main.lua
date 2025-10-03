HNDS = {}

--[[---------------------------
Config tab
--]] ---------------------------
HD = SMODS.current_mod
hnds_config = SMODS.current_mod.config

SMODS.current_mod.config_tab = function()
  return {
    n = G.UIT.ROOT,
    config = {
      align = "tm",
      padding = 0.2,
      minw = 8,
      minh = 2,
      colour = G.C.BLACK,
      r = 0.1,
      hover = true,
      shadow = true,
      emboss = 0.05
    },
    nodes = {
      {
        n = G.UIT.R,
        config = { padding = 0, align = "cm", minh = 0.1 },
        nodes = {
          {
            n = G.UIT.C,
            config = { align = "c", padding = 0, minh = 0.1 },
            nodes = {
              {
                n = G.UIT.R,
                config = { padding = 0, align = "cm", minh = 0 },
                nodes = {
                  { n = G.UIT.T, config = { text = "Enable Stone Ocean hand", scale = 0.45, colour = G.C.UI.TEXT_LIGHT } },
                }
              },
              {
                n = G.UIT.R,
                config = { padding = 0, align = "cm", minh = 0 },
                nodes = {
                  { n = G.UIT.T, config = { text = "Requires restart", scale = 0.35, colour = G.C.JOKER_GREY } },
                }
              }
            }
          },
          {
            n = G.UIT.C,
            config = { align = "cl", padding = 0.05 },
            nodes = {
              create_toggle { col = true, label = "", scale = 1, w = 0, shadow = true, ref_table = hnds_config, ref_value = "enableStoneOcean" },
            }
          },
        }
      },

    }
  }
end


--[[---------------------------
Script names
--]] ---------------------------

local files = {
  jokers = {
    list = {
      --You can rearrange the joker order in the collection by changing the order here
      "coffee_break",
      "jackpot",
      "balloons",
      "banana_split",
      "head_of_medusa",
      "pot_of_greed",
      "jokestone",
      "color_of_madness",
      "deep_pockets",
      "seismic_activity",
      "occultist",
      "stone_mask",
      "meme",
      "digital_circus",
      "jokes_aside"
    },
    directory = 'jokers/'
  },
  seals = {
    list = {
      "black_seal",
      "green_seal"
    },
    directory = 'seals/'
  },
  spectrals = {
    list = {
      "abyss",
      "exchange",
      "growth",
      "hallows",
      "petrify",
      "dream",
    },
    directory = 'consumables/spectral/'
  },
  vouchers = {
    list = {
      "tag_hunter",
      "hashtag_skip"
    },
    directory = 'vouchers/'
  },
  planets = {
    list = {
      "makemake",
    },
    directory = 'consumables/planet/'
  },
  poker_hands = {
    list = {},
    directory = 'poker_hands/'
  },
}

if hnds_config.enableStoneOcean then table.insert(files.poker_hands.list, "stone_ocean") end

--[[---------------------------
Atlases and other resources
--]] ---------------------------

SMODS.Sound({
  key = 'madnesscolor',
  path = 'madnesscolor.ogg',
})

SMODS.Atlas({
	key = "modicon",
	path = "hd_icon.png",
	px = 32,
	py = 32
})

SMODS.Atlas {
  key = 'Jokers',      --atlas key
  path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71,             --width of one card
  py = 95              -- height of one card
}

SMODS.Atlas {
  key = 'Consumables', --atlas key
  path = 'THD.png',    --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71,             --width of one card
  py = 95              -- height of one card
}

SMODS.Atlas {
  key = 'Vouchers', --atlas key
  path = 'VHD.png',    --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71,             --width of one card
  py = 95              -- height of one card
}

SMODS.Atlas {
  key = 'Extras',   --atlas key
  path = 'EHD.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71,          --width of one card
  py = 95           -- height of one card
}


--[[---------------------------
Function hooks
--]] ---------------------------

local old_game_init = Game.init_game_object
Game.init_game_object = function(self)
  old_ret = old_game_init(self)

  old_ret.green_seal_draws = 0
  old_ret.ante_stones_scored = 0

  return old_ret
end

local set_cost_ref = Card.set_cost
function Card.set_cost(self)
  set_cost_ref(self)

  if self.config.center.key == "j_hnds_coffee_break" then
    self.sell_cost = 0
  end
end

local old_card_ui = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
  if _c.set == "Joker" and _c.key == 'j_hnds_banana_split' then
    if card.edition and card.edition.negative then
      main_end = {}
      localize{type = 'other', key = 'remove_negative', nodes = main_end, vars = {}}
      main_end = main_end[1]
    end 
  end

  old_ret = old_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)

  return old_ret
end

--[[---------------------------
Utility functions
--]] ---------------------------

---Gets the number of unique suits in a provided scoring hand - code from Paperback, try it if you haven't!
function HNDS.get_unique_suits(scoring_hand, bypass_debuff, flush_calc)
  -- Set each suit's count to 0
  local suits = {}

  for k, _ in pairs(SMODS.Suits) do
    suits[k] = 0
  end

  -- First we cover all the non Wild Cards in the hand
  for _, card in ipairs(scoring_hand) do
    if not SMODS.has_any_suit(card) then
      for suit, count in pairs(suits) do
        if card:is_suit(suit, bypass_debuff, flush_calc) and count == 0 then
          suits[suit] = count + 1
          break
        end
      end
    end
  end

  -- Then we cover Wild Cards, filling the missing suits
  for _, card in ipairs(scoring_hand) do
    if SMODS.has_any_suit(card) then
      for suit, count in pairs(suits) do
        if card:is_suit(suit, bypass_debuff, flush_calc) and count == 0 then
          suits[suit] = count + 1
          break
        end
      end
    end
  end

  -- Count the amount of suits that were found
  local num_suits = 0

  for _, v in pairs(suits) do
    if v > 0 then num_suits = num_suits + 1 end
  end

  return num_suits
end

---Gets a pseudorandom tag from the Tag pool - Also from Paperback. Go play it!!!!!
function HNDS.poll_tag(seed, options)
  -- This part is basically a copy of how the base game does it
  -- Look at get_next_tag_key in common_events.lua
  local pool = options or get_current_pool('Tag')
  local tag_key = pseudorandom_element(pool, pseudoseed(seed))

  while tag_key == 'UNAVAILABLE' do
    tag_key = pseudorandom_element(pool, pseudoseed(seed))
  end

  local tag = Tag(tag_key)

  -- The way the hand for an orbital tag in the base game is selected could cause issues
  -- with mods that modify blinds, so we randomly pick one from all visible hands
  if tag_key == "tag_orbital" then
    local available_hands = {}

    for k, hand in pairs(G.GAME.hands) do
      if hand.visible then
        available_hands[#available_hands + 1] = k
      end
    end

    tag.ability.orbital_hand = pseudorandom_element(available_hands, pseudoseed(seed .. '_orbital'))
  end

  return tag
end

--For cross-mod compatibility with Maximus
--Use this function when adding to a joker's value
if not Card.scale_value then
	function Card:scale_value(applied_value, scalar)
		return applied_value + scalar
	end
end

--Return a list of all the jokers that create jokers in shop
function HNDS.get_shop_joker_tags()
  local tag_list = {
    "tag_foil",
    "tag_holo",
    "tag_polychrome",
    "tag_negative",
    "tag_rare",
    "tag_uncommon",
    "tag_buffoon"
  }

  --Add tags from other mods
  if next(SMODS.find_mod("paperback")) then
    table.insert(tag_list, "tag_paperback_dichrome")
  end

  if next(SMODS.find_mod("Pokermon")) then
    table.insert(tag_list, "tag_poke_shiny_tag")
    table.insert(tag_list, "tag_poke_stage_one_tag")
    table.insert(tag_list, "tag_poke_safari_tag")
  end

  return tag_list
end

--[[---------------------------
Load files
--]] ---------------------------

local function load_files(set)
    for i = 1, #files[set].list do
        if files[set].list[i] then assert(SMODS.load_file(files[set].directory .. files[set].list[i] .. '.lua'))() end
    end
end

for key, value in pairs(files) do
  load_files(key)
end