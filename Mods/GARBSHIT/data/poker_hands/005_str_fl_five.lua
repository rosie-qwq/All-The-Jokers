return {
 SMODS.PokerHand {
    key = 'str_fl_five',
    chips = 240,
    mult = 20,
    l_chips = 70,
    l_mult = 4,
    example = {
        { 'S_A', true, "m_garb_jump" },
        { 'S_A', true, "m_garb_jump" },
        { 'S_A', true, "m_garb_jump" },
        { 'S_A', true, "m_garb_jump" },
        { 'S_A', true, "m_garb_jump" },
    },
    loc_txt = {
            name = 'Flush Five Straight',
            description = {
              "Flush Five + Straight",
              "(Requires Jump Cards)"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._5) and next(parts._flush) and next(parts._straight) then
            check_for_unlock({ type = "str_flush_five" })
            return {hand}
        end
    end,
  },



-- SHIPPING WALL 

}