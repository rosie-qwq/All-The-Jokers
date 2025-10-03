-- this file has ui hooks lol


local cardGetUIBoxRef = Card.generate_UIBox_ability_table

function Card:generate_UIBox_ability_table(vars)
    local ret = cardGetUIBoxRef(self,vars)
    if (G.GAME.akyrs_character_stickers_enabled or self.ability.forced_letter_render) and self.ability.aikoyori_letters_stickers then
        local letter = self.ability.aikoyori_letters_stickers

        if letter and letter == "#" then
            letter = "#"
        else
            if letter then
                letter = letter
            end
        end
        local loc_vars = {}
        if (letter) then
            loc_vars = {
                letter,
                (AKYRS.get_scrabble_score(self.ability.aikoyori_letters_stickers)),
                1 + (AKYRS.get_scrabble_score(self.ability.aikoyori_letters_stickers) / 10),
                self.ability.akyrs_word_freq
            }
        end
        
        local last_letter = string.lower(string.sub(letter, -1))
        local key = "letters"

        if(AKYRS.non_letter_symbols_reverse[last_letter] or last_letter == "#") then
            key = "symbols"
        end
        if(tonumber(last_letter)) then
            key = "numbers"
        end

        if self.is_null and (self.ability.set == "Enhanced" or self.ability.set == "Default") then
            --print(table_to_string(ret))
            local newRetTable = table.aiko_shallow_copy(ret)

            newRetTable.name = {}
            localize({
                type = 'name_text',
                key = 'aiko_x_akyrs_null',
                set = 'AikoyoriExtraBases',
                vars = { colours = { G.C.BLUE } },
                nodes =
                    newRetTable.name
            })
            newRetTable.name = newRetTable.name[1]
            newRetTable.main = AKYRS.deep_copy(ret.main)
            newRetTable.info = {}
            newRetTable.type = {}

            for i, v in ipairs(ret.info) do
                if i > 0 then
                    table.insert(newRetTable.info, v)
                end
            end
            if ((G.GAME.akyrs_character_stickers_enabled or self.ability.forced_letter_render) and letter) then
                generate_card_ui({ key = key, set = 'AikoyoriExtraBases', vars = loc_vars }, newRetTable)
            else
                generate_card_ui({ key = 'null_card', set = 'AikoyoriExtraBases', vars = loc_vars }, newRetTable)
            end
            if self.ability.set ~= 'Default' then
                for i, v in ipairs(ret.main) do
                    if i > 0 then
                        table.insert(newRetTable.main, v)
                    end
                end
                for i, v in ipairs(ret.type) do
                    if i > 0 then
                        table.insert(newRetTable.type, v)
                    end
                end
            else

            end


            ret = newRetTable
        else
            if ((G.GAME.akyrs_character_stickers_enabled or self.ability.forced_letter_render) and letter) then
                generate_card_ui({ key = key, set = 'AikoyoriExtraBases', vars = loc_vars }, ret)
            end
        end
    end
    return ret
end

local blindRemoveHook = Blind.remove
function Blind:remove()
    if not AKYRS.do_not_remove_blind then
        return blindRemoveHook and blindRemoveHook(self) or Moveable.remove(self)
    end
    
end

function recalculateBlindUI()
    if G.HUD_blind then
        AKYRS.do_not_remove_blind = true
        local conf = (G.HUD_blind.config)
        G.HUD_blind:remove()
        G.HUD_blind = UIBox{
            definition = create_UIBox_HUD_blind(),
            config = conf
        }
    
        --AKYRS.remove_all(G.HUD_blind.children,function(v) print("A") return v and v.config and (v.config.object ~= G.GAME.blind) end)
        --[[
        G.HUD_blind.UIRoot:remove()
        G.HUD_blind.definition = create_UIBox_HUD_blind()
        G.HUD_blind:set_parent_child(G.HUD_blind.definition, nil)

        ]]
        AKYRS.do_not_remove_blind = nil
        G.HUD_blind:recalculate()
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0,
          func = function()
            if G.SHOP_SIGN then
                G.SHOP_SIGN.alignment.offset.y = -15
            end
            return true
          end
        }))
        G.GAME.akyrs_ui_should_recalculate = nil
    end
end

local setBlindHook = Blind.set_blind
function Blind:set_blind(x, y, z)
    local abc = setBlindHook(self,x ,y,z)
    --if x then recalculateBlindUI() end
    
    return abc
end

