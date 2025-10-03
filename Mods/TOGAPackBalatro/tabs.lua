togabalatro.config_tab = function()
	return {n = G.UIT.ROOT, config = {align = "cl", outline = 0.5, outline_colour = HEX('C3C3C3'), padding = 0.025, colour = G.C.UI.BACKGROUND_INACTIVE, minw = 7, minh = 2}, nodes = {
		{n = G.UIT.R, config = {align = "cl", outline = 0.35, outline_colour = HEX('C3C3C3'), colour = HEX('000082')}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
				{n = G.UIT.O, config = { w = 0.75, h = 0.75, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 0, y = 0 }) } },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_configtab'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0 }, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "SFXWhenAdding" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_sfxwhenadd'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "SFXWhenRemoving" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_sfxwhendel'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "SFXWhenTriggered" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_sfxwhenuse'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "StartUpSound" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_startupsfx'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "DoCrashSFX" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_crashsfxuse'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "EnableQE" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_qestuff'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "UseNerfed" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_usenerfedver'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_jokeactive'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				create_option_cycle({w = 1.8, colour = HEX('808080'), scale = 0.85, options = {localize('toga_itemon'), localize('toga_itemoff')}, opt_callback = 'togabalatro_jokeitems', current_option = togabalatro.config.JokeJokersActive and 1 or 2}),
			}},
		}},
		{n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_strongstate'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				create_option_cycle({w = 1.8, colour = HEX('808080'), scale = 0.85, options = {localize('toga_itemon'), localize('toga_itemoff')}, opt_callback = 'togabalatro_poweritems', current_option = togabalatro.config.ShowPower and 1 or 2}),
			}},
		}},
	}}
end

togabalatro.extra_tabs = function()
	return {
		{ label = 'Logging', tab_definition_function = togabalatro.tabs[1] },
		{ label = 'Misc. Audio', tab_definition_function = togabalatro.tabs[2] },
	}
end

togabalatro.logging_tab = function()
	return {n = G.UIT.ROOT, config = {align = "cl", outline = 0.65, outline_colour = HEX('C3C3C3'), padding = 0.025, colour = G.C.UI.BACKGROUND_INACTIVE, minw = 7, minh = 2}, nodes = {
		{n = G.UIT.R, config = {align = "cl", outline = 0.35, outline_colour = HEX('C3C3C3'), colour = HEX('000082')}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
				{n = G.UIT.O, config = { w = 0.75, h = 0.75, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 2, y = 0 }) } },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_logtab'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0 }, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "DoMoreLogging" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_verboselog'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0 }, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "DoEvenMoreLogging" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_extraverboselog'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cm", padding = 0, outline = 0.5, outline_colour = HEX('491A19'), colour = HEX('7A2D29')}, nodes = {
			{n = G.UIT.C, config = { align = "cm", padding = 0}, nodes = {
				{n = G.UIT.O, config = { w = 0.66, h = 0.66, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 1, y = 0 }) } },
			}},
			{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_extraverboselogwarn'), scale = 0.35, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
	}}
end

togabalatro.startupsfx_tab = function()
	return {n = G.UIT.ROOT, config = {align = "cl", outline = 0.65, outline_colour = HEX('C3C3C3'), padding = 0.025, colour = G.C.UI.BACKGROUND_INACTIVE, minw = 7, minh = 2}, nodes = {
		{n = G.UIT.R, config = {align = "cl", outline = 0.35, outline_colour = HEX('C3C3C3'), colour = HEX('000082')}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = 0.05 }, nodes = {
				{n = G.UIT.O, config = { w = 0.75, h = 0.75, object = Sprite(36, 36, 36, 36, G.ASSET_ATLAS['toga_TOGAMoreIcons'], { x = 3, y = 0 }) } },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_startsfxtab'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "UseCustomMMMusic" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_mainmenumusicswap'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "UseCustomModTabMusic" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_modtabmusicswap'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "BoosterPackMusic" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_musicpacks'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config, ref_value = "StartUpSound" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_startupsfx'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cl", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cl", padding = -0.25 }, nodes = {
				create_toggle{ col = true, label = "", scale = 0.85, w = 0.15, shadow = true, ref_table = togabalatro.config.StartUpSFX, ref_value = "UseSelected" },
			}},
			{n = G.UIT.C, config = { align = "cl", padding = 0.2 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_startupsfxuse'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
		}},
		{n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				create_option_cycle({w = 3.5, colour = HEX('808080'), scale = 1, options = togabalatro.startupsfx, opt_callback = 'togabalatro_startupsfx', current_option = togabalatro.config.StartUpSFX and togabalatro.config.StartUpSFX.Selected or 1}),
			}},
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				UIBox_button({label = {localize('toga_startupsfxtest')}, button = "togabalatro_playsfx", minw = 1.3})
			}},
		}},
		{n = G.UIT.R, config = {align = "cm", padding = 0}, nodes = {
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				{n = G.UIT.T, config = { text = localize('toga_sfxswaptext'), scale = 0.5, colour = G.C.UI.TEXT_LIGHT }},
			}},
			{n = G.UIT.C, config = { align = "cm", padding = 0 }, nodes = {
				create_option_cycle({w = 2.2, colour = HEX('808080'), scale = 1, options = {localize('toga_sfxswapnone'), localize('toga_sfxswapdefault'), localize('toga_sfxswapall')}, opt_callback = 'togabalatro_sfxswapcfg', current_option = togabalatro.config.SFXSwapLevel or 2}),
			}},
		}},
	}}
end

togabalatro.tabs = { togabalatro.logging_tab, togabalatro.startupsfx_tab }