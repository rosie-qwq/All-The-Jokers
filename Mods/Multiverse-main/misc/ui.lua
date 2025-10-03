function Multiverse.create_custom_toggle(args)
    args = args or {}
    args.active_colour = args.active_colour or G.C.RED
    args.inactive_colour = args.inactive_colour or G.C.BLACK
    args.w = args.w or 3
    args.h = args.h or 0.5
    args.scale = args.scale or 1
    args.label = args.label or 'NONE'
    args.label_scale = args.label_scale or 0.4
    args.ref_table = args.ref_table or {}
    args.ref_value = args.ref_value or 'NONE'

    local check = Sprite(0, 0, 0.5 * args.scale, 0.5 * args.scale, G.ASSET_ATLAS["icons"], { x = 1, y = 0 })
    check.states.drag.can = false
    check.states.visible = false

    local info = nil
    if args.info then
        info = {}
        for k, v in ipairs(args.info) do
            table.insert(info, {
                n = G.UIT.R,
                config = { align = "cm", minh = 0.05 },
                nodes = {
                    { n = G.UIT.T, config = { text = v, scale = 0.25, colour = G.C.UI.TEXT_LIGHT } }
                }
            })
        end
        info = { n = G.UIT.R, config = { align = "cm", minh = 0.05 }, nodes = info }
    end
    local t =
    {
        n = args.col and G.UIT.C or G.UIT.R,
        config = { align = "cm", padding = 0.1, r = 0.1, colour = G.C.CLEAR, focus_args = { funnel_from = true } },
        nodes = {
            args.label ~= "" and {
                n = G.UIT.C,
                config = { align = "cr", minw = args.w },
                nodes = {
                    { n = G.UIT.T, config = { text = args.label, scale = args.label_scale, colour = G.C.UI.TEXT_LIGHT } },
                    (args.spacer and { n = G.UIT.B, config = { w = 0.1, h = 0.1 } }) or nil,
                }
            } or nil,
            {
                n = G.UIT.C,
                config = { align = "cl", minw = 0.3 * args.w },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "cm", r = 0.1, colour = G.C.BLACK },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = {
                                    align = "cm",
                                    r = 0.1,
                                    padding = 0.03,
                                    minw = 0.4 * args.scale,
                                    minh = 0.4 * args.scale,
                                    outline_colour = args.outline_colour or G.C.WHITE,
                                    outline = 1.2 * args.scale,
                                    line_emboss = 0.5 * args.scale,
                                    ref_table = args,
                                    colour = args.inactive_colour,
                                    button = 'toggle_button',
                                    button_dist = 0.2,
                                    hover = true,
                                    toggle_callback = args.callback,
                                    func = 'toggle',
                                    focus_args = { funnel_to = true }
                                },
                                nodes = {
                                    { n = G.UIT.O, config = { object = check } },
                                }
                            },
                        }
                    }
                }
            },
        }
    }
    if args.info then
        t = {
            n = args.col and G.UIT.C or G.UIT.R,
            config = { align = "cm" },
            nodes = {
                t,
                info,
            }
        }
    end
    return t
end

---@param song string
---@param credit string
function Multiverse.music_toggle(song, credit)
    local toggle = Multiverse.create_custom_toggle({
        label = "",
        active_colour = Multiverse.TRANSMUTED_GRADIENT,
        ref_table = Multiverse.config.music,
        ref_value = song,
        w = 0,
        h = 0
    })
    return { -- 1
        n = G.UIT.C,
        config = { align = "cm", padding = 0.1 },
        nodes = {
            { -- 2
                n = G.UIT.R,
                config = {
                    align = "cm",
                    colour = Multiverse.config.music[song] and G.C.GREEN or G.C.RED,
                    padding = 0.1,
                    r = 0.1,
                    func = "mul_update_music_toggle",
                    song_data = song
                },
                nodes = { -- nesting +3
                    {
                        n = G.UIT.C,
                        config = {
                            align = "cm",
                            padding = 0.1,
                            colour = G.C.WHITE,
                            r = 0.1,
                            emboss = 0.05,
                            tooltip = {
                                text = localize("mul_" .. song),
                                colour = Multiverse.config.music[song] and G.C.GREEN or G.C.RED,
                            }
                        },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "cl" },
                                nodes = {
                                    {
                                        n = G.UIT.O,
                                        config = {
                                            object = DynaText({
                                                string = song,
                                                colours = { G.C.UI.TEXT_DARK },
                                                shadow = true,
                                                scale = 0.4,
                                                float = true
                                            })
                                        }
                                    }
                                }
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "cl" },
                                nodes = {
                                    {
                                        n = G.UIT.O,
                                        config = {
                                            object = DynaText({
                                                string = credit,
                                                colours = { G.C.UI.TEXT_INACTIVE },
                                                scale = 0.3,
                                            })
                                        }
                                    }
                                }
                            },
                        }
                    },
                    { -- index 2
                        n = G.UIT.C,
                        config = { align = "cl" },
                        nodes = { -- 1 more nest at index 1
                            toggle
                        }
                    }
                }
            }
        }
    }
