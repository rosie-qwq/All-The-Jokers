SMODS.Sound {
    key = "gerson_laugh",
    path = "gerson_sfx.ogg"
}
SMODS.Sound {
    key = "prophecy_music",
    path = "Creo_Prophecy.ogg",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Prophecy"] then
            for _, joker in ipairs(G.jokers.cards) do
                if joker.ability.mul_transmutable then
                    return 2
                end
            end
        end
    end,
    sync = false,
    volume = 0.6,
    pitch = 1
}
SMODS.Sound {
    key = "pigstep_music",
    path = "LenaRaine_Pigstep.ogg",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Pigstep"] then
            if next(SMODS.find_card("j_mul_steve")) then
                return 3
            end
        end
    end,
    sync = false,
    volume = 0.6,
    pitch = 1
}
SMODS.Sound {
    key = "lifewillchange_music",
    path = "P5_LifeWillChange.ogg",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Life Will Change"] then
            if next(SMODS.find_card("j_mul_ren_amamiya")) then
                return 3
            end
        end
    end,
    sync = false,
    volume = 0.6,
    pitch = 1
}
SMODS.Sound {
    key = "hammerofjustice_music",
    path = "TobyFox_HammerOfJustice.ogg",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Hammer of Justice"] then
            if next(SMODS.find_card("j_mul_gerson")) then
                return 3
            end
        end
    end,
    sync = false,
    volume = 0.7,
    pitch = 1
}
SMODS.Sound {
    key = "presage_music",
    path = "MIRAR_Presage.ogg",
    select_music_track = function(self)
        if G.GAME and G.GAME.round_resets.ante >= 8 then
            return 1
        end
    end,
    sync = false,
    volume = 0.5,
    pitch = 1
}
SMODS.Sound {
    key = "deltarune_explosion",
    path = "deltarune_explosion.ogg"
}
SMODS.Sound {
    key = "sneaky_snitch_music",
    path = "KevinMacleod_SneakySnitch.ogg",
    select_music_track = function(self)
        if G.jokers and Multiverse.config.music["Sneaky Snitch"] then
            if next(SMODS.find_card("j_mul_waldo")) then
                return 3
            end
        end
    end,
    sync = false,
    volume = 0.7,
    pitch = 1
}
SMODS.Sound {
    key = "isolation_limbo",
    path = "NightHawk22_Isolation(LimboKeys).ogg"
}
SMODS.Sound {
    key = "silent_music",
    path = "silence.ogg",
    select_music_track = function(self)
        if Multiverse.all_videos["bad_apple"].is_visible then
            return 69420
        end
    end,
    sync = false,
    volume = 0,
}
SMODS.Sound {
    key = "take_damage",
    path = "snd_hurt1.ogg"
}
SMODS.Sound {
    key = "block_spear",
    path = "snd_tempbell.ogg"
}
SMODS.Sound {
    key = "BAATH_music",
    path = "TobyFox_BAATH.ogg",
    select_music_track = function(self)
        if G.GAME.blind and G.GAME.blind.config.blind.key == "bl_mul_undying" and Multiverse.config.music["Battle Against a True Hero"] then
            return 4
        end
    end,
    sync = false,
    volume = 0.7,
    pitch = 1,
}