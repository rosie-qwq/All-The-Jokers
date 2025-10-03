local near_spear_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/near_spear.png"))
local near_spear_data = assert(love.image.newImageData(near_spear_file))
Multiverse.NEAR_SPEAR_SPRITE = assert(love.graphics.newImage(near_spear_data))

local far_spear_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/far_spear.png"))
local far_spear_data = assert(love.image.newImageData(far_spear_file))
Multiverse.FAR_SPEAR_SPRITE = assert(love.graphics.newImage(far_spear_data))

local reverse_spear_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/reverse_spear.png"))
local reverse_spear_data = assert(love.image.newImageData(reverse_spear_file))
Multiverse.REVERSE_SPEAR_SPRITE = assert(love.graphics.newImage(reverse_spear_data))

local green_soul_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/green_soul.png"))
local green_soul_data = assert(love.image.newImageData(green_soul_file))
Multiverse.GREEN_SOUL_SPRITE = assert(love.graphics.newImage(green_soul_data))

local soul_background_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/soul_background.png"))
local soul_background_data = assert(love.image.newImageData(soul_background_file))
Multiverse.SOUL_BACKGROUND_SPRITE = assert(love.graphics.newImage(soul_background_data))

local shield_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/shield.png"))
local shield_data = assert(love.image.newImageData(shield_file))
Multiverse.SHIELD_SPRITE = assert(love.graphics.newImage(shield_data))

local undying_instructions_file = assert(NFS.newFileData(Multiverse.path .. "assets/misc/undying_instructions.png"))
local undying_instructions_data = assert(love.image.newImageData(undying_instructions_file))
Multiverse.UNDYING_INSTRUCTIONS_SPRITE = assert(love.graphics.newImage(undying_instructions_data))

---@class Multiverse.undyne_spear
---@field velocity number
---@field dir "left" | "right" | "up" | "down"
---@field is_reversed boolean
---@field is_reversing boolean
---@field r number
---@field theta number
---@field active boolean

Multiverse.in_undyne = false
Multiverse.shield_dir = nil

---@type Multiverse.undyne_spear[]
Multiverse.undyne_spears = {}

Multiverse.shield_rotations = {
    up = 0,
    right = math.pi / 2,
    down = math.pi,
    left = 3 * math.pi / 2
}

Multiverse.spear_rotations = {
    left = 0,
    up = math.pi / 2,
    right = math.pi,
    down = 3 * math.pi / 2
}

Multiverse.opposite_sides = {
    left = "right",
    right = "left",
    up = "down",
    down = "up"
}

