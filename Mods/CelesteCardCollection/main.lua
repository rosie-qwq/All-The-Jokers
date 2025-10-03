--- old
--- MOD_NAME: Celeste Card Collection
--- MOD_ID: CelesteCardCollection
--- PREFIX: ccc
--- MOD_AUTHOR: [AuroraAquir, toneblock, Gappie, bein, sunsetquasar, goose!]
--- MOD_DESCRIPTION: Featuring 4 new decks, 50+ new jokers, and 2 new vouchers! Additional thanks to Bred and Fytos for concepts!
--- PRIORITY: 10
--- DISPLAY_NAME: CCC
--- BADGE_COLOUR: ffc0ff
--- DEPENDENCIES: [Steamodded>=1.0.0~BETA-0308a]
--- VERSION: 0.35.0


----------------------------------------------
------------MOD CODE -------------------------

assert(SMODS.load_file("lua_files/_helper_functions.lua"))()

-- region JOKERS
SMODS.Atlas({key = "j_ccc_jokers", path = "j_ccc_jokers.png", px = 71, py = 95, atlas = "asset_atlas"})
local joker_order = assert(assert(SMODS.load_file("lua_files/jokers.lua"))(), "Joker order was not returned by jokers.lua file!")

-- load joker files in jokers folder
local full_path = SMODS.current_mod.path:gsub("\\", "/")
local joker_data = {}

function loadFiles(prefix, files)
	for k, file in ipairs(files) do            
		local file_type = NFS.getInfo(full_path .. prefix .. file).type
		if file_type == 'directory' then 
			loadFiles(prefix .. file .. "/", NFS.getDirectoryItems(full_path .. prefix .. file))
		else 
			local joker = assert(assert(SMODS.load_file(prefix .. file))(), "Trying to load joker file " .. prefix .. file .. " failed! Returned false value, did you forget to return the config?")

			table.insert(joker_data, 1, joker)
		end
	end
end

local files = NFS.getDirectoryItems(full_path .. "lua_files/jokers")
loadFiles("lua_files/jokers/", files)

local key_lookup = {}
local i = 1
for line in joker_order:gmatch("([^\r\n]+)[\r\n]*") do  -- Changed the * to +
	key_lookup[line] = i
	i = i + 1
end

table.sort(joker_data, function(a, b)

    
    local order_a = assert(key_lookup["j_ccc_" .. a.key], "Key '" .. "j_ccc_" ..tostring(a.key) .. "' not found in key_order list.")
    local order_b = assert(key_lookup["j_ccc_" .. b.key], "Key '" .. "j_ccc_" ..tostring(b.key) .. "' not found in key_order list.")
	
    return order_a < order_b
  end)



for i, joker in ipairs(joker_data) do
	SMODS.Joker(joker)
end

sendDebugMessage("[CCC] Joker files load attempted, if you do not see a 'Last Joker file loaded' before this it failed!")

-- endregion JOKERS

SMODS.Atlas({key = "b_ccc_decks", path = "b_ccc_decks.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(SMODS.load_file("lua_files/decks.lua"))()

SMODS.Atlas({key = "v_ccc_vouchers", path = "v_ccc_vouchers.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(SMODS.load_file("lua_files/vouchers.lua"))()

SMODS.Atlas({key = "bl_ccc_blinds", path = "bl_ccc_blinds.png", px = 34, py = 34, frames = 21, atlas_table = "ANIMATION_ATLAS"})
assert(SMODS.load_file("lua_files/blinds.lua"))()

SMODS.Atlas({key = "c_ccc_consumables", path = "c_ccc_consumables.png", px = 71, py = 95, atlas = "asset_atlas"})
assert(SMODS.load_file("lua_files/consumables.lua"))()

if CardSleeves then
	SMODS.Atlas({key = "s_ccc_sleeves", path = "s_ccc_sleeves.png", px = 73, py = 95, atlas = "asset_atlas"})
	assert(SMODS.load_file("lua_files/sleeves.lua"))()
end
assert(SMODS.load_file("lua_files/editions.lua"))()

assert(SMODS.load_file("lua_files/rarity.lua"))()

SMODS.Atlas({key = "moveblock_pr", path = "moveblock_pr.png", px = 71, py = 95, atlas = "asset_atlas"})
SMODS.Atlas({key = "moveblock_rl", path = "moveblock_rl.png", px = 71, py = 95, atlas = "asset_atlas"})

SMODS.Atlas({
    key = "modicon",
    path = "ccc_icon.png",
    px = 34,
    py = 34
}):register()

SMODS.current_mod.optional_features = {
	cardareas = {
		unscored = true,
	},
}

if not to_big then
	function to_big(x) return x end
end

----------------------------------------------
------------MOD CODE END----------------------
