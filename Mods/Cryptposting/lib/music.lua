SMODS.Sound({
    key = "music_all",
    path = "music_all.ogg",
    select_music_track = function()
        --[[
        -- check if the music_all setting is enabled
        if not (cryptposting_config and cryptposting_config.music_all) then
            return false
        end
        ]]--
        local count = #Cryptid.advanced_find_joker(nil, "crp_all", nil, nil, true)
        if count ~= 0 then
            return 1.7e308
        --[[
        else
            return false
        ]]--
        end
    end,
})

SMODS.Sound({
    key = "music_mythic",
    path = "music_mythic.ogg",
    volume = 1.5,
    select_music_track = function()
        -- check if the music_mythic setting is enabled
        --[[
        if not (cryptposting_config and cryptposting_config.music_mythic) then
            return false
        end
        ]]--
        if (#Cryptid.advanced_find_joker(nil, "crp_mythic", nil, nil, true)
        or #Cryptid.advanced_find_joker(nil, "crp_exomythic", nil, nil, true)
        or #Cryptid.advanced_find_joker(nil, "crp_2exomythic4me", nil, nil, true)
        or #Cryptid.advanced_find_joker(nil, "crp_22exomythic4mecipe", nil, nil, true)
        or #Cryptid.advanced_find_joker(nil, "crp_exomythicepicawesomeuncommon2mexotic22exomythic4mecipe", nil, nil, true)) ~= 0 then
            return 1e308
        --[[
        else
            return false
        ]]--
        end
    end,
})

-- hook into the music_exotic select_music_track function thing to add more of cryptposting's rarities
local original_select_music_track = SMODS.Sounds.cry_music_exotic.select_music_track
SMODS.Sounds.cry_music_exotic.select_music_track = function()
    return (original_select_music_track and original_select_music_track())
        or #Cryptid.advanced_find_joker(nil, "crp_exotic_2", nil, nil, true) ~= 0
end