---@type {[1]: number, [2]: "left" | "up" | "down" | "right", [3]: boolean, [4]: number}[][]
Multiverse.undyne_attacks = {
    {
        { 800,  "right", false, 0.35 },
        { 800,  "left",  true,  0.35 },
        { 800,  "left",  false, 0.35 },
        { 800,  "right", true,  0.35 },
        { 800,  "up",    false, 0.35 },
        { 800,  "down",  true,  0.35 },
        { 800,  "down",  false, 0.35 },
        { 800,  "up",    true,  0.35 },
        { 1000, "up",    false, 1.2 },
        { 1000, "right", false, 0.2 },
        { 1000, "down",  false, 0.2 },
        { 1000, "left",  false, 0.2 },
    },
    {
        { 500,  "right", false, 0.25 },
        { 500,  "right", true,  0.25 },
        { 500,  "right", false, 0.25 },
        { 500,  "right", true,  0.25 },
        { 800,  "left",  false, 1.4 },
        { 800,  "left",  false, 0.2 },
        { 800,  "down",  true,  0.4 },
        { 800,  "up",    true,  0.4 },
        { 800,  "right", true,  0.4 },
        { 800,  "left",  true,  0.4 },
        { 1500, "up",    false, 2 },
    },
    {
        { 200, "right", false, 0.25 },
        { 200, "up",    false, 0.25 },
        { 200, "right", false, 0.25 },
        { 200, "down",  false, 0.25 },
        { 200, "left",  true,  0.25 },
        { 200, "left",  false, 0.25 },
        { 200, "up",    false, 0.25 },
        { 200, "down",  false, 0.25 },
        { 200, "up",    true,  0.25 },
        { 200, "down",  true,  0.25 },
        { 200, "right", false, 0.25 },
        { 200, "left",  false, 0.25 },
        { 200, "right", false, 0.25 },
        { 200, "left",  false, 0.25 },
        { 200, "up",    true,  0.25 },
        { 200, "down",  true,  0.25 },
        { 200, "up",    true,  0.25 },
        { 200, "down",  true,  0.25 },
    },
    {
        { 1000, "up",    false, 0.25 },
        { 1000, "down",  false, 0.25 },
        { 1000, "right", false, 0.25 },
        { 1000, "right", false, 0.25 },
        { 1000, "left",  false, 0.25 },
        { 1000, "down",  false, 0.25 },
        { 1000, "up",    false, 0.25 },
        { 1000, "up",    false, 0.25 },
        { 1000, "down",  false, 0.25 },
        { 1000, "left",  false, 0.25 },
        { 1000, "up",    false, 0.25 },
        { 1000, "right", false, 0.25 },
        { 1000, "up",    false, 0.25 },
        { 1000, "down",  false, 0.25 },
        { 1000, "left",  false, 0.25 },
        { 1000, "right", false, 0.25 },
    },
    {
        { 800, "up",    false, 0.4 },
        { 800, "up",    false, 0.2 },
        { 800, "up",    false, 0.2 },
        { 800, "up",    false, 0.2 },
        { 800, "left",  true,  0.2 },
        { 800, "up",    false, 0.4 },
        { 800, "up",    false, 0.2 },
        { 800, "up",    false, 0.2 },
        { 800, "up",    false, 0.2 },
        { 800, "right", true,  0.2 },
        { 800, "up",    true,  0.4 },
        { 800, "up",    true,  0.2 },
        { 800, "up",    true,  0.2 },
        { 800, "up",    true,  0.2 },
        { 800, "up",    false, 0.2 },
    },
    {
        { 700, "down",  false, 0.3 },
        { 300, "left",  true,  0.3 },
        { 700, "right", false, 0.3 },
        { 700, "down",  false, 0.3 },
        { 700, "left",  false, 0.3 },
        { 700, "up",    false, 0.3 },
        { 700, "left",  false, 0.3 },
        { 700, "up",    false, 0.3 },
        { 700, "down",  false, 0.3 },
        { 300, "right", true,  0.3 },
        { 700, "up",    false, 0.3 },
        { 700, "right", false, 0.3 },
        { 700, "up",    false, 0.3 },
        { 700, "down",  false, 0.3 },
        { 700, "left",  false, 0.3 },
        { 700, "right", false, 0.3 },
    },
    {
        { 800,  "left",  false, 0.3 },
        { 800,  "right", false, 0.3 },
        { 800,  "up",    false, 0.3 },
        { 800,  "left",  false, 0.3 },
        { 800,  "right", false, 0.3 },
        { 800,  "down",  true,  0.3 },
        { 800,  "right", true,  0.3 },
        { 800,  "left",  false, 0.3 },
        { 800,  "down",  false, 0.3 },
        { 800,  "left",  true,  0.3 },
        { 800,  "right", true,  0.3 },
        { 800,  "right", false, 0.3 },
        { 800,  "left",  false, 0.3 },
        { 1500, "right", false, 2 },
    },
    {
        { 700,  "left",  false, 0.3 },
        { 400,  "right", true,  0.6 },
        { 700,  "right", true,  0.3 },
        { 500,  "down",  true,  0.4 },
        { 700,  "right", false, 0.6 },
        { 700,  "down",  false, 0.3 },
        { 700,  "left",  false, 0.5 },
        { 700,  "down",  false, 0.3 },
        { 700,  "down",  false, 0.3 },
        { 1000, "left",  true,  0.5 },
    },
}

---@param i integer?
---@param p {[1]: number, [2]: "left" | "up" | "down" | "right", [3]: boolean, [4]: number}[]?
Multiverse.start_undyne_attack = function(i, p)
    local index = i or 1
    local pattern = p or Multiverse.undyne_attacks[math.random(#Multiverse.undyne_attacks)]
    G.E_MANAGER:add_event(Event({
        trigger = "after",
        delay = pattern[index][4] * (G.SPEEDFACTOR or 1),
        func = function()
            table.insert(Multiverse.undyne_spears, {
                r = 850,
                theta = Multiverse.spear_rotations[pattern[index][2]],
                velocity = pattern[index][1],
                is_reversed = pattern[index][3],
                active = true,
                is_reversing = false,
                dir = pattern[index][2],
            })
            if pattern[index + 1] then
                Multiverse.start_undyne_attack(index + 1, pattern)
            end
            return true
        end
    }), "other")
    return #pattern
end
