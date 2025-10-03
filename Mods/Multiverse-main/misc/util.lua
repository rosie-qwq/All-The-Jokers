Multiverse = Multiverse or {}
---Talisman compatibility?
to_big = to_big or function(x)
    return x
end
---Checks if value is mapped to a key within a table t.
---@param table table
---@param value any
---@return boolean
function Multiverse.contains_value(table, value)
    for _, v in ipairs(table) do
        if v == value then return true end
    end
    return false
end

---Counts the number of items in a table t.
---@param table table
---@return integer
function Multiverse.len(table)
    local count = 0
    for _, _ in pairs(table) do
        count = count + 1
    end
    return count
end


---Forces a number to be within a given range.
---@param n number
---@param min? number
---@param max? number
---@return number
function Multiverse.clamp(n, min, max)
    local lower = min or 0
    local higher = max or 1
    if lower > higher then error("min cannot be higher than max") end
    if n < lower then
        return lower
    elseif n > higher then
        return higher
    else
        return n
    end
end

---Returns all cards in t such that func(t) is truthy.
---@param t Card[]
---@param func fun(card: Card): boolean
---@return Card[]
function Multiverse.filter(t, func)
    local ret = {}
    for _, c in ipairs(t) do
        if func(c) then
            table.insert(ret, c)
        end
    end
    return ret
end

---Updates the animation state of a given card.
---
---Make sure to pass in <code>G.real_dt</code> for the dt argument.
---@param card Card
---@param dt number
---@param vertical? boolean
function Multiverse.update_card_anim(card, dt, vertical)
    local dir = (vertical and "y") or "x"
    if card.config.center.anim_info then
        local data = card.config.center.anim_info
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress or 0
        card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress +
        (dt * data.frames / data.anim_time)
        if card.config.center.anim_info.anim_progress >= data.frames then
            card.config.center.anim_info.anim_progress = card.config.center.anim_info.anim_progress - data.frames
        end
        card.config.center.pos[dir] = Multiverse.clamp(math.floor(card.config.center.anim_info.anim_progress), 0,
            data.frames)
    end
end

---@class Anchor
---@field x_alignment "l" | "c" | "r"
---@field y_alignment "b" | "c" | "t"
---@field x_offset number?
---@field y_offset number?

---@class Multiverse.Animation
---@field path string The name of the file where the animation is stored
---@field frames integer The number of frames the animation has
---@field columns integer? The number of columns the spritesheet has. Do not include if the spritesheet is all in one row.
---@field px integer The width of an individual frame of the animation
---@field py integer The height of an individual frame of the animation
---@field key string The key of the animation
---@field is_continuous boolean? Whether or not this animation is supposed to run continuously
---@field anchor Anchor The place on the screen where the animation is
---@field duration number The amount of time that one animation loop will take
---@field x_scale number? The factor that the animation will be scaled horizontally
---@field y_scale number? The factor that the animation will be scaled vertically
---@field rotation number? The rotation of the animation in radians

---@class Multiverse.AnimationData
---@field frames love.Quad[] The quadrants of the file that each represent a single frame
---@field image love.Image The image where all the quadrants are derived from
---@field is_active boolean Whether or not the animation is displayed on screen
---@field progress number Represents the completion progress of the animation
---@field px integer The width of an individual frame of the animation
---@field py integer The height of an individual frame of the animation
---@field is_continuous boolean? Whether or not this animation is supposed to run continuously
---@field anchor Anchor The place on the screen where the animation is
---@field duration number The amount of time that one animation loop will take
---@field x_scale number? The factor that the animation will be scaled horizontally
---@field y_scale number? The factor that the animation will be scaled vertically
---@field rotation number? The rotation of the animation in radians

---@type table<string, Multiverse.AnimationData>
Multiverse.all_animations = {}

