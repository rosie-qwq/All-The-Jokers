-- Utility Code
local mistiutils = require('mistiutils')

--- @type SMODS.Joker
local j = {
    key = "unstable_atom",
    config = { extra = { Xmult = 5, sd_odds = 6, xmult_odds = 3 } },
    loc_vars = function(self, info_queue, card)
        local stg = card.ability.extra
        return { vars = { G.GAME.probabilities.normal, stg.xmult_odds, stg.Xmult, stg.sd_odds } }
    end,
    blueprint_compat = true,
    rarity = 3,
    cost = 9,
    calculate = function(self, card, context)
        if context.joker_main then
            if mistiutils.chance("unstable_atom_destroy", card.ability.extra.sd_odds) and not context.blueprint then
                mistiutils.destroy_joker(card)
                return {
                    message = localize("k_mstg_decay_ex")
                }
            end

            if mistiutils.chance("unstable_atom_xmult", card.ability.extra.xmult_odds) then
                return {
                    Xmult = card.ability.extra.Xmult
                }
            end
        end
    end
}

return j
