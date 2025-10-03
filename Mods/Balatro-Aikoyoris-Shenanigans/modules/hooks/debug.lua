-- this file focuses on hooks i used to debug

local debugKeysNShit = Controller.key_press_update
function Controller:key_press_update(key, dt)
    local c = debugKeysNShit(self, key, dt)
    local _card = self.hovering.target
    if not _RELEASE_MODE and _card then
        if key == ',' then
            if _card.playing_card then
                _card:set_letters(AKYRS.alphabet_delta(_card.ability.aikoyori_letters_stickers, -1))
            end
        end
        if key == '.' then
            if _card.playing_card then
                _card:set_letters(AKYRS.alphabet_delta(_card.ability.aikoyori_letters_stickers, 1))
            end
        end
        if key == ";" then
            if (_card and _card.ability) then
                _card.ability.akyrs_self_destructs = not not not _card.ability.akyrs_self_destructs
            end
        end
    end
    return c
end