function recalculateHUDUI()
    if G.HUD then
        ease_discard(0, true, true)
        G.HUD:recalculate()
    end
end

local easeDiscardHook = ease_discard
function ease_discard(mod, instant, silent)
    local discard_UI = G.HUD:get_UIE_by_ID('discard_UI_count')
    if discard_UI then
        if G.GAME.blind and G.GAME.blind.config and G.GAME.blind.config.blind and G.GAME.blind.config.blind.debuff and G.GAME.blind.config.blind.debuff.infinite_discards and not G.GAME.blind.disabled and not G.GAME.blind.disabled and not G.GAME.aiko_puzzle_win then
            G.GAME.current_round.aiko_infinite_hack = "∞"
            discard_UI.config.object.font = G.FONTS[8] -- thanks go noto core
            discard_UI.config.object.config.string[1].ref_value = "aiko_infinite_hack"
            --discard_UI.config.object.T.r = 1.57
            attention_text({
                text = localize("ph_akyrs_unknown"),
                scale = 0.8, 
                hold = 0.7,
                cover = discard_UI.parent,
                cover_colour = G.C.RED,
                align = 'cm',
            })
            --Play a chip sound
            if not silent then play_sound('chips2') end
            discard_UI.config.object:update_text(true)
        else
            discard_UI.config.object.config.string[1].ref_value = "discards_left"
            discard_UI.config.object.T.r = 0
            discard_UI.config.object.font = G.LANG.font
            local ret = easeDiscardHook(mod, instant, silent)
            return ret
        end
    end

end

local cardHoverHook = Card.hover
function Card:hover()
    AKYRS.current_hover_card = self
    local ret = cardHoverHook(self)
    return ret
end
local nodeHoverHook = Node.hover
function Node:hover()
    if AKYRS.should_hide_ui() then
        if self.config.h_popup then
            AKYRS.remove_objects_in_nodes(self.config.h_popup.nodes)
        end
        self.config.h_popup = nil
    end
    local ret = nodeHoverHook(self)
    return ret
end

local tagGenUI = Tag.generate_UI
function Tag:generate_UI(_sz)
    local x = {tagGenUI(self,_sz)}
    if AKYRS.should_hide_ui() then
        x[2].hover = function() end
    end
    return unpack(x)
end
local taghoverproxy = G.FUNCS.hover_tag_proxy
G.FUNCS.hover_tag_proxy = function(e)
    if not AKYRS.should_hide_ui() then
        taghoverproxy(e)
    end
end

