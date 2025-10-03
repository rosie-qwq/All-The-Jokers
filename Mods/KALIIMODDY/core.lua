--- STEAMODDED HEADER
--- MOD_NAME: kaliimoddy
--- MOD_ID: kaliimoddy
--- MOD_AUTHOR: [kaliicappy]
--- MOD_DESCRIPTION: follow @kaliicappy on twitter
--- PREFIX: kali
-----------------------------------------------
-------------mod code-------------------------
-- shoutouts cryptid & mathisfun --

if not kaliimoddy then
	kaliimoddy = {}
end
local global = {}

-- code borrowed (& modified) from NeatoJokers by LauraOnline and Yahimod by Yahiamice!!

SMODS.current_mod.description_loc_vars = function()
	return { background_colour = G.C.CLEAR, text_colour = G.C.WHITE, scale = 1.4, shadow = true }
end


local creditspage = {
        "kaliicappy",
        "(mod author, 99% of the work)",
		"",
        "kaliicappy, alfdefolf",
        "Art assets",
		"",
		"kaliicappy, yahiamice, nh6574, the Balatro Discord",
        "Code contributions",
    }

SMODS.current_mod.extra_tabs = function() --Credits tab
    local scale = 0.5
    return {
        label = "Credits",
        tab_definition_function = function()
        return {
            n = G.UIT.ROOT,
            config = {
            align = "cm",
            padding = 0.05,
            colour = G.C.CLEAR,
            },
            nodes = {
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "By kaliicappy",
                    shadow = false,
                    scale = scale*2,
                    colour = G.C.PURPLE
                    }
                }
                }
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Some art assets by",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                },
                }
            },
            {
                n = G.UIT.R,
                config = {
                    padding = 0,
                    align = "cm"
                },
                nodes = {
                    {
                    n = G.UIT.T,
                    config = {
                        text = "kaliicappy, alfdefolf",
                        shadow = false,
                        scale = scale,
                        colour = G.C.MONEY
                    }
                    },
                }
                },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Code contributions by",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                }
                },
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "kaliicappy, yahiamice, nh6574, the Balatro Discord",
                    shadow = false,
                    scale = scale,
                    colour = G.C.GREEN
                    }
                }
                } 
            },
			{
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "Special thanks:",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.INACTIVE
                    }
                }
                } 
            },
            {
                n = G.UIT.R,
                config = {
                padding = 0,
                align = "cm"
                },
                nodes = {
                {
                    n = G.UIT.T,
                    config = {
                    text = "The Balatro Discord Server, Deez Nation Discord Server, all my followers",
                    shadow = false,
                    scale = scale*0.66,
                    colour = G.C.BLUE
                    }
                }
                } 
            }
            }
        }
        end
    }
end


G.FUNCS.go_to_kali_twitter = function(e)
    love.system.openURL("https://x.com/kaliicappy")
end

G.C.KALIPURPLE = HEX("6823de")
G.C.KALIBLUE = HEX("9ac9ed")
G.C.mid_flash = 0
G.C.vort_time = 7
G.C.vort_speed = 0.4

-- from cryptid :}
local oldfunc = Game.main_menu
Game.main_menu = function(change_context)
	local ret = oldfunc(change_context)
	G.SPLASH_BACK:define_draw_steps({
			{
				shader = "splash",
				send = {
					{ name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
           			{name = 'vort_speed', val = G.C.vort_speed},
            		{name = 'colour_1', ref_table = G.C, ref_value = 'KALIPURPLE'},
            		{name = 'colour_2', ref_table = G.C, ref_value = 'KALIBLUE'},
            		{name = 'mid_flash', ref_table = G.C, ref_value = 'mid_flash'},
				},
			},
		})
	return ret
end


local mod_path = "" .. SMODS.current_mod.path
kaliimoddy.path = mod_path
kaliimoddy_config = SMODS.current_mod.config

SMODS.current_mod.optional_features = {
    retrigger_joker = true,
	post_trigger = true,
}

-- effect manager for particles etc

G.effectmanager = {}

--Load item files
local files = NFS.getDirectoryItems(mod_path .. "items")
for _, file in ipairs(files) do
	print("[KALIIMODDY] Loading lua file " .. file)
	local f, err = SMODS.load_file("items/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load lib files
local files = NFS.getDirectoryItems(mod_path .. "libs/")
for _, file in ipairs(files) do
	print("[KALIIMODDY] Loading lib file " .. file)
	local f, err = SMODS.load_file("libs/" .. file)
	if err then
		error(err) 
	end
	f()
end

--Load Localization file
local files = NFS.getDirectoryItems(mod_path .. "localization")
for _, file in ipairs(files) do
	print("[KALIIMODDY] Loading localization file " .. file)
	local f, err = SMODS.load_file("localization/" .. file)
	if err then
		error(err) 
	end
	f()
end