end

Multiverse.music_credits = {
    {                       -- page
        {                   -- row
            {               -- song
                "Prophecy", -- title
                "Creo"      -- source
            },
            {
                "Life Will Change",
                "Persona 5 OST"
            },
            {
                "Pigstep",
                "Minecraft OST"
            },
            {
                "Hammer of Justice",
                "Deltarune Chapter 4 OST"
            },
        },
        {
            {
                "Presage",
                "MIRAR"
            },
            {
                "Sneaky Snitch",
                "Kevin Macleod"
            },
            {
                "Battle Against a True Hero",
                "Undertale OST"
            }
        },
    },
}

function Multiverse.config_tab_definition()
    local mul_settings = {
        {
            n = G.UIT.R,
            config = { align = "cr" },
            nodes = {
                create_toggle({
                    label = localize("mul_debug"),
                    active_colour = Multiverse.TRANSMUTED_GRADIENT,
                    ref_table = Multiverse.config,
                    ref_value = "debug",
                })
            }
        },
        {
            n = G.UIT.R,
            config = { align = "cr" },
            nodes = {
                create_toggle({
                    label = localize("mul_joke"),
                    active_colour = Multiverse.TRANSMUTED_GRADIENT,
                    ref_table = Multiverse.config,
                    ref_value = "joke",
                })
            }
        }
    }
    local mul_nodes = {
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.1 },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = localize("mul_customization"),
                                    colours = { G.C.WHITE },
                                    scale = 0.4,
                                    shadow = true
                                })
                            }
                        }
                    }
                }
            }
        },
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.05 },
                    nodes = mul_settings
                }
            }
        },
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.05 },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = localize("mul_changes_warn"),
                                    colours = { G.C.IMPORTANT },
                                    scale = 0.4,
                                    shadow = true
                                })
                            }
                        }
                    }
                }
            }
        },
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.05 },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = localize("mul_changes_debug"),
                                    colours = { G.C.IMPORTANT },
                                    scale = 0.4,
                                    shadow = true
                                })
                            }
                        }
                    }
                }
            }
        },
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.05 },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = localize("mul_changes_pool1"),
                                    colours = { G.C.IMPORTANT },
                                    scale = 0.4,
                                    shadow = true
                                })
                            }
                        }
                    }
                }
            }
        },
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm", padding = 0.05 },
                    nodes = {
                        {
                            n = G.UIT.O,
                            config = {
                                object = DynaText({
                                    string = localize("mul_changes_pool2"),
                                    colours = { G.C.IMPORTANT },
                                    scale = 0.4,
                                    shadow = true
                                })
                            }
                        }
                    }
                }
            }
        },
    }
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", colour = G.C.BLACK, padding = 0.1 },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.1 },
                nodes = mul_nodes
            }
        }
    }
end

SMODS.current_mod.custom_ui = function(nodes)
    table.insert(nodes, {
        n = G.UIT.R,
        config = { align = "bm", padding = 0.05 },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    UIBox_button({
                        button = "mul_discord_invite",
                        label = { localize("b_mul_discord_server") },
                        minw = 4.75
                    })
                }
            },
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.05 },
                nodes = {
                    UIBox_button({
                        button = "mul_landing_page",
                        label = { localize("b_mul_landing_page") },
                        minw = 4.75
                    })
                }
            }
        }
    })
end

