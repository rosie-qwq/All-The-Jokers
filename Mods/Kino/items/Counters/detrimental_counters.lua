Blockbuster.Counters.Counter {
    key = "poison",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 6,
    atlas = 'blockbuster_counters',
    pos = {x = 7, y = 0},

    config = {
        percentage = 0.05,
        cap = 9
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.percentage * 100
            }
        }
    end,
    counter_class = {
        "detrimental",
        "status",
    },
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            local mult = mult * (card.ability.counter.counter_num * (self.config.percentage))
            local chips = hand_chips * (card.ability.counter.counter_num * (self.config.percentage))
            card:bb_increment_counter(-1)
            return {
                mult = -mult, 
                chips = -chips
            }
        end
    end,
    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}

Blockbuster.Counters.Counter {
    key = "stun",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 8,
    atlas = 'blockbuster_counters',
    pos = {x = 4, y = 0},
    config = {
        
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                
            }
        }
    end,
    counter_class = {
        "detrimental",
        "status",
        "debuff",
    },
    calculate = function(self, card, context)
        if context.after_debuff and context.ignore_debuff then
            card:bb_increment_counter(-1)
        end
    end,

    increment = function(self, card, number)

    end,
    add_counter = function(self, card, number)
        SMODS.debuff_card(card, true, self.key)
    end,
    remove_counter = function(self, card)
        SMODS.debuff_card(card, false, self.key)
    end,
}


Blockbuster.Counters.Counter {
    key = "debt",
    prefix_config = {key = { mod = false, atlas = false}},
    order = 7,
    atlas = 'blockbuster_counters',
    pos = {x = 5, y = 0},
    config = {
        money = 1,
        cap = 9
    },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.money
            }
        }
    end,
    counter_class = {
        "detrimental",
        "economy",
    },
    calculate = function(self, card, context)
        if (context.main_scoring and context.cardarea == G.play) or context.joker_main then
            local return_val = card.ability.counter.counter_num + self.config.money
            card:bb_increment_counter(-1)
            return {
                dollars = -return_val
            }
        end
    end,

    increment = function(self, card, number)
    end,
    add_counter = function(self, card, number)
    end,
    remove_counter = function(self, card)
    end,
}