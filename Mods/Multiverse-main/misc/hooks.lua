local is_face_hook = Card.is_face
function Card:is_face(from_boss)
    if self.config.center.key == "m_mul_calling_card" then
        if self.debuff and not from_boss then return end
        if next(SMODS.find_card("j_pareidolia")) then return true end
    end
    if self.config.center.key == "m_mul_normal" then
        if self.debuff and not from_boss then return end
        return true
    end
    return is_face_hook(self, from_boss)
end

local is_suit_hook = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
    if self.config.center.key == "m_mul_calling_card" then
        if flush_calc then
            if SMODS.find_card("j_smeared") then
                return self.base.suit == "Hearts" or self.base.suit == "Diamonds"
            end
            return self.base.suit == "Hearts"
        else
            if self.debuff and not bypass_debuff then return end
            if SMODS.find_card("j_smeared") then
                return self.base.suit == "Hearts" or self.base.suit == "Diamonds"
            end
            return self.base.suit == "Hearts"
        end
    end
    return is_suit_hook(self, suit, bypass_debuff, flush_calc)
end

local get_id_hook = Card.get_id
function Card:get_id()
    if self.config.center.key == "m_mul_calling_card" and not self.vampired then
        return 14
    end
    return get_id_hook(self)
end

local draw_hook = love.draw
function love.draw()
    draw_hook()
    local width, height = love.graphics.getDimensions()
    local x_factor = width / 1536
    local y_factor = height / 864
    for key, anim in pairs(Multiverse.all_animations) do
        if anim.is_active then
            --print(Multiverse.clamp(math.floor(anim.progress) + 1, 1, #anim.frames))
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(
                anim.image,
                anim.frames[Multiverse.clamp(math.floor(anim.progress) + 1, 1, #anim.frames)],
                Multiverse.anchors.x[anim.anchor.x_alignment] + (anim.anchor.x_offset or 0) * x_factor,
                Multiverse.anchors.y[anim.anchor.y_alignment] + (anim.anchor.y_offset or 0) * y_factor,
                anim.rotation,
                anim.x_scale * x_factor,
                anim.y_scale * y_factor,
                Multiverse.base_offsets.x[anim.anchor.x_alignment](anim),
                Multiverse.base_offsets.y[anim.anchor.y_alignment](anim),
                0,
                0
            )
        end
    end
    for key, video in pairs(Multiverse.all_videos) do
        if video.is_visible then
            love.graphics.setColor(1, 1, 1, 1)
            love.graphics.draw(
                video.video,
                Multiverse.anchors.x[video.anchor.x_alignment] + (video.anchor.x_offset or 0) * x_factor,
                Multiverse.anchors.y[video.anchor.y_alignment] + (video.anchor.y_offset or 0) * y_factor,
                video.rotation,
                video.x_scale * x_factor,
                video.y_scale * y_factor,
                Multiverse.base_offsets.x[video.anchor.x_alignment](video),
                Multiverse.base_offsets.y[video.anchor.y_alignment](video),
                0,
                0
            )
        end
    end
    if Multiverse.in_limbo then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
            Multiverse.LIMBO_INSTRUCTIONS_SPRITE,
            love.graphics.getWidth() - 50 * x_factor,
            love.graphics.getHeight() / 2,
            0,
            x_factor,
            y_factor,
            200,
            150,
            0,
            0
        )
        if Multiverse.in_limbo == "end" then
            for _, key in ipairs(Multiverse.limbo_keys) do
                love.graphics.setColor(key.end_color)
                love.graphics.draw(
                    Multiverse.LIMBO_KEY_SPRITE,
                    love.graphics.getWidth() / 2 + (key.x - 2.5) * 150 * x_factor,
                    love.graphics.getHeight() / 2 + (key.y - 1.5) * 150 * y_factor,
                    0,
                    x_factor,
                    y_factor,
                    30.5,
                    21.5,
                    0,
                    0
                )
            end
        else
            for _, key in ipairs(Multiverse.limbo_keys) do
                love.graphics.setColor(key.current_color)
                love.graphics.draw(
                    Multiverse.LIMBO_KEY_SPRITE,
                    love.graphics.getWidth() / 2 + (key.x - 2.5) * 150 * x_factor,
                    love.graphics.getHeight() / 2 + (key.y - 1.5) * 150 * y_factor,
                    0,
                    x_factor,
                    y_factor,
                    30.5,
                    21.5,
                    0,
                    0
                )
            end
        end
    end
    if Multiverse.in_undyne then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
            Multiverse.SOUL_BACKGROUND_SPRITE,
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2,
            0,
            x_factor,
            y_factor,
            74,
            74,
            0,
            0
        )
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
            Multiverse.GREEN_SOUL_SPRITE,
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2,
            0,
            x_factor,
            y_factor,
            74,
            74,
            0,
            0
        )
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
            Multiverse.SHIELD_SPRITE,
            love.graphics.getWidth() / 2,
            love.graphics.getHeight() / 2,
            Multiverse.shield_rotations[Multiverse.shield_dir or "up"] or 0,
            x_factor,
            y_factor,
            74,
            74,
            0,
            0
        )
        for _, spear in ipairs(Multiverse.undyne_spears) do
            if spear.active then
                love.graphics.setColor(1, 1, 1, 1)
                local current_sprite
                if spear.is_reversed then
                    current_sprite = Multiverse.REVERSE_SPEAR_SPRITE
                elseif spear.r <= 300 then
                    current_sprite = Multiverse.NEAR_SPEAR_SPRITE
                else
                    current_sprite = Multiverse.FAR_SPEAR_SPRITE
                end
                love.graphics.draw(
                    current_sprite,
                    love.graphics.getWidth() / 2 - spear.r * math.cos(spear.theta) * x_factor,
                    love.graphics.getHeight() / 2 - spear.r * math.sin(spear.theta) * y_factor,
                    Multiverse.spear_rotations[spear.dir],
                    x_factor,
                    y_factor,
                    22,
                    14,
                    0,
                    0
                )
            end
        end
    elseif G.GAME.blind and G.GAME.blind.config.blind.key == "bl_mul_undying" then
        love.graphics.setColor(1, 1, 1, 1)
        love.graphics.draw(
            Multiverse.UNDYING_INSTRUCTIONS_SPRITE,
            love.graphics.getWidth() - 50 * x_factor,
            love.graphics.getHeight() / 2,
            0,
            x_factor,
            y_factor,
            200,
            150,
            0,
            0
        )
    end
