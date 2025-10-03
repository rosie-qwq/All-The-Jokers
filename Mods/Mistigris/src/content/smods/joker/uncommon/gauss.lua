-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "gauss",
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    rarity = 2,
    cost = 6,
    unlocked = true,
    discovered = true,
    calculate = function(self, card, context)
        if context.joker_main and context.poker_hands and next(context.poker_hands["Straight"]) then
            local mult = 0
            for k, v in ipairs(context.poker_hands["Straight"]) do
                for k2, v2 in ipairs(v) do
                    mult = mult + v2.base.nominal
                end
            end

            return {
                mult = mult
            }
        end
    end
}

return j
