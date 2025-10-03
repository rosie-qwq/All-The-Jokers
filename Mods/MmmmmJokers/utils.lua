--- Quicker way to print elements
function mxfj_debug(elem)
    if not elem then return sendDebugMessage("[MmmmmJokers] DEBUG: This element doesn't exist") end
    if type(elem) == "boolean" then
        return (elem and sendDebugMessage("[MmmmmJokers] DEBUG: true")) or sendDebugMessage("[MmmmmJokers] DEBUG: false")
    end
    if type(elem) == "table" then
        return sendDebugMessage("[MmmmmJokers] DEBUG: " .. inspect(elem))
    else
        return sendDebugMessage("[MmmmmJokers] DEBUG: " .. elem)
    end
end

-- Faster way to write non-BP/retrigger check
function no_bp_retrigger(context)
    if not context then return false end
    return not (context.blueprint or context.retrigger_joker or context.retrigger_joker_check)
end

--- Counts how many Carcinization there is
function get_cultist_count()
    local cultist_count = 0
    if G.jokers and G.jokers.cards then
        if #G.jokers.cards > 0 then
            for i = 1, #G.jokers.cards do
                if G.jokers.cards[i].config.center.key == "j_mxfj_cultist" and not G.jokers.cards[i].debuff then
                    cultist_count = cultist_count + 1
                end
            end
        end
    end
    return cultist_count
end

-- Modifies Edition Values
-- This doesn't work with modded editions yet. I tested this with Phanta's Waxed edition.
local base_calculate_edition = Card.calculate_edition
function Card.calculate_edition(self, context)
    local ret = base_calculate_edition(self, context)
    if not ret then return end
    local multiplier = 1
    if next(SMODS.find_card('j_mxfj_dungeon_jester')) then
        multiplier = 2 ^ #SMODS.find_card('j_mxfj_dungeon_jester')
    end
    -- Mult
    if ret.x_mult then ret.x_mult = ret.x_mult * multiplier end
    if ret.h_mult then ret.h_mult = ret.h_mult * multiplier end
    if ret.mult then ret.mult = ret.mult * multiplier end

    -- Message overrides
    if ret.x_mult_mod then
        ret.x_mult = ret.x_mult_mod * multiplier
        ret.Xmult_mod = 0
        ret.message = nil
    end
    if ret.mult_mod then
        ret.mult = ret.mult_mod * multiplier
        ret.mult_mod = 0
        ret.message = nil
    end

    -- Chips
    if ret.chips then ret.chips = ret.chips * multiplier end

    -- Message overrides
    if ret.chip_mod then
        ret.chips = ret.chip_mod * multiplier
        ret.chip_mod = 0
        ret.message = nil
    end
    return ret
end

--- Talisman compat
to_big = to_big or function(num)
    return num
end

to_number = to_number or function(num)
    return num
end