local genCardUIHook = generate_card_ui
function generate_card_ui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    if AKYRS.should_hide_ui() then
        return {
            main = {},
            info = {},
            type = {},
            name = nil,
            badges = badges or {}
        }
    end
    return genCardUIHook(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
end

local uiboxspc = UIBox.set_parent_child

function UIBox:set_parent_child(node, parent)
    if node then
        return uiboxspc(self,node,parent)
    end

end

local cardStopHoverHook = Card.stop_hover
function Card:stop_hover()
    local ret = cardStopHoverHook(self)
    return ret
end

local chalUnlock = set_challenge_unlock
function set_challenge_unlock()
    local ret = chalUnlock()

    if G.PROFILES[G.SETTINGS.profile].all_unlocked then return end

    if not G.PROFILES[G.SETTINGS.profile].akyrs_hc_challenges_unlocked then
        if G.PROFILES[G.SETTINGS.profile].challenges_unlocked then
            local challenges_unlocked, challenge_alls = 0, #G.CHALLENGES
            for k, v in ipairs(G.CHALLENGES) do
                if v.id and G.PROFILES[G.SETTINGS.profile].challenge_progress.completed[v.id or ''] then
                    challenges_unlocked = challenges_unlocked + 1
                end
            end
            if (challenges_unlocked >= 1) then
                G.PROFILES[G.SETTINGS.profile].akyrs_hc_challenges_unlocked = true
                notify_alert('b_akyrs_hardcore_challenges', "Back")
            end
        end
    end
    return ret
end

G.FUNCS.akyrs_wildcard_check = function(e)
    G.FUNCS.set_button_pip(e)
    local colour = G.C.GREEN
    local button = nil
    if e.config.ref_table.ability.aikoyori_letters_stickers == "#" then
        button = 'akyrs_wildcard_open_wildcard_ui'
        if not e.config.ref_table.ability.aikoyori_pretend_letter then
            colour = AKYRS.config.wildcard_behaviour == 3 and SMODS.Gradients["akyrs_unset_letter"] or G.C.RED
        elseif e.config.ref_table.ability.aikoyori_pretend_letter == "#" then
            colour = G.C.YELLOW
        end
    else
        colour = G.C.UI.BACKGROUND_INACTIVE
        button = nil
    end
    e.config.button = button
    e.config.colour = colour
end

G.FUNCS.akyrs_wildcard_open_wildcard_ui = function(e)
    if e.config.ref_table.ability.aikoyori_letters_stickers == "#" then 
        --print("SUCCESS!")
        local card = e.config.ref_table
        G.FUNCS.overlay_menu{
            definition = AKYRS.UIDEF.wildcards_set_letter_ui(card)
        }
        --print(inspect(e.config.ref_table))
    else
        
    end
end


G.FUNCS.akyrs_wildcard_set_letter_wildcard = function(e)
    
    local card = e.config.ref_table.card
    card:flip()
    G.E_MANAGER:add_event(
        Event{
            trigger = "after",
            delay = AKYRS.get_speed_mult(card) * 0.5,
            func = function ()
                card.area:remove_from_highlighted(card, true)
                delay(AKYRS.get_speed_mult(card) * 0.5)
                card:flip()
                play_sound('card1')
                card:set_pretend_letters(e.config.ref_table.letter ~= "" and e.config.ref_table.letter or nil)
                return true
            end
        }
    )
    AKYRS.better_input_selected = nil
    G.FUNCS.exit_overlay_menu()
end

G.FUNCS.akyrs_wildcard_set_letter_wildcard_auto = function(e)
    
    local card = e.config.ref_table.card
    card:flip()
    G.E_MANAGER:add_event(
        Event{
            trigger = "after",
            delay = AKYRS.get_speed_mult(card) * 0.5,
            func = function ()
                card.area:remove_from_highlighted(card, true)
                delay(AKYRS.get_speed_mult(card) * 0.5)
                card:flip()
                play_sound('card1')
                card:set_pretend_letters("#")
                card:highlight(false)
                return true
            end
        }
    )
    card.area:remove_from_highlighted(card, true)
    AKYRS.better_input_selected = nil
    G.FUNCS.exit_overlay_menu()
end
    
G.FUNCS.akyrs_wildcard_unset_letter_wildcard = function(e)
    
    local card = e.config.ref_table.card
    card:flip()
    G.E_MANAGER:add_event(
        Event{
            trigger = "after",
            delay = AKYRS.get_speed_mult(card) * 0.5,
            func = function ()
                card.area:remove_from_highlighted(card, true)
                delay(AKYRS.get_speed_mult(card) * 0.5)
                card:flip()
                play_sound('card1')
                card:set_pretend_letters(nil)
                card:highlight(false)
                return true
            end
        }
    )
    AKYRS.better_input_selected = nil
    G.FUNCS.exit_overlay_menu()
end
G.FUNCS.akyrs_wildcard_switch_case_letter_wildcard = function(e)
    
    local card = e.config.ref_table.card
    card:flip()
    G.E_MANAGER:add_event(
        Event{
            trigger = "after",
            delay = AKYRS.get_speed_mult(card) * 0.5,
            func = function ()
                card.area:remove_from_highlighted(card, true)
                delay(AKYRS.get_speed_mult(card) * 0.5)
                card:flip()
                play_sound('card1')
                card:set_pretend_letters(AKYRS.swap_case(card.ability.aikoyori_pretend_letter))
                card:highlight(false)
                return true
            end
        }
    )
    AKYRS.better_input_selected = nil
    G.FUNCS.exit_overlay_menu()
end

G.FUNCS.akyrs_wildcard_quit_set_letter_wildcard_menu = function(e)
    AKYRS.better_input_selected = nil
    G.FUNCS.exit_overlay_menu()
end


function AKYRS.UIDEF.wildcards_set_letter_ui(card)
    local data = { letter = card.ability.aikoyori_pretend_letter or '', card = card }
    
    
    return create_UIBox_generic_options({
        back_func = 'akyrs_wildcard_quit_set_letter_wildcard_menu',
        contents = {
                {
                    n = G.UIT.R,
                    config = { padding = 0.05,  w = 6, colour = G.C.CLEAR, align = 'cm' },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { padding = 0.05, w = 4.5, align = 'cm' },
                            nodes = {
                                AKYRS.create_better_text_input({
                                    w = 4.5,
                                    h = 1,
                                    max_length = 1, 
                                    extended_corpus = true, 
                                    prompt_text = "",
                                    ref_table = data,
                                    ref_value = "letter",
                                    id = "wild_card",
                                    keyboard_offset = 4.5,
                                })
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { align = "cm", padding = 0.1 },
                            nodes = {
                                {
                                    n = G.UIT.C,
                                    config = { align = "cm" },
                                    nodes = {
                                        UIBox_button({
                                            colour = G.C.GREEN,
                                            button = "akyrs_wildcard_set_letter_wildcard",
                                            label = { localize("k_akyrs_letter_btn_set") },
                                            ref_table = data,
                                            minw = 2.5,
                                            focus_args = { set_button_pip = true, button = 'leftshoulder', orientation = 'rm'},
                                        }),
                                    },
                                },
                                {
                                    n = G.UIT.C,
                                    config = { align = "cm" },
                                    nodes = {
                                        UIBox_button({
                                            colour = G.C.YELLOW,
                                            text_colour = G.C.UI.TEXT_DARK,
                                            button = "akyrs_wildcard_set_letter_wildcard_auto",
                                            label = { localize("k_akyrs_letter_btn_auto") },
                                            ref_table = data,
                                            minw = 2.5,
                                            focus_args = { set_button_pip = true, button = 'rightshoulder', orientation = 'rm', snap_to = true },
                                        }),
                                    },
                                },
                                {
                                    n = G.UIT.C,
                                    config = { align = "cm" },
                                    nodes = {
                                        UIBox_button({
                                            colour = G.C.RED,
                                            text_colour = G.C.WHITE,
                                            button = "akyrs_wildcard_unset_letter_wildcard",
                                            ref_table = data,
                                            label = { localize("k_akyrs_letter_btn_unset") },
                                            minw = 2.5,
                                            focus_args = {},
                                        }),
                                    },
                                },
                            },
                        },
                        {
                            n = G.UIT.R,
                            config = { padding = 0.05, w = 4.5, align = 'cl' },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        colour = G.C.UI.TEXT_INACTIVE,
                                        scale = 0.3,
                                        text = localize("k_akyrs_textbox_notice")
                                    }
                                }
                            }
                        },
                        {
                            n = G.UIT.R,
                            config = { padding = 0.05, w = 4.5, align = 'cl' },
                            nodes = {
                                {
                                    n = G.UIT.T,
                                    config = {
                                        colour = G.C.UI.TEXT_INACTIVE,
                                        scale = 0.3,
                                        text = localize("k_akyrs_textbox_notice_2")
                                    }
                                }
                            }
                        },
                    }
                },
            }
        }
    )
