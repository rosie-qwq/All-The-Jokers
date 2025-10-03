local function numberToColor(num)
  if num == 1 then
    return G.SETTINGS.colourblind_option and G.C.ORANGE or G.C.GREEN
  elseif num == 2 then
    return G.SETTINGS.colourblind_option and G.C.BLUE or G.C.YELLOW
  elseif num == 3 then
    return G.C.GREY
  end
  return G.C.TRANSPARENT_DARK
end

local function numberToTextColor(num)
  if num == 1 then
    return G.SETTINGS.colourblind_option and G.C.BLACK or G.C.WHITE
  elseif num == 2 then
    return G.SETTINGS.colourblind_option and G.C.WHITE or G.C.BLACK
  elseif num == 3 then
    return G.C.WHITE
  end
  return G.C.TRANSPARENT_DARK
end


function INFINITE_DISCARD_UI(temp_col2, scale)
  return {
    {
      n = G.UIT.R,
      config = { align = "cm", r = 0.1, minw = 1.2, minh = 0.7, colour = temp_col2 },
      nodes = {
        { n = G.UIT.O, config = { object = DynaText({ string = { { string = "" } }, font = G.LANGUAGES['en-us'].font, colours = { HEX("00000000") }, shadow = true, rotate = true, scale = 2 * scale }), id = 'discard_UI_count' } },
        { n = G.UIT.T, config = { text = "8", hover = true, shadow = true, colour = G.C.RED, vert = true, scale = 2 * scale } },
      }
    }
  }
end

function create_UIBOX_Aikoyori_WordPuzzleBox()
  local nodesnshit = {}
  for a, x in ipairs(G.GAME.current_round.aiko_round_played_words) do
    local subnoteforrow = {}
    for b, y in ipairs(x) do
      -- 1 is letter and [2] is stats
      table.insert(subnoteforrow, {
        n = G.UIT.C,
        config = { padding = 0.1, minw = 0.4, maxh = 0.5, colour = numberToColor(y[2]) },
        nodes = {
          {
            n = G.UIT.T,
            config = {
              align = "c",
              text = y[1],
              colour = numberToTextColor(y[2]),
              scale = 0.3
            }
          }
        }
      })
    end
    table.insert(
      nodesnshit,
      {
        n = G.UIT.R,
        config = { padding = 0.0, maxh = 0.5 },
        nodes = subnoteforrow

      }
    )
  end
  return {
    n = G.UIT.ROOT,
    config = {
      align = "cm",
      minw = 2,
      minh = 0.6,
      padding = 0.2,
      colour = G.C.UI.TRANSPARENT_DARK,
      r = 0.1,
    },
    nodes = {
      {
        n = G.UIT.R,
        config = {
        },
        nodes = nodesnshit
      }
    }
  }
end

  
G.FUNCS.akyrs_letter_dialog = function(e)
  G.FUNCS.overlay_menu{
    definition = create_UIBox_options(),
  }
end

-- thunk didn't have this so i might as well add the shift key

