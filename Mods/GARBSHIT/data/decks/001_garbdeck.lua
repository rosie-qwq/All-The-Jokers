return {
 SMODS.Back {
        key = 'garbdeck',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 0, y = 0 },    
        unlocked = true,
        discovered = true,
        config = {
            vouchers = {
                'v_overstock_norm',
            },
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {localize{type = 'name_text', key = 'v_overstock_norm', set = 'Voucher'}}}
        end,
        unlock_condition = {type = 'win_deck', deck = 'b_red'}
    },

    }