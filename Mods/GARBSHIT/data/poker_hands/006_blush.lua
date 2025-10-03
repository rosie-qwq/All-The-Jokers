return {
 SMODS.PokerHand {
    key = 'blush',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'H_A',    true },
        { 'H_5',    true },
        { 'H_4',    true },
        { 'H_J',    true },
        { 'H_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Matesprit',
            description = {
              "5 Heart cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Matesprit" then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Hearts')
            end
            if royal then return {_flosh} end
        end
    end,
  },
  
  }