function G.FUNCS.mul_discord_invite(e)
    love.system.openURL("https://discord.gg/TTEU5K3XC5")
end

function G.FUNCS.mul_landing_page(e)
    love.system.openURL("https://thunderedge.carrd.co/")
end

function Multiverse.display_songs(page)
    rows = {}
    for _, row in ipairs(Multiverse.music_credits[page]) do
        local row_items = {}
        for _, item in ipairs(row) do
            table.insert(row_items, Multiverse.music_toggle(item[1], item[2]))
        end
        table.insert(rows, {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = row_items
        })
    end
    return {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm" },
                nodes = rows
            }
        }
    }
end

function Multiverse.music_tab_text()
    local n = {
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = localize("mul_music_customization1"),
                            colours = { G.C.WHITE },
                            shadow = true,
                            scale = 0.4
                        })
                    }
                }
            }
        },
        {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.O,
                    config = {
                        object = DynaText({
                            string = localize("mul_music_customization2"),
                            colours = { G.C.WHITE },
                            shadow = true,
                            scale = 0.4
                        })
                    }
                }
            }
        },
    }
    return n
end

function Multiverse.music_tab_definition(page)
    local mul_nodes = Multiverse.music_tab_text()
    table.insert(mul_nodes, Multiverse.display_songs(page))
    local pages = {}
    for i, _ in ipairs(Multiverse.music_credits) do
        table.insert(pages, localize("mul_page") .. string.format(" %s/%s", i, #Multiverse.music_credits))
    end
    table.insert(mul_nodes, {
        n = G.UIT.R,
        config = { align = "cm" },
        nodes = {
            {
                n = G.UIT.C,
                config = {},
                nodes = {
                    create_option_cycle({
                        options = pages,
                        current_option = page,
                        opt_callback = "mul_select_music_page"
                    })
                }
            }
        }
    })
    return {
        n = G.UIT.ROOT,
        config = { align = "cm", colour = G.C.BLACK, padding = 0.1 },
        nodes = {
            {
                n = G.UIT.C,
                config = { align = "cm", padding = 0.1 },
                nodes = mul_nodes
            }
        }
    }
end

function Multiverse.music_tab()
    return {
        n = G.UIT.ROOT,
        config = { colour = G.C.BLACK, align = "ct", r = 0.1, padding = 0.1, emboss = 0.05 },
        nodes = {
            {
                n = G.UIT.O,
                config = {
                    id = "mul_music_page",
                    object = UIBox({
                        definition = Multiverse.music_tab_definition(Multiverse.selected_music_page),
                        config = { type = "cm" }
                    })
                },
                align = "cm"
            }
        }
    }
end

function G.FUNCS.mul_update_music_toggle(e)
    e.config.colour = (e.config.song_data and Multiverse.config.music[e.config.song_data]) and G.C.GREEN or G.C.RED
    e.children[1].config.tooltip.colour = (e.config.song_data and Multiverse.config.music[e.config.song_data]) and
    G.C.GREEN or G.C.RED
end

-- Code is based on Handy's UI code
function G.FUNCS.mul_select_music_page(args)
    if not G.OVERLAY_MENU then return end
    Multiverse.selected_music_page = args.to_key
    local def = Multiverse.music_tab_definition(Multiverse.selected_music_page)
    local container = G.OVERLAY_MENU:get_UIE_by_ID("mul_music_page")
    if container then
        container.config.object:remove()
        container.config.object = UIBox({
            definition = def,
            config = { type = "cm", parent = container }
        })
        container.config.object:recalculate()
    end
end

SMODS.current_mod.config_tab = function()
    return {
        n = G.UIT.ROOT,
        config = {
            emboss = 0.05,
            r = 0.1,
            padding = 0.1,
            colour = G.C.BLACK
        },
        nodes = {
            {
                n = G.UIT.O,
                config = {
                    id = "mul_config_menu",
                    object = UIBox({
                        definition = Multiverse.config_tab_definition(),
                        config = { type = "cm" }
                    }),
                    align = "cm"
                }
            }
        }
    }
end

SMODS.current_mod.extra_tabs = function()
    return {
        {
            label = "Music",
            tab_definition_function = function()
                return Multiverse.music_tab()
            end
        }
    }
end
