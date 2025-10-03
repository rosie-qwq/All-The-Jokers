local backInfo = {
    key = "ju_fossil",
    atlas = 'ThemedJokersRetriggered_backs',
    pos = { x = 1, y = 0 },
    unlocked = true,
    discovered = true,
    config = {jokers={'j_tjr_ju_dinosauregg'}, consumables={'c_tjr_ju_amber'} },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()  
                for i=1, 10 do
                    local _card = pseudorandom_element(G.playing_cards, pseudoseed('jurassic'))
                    if _card then
                        _card:set_ability('m_stone', nil, true)         
                    end
                end
                return true
            end
        }))
    end
}

return backInfo