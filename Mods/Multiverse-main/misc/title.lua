-- Do main menu stuff here
-- Yoinked from Maximus (Thanks Astra)
local main_menu_hook = Game.main_menu
function Game.main_menu(change_context)
    local ret = main_menu_hook(change_context)
    G.SPLASH_MULTIVERSE_LOGO = Sprite(
        0, 0,
        6,
        6 * G.ASSET_ATLAS["mul_mod_logo"].py / G.ASSET_ATLAS["mul_mod_logo"].px,
        G.ASSET_ATLAS["mul_mod_logo"],
        { x = 0, y = 0 }
    )
    G.SPLASH_MULTIVERSE_LOGO:set_alignment({
        major = G.title_top,
        type = "cm",
        bond = "Strong",
        offset = { x = 0, y = 3.75 }
    })
    G.SPLASH_MULTIVERSE_LOGO.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }
    G.SPLASH_MULTIVERSE_LOGO.states.collide.can = true
    G.SPLASH_MULTIVERSE_LOGO.dissolve = 1
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = change_context == 'splash' and 3.6 or change_context == 'game' and 4 or 1,
        blockable = false,
        blocking = false,
        func = (function()
            play_sound('whoosh1', 0.2, 0.8)
            G.SPLASH_MULTIVERSE_LOGO:juice_up(0.1,0.1)
            G.VIBRATION = G.VIBRATION + 1.5
            return true
        end)
    }))
    function G.SPLASH_MULTIVERSE_LOGO:click()
        play_sound('button', 1, 0.3)
        G.FUNCS['openModUI_Multiverse']()
    end
    function G.SPLASH_MULTIVERSE_LOGO:hover()
        G.SPLASH_MULTIVERSE_LOGO:juice_up(0.05,0.05)
        Node.hover(self)
    end
    function G.SPLASH_MULTIVERSE_LOGO:stop_hover()
        Node.stop_hover(self)
    end
    return ret
end

SMODS.Atlas {
    key = "mod_logo",
    px = 575,
    py = 250,
    path = "multiverse_logo.png"
}
