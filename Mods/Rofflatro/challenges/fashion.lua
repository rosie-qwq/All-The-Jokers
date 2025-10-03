SMODS.Challenge{
    key = 'fashion',
    rules = {
        custom = {
            {id = 'no_reward'},
            {id = 'no_interest'},
        },
    },
    jokers = {
        {id = 'j_roff_cat_ears', eternal = true, pinned = false},
        {id = 'j_trousers', eternal = false, pinned = false},
        {id = 'j_roff_black_shirt', eternal = true, pinned = false},
    },
    restrictions = {
        banned_cards = {
            {
                id = 'j_trousers'
            }
        }
    }
}
