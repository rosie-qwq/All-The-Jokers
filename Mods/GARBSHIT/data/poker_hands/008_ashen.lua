return {
 SMODS.PokerHand {
    key = 'ashen',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'C_A',    true },
        { 'C_5',    true },
        { 'C_4',    true },
        { 'C_J',    true },
        { 'C_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Auspistice',
            description = {
              "5 Club cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Auspistice" then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Clubs')
            end
            if royal then return {_flosh} end
        end
    end,
  },
  
  }