function AKYRS.create_better_keyboard_input(args)
  local keyboard_rows = {
    '`1234567890-=',
    'qwertyuiop[]\\',
    'asdfghjkl;\'',
    'zxcvbnm,./',
    args.space_key and ' ' or nil
  }
  local keyboard_button_rows = {
      {},{},{},{},{},{}
  }
  for k, v in ipairs(keyboard_rows) do
      for i = 1, #v do
          local c = v:sub(i,i)
          keyboard_button_rows[k][#keyboard_button_rows[k] +1] = AKYRS.create_better_keyboard_button(c, c == ' ' and 'y' or nil, args.osk)

      end
  end
  return {n=G.UIT.ROOT, config={align = "cm", padding = 0.1, r = 0.1, colour = {G.C.GREY[1], G.C.GREY[2], G.C.GREY[3],0.7}}, nodes={
    {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.CLEAR}, nodes = {
      {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.BLACK, emboss = 0.05, r = 0.1, mid = true}, nodes = {
        {n=G.UIT.R, config={align = "cm", padding = 0.05}, nodes = {
          {n=G.UIT.C, config={align = "cm", padding = 0.05, colour = G.C.CLEAR}, nodes = {
              {n=G.UIT.R, config={align = "cm",padding = 0.04, colour = G.C.CLEAR}, nodes=keyboard_button_rows[1]},
              {n=G.UIT.R, config={align = "cm",padding = 0.04, colour = G.C.CLEAR}, nodes=keyboard_button_rows[2]},
              {n=G.UIT.R, config={align = "cm",padding = 0.04, colour = G.C.CLEAR}, nodes=keyboard_button_rows[3]},
              {n=G.UIT.R, config={align = "cm",padding = 0.04, colour = G.C.CLEAR}, nodes=keyboard_button_rows[4]},
              {n=G.UIT.R, config={align = "cm",padding = 0.04, colour = G.C.CLEAR}, nodes=keyboard_button_rows[5]},
              {n=G.UIT.R, config={align = "cm",padding = 0.04, colour = G.C.CLEAR}, nodes=keyboard_button_rows[6]}
          }},
          (args.backspace_key or args.return_key) and {n=G.UIT.C, config={align = "r", padding = 0.05, colour = G.C.CLEAR, minw = 5}, nodes = {
              args.backspace_key and {n=G.UIT.R, config={align = "r", padding = 0.05, colour = G.C.CLEAR}, nodes={AKYRS.create_better_keyboard_button('backspace', 'x', args.osk)}} or nil,
              args.return_key and {n=G.UIT.R, config={align = "r", padding = 0.05, colour = G.C.CLEAR}, nodes={AKYRS.create_better_keyboard_button('return', 'start', args.osk)}} or nil,
              args.shift_key and {n=G.UIT.R, config={align = "r", padding = 0.05, colour = G.C.CLEAR}, nodes={AKYRS.create_toggle_keyboard_button('lshift', 'leftstick', args.osk)}} or nil,
              {n=G.UIT.R, config={align = "r", padding = 0.05, colour = G.C.CLEAR}, nodes={AKYRS.create_better_keyboard_button('back', 'b', args.osk)}}
          }} or nil
        }},
      }}
    }},
    
  }}
end

-- mainly for shift button support

function AKYRS.create_better_keyboard_button(key, binding, osk)
  local key_label = (key == 'backspace' and 'Backspace') or (key == ' ' and 'Space') or (key == 'back' and 'Back') or (key == 'return' and 'Enter')  or (key == 'lshift' and 'Shift') or (AKYRS.shift_toggled and AKYRS.get_shifted_from_key(key)) or key
  local is_one_of_those = key == 'backspace' or key == ' ' or key == 'back' or key == 'return' or key == 'lshift' and true or false
  return UIBox_button{ akyrs_osk = osk,label = {key_label}, button = "akyrs_key_update", func = not is_one_of_those and 'akyrs_shifted_keyboard_keys' or nil, ref_table = {key = key == 'back' and 'return' or key},
      minw = key == ' ' and 9 or key == 'return' and 3 or key == 'backspace' and 3.5 or key == 'back' and 3.5 or key == 'lshift' and 4 or 0.8,
      minh = key == 'return' and 1 or key == 'backspace' and 1 or key == 'back' and 0.5 or key == 'lshift' and 1 or 0.7,
      col = true, colour = G.C.GREY, scale = 0.4, focus_args = binding and {button = binding, orientation = 'cr', set_button_pip= true, snap_to = key == ' ' and true or false} or nil,
    }
end
function AKYRS.create_toggle_keyboard_button(key, binding, osk)
  local key_label = (key == 'lshift' and 'Shift') or key
  return UIBox_button{ akyrs_osk = osk,label = {key_label}, button = "akyrs_toggle_key_button", func = key=="lshift" and "akyrs_shift_enabled" or nil, ref_table = {key = key == 'back' and 'return' or key},
      minw = key == ' ' and 9 or key == 'return' and 3 or key == 'backspace' and 3.5 or key == 'back' and 3.5 or key == 'lshift' and 4 or 0.8,
      minh = key == 'return' and 1 or key == 'backspace' and 1 or key == 'back' and 0.5 or key == 'lshift' and 1 or 0.7,
      col = true, colour = G.C.GREY, scale = 0.4, focus_args = binding and {button = binding, orientation = 'cr', set_button_pip= true, snap_to = key == ' ' and true or false} or nil}
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

