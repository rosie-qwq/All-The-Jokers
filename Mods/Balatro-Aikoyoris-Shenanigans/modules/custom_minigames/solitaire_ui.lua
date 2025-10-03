local solitaireCardAreaDrawHook = CardArea.draw
function CardArea:draw()
    local c = solitaireCardAreaDrawHook(self)
    
    if self == AKYRS.SOL.stockCardArea then

        if not self.children.redeal_iui then 
            self.children.redeal_iui = UIBox{
                definition = 
                    {n=G.UIT.ROOT, config = {align = 'cm', padding = 0.1, r =0.1, button = "akyrs_draw_from_waste_to_stock", colour = G.C.CLEAR}, nodes={
                        {n=G.UIT.R, config={align = "cm", padding = 0.2, r =0.1, colour = adjust_alpha(G.C.BLACK, 0.5),func = 'set_button_pip', focus_args = {button = 'rightshoulder', orientation = 'bm', scale = 0.6}, button = 'deck_info'}, nodes={
                            {n=G.UIT.R, config={align = "cm", maxw = 2}, nodes={
                                {n=G.UIT.T, config={text = localize('k_akyrs_solitaire_redeal'), scale = 0.48, colour = G.C.WHITE, shadow = true}}
                            }},
                        }},
                    }},
                config = { align = 'cm', offset = {x=0,y=0}, major = self , parent = self}
            }
            self.children.redeal_iui.states.collide.can = false
        end
        if #self.cards <= 0 then
            self.children.redeal_iui:draw()
        end
    end
    return c
end

AKYRS.SOL.get_UI_definition = function(params)
    if AKYRS.SOL.cardarea_initialized then
        AKYRS.SOL.reset_card_areas()

    end
    AKYRS.SOL.fill_stock_with_fresh_cards()
    params = params or {}
    local width = params.width or 8
    local height = params.height or 6
    
    return {
        n = G.UIT.ROOT, 
        config = {
            w = width, minh = height,
            r = 0.1,
            colour = G.C.UI.TRANSPARENT_DARK
        },
        nodes =                 {
            { -- top row with stock waste and foundation
                n = G.UIT.R, config = {
                    align = "tc",
                    h = 1,
                    w = width / 2,
                },
                nodes = {
                    {
                        n = G.UIT.C, -- deck and draw deck area
                        config = { maxh = 1, padding = 0.1 ,},
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = {},
                                nodes = {
                                    {
                                        n = G.UIT.C, 
                                        config = { align = "cm" },
                                        nodes = {
                                            { n = G.UIT.C, config = { align = "cm" }, nodes = { -- deck area
                                                { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('stock') }}
                                            }}
                                        }
                                    },
                                    {
                                        n = G.UIT.C, 
                                        config = { align = "cm" },
                                        nodes = {
                                            { n = G.UIT.C, config = { align = "cm" }, nodes = { -- deck draw area
                                                { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('waste') }}
                                            }}
                                        }
                                    },
                                }
                            }
                        }
                    },
                    {
                        n = G.UIT.B,
                        config = { w = 3, h = 1 },
                        nodes = {}
                    },
                    {
                        n = G.UIT.C, -- for the part where you move shit
                        config = { align = "r", maxh = 1, padding = 0.1 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = {padding = 0.1},
                                nodes = {
                                    {
                                        n = G.UIT.C, 
                                        config = { colour = G.C.UI.TRANSPARENT_DARK, r = 0.1},
                                        nodes = {
                                            { n = G.UIT.C, config = {  }, nodes = { -- these are for the thing
                                                { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('foundation1') }}
                                            }}
                                        }
                                    },
                                    {
                                        n = G.UIT.C, 
                                        config = { colour = G.C.UI.TRANSPARENT_DARK, r = 0.1},
                                        nodes = {
                                            { n = G.UIT.C, config = {  }, nodes = {
                                                { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('foundation2') }}
                                            }}
                                        }
                                    },
                                    {
                                        n = G.UIT.C, 
                                        config = { colour = G.C.UI.TRANSPARENT_DARK, r = 0.1},
                                        nodes = {
                                            { n = G.UIT.C, config = {  }, nodes = {
                                                { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('foundation3') }}
                                            }}
                                        }
                                    },
                                    {
                                        n = G.UIT.C, 
                                        config = { colour = G.C.UI.TRANSPARENT_DARK, r = 0.1},
                                        nodes = {
                                            { n = G.UIT.C, config = {  }, nodes = {
                                                { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('foundation4') }}
                                            }}
                                        }
                                    },
                                }
                            }
                        }
                    },
                }
            },            
            { -- bottom row with tableaus
                n = G.UIT.R, config = { w = width, padding = 0.2, minh = height - 1, align = "tm", },
                nodes = {
                    {
                        n = G.UIT.C, 
                        config = { align = "tm"},
                        nodes = {
                            { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('tableau1') } }
                        }
                    },
                    {
                        n = G.UIT.C, 
                        config = { align = "tm" },
                        nodes = {
                            { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('tableau2') } }
                        }
                    },
                    {
                        n = G.UIT.C, 
                        config = { align = "tm" },
                        nodes = {
                            { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('tableau3') } }
                        }
                    },
                    {
                        n = G.UIT.C, 
                        config = { align = "tm" },
                        nodes = {
                            { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('tableau4') } }
                        }
                    },
                    {
                        n = G.UIT.C, 
                        config = { align = "tm" },
                        nodes = {
                            { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('tableau5') } }
                        }
                    },
                    {
                        n = G.UIT.C, 
                        config = { align = "cm" },
                        nodes = {
                            { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('tableau6') } }
                        }
                    },
                    {
                        n = G.UIT.C, 
                        config = { align = "cm" },
                        nodes = {
                            { n = G.UIT.O, config = { object = AKYRS.SOL.initialize_card_area('tableau7') } }
                        }
                    },
                }
            },                    
        }
    }
end