end

function AKYRS.UIDEF.wildcards_ui(card)
    local colour = G.C.GREEN
    local text_colour = G.C.UI.TEXT_LIGHT
    local text = ""
    if card.ability.aikoyori_letters_stickers == "#" then
        if not card.ability.aikoyori_pretend_letter then
            text = localize("k_akyrs_letter_btn_unset")
            colour = AKYRS.config.wildcard_behaviour == 3 and SMODS.Gradients["akyrs_unset_letter"] or G.C.RED
        elseif card.ability.aikoyori_pretend_letter == "#" then
            text = localize("k_akyrs_letter_btn_auto")
            colour = G.C.YELLOW
            text_colour = G.C.UI.TEXT_DARK
        else
            text = localize("k_akyrs_letter_btn_set")
        end
    end
    if card.area and card.area == G.hand then
        return {
            n = G.UIT.ROOT,
            config = { padding = 0, colour = G.C.CLEAR },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { padding = 0.15, align = 'cl' },
                    nodes = {
                        {
                            n = G.UIT.R,
                            config = { align = 'cl' },
                            nodes = {
                                {

                                    n = G.UIT.C,
                                    config = { align = "cl" },
                                    nodes = {
                                        {
                                            n = G.UIT.C,
                                            config = { 
                                                    ref_table = card, 
                                                    align = "cl", 
                                                    maxw = 1.25, 
                                                    padding = 0.1, 
                                                    r = 0.08, 
                                                    minw = 1.9, 
                                                    minh = 1.5, 
                                                    hover = true, 
                                                    shadow = true, 
                                                    colour = colour, 
                                                    button = "akyrs_wildcard_open_wildcard_ui", 
                                                },
                                            nodes = {
                                                {
                                                    n = G.UIT.R,
                                                    nodes = {
                                                        { n = G.UIT.T, config = { text = localize("k_akyrs_letter_btn_currently"), colour = text_colour, scale = 0.4, shadow = true } },
                                                    }
                                                },
                                                {
                                                    n = G.UIT.R,
                                                    nodes = {
                                                        { n = G.UIT.T, config = { text = text, colour = text_colour, scale = 0.6, shadow = true, func = 'set_button_pip', 
                                                            focus_args = {
                                                            button = 'leftshoulder', 
                                                            orientation = 'bm',
                                                        }, } },
                                                    }
                                                },
                                            }
                                        }
                                    }
                                },
                                { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                                { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                                { n = G.UIT.B, config = { w = 0.1, h = 0.6 } },
                            }
                        },
                    }
                },
            }
        }
    end
