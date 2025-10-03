return {
 SMODS.PokerHand {
    key = 'pale',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'D_A',    true },
        { 'D_5',    true },
        { 'D_4',    true },
        { 'D_J',    true },
        { 'D_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Moirail',
            description = {
              "5 Diamond cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Moirail" then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Diamonds')
            end
            if royal then return {_flosh} end
        end
    end,
  },
    
}