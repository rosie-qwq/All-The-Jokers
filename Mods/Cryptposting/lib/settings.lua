-- everything seems to work but nothing is saved upon reload :(

--[[
-- initialize cryptposting_config if it don't exist
cryptposting_config = cryptposting_config or {}

-- config tab
local function cryptpostingConfigTab()
    local crp_nodes = {}

    -- http toggle
    crp_nodes[#crp_nodes + 1] = create_toggle({
        label = "HTTP Module",
        active_colour = G.C.DARK_EDITION,
        ref_table = cryptposting_config,
        ref_value = "HTTPS",
    })

    return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            minh = 6,
            r = 0.1,
            minw = 10,
            align = "cm",
            padding = 0.2,
            colour = G.C.BLACK,
        },
        nodes = crp_nodes,
    }
end

-- music tab
local function cryptpostingMusicTab()
    return {
        label = "Music",
        tab_definition_function = function()
            local crp_nodes = {}

            -- music toggles
            local settings = { n = G.UIT.C, config = { align = "tl", padding = 0.05 }, nodes = {} }
            
            -- all toggle
            settings.nodes[#settings.nodes + 1] = create_toggle({
                label = "All Music (All Powerful - ottermatter)",
                active_colour = G.C.DARK_EDITION,
                ref_table = cryptposting_config,
                ref_value = "music_all",
            })
            
            -- mythic toggle
            settings.nodes[#settings.nodes + 1] = create_toggle({
                label = "Mythic+ Music (Joker in Ascension - ottermatter)",
                active_colour = G.C.DARK_EDITION,
                ref_table = cryptposting_config,
                ref_value = "music_mythic",
            })

            local config = { n = G.UIT.R, config = { align = "tm", padding = 0 }, nodes = { settings } }
            crp_nodes[#crp_nodes + 1] = config

            return {
                n = G.UIT.ROOT,
                config = {
                    emboss = 0.05,
                    minh = 6,
                    r = 0.1,
                    minw = 10,
                    align = "cm",
                    padding = 0.2,
                    colour = G.C.BLACK,
                },
                nodes = crp_nodes,
            }
        end,
    }
end

-- config tab loader
SMODS.current_mod.config_tab = cryptpostingConfigTab

-- music tab load
SMODS.current_mod.extra_tabs = cryptpostingMusicTab
]]--