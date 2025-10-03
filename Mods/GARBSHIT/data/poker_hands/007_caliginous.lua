return {
 SMODS.PokerHand {
    key = 'caliginous',
    chips = 50,
    mult = 6,
    l_chips = 40,
    l_mult = 3,
    example = {
        { 'S_A',    true },
        { 'S_5',    true },
        { 'S_4',    true },
        { 'S_J',    true },
        { 'S_3',    true },
    },
    loc_txt = {
        ['en-us'] = {
            name = 'Kismesis',
            description = {
              "5 Spade cards"
            }
        }
    },
    visible = false,
    evaluate = function(parts, hand)
        if next(parts._flush) and next(find_joker("j_garb_shipping")) and SHIPPINGWALL_HAND == "Kismesis" then
            local royal = true
            local _flosh = SMODS.merge_lists(parts._flush)
            for j = 1, #_flosh do
                royal = royal and _flosh[j]:is_suit('Spades')
            end
            if royal then return {_flosh} end
        end
    end,
  },
  
  }