G.FUNCS.akyrs_shift_enabled = function(e)  if AKYRS.shift_toggled then
    e.config.colour = G.C.PURPLE
  else
    e.config.colour = G.C.GREY
  end

end
G.FUNCS.akyrs_shifted_keyboard_keys = function(e)
  
  --[[
  if new and old ~= new then
    e.children[1].children[1].config.object.config.string = {new}
    e.children[1].children[1].config.object:update_text(true)
  end]]
end

--[[
G.FUNCS.akyrs_shifted_keyboard_keys = function(e)
  local args = e.config.ref_table
  local old = e.children[1].children[1].children[1].config.text
  local old_node = e.children[1].children[1].children[1].config
  local new = nil
  if AKYRS.shift_toggled and args.key then
    new = AKYRS.get_shifted_from_key(args.key)
  elseif AKYRS.shift_toggled and old:upper() ~= old then
    new = old:upper()
  else
    new = args.key
  end
  if new and old ~= new then
    e.children[1].children[1]:remove()
    old_node.text = new
    e.children[1].children[1] = UIBox{
      definition = {n=G.UIT.T, config=old_node},
      config = { align = 'cm', offset = {x=0,y=0}, major = e.children[1], parent = e.children[1]}

    }
  end
end
]]

G.FUNCS.akyrs_toggle_key_button = function(e)
  local args = e.config.ref_table
  if args.key and args.key == "lshift" then
    AKYRS.shift_toggled = not AKYRS.shift_toggled
    local OSkeyboard_e = e.config.akyrs_osk.parent.parent.parent
    local x = e.config.akyrs_osk
    if OSkeyboard_e.children.controller_keyboard then
      
      G.CONTROLLER:mod_cursor_context_layer(-1)
      OSkeyboard_e.children.controller_keyboard:remove()
      G.CONTROLLER.screen_keyboard = nil
      OSkeyboard_e.children.controller_keyboard = UIBox{
      definition = AKYRS.create_better_keyboard_input{backspace_key = true, return_key = true, space_key = true, shift_key = true, osk = x},
      config = {
        align= 'cm',
        offset = {x = 0, y = G.CONTROLLER.text_input_hook.config.ref_table.keyboard_offset or -4},
        major = x.UIBox, parent = OSkeyboard_e}
      }
      
      G.CONTROLLER.screen_keyboard = OSkeyboard_e.children.controller_keyboard
      G.CONTROLLER:mod_cursor_context_layer(1)
    end
  end
end
G.FUNCS.akyrs_key_update = function(e)
  local args = e.config.ref_table
  if args.key then 
    G.CONTROLLER:key_press_update(args.key) 
  end
end
-- so it support shift and disables the fullscreen dim

