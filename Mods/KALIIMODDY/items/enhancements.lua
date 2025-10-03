-- Fake Transparency Enhancement
SMODS.Atlas{
    key = 'faketp',
    path = 'fakeenhance.png',
    px = 71,
    py = 95,
}

SMODS.Enhancement {
    key = 'faketp',
    type = 'modifier',
    atlas = 'faketp',
    pos = { x = 0, y = 0 },
    config = {
        extra = {
            xmult = 2,
            odds = 4
        }
    },
    shatters = false,

    loc_txt = {
        name = "Fake Transparent PNG",
        text = {
            "{C:green}1 in #2#{} chance to gain {X:mult,C:white}X#1#{} {C:mult}Mult{} when scored"
        }
    },

    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                self.config.extra.xmult,
                self.config.extra.odds
            }
        }
    end,

    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            if SMODS.pseudorandom_probability(card, 'faketp', 1, self.config.extra.odds) then
                return {
                    x_mult = self.config.extra.xmult,
                    colour = G.C.MULT
                }
            end
        end
    end,
}

--luckier card
SMODS.Atlas{
    key = 'luckier',
    path = 'luckiercard.png',
    px = 71,
    py = 95,
}

SMODS.Enhancement {
    key = 'luckier',
    atlas = 'luckier',
    pos = { x = 0, y = 0 },
    config = { extra = { mult = 30, dollars = 30, mult_odds = 3, dollars_odds = 5 } },
    loc_txt = {
    name = "Luckier Card",
    text = {
        "{C:green}1 in #3# {}chance",
        "for {C:mult}+#1# {}Mult",
     "{C:green}1 in #4# {}chance",
     "to win {C:money}$#2#{}"
    }
},
loc_vars = function(self, info_queue, card)
    local mult_numerator, mult_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.mult_odds)
    local dollars_numerator, dollars_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.dollars_odds)
    return {
        vars = {
            card.ability.extra.mult,         -- #1#    REMEMBER THIS KALI
            card.ability.extra.dollars,      -- #2#
            mult_denominator,                -- #3#
            dollars_denominator              -- #4#
        }
    }
end,
    calculate = function(self, card, context)
        if context.main_scoring and context.cardarea == G.play then
            local ret = {}
            if SMODS.pseudorandom_probability(card, 'kaliicappy_luckier_mult', 1, card.ability.extra.mult_odds) then
                card.lucky_trigger = true
                ret.mult = card.ability.extra.mult
            end
            if SMODS.pseudorandom_probability(card, 'kaliicappy_luckier_mult', 1, card.ability.extra.dollars_odds) then
                card.lucky_trigger = true
                ret.dollars = card.ability.extra.dollars
            end
            G.E_MANAGER:add_event(Event {
               func = function()
                   card.lucky_trigger = true
                   return true
               end
})
            return ret
        end
    end,
}

