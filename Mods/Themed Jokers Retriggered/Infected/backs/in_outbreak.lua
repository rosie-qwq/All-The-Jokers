local backInfo = {
    key = "in_outbreak",
    atlas = 'ThemedJokersRetriggered_backs',
    pos = { x = 2, y = 0 },
    unlocked = true,
    discovered = true,
    config = { consumables = {'c_tjr_in_blight'}, jokers = {'j_tjr_in_mutation'}},
    apply = function(self, back)
        G.E_MANAGER:add_event(Event({
            func = function()                
                for i=1, 5 do
                    local _card = pseudorandom_element(G.playing_cards, pseudoseed('infected'))
                    if _card then
                        _card:set_ability('m_tjr_infected', nil, true)         
                    end
                end
                return true
            end
        }))
    end
}

return backInfo