function AKYRS.create_better_text_input(args)
  args = args or {}
  args.colour = copy_table(args.colour) or copy_table(G.C.BLUE)
  args.hooked_colour = copy_table(args.hooked_colour) or darken(copy_table(G.C.BLUE), 0.3)
  args.w = args.w or 2.5
  args.h = args.h or 0.7
  args.text_scale = args.text_scale or 0.4
  args.max_length = args.max_length or 16
  args.all_caps = args.all_caps or false
  args.prompt_text = args.prompt_text or ""
  args.current_prompt_text = args.ref_table[args.ref_value] or ''
  args.id = args.id or "text_input"

  local text = {ref_table = args.ref_table, ref_value = args.ref_value, letters = {}, current_position = string.len(args.ref_table[args.ref_value])}
  local ui_letters = {}
  for i = 1, args.max_length do
    text.letters[i] = (args.ref_table[args.ref_value] and (string.sub(args.ref_table[args.ref_value], i, i) or '')) or ''
    ui_letters[i] = {n=G.UIT.T, config={ref_table = text.letters, ref_value = i, scale = args.text_scale, colour = G.C.UI.TEXT_LIGHT, id = args.id..'_letter_'..i}}
  end
  args.text = text

  local position_text_colour = lighten(copy_table(G.C.BLUE), 0.4)

  ui_letters[#ui_letters+1] = {n=G.UIT.T, config={ref_table = args, ref_value = 'current_prompt_text', scale = args.text_scale, colour = lighten(copy_table(args.colour), 0.4), id = args.id..'_prompt'}}
  ui_letters[#ui_letters+1] = {n=G.UIT.B, config={r = 0.03,w=0.1, h=0.4, colour = position_text_colour, id = args.id..'_position', func = 'flash'}}

  local t = 
      {n=G.UIT.C, config={align = "cm", colour = G.C.CLEAR}, nodes = {
          {n=G.UIT.C, config={id = args.id, align = "cm", padding = 0.05, r = 0.1, hover = true, colour = args.colour,minw = args.w, min_h = args.h, button = 'select_text_input', shadow = true}, nodes={
            {n=G.UIT.R, config={ref_table = args, padding = 0.05, align = "cm", r = 0.1, colour = G.C.CLEAR}, nodes={
              {n=G.UIT.R, config={ref_table = args, align = "cm", r = 0.1, colour = G.C.CLEAR, func = 'akyrs_text_input'}, nodes=
                ui_letters
              }
            }}
          }}
        }}
  return t
end

-- TEXT INPUT IS JANK

G.FUNCS.akyrs_text_input = function(e)
  local args = e.config.ref_table
  if G.CONTROLLER.text_input_hook == e then
    e.parent.parent.config.colour = args.hooked_colour
    args.current_prompt_text = ''
    args.current_position_text = args.position_text
  else
    e.parent.parent.config.colour = args.colour
    args.current_prompt_text = (args.text.ref_table[args.text.ref_value] and args.text.ref_table[args.text.ref_value] and args.prompt_text or '')
    args.current_position_text = ''
  end

  local OSkeyboard_e = e.parent.parent.parent
  if G.CONTROLLER.text_input_hook == e then
    if not OSkeyboard_e.children.controller_keyboard then 
      OSkeyboard_e.children.controller_keyboard = UIBox{
        definition = AKYRS.create_better_keyboard_input{backspace_key = true, return_key = true, space_key = true, shift_key = true, osk = e},
        config = {
          align= 'cm',
          offset = {x = 0, y = G.CONTROLLER.text_input_hook.config.ref_table.keyboard_offset or -4},
          major = e.UIBox, parent = OSkeyboard_e}
      }
      G.CONTROLLER.screen_keyboard = OSkeyboard_e.children.controller_keyboard
      G.CONTROLLER:mod_cursor_context_layer(1)
    end
  elseif OSkeyboard_e.children.controller_keyboard then
    OSkeyboard_e.children.controller_keyboard:remove()
    OSkeyboard_e.children.controller_keyboard = nil
    G.CONTROLLER.screen_keyboard = nil
    AKYRS.shift_toggled = nil
    G.CONTROLLER:mod_cursor_context_layer(-1)
  else
    if not AKYRS.better_input_selected then
      AKYRS.better_input_selected = true
      AKYRS.simple_event_add(
        function ()
          G.FUNCS.select_text_input(e.parent.parent)
          return true
        end, 0.05
      )
    end
  end
end


function AKYRS.UIBox_dynatext_button(args)
  args = args or {}
  args.button = args.button or "exit_overlay_menu"
  args.func = args.func or nil
  args.key = args.key or "generic"
  args.colour = args.colour or G.C.RED
  args.choice = args.choice or nil
  args.chosen = args.chosen or nil
  args.label = args.label or {}
  args.minw = args.minw or 2.7
  args.maxw = args.maxw or (args.minw - 0.2)
  if args.minw < args.maxw then args.maxw = args.minw - 0.2 end
  args.minh = args.minh or 0.9
  args.scale = args.scale or 0.5
  args.focus_args = args.focus_args or nil
  args.text_colour = args.text_colour or G.C.UI.TEXT_LIGHT
  local but_UIT = args.col == true and G.UIT.C or G.UIT.R

  local but_UI_label = {}
  AKYRS.dynatext = AKYRS.dynatext or {}
  AKYRS.dynatext[args.key] = AKYRS.dynatext[args.key] or DynaText{
    string = args.label,
    scale = args.scale,
    colours = {args.text_colour},
    shadow = args.shadow,
  }
  local button_pip = nil
  if args.focus_args and args.focus_args.set_button_pip then 
    button_pip ='set_button_pip'
  end
  table.insert(but_UI_label, {n=G.UIT.R, config={align = "cm", padding = 0, minw = args.minw, maxw = args.maxw}, nodes={
    {n=G.UIT.O, config={
      object = AKYRS.dynatext[args.key]
    },
    {n=G.UIT.T, config={text = '', scale = args.scale, colour = args.text_colour, shadow = args.shadow, focus_args = button_pip and args.focus_args or nil, func = button_pip, ref_table = args.ref_table}},
  }}})
  return 
  {n= but_UIT, config = {align = 'cm'}, nodes={
  {n= G.UIT.C, config={
      align = "cm",
      padding = args.padding or 0,
      r = 0.1,
      hover = true,
      colour = args.colour,
      one_press = args.one_press,
      button = (args.button ~= 'nil') and args.button or nil,
      choice = args.choice,
      chosen = args.chosen,
      focus_args = args.focus_args,
      minh = args.minh - 0.3*(args.count and 1 or 0),
      shadow = true,
      func = args.func,
      id = args.id,
      back_func = args.back_func,
      ref_table = args.ref_table,
      mid = args.mid
    }, nodes=
    but_UI_label
    }}}
end

AKYRS.akyrs_selection = {
  adequate = nil,
  absurd = nil
}

AKYRS.balance_intro_end = function (set)
  G.PROFILES[G.SETTINGS.profile].akyrs_balance = set
  G:save_settings()
  G.akyrs_current_balancing_page = nil
  G.FUNCS.exit_overlay_menu()
  G.SETTINGS.paused = false
  if G.AKYRS_AIKOYORI then
    G.akyrs_aiko_y = 20
    AKYRS.simple_event_add(
      function ()
        
      if G.AKYRS_AIKOYORI then
            G.AKYRS_AIKOYORI:remove()
            G.AKYRS_AIKOYORI = nil
      end
        return true
      end, 1
    )
  end
end

G.FUNCS.akyrs_balance_select_button_enabled = function(e)
  if not AKYRS.akyrs_selection.adequate and not AKYRS.akyrs_selection.absurd then
    e.config.colour = G.C.GREY
    e.config.button = nil
  else
    e.config.colour = G.C.GREEN
    e.config.button = "akyrs_advance_balance_intro"
  end
end

AKYRS.balance_box = function(page)
  G.SETTINGS.paused = true
  G.FUNCS.overlay_menu({
    definition = AKYRS.UIBox_balancing_intro(page),
    config = {
        align = "cm",
        offset = {x=-2,y=10},
        major = G.ROOM_ATTACH,
        bond = 'Weak',
        no_esc = true
    }
})
end

G.FUNCS.akyrs_select_balance_checkbox = function(val, e)
  
  if e.config.ref_table.ref_value == "adequate" or (e.config.ref_table.ref_value == "absurd" and not Talisman) then
    AKYRS.akyrs_selection.adequate = true
    AKYRS.akyrs_selection.absurd = false
    
  end
  if e.config.ref_table.ref_value == "absurd" then
    AKYRS.akyrs_selection.absurd = true
    AKYRS.akyrs_selection.adequate = false
  end
end

G.FUNCS.akyrs_advance_balance_intro = function(e)
  --print(inspect(e.config))
  if G.akyrs_current_balancing_page == "intro" then
    if Playbook then
      
      AKYRS.balance_box("playbook")
    elseif Cryptid then
      AKYRS.balance_box("cryptid")
    else
      AKYRS.balance_box("details")
    end
  elseif G.akyrs_current_balancing_page == "cryptid" or G.akyrs_current_balancing_page == "playbook" then
    if e.config.id == "accept" then
      AKYRS.balance_intro_end("absurd")
    else
      AKYRS.balance_box("details")
    end
  elseif G.akyrs_current_balancing_page == "details" then
    AKYRS.balance_box("pick")
  elseif G.akyrs_current_balancing_page == "pick" then
    local picked = nil
    if AKYRS.akyrs_selection.adequate then
      picked = 'adequate'
    end
    if AKYRS.akyrs_selection.absurd then
      picked = 'absurd'
    end
    if picked then
      AKYRS.balance_intro_end(picked)
    end
  end
end

function AKYRS.UIBox_balancing_intro(page)
  G.akyrs_current_balancing_page = page
  local child_elements = {}
  local buttons = {}
    local shx = {}
  if page == "intro" then
    localize{type = "descriptions", key = "akyrs_balance_dialog_intro", set = "Akyrs_Dialog", default_col = G.C.WHITE, nodes = shx, vars = {}, scale = 2}
    child_elements = {transparent_multiline_text(shx)}
    buttons = {
      UIBox_button({
        label = {localize('k_akyrs_balance_dialog_intro_next')},
        button = 'akyrs_advance_balance_intro',
        page = page,
        colour = G.C.BLUE,
        minw = 4
      }),
    }
  elseif page == "playbook" then
    localize{type = "descriptions", key = "akyrs_balance_dialog_playbook", set = "Akyrs_Dialog", default_col = G.C.WHITE, nodes = shx, vars = {}, scale = 2}
    child_elements = {transparent_multiline_text(shx)}
    buttons = {
      UIBox_button({
        label = {localize('k_akyrs_balance_dialog_cryptid_decline')},
        button = 'akyrs_advance_balance_intro',
        page = page,
        id = 'decline',
        colour = G.C.RED,
        minw = 4
      }),
      UIBox_button({
        label = {localize('k_akyrs_balance_dialog_cryptid_accept')},
        button = 'akyrs_advance_balance_intro',
        page = page,
        id = 'accept',
        colour = G.C.GREEN,
        minw = 4
      }),
    }
  elseif page == "cryptid" then
    localize{type = "descriptions", key = "akyrs_balance_dialog_cryptid", set = "Akyrs_Dialog", default_col = G.C.WHITE, nodes = shx, vars = {}, scale = 2}
    child_elements = {transparent_multiline_text(shx)}
    buttons = {
      UIBox_button({
        label = {localize('k_akyrs_balance_dialog_cryptid_decline')},
        button = 'akyrs_advance_balance_intro',
        page = page,
        id = 'decline',
        colour = G.C.RED,
        minw = 4
      }),
      UIBox_button({
        label = {localize('k_akyrs_balance_dialog_cryptid_accept')},
        button = 'akyrs_advance_balance_intro',
        page = page,
        id = 'accept',
        colour = G.C.GREEN,
        minw = 4
      }),
    }
  elseif page == "details" then
    localize{type = "descriptions", key = "akyrs_balance_dialog_details", set = "Akyrs_Dialog", default_col = G.C.WHITE, nodes = shx, vars = {}, scale = 2}
    child_elements = {transparent_multiline_text(shx)}
    buttons = {
      UIBox_button({
        label = {localize('k_akyrs_balance_dialog_details_next')},
        button = 'akyrs_advance_balance_intro',
        page = page,
        colour = G.C.BLUE,
        minw = 4
      }),
    }
  elseif page == "pick" then
    child_elements = {
      { n = G.UIT.R, config = { padding = 0.1, align = "cl" }, nodes = {
        { n = G.UIT.C, config = { padding = 0.1, align = "cl" }, nodes = {
          create_toggle({w = 0, label = '', scale = 1, ref_table = AKYRS.akyrs_selection, ref_value = 'adequate', callback = G.FUNCS.akyrs_select_balance_checkbox}),
        }},
        { n = G.UIT.C, config = { padding = 0.1, align = "cl" }, nodes = {
          { n = G.UIT.T, config = { colour = G.C.WHITE, text = localize('k_akyrs_balance_dialog_adequate_text'), scale = 0.8}}
        }}
      }},
      { n = G.UIT.R, nodes = {
        { n = G.UIT.T, config = { colour = G.C.JOKER_GREY, text = localize('k_akyrs_balance_dialog_adequate_description'), scale = 0.5}}
      }},
      { n = G.UIT.R, config = { h = 0.5, w = 0.1 }, nodes = {{ n = G.UIT.B, config = { h = 0.5, w = 0.1 } },}},
      { n = G.UIT.R, config = { padding = 0.1, align = "cl" }, nodes = {
        { n = G.UIT.C, config = { padding = 0.1, align = "cl" }, nodes = Talisman and {
          create_toggle({w = 0, label = '', scale = 1, ref_table = AKYRS.akyrs_selection, ref_value = 'absurd', callback = G.FUNCS.akyrs_select_balance_checkbox}),
        } or {
          {
            n = G.UIT.R, config = { align = "cm", minw = 0.5, minh = 0.5, padding = 0.2, colour = G.C.UI.TEXT_INACTIVE, outline = 1.5, outline_colour = G.C.WHITE, r = 0.2, emboss = 0.1 },
            nodes = {
              { n = G.UIT.T, config = { text = "-", colour = G.C.WHITE, scale = 0.3}}
            }
          }
        },},
        { n = G.UIT.C, config = { padding = 0.1, align = "cl" }, nodes = {
          { n = G.UIT.T, config = { colour = G.C.WHITE, text = localize('k_akyrs_balance_dialog_absurd_text'), scale = 0.8}}
        }}
      }},
      { n = G.UIT.R, nodes = {
        { n = G.UIT.T, config = { colour = G.C.JOKER_GREY, text = localize('k_akyrs_balance_dialog_absurd_description'), scale = 0.5}}
      }},
      
      
      
    }
    buttons = {
      UIBox_button({
        label = {localize('k_akyrs_balance_dialog_finish_wizard')},
        button = 'akyrs_advance_balance_intro',
        func = 'akyrs_balance_select_button_enabled',
        page = page,
        minw = 4
      }),
    }
  end
  return {
    n = G.UIT.ROOT, config = { align = "cm", colour = {0.32,0.36,0.41,0.6}, padding = 32.01, r = 0.1, can_collide = true}, nodes = {
      {
        n = G.UIT.R, config = {padding = 0.0},  nodes = {
          {
            n = G.UIT.R, config = {align = "cm", r = 0.1, padding = 0.05, minh = G.ROOM.T.h - 3, minw = G.ROOM.T.w - 4, can_collide = true, colour = G.C.L_BLACK, outline_colour = G.C.JOKER_GREY, emboss = 0.1}, nodes = child_elements
          },
          {
            n = G.UIT.R, config = {align = "cr", r = 0.1, padding = 0.2, minh = 1, minw = G.ROOM.T.w - 4, can_collide = true, colour = mix_colours(G.C.L_BLACK,G.C.BLACK,0.5), outline_colour = mix_colours(G.C.JOKER_GREY,G.C.BLACK,0.5), emboss = 0.1 }, nodes = {
              {
                n = G.UIT.C, config = { padding = 0.2 }, nodes = AKYRS.wrap_in_col(buttons)
              }
            }
          },
        }
      }
    }
  }
end


AKYRS.start_onboarding = function (forced)
    AKYRS.simple_event_add(
        function()
            if not G.PROFILES[G.SETTINGS.profile].akyrs_balance or forced then
                G.SETTINGS.paused = true
                G.FUNCS.overlay_menu({
                    definition = AKYRS.UIBox_balancing_intro("intro"),
                    config = {
                        align = "cm",
                        offset = {x=-2,y=10},
                        major = G.ROOM_ATTACH,
                        bond = 'Weak',
                        no_esc = true
                    }
                })
                local atl = G.ASSET_ATLAS['akyrs_aikoyori_intro']
                local scale = 60
                G.AKYRS_AIKOYORI = G.AKYRS_AIKOYORI or Sprite(16,12,scale*atl.px/1000,scale*atl.py/1000, atl,{ x = 0, y = 0 })
                G.AKYRS_AIKOYORI.T.y = 3
                G.akyrs_aiko_y = 0 
            end
            return true
        end, 0,"akyrs_desc"
    )
end

function AKYRS.UIBox_HUD_villager_trading()
  return {
    n = G.UIT.ROOT,
    config = {},
    nodes = {
      {
        n = G.UIT.C,
        config = {},

      }
    }
  }
end