end

local cardhighlighthook = Card.highlight
function Card:highlight(is_higlighted)
    local ret = cardhighlighthook(self, is_higlighted)

    if self.base and (self.area and self.area == G.hand) and self.ability.aikoyori_letters_stickers == "#" then
        if self.highlighted and self.area and self.area ~= G.play and self.area.config.type ~= 'shop' then

            self.children.use_button = UIBox {
                definition = AKYRS.UIDEF.wildcards_ui(self),
                config = { align =
                    "cl",
                    offset = { x = 1, y = -0.75 },
                    parent = self }
            }
        elseif self.children.use_button and self.highlighted then
            self.children.use_button:remove()
            self.children.use_button = nil
        end
    end
    return ret
end

local useCardHook = G.FUNCS.use_card
G.FUNCS.use_card = function (e,m,ns)
    local card = e.config.ref_table
    local area = card.area
    local prev_state = G.STATE
    local dont_dissolve = nil
    local delay_fac = 1
    if area == G.hand and card.ability.aikoyori_letters_stickers == "#" then
        G.FUNCS.akyrs_wildcard_open_wildcard_ui(e)
        return true
    end
    local r = useCardHook(e,m,ns)
    return r
    
end

local canPlayHook = G.FUNCS.can_play
G.FUNCS.can_play = function(e)
    local shouldDisableButton = false
    local runOGHook = true
    if AKYRS.config.wildcard_behaviour == 2 and G.GAME.akyrs_character_stickers_enabled then
        
        for i,k in ipairs(G.hand.highlighted) do
            if k.ability.aikoyori_letters_stickers == "#" and not k.ability.aikoyori_pretend_letter then
                shouldDisableButton = true
                break
            end
        end
    elseif G.GAME.akyrs_character_stickers_enabled and G.GAME.akyrs_mathematics_enabled then
        
        local word_hand = {}
        local hand = {}
        for i,k in ipairs(G.hand.highlighted) do
            table.insert(hand,k)
        end
        table.sort(hand, AKYRS.hand_sort_function)
        for _, v in pairs(hand) do
            if not v.ability then return {} end
            local alpha = v.ability.aikoyori_letters_stickers:lower()
            if alpha == "#" and v.ability.aikoyori_pretend_letter then
                -- if wild is set fr tbh
                alpha = v.ability.aikoyori_pretend_letter:lower()
            elseif alpha == "#" and AKYRS.config.wildcard_behaviour == 3 then -- if it's unset in mode 3 then just make it a random letter i guess
                alpha = '★'
            end
            table.insert(word_hand, alpha)
                
        end
        
        local to_number = to_number or function(l) return l end
        local expression = table.concat(word_hand)
        local stat, val = pcall(AKYRS.MathParser.solve,AKYRS.MathParser,expression)
        local stat2, val = pcall(AKYRS.MathParser.solve,AKYRS.MathParser,""..to_number(G.GAME.chips)..expression)
        local assignment_parts = {}
        for part in expression:gmatch("[^=]+") do
            table.insert(assignment_parts, part)
        end
        local stat3 = false
        if #assignment_parts == 2 then
            local variable, value_expression = assignment_parts[1], assignment_parts[2]
            local status, value = pcall(AKYRS.MathParser.solve, AKYRS.MathParser, value_expression)
            if status then
                stat3 = true
            end
        end


        if not stat and not stat2 and not stat3 then
            shouldDisableButton = true
            runOGHook = false
        end
    end
    if shouldDisableButton then
        e.config.colour = G.C.UI.BACKGROUND_INACTIVE
        e.config.button = nil
        runOGHook = false
    end
    if runOGHook then
        return canPlayHook(e)
    end
