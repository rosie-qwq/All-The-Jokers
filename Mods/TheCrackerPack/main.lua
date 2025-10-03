CrackerConfig = SMODS.current_mod.config

Cracker = {}

assert(SMODS.load_file('src/base_jokers.lua'))()
if not CrackerConfig.disable_upgradedfood then
    assert(SMODS.load_file('src/upgraded_food.lua'))()
end
assert(SMODS.load_file('src/voucher.lua'))()

if not CrackerConfig.disable_card then
    assert(SMODS.load_file('src/expansion_1/card_jokers.lua'))()
end

if JokerDisplay then
    assert(SMODS.load_file('src/compat/JokerDisplay.lua'))()
end


assert(SMODS.load_file('src/challenge.lua'))() -- load this last cause it references stuff from previous files

--region Atlas
SMODS.Atlas {
    key = 'Jokers',
    path = "Jokers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'Vouchers',
    path = "Vouchers.png",
    px = 71,
    py = 95
}

SMODS.Atlas {
    key = 'modicon',
    px = 34,
    py = 34,
    path = 'modicon.png'
}

Cracker.vanilla_food = {
  j_gros_michel = true,
  j_ice_cream = true,
  j_cavendish = true,
  j_turtle_bean = true,
  j_diet_cola = true,
  j_popcorn = true,
  j_ramen = true,
  j_selzer = true,
  j_egg = true,
}

-- Initialize pool of food jokers if it doesn't exist already, which may be created by other mods.
-- Any joker can add itself to this pool by adding pools = { Food = true } to its code
-- Credits to Cryptid for the idea and Paperback for this code
if not SMODS.ObjectTypes.Food then
  SMODS.ObjectType {
    key = 'Food',
    default = 'j_joker',
    cards = {},
    inject = function(self)
      SMODS.ObjectType.inject(self)
      -- Insert base game food jokers
      for k, _ in pairs(Cracker.vanilla_food) do
        self:inject_card(G.P_CENTERS[k])
      end
    end
  }
end

function Cracker.mostplayedhand() -- Balatro doesn't update G.GAME.current_round.most_played_poker_hand so
    if not G.GAME or not G.GAME.current_round then 
        return 'High Card'
    end
    local chosen_hand = 'High Card'
    local _handname, _played, _order = 'High Card', -1, 100
    for k, v in pairs(G.GAME.hands) do
        if v.played > _played or (v.played == _played and _order > v.order) then 
            _played = v.played
            _handname = k
        end
    end
    chosen_hand = _handname
    return chosen_hand
end

-- Code modified from Paperback 
---@param card table | string a center key or a card
---@return boolean
function Cracker.is_food(card)
    if not card then
        return false
    else
        local center = type(card) == "string"
            and G.P_CENTERS[card]
            or (card.config and card.config.center)

        if not center then
            return false
        end
        -- If the center has the Food pool in its definition
        if center.pools and center.pools.Food then
            return true
        end
    end
end

local remove_ref = Card.remove
function Card.remove(self)
    if self.added_to_deck and self.ability.set == 'Joker' and not G.CONTROLLER.locks.selling_card and not self.getting_sliced and Cracker.is_food(self.config.center_key) then
        SMODS.calculate_context({
            self_destroying_food_joker = true,
            destroyed_joker = self
        })
    end

    return remove_ref(self)
end


-- Tailsman Compat (fake)

to_big = to_big or function(x)
  return x
end

to_number = to_number or function(n)
  return n
end

--

local igo = Game.init_game_object
Game.init_game_object = function(self)
    local ret = igo(self)
    ret.food_multiplier = 1
    
    return ret
end

SMODS.current_mod.extra_tabs = function() --Credits
    local scale = 0.4
    return {
        {
            label = "Credits",
            tab_definition_function = function()
            return {
                n = G.UIT.ROOT,
                config = {
                    align = "cm",
                    padding = 0.05,
                    colour = G.C.CLEAR,
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Directors: sugariimarii, sophiedeergirl",
                                    shadow = true,
                                    scale = scale,
                                    colour = G.C.GREEN
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Art: palestjade, MrkySpices, amoryax, LumaHoneyy, wombatcountry",
                                    shadow = true,
                                    scale = scale,
                                    colour = G.C.BLUE
                                }
                            },
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Programming: sophiedeergirl, I'm an issue",
                                    shadow = true,
                                    scale = scale,
                                    colour = G.C.GREEN
                                }
                            }
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Testing: brook03",
                                    shadow = true,
                                    scale = scale,
                                    colour = G.C.MONEY
                                }
                            }
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0,
                            align = "cm"
                        },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = {
                                    text = "Joker Ideas: sophiedeergirl, sugariimarii, palestjade, brook03, plebmiester",
                                    shadow = true,
                                    scale = scale,
                                    colour = G.C.SECONDARY_SET.Spectral
                                }
                            }
                        },
                    },
                }
            }
            end
        },
        {
            label = "Feedback",
            tab_definition_function = function()
            return {
                n = G.UIT.ROOT,
                config = {
                    align = "cm",
                    padding = 0.05,
                    colour = G.C.CLEAR,
                },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0.1,
                            align = "cm"
                        },
                        nodes = {
                            UIBox_button({
                                colour = G.C.RED, minw = 3.5, minh = 1, padding = 0.1, emboss = 0.2, button = "open_url", label = {localize("k_open_url")}
                            }),
                        }
                    },
                    {
                        n = G.UIT.R,
                        config = {
                            padding = 0.1,
                            align = "cm"
                        },
                        nodes = {
                            UIBox_button({
                                colour = G.C.RED, minw = 3.5, minh = 1, padding = 0.1, emboss = 0.2, button = "copy_url", label = {localize("k_copy_url")}
                            })
                        }
                    }
                }
            }
            end
        },
    }
end

G.FUNCS.open_url = function(e)
    love.system.openURL("https://docs.google.com/forms/d/e/1FAIpQLSdp-g2-Dd58vgNu6moXMbppHyBMSOXFt12NOLlqX6Yx2SHp0w/viewform")
end
G.FUNCS.copy_url = function(e)
    love.system.setClipboardText("https://docs.google.com/forms/d/e/1FAIpQLSdp-g2-Dd58vgNu6moXMbppHyBMSOXFt12NOLlqX6Yx2SHp0w/viewform")
end

SMODS.current_mod.config_tab = function() --Config
    return {
      n = G.UIT.ROOT,
      config = {
        align = "cm",
        padding = 0.05,
        colour = G.C.CLEAR,
      },
      nodes = {
        {
            n = G.UIT.R,
            config = {
                padding = 0,
                align = "cm"
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        text = "All changes require a restart.",
                        shadow = true,
                        scale = 0.5,
                        colour = G.C.SECONDARY_SET.Enhanced
                    }
                },
            }
        },
        create_toggle({
            label = "Disable Card Pack",
            ref_table = CrackerConfig,
            ref_value = "disable_card",
        }),
        create_toggle({
            label = "Disable Upgraded Food Jokers",
            ref_table = CrackerConfig,
            ref_value = "disable_upgradedfood",
        }),
        create_toggle({
            label = "Disable Tier 3 Vouchers",
            ref_table = CrackerConfig,
            ref_value = "disable_tier3",
        }),
        create_toggle({
            label = "Dev Textures",
            ref_table = CrackerConfig,
            ref_value = "starlo",
        }),
      },
    }
end