---Registers an animation to a global table.
---Access this animation with Multiverse.all_animations[key].
---@param t Multiverse.Animation
---@return Multiverse.AnimationData
function Multiverse.Animation(t)
    local file_data = assert(NFS.newFileData(Multiverse.path .. "assets/animations/" .. t.path),
        "Failed to get file data")
    local image_data = assert(love.image.newImageData(file_data), "Failed to convert to image data")
    local love_image = assert(love.graphics.newImage(image_data), "Failed to create an image")
    ---@type Multiverse.AnimationData
    local anim_data = {
        frames = {},
        image = love_image,
        is_active = false,
        progress = 0,
        is_continuous = t.is_continuous or false,
        anchor = t.anchor,
        x_scale = t.x_scale or 1,
        y_scale = t.y_scale or 1,
        rotation = t.rotation or 0,
        px = t.px,
        py = t.py,
        duration = t.duration
    }
    for i = 1, t.frames do
        local x, y = (i - 1) % (t.columns or i), (t.columns and math.floor((i - 1) / t.columns) or 0)
        anim_data.frames[#anim_data.frames + 1] = love.graphics.newQuad(x * t.px, y * t.py, t.px, t.py, love_image)
    end
    Multiverse.all_animations = Multiverse.all_animations or {}
    Multiverse.all_animations[t.key] = anim_data
    return anim_data
end

---@type table<string,table<string, number>>>
Multiverse.anchors = {
    x = {
        l = 0,
        c = love.graphics.getWidth() / 2,
        r = love.graphics.getWidth()
    },
    y = {
        t = 0,
        c = love.graphics.getHeight() / 2,
        b = love.graphics.getHeight()
    }
}
---Gets the correct offset for love.draw based on the animation's dimensions
---using a function that takes in AnimationData or VideoData and returns a number.
---The functions are grouped by axis and then by alignment type.
---@type table<string, table<string, fun(a: Multiverse.AnimationData | Multiverse.VideoData): number>>
Multiverse.base_offsets = {
    x = {
        l = function(a)
            return 0
        end,
        c = function(a)
            return a.px / 2
        end,
        r = function(a)
            return a.px
        end
    },
    y = {
        t = function(a)
            return 0
        end,
        c = function(a)
            return a.py / 2
        end,
        b = function(a)
            return a.py
        end
    }
}

---Starts the animation with the given key.
---@param key string The key of the animation to start
function Multiverse.start_animation(key)
    if Multiverse.all_animations[key] then
        Multiverse.all_animations[key].progress = 0
        Multiverse.all_animations[key].is_active = true
    else
        error("No animation for " .. key .. " exists")
    end
end

---Ends the animation with the given key.
---@param key string
function Multiverse.end_animation(key)
    if Multiverse.all_animations[key] then
        Multiverse.all_animations[key].progress = 0
        Multiverse.all_animations[key].is_active = false
    else
        error("No animation for " .. key .. " exists")
    end
end

---@class Multiverse.Video
---@field path string The name of the file where the video is stored
---@field key string The key of the video.
---@field anchor Anchor The place on the screen where the video is
---@field x_scale number? The factor that the video will be scaled horizontally
---@field y_scale number? The factor that the video will be scaled vertically
---@field rotation number? The rotation of the video in radians
---@field volume number? The volume of the video

---@class Multiverse.VideoData
---@field video love.Video The video to be displayed
---@field anchor Anchor The place on the screen where the video is
---@field x_scale number? The factor that the video will be scaled horizontally
---@field y_scale number? The factor that the video will be scaled vertically
---@field rotation number? The rotation of the video in radians
---@field px integer The width of an individual frame of the video
---@field py integer The height of an individual frame of the video
---@field is_visible boolean Whether or not the video is visible on screen

---@type table<string, Multiverse.VideoData>
Multiverse.all_videos = {}

---Registers a video to a global table.
---Access this video with Multiverse.all_videos[key].
---@param t Multiverse.Video
---@return Multiverse.VideoData
function Multiverse.Video(t)
    local path = Multiverse.path .. "assets/videos/" .. t.path
    local f = NFS.read(path)
    love.filesystem.write("mul_" .. t.key .. ".ogv", f)
    local love_video = love.graphics.newVideo("mul_" .. t.key .. ".ogv")
    if love_video:getSource() then
        love_video:getSource():setVolume(G.SETTINGS.SOUND.volume * G.SETTINGS.SOUND.game_sounds_volume / 1000)
    end
    ---@type Multiverse.VideoData
    local v_data = {
        video = love_video,
        anchor = t.anchor,
        x_scale = t.x_scale or 1,
        y_scale = t.y_scale or 1,
        rotation = t.rotation or 0,
        px = love_video:getWidth(),
        py = love_video:getHeight(),
        is_visible = false
    }
    Multiverse.all_videos = Multiverse.all_videos or {}
    Multiverse.all_videos[t.key] = v_data
    return v_data
end

function Multiverse.play_video(key)
    if Multiverse.all_videos[key] then
        Multiverse.all_videos[key].video:rewind()
        Multiverse.all_videos[key].video:play()
        Multiverse.all_videos[key].is_visible = true
    else
        error("No video for " .. key .. " exists")
    end
end

function Multiverse.pause_video(key)
    if Multiverse.all_videos[key] then
        Multiverse.all_videos[key].video:pause()
    else
        error("No video for " .. key .. " exists")
    end
end

function Multiverse.stop_video(key)
    if Multiverse.all_videos[key] then
        Multiverse.all_videos[key].is_visible = false
        Multiverse.all_videos[key].video:pause()
    else
        error("No video for " .. key .. " exists")
    end
end

function Multiverse.set_transmute_requirements(base)
    return Multiverse.config.debug and 1 or base
end