end


function UIBox:akyrs_set_parent_child_with_pos(node, parent, pos)
    local UIE = UIElement(parent, self, node.n, node.config)

    --set the group of the element
    if parent and parent.config and parent.config.group then if UIE.config then UIE.config.group = parent.config.group else UIE.config = {group = parent.config.group} end end

    --set the button for the element
    if parent and parent.config and parent.config.button then if UIE.config then UIE.config.button_UIE = parent else UIE.config = {button_UIE = parent} end end
    if parent and parent.config and parent.config.button_UIE then if UIE.config then UIE.config.button_UIE = parent.config.button_UIE else UIE.config = {button = parent.config.button} end end

    if node.n and node.n == G.UIT.O and UIE.config.button then
        UIE.config.object.states.click.can = false
    end

    --current node is a container
    if (node.n and node.n == G.UIT.C or node.n == G.UIT.R or node.n == G.UIT.ROOT) and node.nodes then
        for k, v in pairs(node.nodes) do
            self:set_parent_child(v, UIE)
        end
    end

    if not parent then
        self.UIRoot = UIE 
        self.UIRoot.parent = self
    else
        table.insert(parent.children, pos, UIE)
    end
    if node.config and node.config.mid then 
        self.Mid = UIE
    end
end


local ogBlindBox = create_UIBox_HUD_blind
function create_UIBox_HUD_blind()
    local x = ogBlindBox()
    local blind_setup = G.P_BLINDS[G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]]
    local shit = AKYRS.add_blind_extra_info(blind_setup,nil,{text_size = 0.35,border_size = 0.3, difficulty_text_size = 0.3, cached_icons = true, row = true})

    local bldis = G.GAME.blind and G.GAME.blind.disabled or false

    --print(inspect(G.GAME.blind))

    
    local bl = G.P_BLINDS[G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck]]
    local elem = x.nodes[2].nodes[2].nodes[2]


    if bl and elem then
        local blindloc = AKYRS.getBlindText(G.GAME.round_resets.blind_choices[G.GAME.blind_on_deck] or "nololxd")
        local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)
        if blindloc[1] then elem.nodes[1].nodes[1].config.text = blindloc[1] end
        if blindloc[2] then elem.nodes[2].nodes = {
            { n = G.UIT.O, config = { w = 0.5, h = 0.5, colour = G.C.BLUE, object = stake_sprite, hover = true, can_collide = false } },
            { n = G.UIT.B, config = { h = 0.1, w = 0.1 } },
            { n = G.UIT.T, config = { text = blindloc[2], scale = 0.4, colour = G.C.RED, id = 'HUD_blind_count', shadow = true } }
        }
        end
    end    
    if #shit > 0 then
        G.akyrs_blind_icons = true
        table.insert(x.nodes[2].nodes,2,{
            n = G.UIT.R, config = { align = "cm", id = "akyrs_blind_attributes"}, nodes = shit
        })
        table.insert(x.nodes[2].nodes,2, { n = G.UIT.B, config = { h = 0.1, w = 0.1 } })
    else
        G.akyrs_blind_icons = nil
    end

    return x
end

local blindSetTextHook = Blind.set_text
function Blind:set_text()
    local x = blindSetTextHook(self)
    G.HUD_blind:recalculate()
    return x
end

local ogBlindSel = create_UIBox_blind_choice
function create_UIBox_blind_choice(type, run_info)
    local x = ogBlindSel(type, run_info)
    local bl = G.P_BLINDS[G.GAME.round_resets.blind_choices[type]]
    local elem = AKYRS.search_UIT_for_id(x, "blind_desc")
    if bl and elem then
        local blindloc = AKYRS.getBlindText(G.GAME.round_resets.blind_choices[type] or "nololxd")
        local stake_sprite = get_stake_sprite(G.GAME.stake or 1, 0.5)
        if blindloc[1] then
            pcall(function ()
                elem.nodes[2].nodes[1].nodes[1].config.text = blindloc[1]
            end)
        end
        if blindloc[2] then
            pcall(function ()
            elem.nodes[2].nodes[2].nodes = {
            
                { n = G.UIT.O, config = { w = 0.5, h = 0.5, colour = G.C.BLUE, object = stake_sprite, hover = true, can_collide = false } },
                { n = G.UIT.B, config = { h = 0.1, w = 0.1 } },
                { n = G.UIT.T, config = { text = blindloc[2], scale = 0.4, colour = G.C.RED, shadow = true } }
            }
            end)
        end

    end
    return x
