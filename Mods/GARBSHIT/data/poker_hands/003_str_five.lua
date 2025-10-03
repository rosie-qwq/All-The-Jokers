return {
 SMODS.PokerHand {
    key = 'str_five',
    chips = 145,
    mult = 16,
    l_chips = 50,
    l_mult = 4,
    example = {
        { 'S_A', true, "m_garb_jump" },
        { 'D_A', true, "m_garb_jump" },
        { 'H_A', true, "m_garb_jump" },
        { 'C_A', true, "m_garb_jump" },
        { 'H_A', true, "m_garb_jump" },
    },
    loc_txt = {
            name = 'Straight Five',
            description = {
              "5 of a Kind + Straight",
              "(Requires Jump Cards)"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._5) and next(parts._straight) then
            return {hand}
        end
    end,
  },


  }