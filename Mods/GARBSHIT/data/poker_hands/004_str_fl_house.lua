return {
 SMODS.PokerHand {
    key = 'str_fl_house',
    chips = 200,
    mult = 18,
    l_chips = 60,
    l_mult = 5,
    example = {
        { 'S_A', true, "m_garb_jump" },
        { 'S_A', true, "m_garb_jump" },
        { 'S_A', true, "m_garb_jump" },
        { 'S_K', true, "m_garb_jump" },
        { 'S_K', true, "m_garb_jump" },
    },
    loc_txt = {
            name = 'Flush House Straight',
            description = {
              "Flush House + Straight",
              "(Requires Jump Cards)"
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._3) and next(parts._2) and next(parts._straight) and next(parts._flush) then
            if #parts._3 < 1 or #parts._2 < 2 then return {} end
            return parts._all_pairs
        end
    end,
  },

  }