if G.FUNCS.njy_endround then            
    local notjustyetCanEndRoundHook = G.FUNCS.njy_can_endround
    G.FUNCS.njy_can_endround = function (e)
        local button_enabled = false
        if (G.GAME.current_round.advanced_blind) then 
            if G.GAME.aiko_puzzle_win then
                button_enabled = true
            end
        elseif G.GAME.akyrs_mathematics_enabled and G.GAME.akyrs_character_stickers_enabled then
            if G.GAME.blind and AKYRS.is_value_within_threshold(G.GAME.blind.chips,G.GAME.chips,G.GAME.akyrs_math_threshold) or AKYRS.does_hand_only_contain_symbols(G.hand) then
                button_enabled = true
            end

        else
            return notjustyetCanEndRoundHook(e)
        end
        if button_enabled then
            e.config.colour = G.C[G.njy_colour]
            e.config.button = 'njy_attempt_endround'
        else
            e.config.colour = G.C.UI.BACKGROUND_INACTIVE
            e.config.button = nil
        end
    end

end