end


local ogBlindUIPopup = create_UIBox_blind_popup
function create_UIBox_blind_popup(bl, disco, vars)
    local x = ogBlindUIPopup(bl,disco,vars)
    
    local info_queue = {}
    AKYRS.add_blind_extra_info(bl,nil,{text_size = 0.25, difficulty_text_size = 0.3, full_ui = true, info_queue = info_queue})
    if #info_queue > 0 then
        local noders = {}
        local all_nodes = {}
        x.n = G.UIT.R
        --table.insert(noders,x)
        for i, valueinfo in ipairs(info_queue) do
            local full_UI_table = {
                main = {},
                info = {},
                type = {},
                name = 'done',
                badges = {}
            }
            local desc = generate_card_ui(valueinfo, full_UI_table)
            if desc then
                table.insert(noders,{
                    n = G.UIT.R, config = { align = "cm"}, nodes = {
                        {n=G.UIT.C, config={align = "cm", colour = lighten(G.C.JOKER_GREY, 0.5), r = 0.1, padding = 0.05, emboss = 0.05}, nodes={
                            info_tip_from_rows(desc.info[1], desc.info[1].name)
                        }}
                    }
                })
            end
        end
        table.insert(all_nodes,
        { n = G.UIT.C, config={align = "cm", func = 'show_infotip',object = Moveable(),ref_table = next(noders) and noders or nil}, nodes = {
            x
        }})
        --table.insert(all_nodes,x)
        return {n=G.UIT.ROOT, config={align = "cm", colour = G.C.CLEAR}, nodes=all_nodes}
    end
    return x
end

local locHooker = localize
function localize(args, misc_cat)
    if not args then args = {} end
    return locHooker(args, misc_cat)
end

--[[
G.FUNCS.HUD_blind_debuff = function(e)
	local scale = 0.4
	local num_lines = #G.GAME.blind.loc_debuff_lines
	while G.GAME.blind.loc_debuff_lines[num_lines] == '' do
		num_lines = num_lines - 1
	end
	local padding = 0.05
	if num_lines > 5 then
		local excess_height = (0.3 + padding)*(num_lines - 5)
		padding = padding - excess_height / (num_lines + 1)
	end
	e.config.padding = padding
	if num_lines > #e.children then
		for i = #e.children+1, num_lines do
			local node_def = {n = G.UIT.R, config = {align = "cm", minh = 0.3, maxw = 4.2}, nodes = {
				{n = G.UIT.T, config = {ref_table = G.GAME.blind.loc_debuff_lines, ref_value = i, scale = scale * 0.9, colour = G.C.UI.TEXT_LIGHT}}}}
			e.UIBox:set_parent_child(node_def, e)
		end
	elseif num_lines + (G.skill_deck and 1 or 0) + (G.akyrs_blind_icons and 1 or 0) < #e.children then
		for i = num_lines+1, #e.children do
			e.children[i]:remove()
			e.children[i] = nil
		end
	end
	assert(G.HUD_blind == e.UIBox)
	e.UIBox:recalculate()

end
]]
local moveableRemoveHook = Moveable.remove
function Moveable:remove()
    if self.children and type(self.children) == 'table' then
        for i, ch in pairs(self.children) do
            ch.REMOVED = true
            ch:remove()
        end
    end
    self.REMOVED = true
    return moveableRemoveHook(self)
end

