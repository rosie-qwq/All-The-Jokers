AKYRS.TradeProfessions = {}
AKYRS.Trades = {}
AKYRS.TradeProfessionTrades = {}
-- trade recipe definitons
AKYRS.TRADE_INGREDIENTS = { -- stand for trade ingredients type ._.
    EMERALD = 1, -- emerald
    RARITY = 2, -- jokers of certain rarity
    P_CARDS = 3, -- playing card
    SET = 4, -- anything from specificed set (Jokers, Tarots, Spectrals, etc.)
    KEY = 5, -- specific object
    CUSTOM = 6, -- config can just be SMODS.create_card argument for anything else (this is for output only)
    INPUT_FUNCTION = 7, -- config.drop_card(card) and config.tradable(area) should be specified, for input only, 
                        -- also drop card is default always true and tradable is false
    REWARD_FUNCTION = 8, -- config.reward(ar = {  }ea) area is the area of the input
}
AKYRS.TRADE_RESETS_CONDITION = {
    HAND = 1,
    DISCARD = 2,
    ROUND = 3,
    ANTE = 4, -- actually boss blind cash out
    SKIP = 5,
    SHOP_START = 6,
    SHOP_END = 7,
    NEVER = 8,
    CUSTOM = 9
}
--[[
trade entry config
limit - how many times this trade can be traded 
]]
-- [[
-- Example of Trade definition (for myself to implement later)
local trades = { -- this is just an array for each level
    { -- novice villager, contains an array of trades
        {
            input = {
                { ingredient = AKYRS.TRADE_INGREDIENTS.EMERALD, config = { count = 2 } },
            },
            output = {
                { ingredient = AKYRS.TRADE_INGREDIENTS.RARITY, config = { rarity = 2 } },
            },
            config = { limit = 12, villager_exp = 6, refresh = { on = AKYRS.TRADE_RESETS_CONDITION.ANTE, every = 1 } }
        },
        {
            input = {
                { ingredient = AKYRS.TRADE_INGREDIENTS.EMERALD, config = { count = 3 } },
                { ingredient = AKYRS.TRADE_INGREDIENTS.EMERALD, config = { count = 1, edition = "e_negative" } },
            },
            output = {
                { ingredient = AKYRS.TRADE_INGREDIENTS.P_CARDS, config = { enhancement = G.P_CENTER_POOLS.Enhanced["m_glass"], count = 4 } },
            },
            config = { limit = 12, villager_exp = 6, refresh = { on = AKYRS.TRADE_RESETS_CONDITION.ANTE, } } -- same effect as 1
        },
    },
    {
        {
            input = {
                { ingredients = AKYRS.TRADE_INGREDIENTS.SET, config = { count = 4, set = "Spectral" }}
            },
            output = {
                { ingredients = AKYRS.TRADE_INGREDIENTS.KEY, config = { count = 1, key = "c_soul" }}
            },
            config = { limit = 1, villager_exp = 150, refresh = { on = AKYRS.TRADE_RESETS_CONDITION.ANTE } }
        }
    },
    {
        {
            input = {
                { ingredients = AKYRS.TRADE_INGREDIENTS.INPUT_FUNCTION, 
                    config = { 
                        drop_card = function(c) return c and c.ability.eternal end,  
                        tradable = function(a) return a and a.cards and #a.cards >= 2 end,
                    }}
            },
            output = {
                { ingredients = AKYRS.TRADE_INGREDIENTS.CUSTOM, config = { set = "Alphabet", edition = "e_akyrs_noire" }}
            },
            config = { limit = 1, villager_exp = 15, refresh = { on = AKYRS.TRADE_RESETS_CONDITION.HAND, every = 2 } }
        }
    },
}
--[[]]

AKYRS.TradeProfession = SMODS.GameObject:extend{
    set = 'TradeProfession',
    obj_table = AKYRS.TradeProfessions,
    obj_buffer = {},
    atlas = "villager",
    pos = { x = 0, y = 0},
    required_params = {
        'key',
    },
    class_prefix = 'profession',

    register = function(self)
        if self.registered then
            sendWarnMessage(('Detected duplicate register call on object %s'):format(self.key), self.set)
            return
        end
        self.name = self.key
        AKYRS.TradeProfessionTrades[self.trade_profession] = {}
        AKYRS.TradeProfession.super.register(self)
    end,
}