end

local update_hook = G.update
function G:update(dt)
    update_hook(self, dt)
    if G.SPLASH_MULTIVERSE_LOGO then
        G.SPLASH_MULTIVERSE_LOGO:set_alignment({
            major = G.title_top,
            type = "cm",
            bond = "Strong",
            offset = { x = 8 * math.sin(G.TIMERS.REAL * 0.075), y = 3.75 * math.cos(G.TIMERS.REAL * 0.075) }
        })
    end
    for key, anim in pairs(Multiverse.all_animations) do
        if anim.is_active then
            if anim.is_continuous then
                anim.progress = anim.progress + G.real_dt * #anim.frames / anim.duration
                if anim.progress >= #anim.frames then
                    anim.progress = anim.progress - #anim.frames
                end
                -- anim_progress \in [0, #anim_frames)
                -- anim_progress + 1 \in [1, anim_frames + 1)
            else
                if anim.progress < #anim.frames then
                    anim.progress = anim.progress + G.real_dt * #anim.frames / anim.duration
                else
                    anim.is_active = false
                end
            end
        end
    end
    for i, spear in pairs(Multiverse.undyne_spears) do
        if spear.active then
            if spear.r < 35 then
                play_sound("mul_take_damage", 1, 0.7)
                G.GAME.chips = G.GAME.chips - G.GAME.blind.chips / to_big(10)
                spear.active = false
            elseif spear.r < 70 then
                local check_dir = spear.is_reversed and Multiverse.opposite_sides[spear.dir] or spear.dir
                if check_dir == Multiverse.shield_dir then
                    spear.active = false
                    play_sound("mul_block_spear", 1, 0.75)
                end
            end
            if spear.is_reversed and not spear.is_reversing and spear.r < Multiverse.clamp(spear.velocity / 4 + 150, 250, 350) then
                spear.is_reversing = true
                G.E_MANAGER:add_event(Event({
                    trigger = "ease",
                    delay = math.min(0.2, 0.3 - spear.velocity / 10000) * (G.SPEEDFACTOR or 1),
                    ease_to = spear.theta + math.pi,
                    ref_table = spear,
                    ref_value = "theta",
                    blockable = false,
                    blocking = false
                }), "other", true)
            end
            spear.r = spear.r - G.real_dt * spear.velocity
        end
    end
end

local tooltip_hook = create_popup_UIBox_tooltip
function create_popup_UIBox_tooltip(tooltip)
    local ret = tooltip_hook(tooltip)
    if ret and tooltip.colour then
        ret.config.colour = tooltip.colour
    end
    return ret
end

local copy_card_hook = copy_card
function copy_card(other, new_card, card_scale, playing_card, strip_edition)
    local card = copy_card_hook(other, new_card, card_scale, playing_card, strip_edition)
    if card and SMODS.has_enhancement(card, "m_mul_waldo") and not G.VIEWING_DECK then
        if not Multiverse.all_animations["explosion"].is_active then
            Multiverse.start_animation("explosion")
            play_sound("mul_deltarune_explosion", 1, 0.7)
        end
        card:set_ability("c_base", nil, true)
    end
    return card
end

local mousepressed_hook = love.mousepressed
function love.mousepressed(x, y, button, istouch, presses)
    mousepressed_hook(x, y, button, istouch, presses)
    if Multiverse.in_limbo == "end" and not Multiverse.has_guessed then
        local clicked = Multiverse.detect_key_click(x, y)
        if clicked then
            Multiverse.has_guessed = true
            Multiverse.in_limbo = nil
            Multiverse.limbo_safe = clicked.is_correct
            if not clicked.is_correct then
                G.GAME.blind.chips = G.GAME.blind.chips * 10
                G.GAME.blind.chip_text = number_format(G.GAME.blind.chips)
                Multiverse.start_animation("explosion")
                play_sound("mul_deltarune_explosion", 1, 0.8)
            end
        end
    end
end

local keypressed_hook = love.keypressed
function love.keypressed(key, scancode, is_repeat)
    keypressed_hook(key, scancode, is_repeat)
    if Multiverse.in_undyne then
        if key == "left" or key == "right" or key == "up" or key == "down" then
            Multiverse.shield_dir = key
        end
    end
end

local options_hook = G.FUNCS.options
function G.FUNCS.options()
    if Multiverse.in_limbo or Multiverse.in_undyne then return end
    options_hook()
end

local info_hook = G.FUNCS.run_info
function G.FUNCS.run_info()
    if Multiverse.in_limbo or Multiverse.in_undyne then return end
    info_hook()
end

local deck_info_hook = G.FUNCS.deck_info
function G.FUNCS.deck_info()
    if Multiverse.in_limbo or Multiverse.in_undyne then return end
    deck_info_hook()
end

local card_click_hook = Card.click
function Card:click()
    if self.config.center.key == "j_mul_mod_logo" then
        if math.random() <= 0.00333 then
            love.system.openURL("https://www.youtube.com/watch?v=dQw4w9WgXcQ")
        end
    end
    card_click_hook(self)
end
