SMODS.Voucher {
    key = 'silver_spoon',
    pos = {
        x = 0,
        y = 0
    },
    unlocked = true,
    discovered = true,
    atlas = 'Vouchers',
    config = {
        extra = {
            money = 2,
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
    
    calc_dollar_bonus = function(self, card)
        local bonus = card.ability.extra.money
        if bonus > 0 then return bonus end
    end,
}

SMODS.Voucher {
    key = 'heirloom',
    loc_txt = {
        ['name'] = 'Heirloom',
        ['text'] = {
            [1] = 'Earn {C:money}$#1#{}',
            [2] = 'at end of round',
        }
    },
    pos = {
        x = 1,
        y = 0
    },
    unlocked = true,
    discovered = true,
    atlas = 'Vouchers',
    config = {
        extra = {
            money = 3,
        }
    },
    requires = { "v_cracker_silver_spoon" },
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.money}}
    end,
    calc_dollar_bonus = function(self, card)
        local bonus = card.ability.extra.money
        if bonus > 0 then return bonus end
    end,
}

SMODS.Voucher {
    key = 'clowncar',
    pos = {
        x = 4,
        y = 0
    },
    unlocked = true,
    discovered = true,
    atlas = 'Vouchers',
    config = {
        extra = {
            weight_mod = 1.4,
        }
    },
    loc_vars = function(self, info_queue, card)
        if card and card.area and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'sugariimari'}, key = 'artist_credits_cracker'} end
        return {vars = {card.ability.extra.weight_mod}}
    end,
    redeem = function(self)
        G.GAME["uncommon"..'_mod'] = self.config.extra.weight_mod
    end,
}

SMODS.Voucher {
    key = 'busfullofclowns',
    pos = {
        x = 5,
        y = 0
    },
    unlocked = true,
    discovered = true,
    atlas = 'Vouchers',
    config = {
        extra = {
            weight_mod = 2,
        }
    },
    requires = { "v_cracker_clowncar" },
    loc_vars = function(self, info_queue, card)
        return {vars = {}}
    end,
    redeem = function(self)
        G.GAME["rare"..'_mod'] = self.config.extra.weight_mod
    end,
}

if not CrackerConfig.disable_tier3 then
    SMODS.Voucher {
        key = 'cheese_touch',
        pos = {
            x = 2,
            y = 0
        },
        unlocked = true,
        discovered = true,
        atlas = 'Vouchers',
        config = {
            extra = {
                hands = 1,
            }
        },
        requires = { "v_nacho_tong" },
        loc_vars = function(self, info_queue, card)
            if card and card.area and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'sugariimari'}, key = 'artist_credits_cracker'} end
            return {vars = {card.ability.extra.hands}}
        end,
        
        redeem = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.hands = G.GAME.round_resets.hands + self.config.extra.hands
                    ease_hands_played(self.config.extra.hands)
                    return true
                end,
            }))
        end
    }

    SMODS.Voucher {
        key = 'dumpster',
        pos = {
            x = 3,
            y = 0
        },
        unlocked = true,
        discovered = true,
        atlas = 'Vouchers',
        config = {
            extra = {
                discards = 1,
            }
        },
        requires = { "v_recyclomancy" },
        loc_vars = function(self, info_queue, card)
            if card and card.area and card.area.config.collection then info_queue[#info_queue+1] = {set = 'Other', vars = {'mrkyspices', 'sugariimari'}, key = 'artist_credits_cracker'} end
            return {vars = {card.ability.extra.discards}}
        end,
        
        redeem = function(self)
            G.E_MANAGER:add_event(Event({
                func = function()
                    G.GAME.round_resets.discards = G.GAME.round_resets.discards + self.config.extra.discards
                    ease_discard(self.config.extra.discards)
                    return true
                end,
            }))
        end
    }
end