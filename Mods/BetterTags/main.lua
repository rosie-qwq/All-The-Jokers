BetterTags = BetterTags or {}
BetterTags.tag_count = nil

BetterTags.config = SMODS.current_mod.config
local has_cryptid = SMODS.Mods["Cryptid"] and SMODS.Mods["Cryptid"].can_load
SMODS.current_mod.config_tab = function()
    return {n = G.UIT.ROOT, config = {
        r = .2, colour = G.C.BLACK
    }, nodes = {
        {n = G.UIT.C, config = { padding = .5,}, nodes = {
            has_cryptid and create_toggle({label = "Auto-Merge Cat-Tags", ref_table = BetterTags.config, ref_value = 'auto_merge_cat_tags', info = {"May be buggy!", "Jokers that count tags", "will *not* count cat tags anymore.", "USE ONLY ON NEW PROFILES!"}, active_colour = G.C.RED}) or nil,
            create_option_cycle{
                label = "UI Anchor",
                info = {"Where in the Tags UI,", "the counter is displayed."},
                options = {'Left', "Right"},
                current_option = BetterTags.config.ui_location,
                colour = G.C.BOOSTER,
                w = 5,
                text_scale = 0.5,
                scale = 1,
                ref_table = BetterTags.config,
                ref_value = "ui_location",
                opt_callback = 'config_change',
            }
        }}
    }}
end
if not has_cryptid then BetterTags.config.auto_merge_cat_tags = false end

G.FUNCS.config_change = function(args) 
    -- G.FUNCS.cycle_options from CardSleeves which in turn is G.FUNCS.cycle_update from Galdur
    args = args or {}
    if args.cycle_config and args.cycle_config.ref_table and args.cycle_config.ref_value then
        args.cycle_config.ref_table[args.cycle_config.ref_value] = args.to_key
    end
    generateTagUi()
end

function getTagCounts()
    local result = {}

    for _, tag in pairs(G.GAME.tags) do
        result[tag.key] = (result[tag.key] or 0) + 1
    end
    return result
end 

function generateTagUi()
    if G.HUD_tags then
        for k, v in pairs(G.HUD_tags) do
            v:remove()
            G.HUD_tags[k] = nil
        end
    end
    local counts = getTagCounts()
    local done = {}

    local right_sided = BetterTags.config.ui_location == 2
    local padding = right_sided and 0.05 or 0.1
    for k, tag in pairs(G.GAME.tags) do
        if not done[tag.key] then
            local tag_sprite_ui = tag:generate_UI()
            tag.count = counts[tag.key]
            
            if tag.key == "tag_cry_cat" and BetterTags.config.auto_merge_cat_tags then
                tag.cat_count = tag.cat_count or 1
                tag.count = tag.cat_count
            end
            G.HUD_tags[#G.HUD_tags+1] = UIBox{
                definition = {n=G.UIT.ROOT, config={align = "cm",padding = 0.05, colour = G.C.CLEAR}, nodes={
                    BetterTags.config.ui_location == 2 and tag_sprite_ui or nil,
                    {n= G.UIT.C, config={align = "cm", padding=padding}, nodes={   
                        {n = G.UIT.T, config = {text = 'x'..tag.count, scale = 0.4, colour = G.C.UI.TEXT_LIGHT}},
                    }},
                    BetterTags.config.ui_location == 1 and tag_sprite_ui or nil,
                }},
                config = {
                    align = G.HUD_tags[1] and 'tm' or 'bri',
                    offset = G.HUD_tags[1] and {x=0,y=0} or {x=1,y=0},
                    major = G.HUD_tags[1] and G.HUD_tags[#G.HUD_tags] or G.ROOM_ATTACH
                },
            }
            if Handy then
                local _handy_tag_click_target = tag.tag_sprite
                local _handy_tag_click_ref = _handy_tag_click_target.click
                _handy_tag_click_target.click = function(...)
                    if Handy.controller.process_tag_click(tag) then return end
                    return _handy_tag_click_ref(...)
                end
            end
            done[tag.key] = {
                HUD_tag = G.HUD_tags[#G.HUD_tags],
                tag = tag
            }
        else
            if tag.key == "tag_cry_cat" and BetterTags.config.auto_merge_cat_tags then
                done["tag_cry_cat"].tag.cat_count = (done["tag_cry_cat"].tag.cat_count or 0) + 1
                tag.HUD_tag = done[tag.key].HUD_tag
                tag:remove()
            end
        end
        
        tag.HUD_tag = done[tag.key].HUD_tag
    end
    BetterTags.tag_count = 0
    for k, tag in pairs(done) do
        BetterTags.tag_count = BetterTags.tag_count + tag.tag.count
    end

    -- Cryptid Cat Tag. 
    local cat_ref = done["tag_cry_cat"]
    if cat_ref and cat_ref.tag then
        local cat_tag = cat_ref.tag

        local count = cat_tag.cat_count or cat_tag.count
        local logvalue = math.log(count,2)+1
        cat_tag.count = count

        if (logvalue == math.floor(logvalue)) and not (cat_tag.ability.level == logvalue) and not (logvalue == 1) then
            cat_tag.ability.level = logvalue
            upgradeCatTag(cat_tag)
        end
    end
end 

function upgradeCatTag(cat_tag, new_tag) 
    local perc = (cat_tag.ability.level + 1)/10
    if perc > 1 then perc = 1 end

    local edition = G.P_CENTER_POOLS.Edition[1]
    local j = 1
    while j < cat_tag.ability.level + 1 do
        for i = 2, #G.P_CENTER_POOLS.Edition do
            j = j + 1
            if j >= cat_tag.ability.level + 1 then
                edition = G.P_CENTER_POOLS.Edition[i]
                break
            end
        end
    end

    G.E_MANAGER:add_event(Event({
        delay = 0.0,
        trigger = 'immediate',
        func = (function()
            attention_text({
                text = ""..cat_tag.ability.level,
                colour = G.C.WHITE,
                scale = 1,
                hold = 0.3/G.SETTINGS.GAMESPEED,
                cover = cat_tag.HUD_tag,
                cover_colour = G.C.DARK_EDITION,
                align = 'cm',
            })
            play_sound('generic1', 0.8 + perc/2, 0.6)
            play_sound('multhit1', 0.9 + perc/2, 0.4)
            return true
        end)
    }))

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 0.2,
        func = (function()
            cat_tag:juice_up(0.25, 0.1)
            cat_tag.ability.edshader = edition.shader
            play_sound(edition.sound.sound, (edition.sound.per or 1)*1.3, (edition.sound.vol or 0.25)*0.6)
            generateTagUi()
            return true
        end)
    }))
end

-- watch lua Mods/BetterTags/main.lua