AKYRS.mod_run_info_hands = function(object)
    local show_power
    if Talisman then
        show_power = to_big(G.GAME.akyrs_pure_hand_modifier.power) ~= to_big(1)
    else 
        show_power = G.GAME.akyrs_pure_hand_modifier.power ~= 1
    end
    local to_number = to_number or function(l) return tonumber(l) end
    if G.GAME.akyrs_pure_unlocked then
        table.insert(object.nodes, 1,{
                n = G.UIT.R,
                config = { colour = G.C.AKYRS_UMBRAL_Y, r = 0.05, padding = 0.1 },
                nodes =     {
            {n=G.UIT.C, config={align = "cl", padding = 0, minw = 5}, nodes={
                {n=G.UIT.C, config={align = "cm", padding = 0.01, r = 0.1, colour = G.C.HAND_LEVELS[math.floor(to_number(math.min(7, G.GAME.akyrs_pure_hand_modifier.level)))], minw = 1.5, outline = 0.8, outline_colour = G.C.WHITE}, nodes={
                {n=G.UIT.T, config={text = localize('k_level_prefix')..number_format(G.GAME.akyrs_pure_hand_modifier.level), scale = 0.5, colour = G.C.UI.TEXT_DARK}}
                }},
                {n=G.UIT.C, config={align = "cm", minw = 4.5, maxw = 4.5}, nodes={
                {n=G.UIT.T, config={text = ' '..localize("k_akyrs_pure_hands"), scale = 0.45, colour = G.C.BLACK, shadow = true}}
                }}
            }},
            {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.BLACK,r = 0.1}, nodes={
                {n=G.UIT.T, config={text = "×", scale = 0.45, colour = G.C.AKYRS_UMBRAL_Y}},
                {n=G.UIT.C, config={align = "cr", padding = 0.01, r = 0.1, colour = G.C.AKYRS_UMBRAL_P, minw = 1.1}, nodes={
                    {n=G.UIT.T, config={text = number_format(G.GAME.akyrs_pure_hand_modifier.multiplier, 1000000), scale = 0.45, colour = G.C.UI.TEXT_LIGHT}},
                    {n=G.UIT.B, config={w = 0.08, h = 0.01}}
                }},
                show_power and {n=G.UIT.T, config={text = "^", scale = 0.45, colour = G.C.AKYRS_UMBRAL_P}},
                show_power and {n=G.UIT.C, config={align = "cl", padding = 0.01, r = 0.1, colour = G.C.AKYRS_UMBRAL_Y, minw = 1.1}, nodes={
                    {n=G.UIT.B, config={w = 0.08,h = 0.01}},
                    {n=G.UIT.T, config={text = number_format(G.GAME.akyrs_pure_hand_modifier.power, 1000000), scale = 0.45, colour = G.C.UI.TEXT_DARK}}
                }}
            }},
            not show_power and {n=G.UIT.B, config={w = 0.8,h = 0.01}},
            {n=G.UIT.C, config={align = "cm"}, nodes={
                {n=G.UIT.T, config={text = '  #', scale = 0.45, colour = G.C.UI.TEXT_DARK, shadow = true}}
                }},
            {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.L_BLACK,r = 0.1, minw = 0.9}, nodes={
                {n=G.UIT.T, config={text = G.GAME.akyrs_pure_hand_modifier.played, scale = 0.45, colour = G.C.FILTER, shadow = true}},
            }}
            }
        })
    end
    return object
end

local refresh_col_sel = G.FUNCS.refresh_contrast_mode
G.FUNCS.refresh_contrast_mode = function(...)
    
    if G.aiko_wordle then
        G.aiko_wordle:remove(); G.aiko_wordle = nil
    end
    if not G.aiko_wordle and AKYRS.checkBlindKey("bl_akyrs_the_thought") then
        G.aiko_wordle = UIBox {
            definition = create_UIBOX_Aikoyori_WordPuzzleBox(),
            config = { align = "b", offset = { x = 0, y = 0.4 }, major = G.jokers, bond = 'Weak' }
        }
    end
    return refresh_col_sel(...)
end


local gameMainMenuRef = Game.main_menu
function Game:main_menu(change_context)
    gameMainMenuRef(self, change_context)
    UIBox({
        definition = {
            n = G.UIT.ROOT,
            config = {
                align = "cm",
                colour = G.C.UI.TRANSPARENT_DARK
            },
            nodes = {
                {
                    n = G.UIT.T,
                    config = {
                        scale = 0.3,
                        text = "Aikoyori's Shenanigans v"..AKYRS.version,
                        colour = G.C.UI.TEXT_LIGHT
                    }
                }
            }
        },
        config = {
            align = "tli",
            bond = "Weak",
            offset = {
                x = 0,
                y = 0
            },
            major = G.ROOM_ATTACH
        }
    })
end

AKYRS.rows_needed_for_icon = function()
    return (G.skill_deck and 1 or 0) + (G.akyrs_blind_icons and 1 or 0) 
end

local tagGen = Tag.generate_UI
function Tag:generate_UI(_size)
    local tag_sprite_tab, tag_sprite = tagGen(self, _size)
    if AKYRS.should_conceal_card(nil,self.config) then
        tag_sprite.atlas = G.ASSET_ATLAS["akyrs_aikoyoriTags"]
        tag_sprite:set_sprite_pos({x = 0, y = 9})
    end
    return tag_sprite_tab, tag_sprite
end