return {
 SMODS.PokerHand {
    key = 'str_four',
    chips = 140,
    mult = 12,
    l_chips = 45,
    l_mult = 4,
    example = {
        { 'S_A', true, "m_garb_jump" },
        { 'D_A', true, "m_garb_jump" },
        { 'H_A', true, "m_garb_jump" },
        { 'C_A', true, "m_garb_jump" },
        { 'H_K', true, "m_garb_jump" },
    },
    loc_txt = {
            name = 'Straight Four',
            description = {
              "4 of a Kind + Straight",
              "(Requires Jump Cards)"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._4) and next(parts._straight) then
            return {hand}
        end
    end,
  },

    }