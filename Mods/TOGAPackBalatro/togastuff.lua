-- We are loading...
sendInfoMessage("░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▐▓█▀▀▀▀▀▀▀▀█▓▌░▄▄▄▄▄░░", "TOGAPack")
sendInfoMessage("░█░░░█▀█░█▀█░█▀▄░█░█▄░█░█▀▀░░░░░░░░▐▓█░░░░░░░░█▓▌░█▄▄▄█░░", "TOGAPack")
sendInfoMessage("░█░░░█░█░█▀█░█░█░█░█░▀█░█░█░░░░░░░░▐▓█░░░░░░░░█▓▌░█▄▄▄█░░", "TOGAPack")
sendInfoMessage("░▀▀▀░▀▀▀░▀░▀░▀▀░░▀░▀░░▀░▀▀▀░░▀░▀░▀░▐▓█▄▄▄▄▄▄▄▄█▓▌░█████░░", "TOGAPack")
sendInfoMessage("░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▄▄██▄▄░░░░░█████░░", "TOGAPack")
sendInfoMessage("Hello World! Starting TOGAPack...", "TOGAPack")

-- Define thy map.
SMODS.Atlas{key = "TOGAJokersMain", path = "togajokers.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersMainW", path = "togajokersw.png", px = 91, py = 95}
SMODS.Atlas{key = "TOGAJokersOther", path = "togajokersother.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersOtherDiffSize", path = "togajokersothersize.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersWindows", path = "togajokerswinos.png", px = 72, py = 95}
SMODS.Atlas{key = "TOGAJokersMac", path = "togamacos.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersLinux", path = "togalinuxos.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokersUpdate", path = "togajokerupdate.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAJokerRover", path = "togarover.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGABoosterPack", path = "togabooster.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAConsumables", path = "togacons.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGADeckBack", path = "togadeck.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGATags", path = "togatags.png", px = 34, py = 34}
SMODS.Atlas{key = "TOGASeals", path = "togaseal.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGAEnhancements", path = "togaenh.png", px = 71, py = 95}
SMODS.Atlas{key = "TOGADialUpBlind", path = "togadialupblind.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 24}
SMODS.Atlas{key = "TOGAWWWBlind", path = "togawwwblind.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 32}
SMODS.Atlas{key = "TOGAJoyStickBlind", path = "togajoystickblind.png", px = 34, py = 34, atlas_table = 'ANIMATION_ATLAS', frames = 1}
SMODS.Atlas{key = "TOGAMoreIcons", path = "togamoricons.png", px = 36, py = 36, disable_mipmap = true}
SMODS.Atlas{key = "TOGAFunny", path = "togazefunny.png", px = 64, py = 64, atlas_table = 'ANIMATION_ATLAS', frames = 9}
SMODS.Atlas{key = "TOGAFunnyStatic", path = "togazefunny.png", px = 64, py = 64}
SMODS.Atlas{key = "modicon", path = "togaicon.png", px = 32, py = 32}

-- Hear me scream.
SMODS.Sound({key = "win95start", path = "win95start.ogg"}) -- The Microsoft Sound (95 & NT4)
SMODS.Sound({key = "win95tada", path = "win95tada.ogg"}) -- tada.wav (3.x, 95 & NT4)
SMODS.Sound({key = "bells", path = "startup/bells.wav"}) -- Windows 3.0 MME
SMODS.Sound({key = "gong", path = "startup/GONG.WAV"}) -- Windows 3.0 MME
SMODS.Sound({key = "w96", path = "startup/w96.wav"}) -- Custom Windows Startup
SMODS.Sound({key = "w94", path = "startup/w94.wav"}) -- Custom Windows Startup
SMODS.Sound({key = "money9597", path = "startup/mm9597.wav"}) -- Microsoft Money 95/97
SMODS.Sound({key = "money9899", path = "startup/mm9899.ogg"}) -- Microsoft Money 98/99
SMODS.Sound({key = "longhorn", path = "startup/longhorn.wav"}) -- "Longhorn Startup" / Samsung Theme for Windows XP
SMODS.Sound({key = "ntreskit", path = "startup/ntreskit.ogg"}) -- Windows NT4 Resource Kit
SMODS.Sound({key = "chordold", path = "chordold.wav"}) -- chord.wav (95 & NT4)
SMODS.Sound({key = "chord", path = "chord.wav"}) -- chord.wav (98, ME, 2000 and XP)
SMODS.Sound({key = "win98start", path = "win98start.ogg"}) -- The Microsoft Sound (98) [edited]
SMODS.Sound({key = "win98tada", path = "win98tada.ogg"}) -- tada.wav (98, ME, 2000 and XP)
SMODS.Sound({key = "winme2000start", path = "winmestart.ogg"}) -- Windows Logon Sound for ME/2000 [edited]
SMODS.Sound({key = "winme2000shutdown", path = "winmeshutdown.ogg"}) -- Windows Logoff Sound for ME/2000 [edited]
SMODS.Sound({key = "winnt4start", path = "winnt4start.ogg"}) -- Windows Logon Sound for NT4 [edited]
SMODS.Sound({key = "winnt4shutdown", path = "winnt4shutdown.ogg"}) -- Windows Logoff Sound for NT4 [edited]
SMODS.Sound({key = "winxplogon", path = "Windows XP Logon Sound.wav"}) -- Windows Logon Sound, XP
SMODS.Sound({key = "winxplogoff", path = "Windows XP Logoff Sound.wav"}) -- Windows Logoff Sound, XP
SMODS.Sound({key = "winxpyesyoucan", path = "theexperience.ogg"}) -- Snippet from Windows XP Tour
SMODS.Sound({key = "winxpcritstop", path = "Windows XP Critical Stop.wav"}) -- Critical Stop, XP
SMODS.Sound({key = "winxpballoon", path = "Windows XP Balloon.wav"}) -- Critical Stop, XP
SMODS.Sound({key = "winxpinfobar", path = "Windows XP Information Bar.wav"}) -- Information Bar, XP
SMODS.Sound({key = "winvista78logon", path = "winvista78logon.wav"}) -- Startup/Logon, Vista, 7 & 8.x
SMODS.Sound({key = "winvista78logoff", path = "winvista78logoff.wav"}) -- Logoff, Vista, 7 & 8.x
SMODS.Sound({key = "winvista7critstop", path = "winvista7critstop.wav"}) -- Critical Stop, Vista, 7
SMODS.Sound({key = "win8error", path = "win8bg.wav"}) -- Windows Background, 8.x
SMODS.Sound({key = "ssb64crowdohh", path = "Crowd Ohhh.ogg"}) -- Crowd Ohhh from Super Smash Bros 64
SMODS.Sound({key = "duck", path = "duck.ogg"}) -- Mac OS 9 Quack
SMODS.Sound({key = "kcud", path = "kcud.ogg"}) -- kcauQ 9 SO caM
SMODS.Sound({key = "ie31", path = "1.wav"}) -- Internet Explorer 3 Administration Kit Autorun
SMODS.Sound({key = "access97", path = "Microsoft Access 97 Sound.wav"}) -- Microsoft Access 97
SMODS.Sound({key = "recyclebinsfx", path = "recycle.ogg"}) -- recycle.wav (98, ME, 2000) 
SMODS.Sound({key = "plus98emptybin", path = "WI_EMPTY.WAV"}) -- Plus! 98, Windows 98 Empty Recycle Bin
SMODS.Sound({key = "infraredbegin", path = "ir_begin.ogg"}) -- Infrared Begin (starting infrared activity?)
SMODS.Sound({key = "infraredend", path = "ir_end.ogg"}) -- Infrared End (ending infrared activity?)
SMODS.Sound({key = "o97doorbell", path = "doorbell.wav"}) -- doorbell.wav from Office 97 Multimedia
SMODS.Sound({key = "o97glide", path = "glide.wav"}) -- glide.wav from Office 97 Multimedia
SMODS.Sound({key = "mmeclap", path = "CLAP.WAV"}) -- clap.wav from Windows 3.0 MME
SMODS.Sound({key = "officehammer", path = "HAMMER.WAV"}) -- hammer.wav from Microsoft Office sounds, unused as of 1.7.1-RC1
SMODS.Sound({key = "roverbark", path = "roverbark.ogg"}) -- 0002.wav, Microsoft Agent - Rover
SMODS.Sound({key = "mscmenucmd", path = "Musica Menu Command.ogg"}) -- Musica Sound Scheme (95 & NT4)
SMODS.Sound({key = "spb", path = "kc57.ogg"}) -- Unused in Knuckles Chaotix, Self-Propelled Bomb targeting first place in SRB2Kart/Dr. Robotnik's Ring Racers.
SMODS.Sound({key = "thundershield", path = "DSZIO3.ogg"}) -- Thunder Shield
SMODS.Sound({key = "anviluse", path = "mcanviluse.ogg"}) -- Snippet of block.anvil.use, Minecraft
SMODS.Sound({key = "xporb", path = "mcxp.ogg"}) -- Experience, Minecraft
SMODS.Sound({key = "pinballstart", path = "SOUND4.WAV"}) -- Round Start, Plus! 98 - Space Cadet Pinball Demo
SMODS.Sound({key = "pinballshutdown", path = "SOUND68.WAV"}) -- Board Shut Down - Space Cadet Pinball Demo
SMODS.Sound({key = "pinballloseball", path = "SOUND27.WAV"}) -- Lose Ball, Plus! 98 - Space Cadet Pinball Demo
SMODS.Sound({key = "pinballsfx8", path = "pinball/SOUND8.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx14", path = "pinball/SOUND14.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx16", path = "pinball/SOUND16.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx21", path = "pinball/SOUND21.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx24", path = "pinball/SOUND24.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx26", path = "pinball/SOUND26.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx43", path = "pinball/SOUND43.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx49", path = "pinball/SOUND49.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx53", path = "pinball/SOUND53.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "pinballsfx55", path = "pinball/SOUND55.WAV"}) -- Space Cadet Pinball Demo SFX
SMODS.Sound({key = "rosenclick", path = "rosenclick.ogg"}) -- *click* Nice. - Michael Rosen
SMODS.Sound({key = "rosenhello", path = "rosenhello.ogg"}) -- self explanatory, same as above.
SMODS.Sound({key = "rosenbye", path = "rosenthatsashame.ogg"}) -- self explanatory, same as above.
SMODS.Sound({key = "rosenah", path = "rosenah.ogg"}) -- self explanatory, same as above.
SMODS.Sound({key = "scalesofjustice", path = "ScalesOfJustice.wav"}) -- self explanatory, Worms Armageddon/World Party.
SMODS.Sound({key = "failsfx", path = "comedicfail.ogg"}) -- fart.mp3
SMODS.Sound({key = "goldenhit", path = "Saxxy_impact_gen_06.ogg"}) -- getting a kill with a Golden Wrench, Saxxy or Golden Frying Pan, TF2
SMODS.Sound({key = "jaratehit", path = "crit_hit_mini.wav"}) -- Minicrits, TF2
SMODS.Sound({key = "soldierscream", path = "screm.ogg"}) -- TF2 Soldier screaming?
SMODS.Sound({key = "w95restup", path = "Windows 95 restore up.ogg"}) -- Plus! 95, Windows 95 restore up.wav
SMODS.Sound({key = "bass", path = "bass.ogg"}) -- Roblox Bass / Kik-Arse Bass Soundfont (2007) / Zero-G Sample Disc Bass 4 (1990s)
SMODS.Sound({key = "mcprf5400", path = "macperforma5400.ogg"}) -- Mac Performa 5400 (Death Chime)

-- I command you to execute.
SMODS.Sound({key = "win95pluscmd1", path = "plus95/Dangerous Creatures menu command.ogg"})
SMODS.Sound({key = "win95pluscmd2", path = "plus95/Inside your Computer menu command.ogg"})
SMODS.Sound({key = "win95pluscmd3", path = "plus95/Jungle menu command.ogg"})
SMODS.Sound({key = "win95pluscmd4", path = "plus95/Leonardo da Vinci menu command.ogg"})
SMODS.Sound({key = "win95pluscmd5", path = "plus95/Mystery menu command.ogg"})
SMODS.Sound({key = "win95pluscmd6", path = "plus95/Nature menu command.ogg"})
SMODS.Sound({key = "win95pluscmd7", path = "plus95/Science menu command.ogg"})
SMODS.Sound({key = "win95pluscmd8", path = "plus95/Space menu command.ogg"})
SMODS.Sound({key = "win95pluscmd9", path = "plus95/Sports menu command.ogg"})
SMODS.Sound({key = "win95pluscmd10", path = "plus95/The 60's USA menu command.ogg"})
SMODS.Sound({key = "win95pluscmd11", path = "plus95/The Golden Era menu command.ogg"})
SMODS.Sound({key = "win95pluscmd12", path = "plus95/Windows 95 menu command.ogg"})

-- wmplayer.exe > balatro♠ost.mid
SMODS.Sound({
	key = "music_balatro98",
	path = "balatro98.ogg",
	select_music_track = function()
		return togabalatro.config.UseCustomMMMusic and G.STAGE == G.STAGES.MAIN_MENU
		or togabalatro.config.BoosterPackMusic and G.pack_cards and not G.screenwipe and G.STATE == G.STATES.SMODS_BOOSTER_OPENED and SMODS.OPENED_BOOSTER
		and (SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togazipboosterpack' or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togaziparchivepack'
		or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togararpack' or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togacardcabpack'
		or SMODS.OPENED_BOOSTER.config.center.key == 'p_toga_togaxcopydnapack') and 2
	end,
})

SMODS.Sound({
	key = "music_upgradestation",
	path = "upgradestation.ogg",
	pitch = 1,
	select_music_track = function()
		return togabalatro.config.UseCustomModTabMusic and SMODS.LAST_SELECTED_MOD_TAB and G.ACTIVE_MOD_UI and G.ACTIVE_MOD_UI.id == "TOGAPack" and 2
	end,
})

-- I think, therefore, I am.
togabalatro = SMODS.current_mod

assert(SMODS.load_file("tabs.lua"))()

togabalatro.custom_ui = function(modNodes)
	if math.random(1, 10) == 5 then
		table.insert(modNodes, #modNodes+1, {n = G.UIT.R, config = {r = 0.1, align = "cm", padding = 0.1}, nodes = {
			{n = G.UIT.C, config = { align = "cm", padding = 0.05 }, nodes = {
				{n = G.UIT.O, config = { w = 1, h = 1, object = AnimatedSprite(0, 0, 1, 1, G.ANIMATION_ATLAS['toga_TOGAFunny'], { x = 0, y = 0 }) } },
			}},
		}})
	end
end

togabalatro.description_loc_vars = function(self)
	return {
		scale = 1.25,
		text_colour = HEX('FFFFFF'),
		background_colour = HEX('2B2B2B')
	}
end

togabalatro.optional_features = function()
	return {
		retrigger_joker = true,
		quantum_enhancements = togabalatro.config.EnableQE and true or nil
	}
end

togabalatro.set_debuff = function(card)
	if SMODS.has_enhancement(card, 'm_toga_nickel') then return 'prevent_debuff' end
end

local nfs = require('nativefs')
togabalatro.errorhandler = function()
	if togabalatro.config.DoCrashSFX and not togabalatro.crashtrig then
		local crashdata = love.filesystem.newFileData(nfs.read(togabalatro.path.."/assets/sounds/macperforma5400.ogg"))
		if crashdata then
			local crashsfx = love.sound.newSoundData(crashdata)
			if crashsfx then
				local crashsource = love.audio.newSource(crashsfx, 'static')
				if crashsource then
					crashsource:setVolume(0.33)
					love.audio.play(crashsource)
				end
			end
		end
	end
	togabalatro.crashtrig = true
end

togabalatro.getrandcons = function(seed)
	seed = seed or 'grep'
	local getconspool = get_current_pool('Consumeables')
	local curcons, iter, iterlimit = nil, 0, 2222
	while iter < iterlimit do
		curcons = pseudorandom_element(getconspool, pseudoseed(seed))
		if curcons ~= "UNAVAILABLE" then break end
	end
	if curcons and curcons ~= "UNAVAILABLE" then return curcons else return "c_tower" end
end

togabalatro.iswindows = function(card)
	if card.config.center.key == 'j_toga_win95' or card.config.center.key == 'j_toga_win98'
	or card.config.center.key == 'j_toga_win98' or card.config.center.key == 'j_toga_winmillenium'
	or card.config.center.key == 'j_toga_win2000' or card.config.center.key == 'j_toga_winxp'
	or card.config.center.key == 'j_toga_winvista' or card.config.center.key == 'j_toga_win7'
	or card.config.center.key == 'j_toga_win8' then return true end
end

togabalatro.performpseudolag = function()
	if not togabalatro.pseudolag then
		togabalatro.pseudolag = true
		if love.mouse.isCursorSupported() then love.mouse.setCursor(love.mouse.getSystemCursor("waitarrow")) end
		G.E_MANAGER:add_event(Event({
			trigger = 'after',
			delay = math.random()*G.SETTINGS.GAMESPEED/2,
			func = function()
				togabalatro.pseudolag = nil
				if love.mouse.isCursorSupported() then love.mouse.setCursor(love.mouse.getSystemCursor("arrow")) end
				return true
			end
		}))
	end
end

togabalatro.systemtype = function()
	local stype = love.system.getOS()
	if stype == 'Windows' then return 'Windows'
	elseif stype == 'OS X' or stype == 'Linux' then return 'UNIX'
	elseif stype == 'Android' or stype == 'iOS' then return 'Mobile ('..stype..')'
	end
end

togabalatro.curcpucount = love.system.getProcessorCount()

-- Check for specific process name.
togabalatro.getprocessamount = function(process)
	process = string.lower(process) or 'whereismysupersuit'
	-- If a new table exists on the message queue on the Channel, set table to it. Otherwise, stay as-is.
	togabalatro.tasklisttable = love.thread.getChannel('togatasklist'):pop() or togabalatro.tasklisttable
	local count = 0
	for k, v in pairs(togabalatro.tasklisttable) do
		if string.find(v, process) then count = count + 1 end
	end
	return count
end

togabalatro.tasklisttable = {}

-- This code is for the thread that's initialized below. (although this could be its' own file, lmao.)
-- Upon loading, it preps some of the functions, checks what system we're on and assigns the appropriate command,
-- then it gets the initial list of processes without writing to an actual file and pushes the table in a message
-- via the channel and stores the ID of the pushed message, constantly checking whether the message is still there.
-- When the message is read with :pop(), the message is removed and the table is obtained, leading to the Table
-- being reset and repopulated, then pushing and waiting again all over again.
local tasklistcode = [[
require 'love.timer'
require 'love.system'
require 'io'
require 'os'

function os.capture(cmd, raw)
	local f = assert(io.popen(cmd, 'r'))
	local s = assert(f:read('*a'))
	f:close()
	if raw then return s end
	s = string.gsub(s, '^%s+', '')
	s = string.gsub(s, '%s+$', '')
	s = string.gsub(s, '[\n\r]+', ' ')
	return s
end

local function mlineproc(s)
	local t = {}
	local i = 1
	for str in string.gmatch(s, "[^\r\n]+") do
		t[i] = str
		i = i + 1
	end
	return t
end

local function sendMsg(level, logger, message)
    level = level or "DEBUG"
    logger = logger or "DefaultLogger"
    message = message or "Default log message"
    date = os.date('%Y-%m-%d %H:%M:%S')
    print(date .. " :: " .. level .. " :: " .. logger .. " :: " .. message)
end

local stype = love.system.getOS()
if stype == 'OS X' or stype == 'Linux' then stype = 'UNIX' elseif stype == 'Android' or stype == 'iOS' then stype = 'Mobile ('..stype..')' end
local cmd = stype == 'Windows' and "tasklist" or (stype == 'OS X' or stype == 'UNIX') and "ps -e" or nil
if cmd then
	local table, strcapture = {}, mlineproc(os.capture(cmd, true))
	local togachannel = love.thread.getChannel('togatasklist')
	local id = togachannel:push(table)
	while true do
		if togachannel:hasRead(id) then
			table = mlineproc(os.capture(cmd, true))
			id = togachannel:push(table)
			sendMsg('INFO ', 'TOGAPack', 'love2d Channel <> Thread - Table refreshed and sent.')
		end
	end
end
]]

-- Create Thread object using the code above and then start it.
togabalatro.thread = love.thread.newThread(tasklistcode)
togabalatro.thread:start(togabalatro.tasklisttable)

togabalatro.startupsfx = {'toga_w96', 'toga_w94', 'toga_bells', 'toga_ntreskit', 'toga_longhorn', 'toga_gong', 'toga_money9597', 'toga_money9899'}
togabalatro.verifysfxconfig = function()
	togabalatro.config.StartUpSFX = type(togabalatro.config.StartUpSFX) == 'table' and togabalatro.config.StartUpSFX or {}
	togabalatro.config.StartUpSFX.Selected = togabalatro.config.StartUpSFX.Selected or 1
	togabalatro.config.StartUpSFX.UseSelected = togabalatro.config.StartUpSFX.UseSelected or false
end
togabalatro.execstartupsfx = function()
	if not togabalatro.has_tried_startup and togabalatro.config.StartUpSound then
		togabalatro.verifysfxconfig()
		togabalatro.tasklisttable = love.thread.getChannel('togatasklist'):pop()
		if not togabalatro.config.StartUpSFX.UseSelected or togabalatro.config.StartUpSFX.Selected == nil then
			togabalatro.config.StartUpSFX.Selected = math.random(1, #togabalatro.startupsfx)
		end
		play_sound(togabalatro.startupsfx[togabalatro.config.StartUpSFX.Selected], 1, 0.5)
	end
	togabalatro.has_tried_startup = true
	
	-- Sneak our title screen card addition here.
	local replace_card = Card(G.title_top.T.x, G.title_top.T.y, G.CARD_W, G.CARD_H, nil, G.P_CENTERS.j_toga_win95)
	G.title_top.T.w = G.title_top.T.w*1.7675
	G.title_top.T.x = G.title_top.T.x - 0.8
	replace_card.T.w = replace_card.T.w*1.1*1.2
	replace_card.T.h = replace_card.T.h*1.1*1.2
    G.title_top:emplace(replace_card)

    replace_card.states.visible = false
    replace_card.no_ui = true
    replace_card.ambient_tilt = 0.0

    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = change_context == 'game' and 1.5 or 0,
        blockable = false,
        blocking = false,
        func = (function()
            if change_context == 'splash' then 
                replace_card.states.visible = true
                replace_card:start_materialize({G.C.WHITE,G.C.WHITE}, true, 2.5)
                play_sound('whoosh1', math.random()*0.1 + 0.3,0.3)
                play_sound('crumple'..math.random(1,5), math.random()*0.2 + 0.6,0.65)
            else
                replace_card.states.visible = true
                replace_card:start_materialize({G.C.WHITE,G.C.WHITE}, nil, 1.2)
            end
            G.VIBRATION = G.VIBRATION + 1
            return true
    end)}))
end

SMODS.ObjectType{
	object_type = "ObjectType",
	key = "TOGAJKR",
	default = "j_toga_win95",
	cards = {
		["j_toga_y2kbug"] = true, ["j_toga_controlpanel"] = true, ["j_toga_mcanvil"] = true,
		["j_toga_taskmgr"] = true, ["j_toga_solitairejoker"] = true, ["j_toga_win95"] = true,
		["j_toga_win98"] = true, ["j_toga_winmillenium"] = true, ["j_toga_winnt4"] = true,
		["j_toga_win2000"] = true, ["j_toga_winvista"] = true, ["j_toga_win7"] = true,
		["j_toga_win8"] = true, ["j_toga_useraccounts"] = true, ["j_toga_virtualmemory"] = true,
		["j_toga_computerlock"] = true, ["j_toga_recyclebin"] = true, ["j_toga_theinternet"] = true,
		["j_toga_bonusducks"] = true, ["j_toga_spacecadetpinball"] = true, ["j_toga_jokersrb2kart"] = true,
		["j_toga_heartyspades"] = true, ["j_toga_systemrestore"] = true, ["j_toga_mcanvil"] = true, 
		["j_toga_bonusducks"] = true, ["j_toga_speedsneakers"] = true, ["j_toga_internetexplorer"] = true,
		["j_toga_megasxlr"] = true, ["j_toga_asterism"] = true, ["j_toga_theinternet"] = true,
		["j_toga_binaryjkr"] = true, ["j_toga_hexadecimaljkr"] = true, ["j_toga_y2ksticker"] = true,
		["j_toga_jimboplus"] = true, ["j_toga_tomscott"] = true, ["j_toga_goldenwrench"] = true,
		["j_toga_skype"] = true, ["j_toga_msn"] = true, ["j_toga_mac_os_9"] = true, 
		["j_toga_mac_os_x"] = true, ["j_toga_linux_ubuntu"] = true, ["j_toga_linux_debian"] = true,
		["j_toga_linux_slackware"] = true, ["j_toga_linux_redhat"] = true, ["j_toga_tempinternetfiles"] = true,
		["j_toga_google"] = true, ["j_toga_bonzibuddy"] = true, ["j_toga_netscapenavigator"] = true,
		["j_toga_diskcleanup"] = true, ["j_toga_regedit"] = true, ["j_toga_msagent"] = true,
		["j_toga_drwatson"] = true, ["j_toga_fontsfolder"] = true, ["j_toga_pcmcia"] = true,
		["j_toga_scsi"] = true, ["j_toga_visualstudio"] = true, ["j_toga_printershare"] = true,
		["j_toga_netshow"] = true, ["j_toga_certserver"] = true, ["j_toga_cpu"] = true,
		["j_toga_ups"] = true, ["j_toga_hammer"] = true, ["j_toga_joker203"] = true,
		["j_toga_chrome"] = true, ["j_toga_firefox"] = true, ["j_toga_cavingjkr"] = true,
		["j_toga_miningjkr"] = true, ["j_toga_virtualpc"] = true, ["j_toga_tuneupwizard"] = true, 
	}
}

G.FUNCS.togabalatro_startupsfx = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.verifysfxconfig()
	togabalatro.config.StartUpSFX.Selected = args.to_key
end
G.FUNCS.togabalatro_playsfx = function()
	togabalatro.verifysfxconfig()
	play_sound(togabalatro.startupsfx[togabalatro.config.StartUpSFX.Selected], 1, 0.5)
end
G.FUNCS.togabalatro_sfxswapcfg = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.config.SFXSwapLevel = args.to_key
end
G.FUNCS.togabalatro_jokeitems = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.config.JokeJokersActive = args.to_key == 1 and true or false
	togabalatro.updatecollectionitems()
	G.FUNCS.openModUI_TOGAPack()
end
G.FUNCS.togabalatro_poweritems = function(args)
	if not args or args.to_key == nil then return end
	togabalatro.config.ShowPower = args.to_key == 1 and true or false
	togabalatro.updatecollectionitems()
	G.FUNCS.openModUI_TOGAPack()
end

togabalatro.updatecollectionitems = function()
	for _, t in ipairs{G.P_CENTERS, G.P_TAGS, G.P_SEALS} do
		for k, v in pairs(t) do
			if (v.original_mod or {}).id == 'TOGAPack' and not v.remainhidden then
				if v.jokeitem then
					if togabalatro.config.JokeJokersActive then v.no_collection = nil else v.no_collection = true end
				end
				if v.poweritem then
					if togabalatro.config.ShowPower then v.no_collection = nil else v.no_collection = true end
				end
			end
		end
	end
end

-- Prevent seals spawning if power items disabled.
sendInfoMessage("Hooking SMODS.poll_seal...", "TOGAPack")
local smodssealref = SMODS.poll_seal
function SMODS.poll_seal(args)
	local resultseal = smodssealref(args) -- original result.
	local iter, iterlimit = 0, 100 -- just so we don't lock the game up.
	
	if not togabalatro.config.ShowPower and resultseal ~= nil and (resultseal == 'toga_sealseal' or resultseal == 'toga_urlseal') then
		repeat
			iter = iter + 1
			smodssealref(args)
		until (resultseal ~= 'toga_sealseal' and resultseal ~= 'toga_urlseal') or iter > iterlimit
		
		if (resultseal == 'toga_sealseal' or resultseal == 'toga_urlseal') then resultseal = nil end
	end
	
	return resultseal
end

-- Tom Scott?!
sendInfoMessage("Hooking SMODS.showman...", "TOGAPack")
local showmansmodsref = SMODS.showman
function SMODS.showman(card_key)
	if card_key == 'j_toga_tomscott' and next(SMODS.find_card('j_toga_tomscott')) then return true end
	
	return showmansmodsref(card_key)
end

-- Still kept for colouring the button with higher allowed amount of cards to play, but also backwards compat.
sendInfoMessage("Hooking G.FUNCS.can_play...", "TOGAPack")
local canplayref = G.FUNCS.can_play
function G.FUNCS.can_play(e)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("G.FUNCS.can_play hook.", "TOGAPack") end
	canplayref(e) -- execute original first before we do anything.
	if #G.hand.highlighted <= G.hand.config.highlighted_limit then
		if #G.hand.highlighted >= 52 then -- Cryptid?
			e.config.colour = G.C.EDITION
			if not togabalatro.handlimitapi() then e.config.button = 'play_cards_from_highlighted' end
		elseif #G.hand.highlighted >= 10 and #G.hand.highlighted < 52 then -- 2x the base and more.
			e.config.colour = G.C.DARK_EDITION
			if not togabalatro.handlimitapi() then e.config.button = 'play_cards_from_highlighted' end
		elseif #G.hand.highlighted > 5 and #G.hand.highlighted < 10 then -- more than base.
			e.config.colour = G.C.PURPLE
			if not togabalatro.handlimitapi() then e.config.button = 'play_cards_from_highlighted' end
		end
	end
end

-- As Talisman is now optional and we have some items using this, best keep these.
to_big = to_big or function(a) return a end
to_number = to_number or function(a) return a end

togabalatro.reset_solitaire = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.solitaire = {} end
	G.GAME.current_round.togabalatro.solitaire.rank = 'Ace'
	G.GAME.current_round.togabalatro.solitaire.id = 14
	local valid_soli_cards = {}
	for k, v in ipairs(G.playing_cards) do
		if v.ability.effect ~= 'Stone Card' then
			if not SMODS.has_no_rank(v) then
				valid_soli_cards[#valid_soli_cards+1] = v
			end
		end
	end
	if valid_soli_cards[1] then
		local soli_card = pseudorandom_element(valid_soli_cards, pseudoseed('solitaire'..G.GAME.round_resets.ante))
		G.GAME.current_round.togabalatro.solitaire.rank = soli_card.base.value
		G.GAME.current_round.togabalatro.solitaire.id = soli_card.base.id
	end
end

togabalatro.reset_diskcleanup = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.diskcleanup = {}; G.GAME.current_round.togabalatro.diskcleanup.suit = 'Hearts' end
	local dc_suits = {}
	for k, v in ipairs(G.playing_cards) do
		if v.ability.effect ~= 'Stone Card' then
			if not SMODS.has_no_suit(v) and not dc_suits[v.base.suit] and SMODS.Suits[v.base.suit] then
				dc_suits[v.base.suit] = true
			end
		end
	end
	local valid_dc_suits = {}
	for k, v in pairs(dc_suits) do valid_dc_suits[#valid_dc_suits+1] = k end
	if next(valid_dc_suits) then G.GAME.current_round.togabalatro.diskcleanup.suit = pseudorandom_element(valid_dc_suits, pseudoseed('diskcleanup'..G.GAME.round_resets.ante)) end
end

togabalatro.reset_regedit = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.regedit = {}; G.GAME.current_round.togabalatro.regedit.suit = 'Hearts' end
	local regedit_suits = {}
    for k, v in pairs(SMODS.Suits) do
        if k ~= G.GAME.current_round.togabalatro.regedit.suit then regedit_suits[#regedit_suits + 1] = k end
    end
    G.GAME.current_round.togabalatro.regedit.suit = pseudorandom_element(regedit_suits, pseudoseed('regedit'..G.GAME.round_resets.ante))
end

togabalatro.reset_certificateserver = function(run_start)
	if run_start then G.GAME.current_round.togabalatro.certserver = {} end
	G.GAME.current_round.togabalatro.certserver.rank = 'Ace'
	G.GAME.current_round.togabalatro.certserver.id = 14
	
	local rndrank = pseudorandom_element(SMODS.Ranks, pseudoseed('certserver'..G.GAME.round_resets.ante))
	if rndrank then
		G.GAME.current_round.togabalatro.certserver.rank = rndrank.key
		G.GAME.current_round.togabalatro.certserver.id = rndrank.id
		G.GAME.current_round.togabalatro.certserver.value = rndrank.value
	end
end

togabalatro.reset_game_globals = function(run_start)
	if run_start then G.GAME.current_round.togabalatro = {} end
	
	togabalatro.reset_solitaire(run_start)
	togabalatro.reset_diskcleanup(run_start)
	togabalatro.reset_regedit(run_start)
	togabalatro.reset_certificateserver(run_start)
	
	if togabalatro.config.DoMoreLogging then sendInfoMessage("Reset own round variables.", "TOGAPack") end
end

-- Random pitch...
togabalatro.randompitch = function()
	local genvalue = math.random(50, 150)/100
	if togabalatro.config.DoMoreLogging then sendInfoMessage("Random pitch of "..genvalue.." returned.", "TOGAPack") end
	return genvalue
end

-- Rosen sound swap stuff.
togabalatro.rosensfx = { chips1 = true, multhit1 = true, multhit2 = true, coin1 = true, generic1 = true, foil2 = true, xchips = true,
						talisman_xchip = true, talisman_echip = true, talisman_eechip = true, talisman_eeechip = true,
						talisman_emult = true, talisman_eemult = true, talisman_eeemult = true }

sendInfoMessage("Hooking play_sound...", "TOGAPack")
local playsoundref = play_sound
function play_sound(sound_code, per, vol)
	-- ...only if config is set to allow it.
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("play_sound hook.", "TOGAPack") end
	if togabalatro.config.SFXWhenTriggered and next(SMODS.find_card('j_toga_michaelrosen')) and ((togabalatro.config.SFXSwapLevel == 3) or (togabalatro.config.SFXSwapLevel == 2 and togabalatro.rosensfx[sound_code])) then sound_code = 'toga_rosenclick' end
	if G and G.GAME and G.GAME.blind and G.GAME.blind.boss and G.GAME.blind.config.blind.key == 'bl_toga_xpboss' and (togabalatro.config.SFXSwapLevel >= 2) then sound_code = 'toga_winxpcritstop' end
	
	playsoundref(sound_code, per, vol)
end

-- Y2K Sticker yoink.
local ischecking2s = false
sendInfoMessage("Hooking Card:is_face...", "TOGAPack")
local isfaceref = Card.is_face
function Card:is_face(from_boss)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Card:is_face hook.", "TOGAPack") end
	if next(SMODS.find_card('j_toga_y2ksticker')) then
		if not ischecking2s then
			ischecking2s = true
			if self:get_id() == 2 then ischecking2s = false; return true end
		end
		ischecking2s = false
	end
	ischecking2s = false
	local result = isfaceref(self, from_boss)
	local tuneupcalc = {}
	SMODS.calculate_context({ tuneupwizard = true }, tuneupcalc)
	for _, eval in pairs(tuneupcalc) do
		for key, eval2 in pairs(eval) do
			if eval2.flip and eval2.card then result = not result end
		end
	end
	return result
end

-- Hexa & Binary Joker and Megas XLR yoink.
local getiduse = false
sendInfoMessage("Hooking Card:get_id...", "TOGAPack")
local getidref = Card.get_id
function Card:get_id()
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Card:get_id hook.", "TOGAPack") end
	if not getiduse then
		getiduse = true
		local id = getidref(self) or self.base.id
		if next(SMODS.find_card('j_toga_megasxlr')) and id == 8 then id = 13 end
		if next(SMODS.find_card('j_toga_hexadecimaljkr')) and id == 14 then id = 10 end
		if next(SMODS.find_card('j_toga_binaryjkr')) and id == 10 then id = 2 end
		getiduse = false
		return id
	else
		getiduse = false
		return getidref(self)
	end
end

-- This still feels hacky, tbh.
sendInfoMessage("Hooking Card:is_suit...", "TOGAPack")
local issuitref = Card.is_suit
function Card:is_suit(suit, bypass_debuff, flush_calc)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Card:get_is_suit hook.", "TOGAPack") end
	if flush_calc then
		if next(SMODS.find_card('j_toga_heartyspades')) and next(SMODS.find_card('j_smeared'))
		and (self.base.suit == 'Hearts' or self.base.suit == 'Spades' or self.base.suit == 'Diamonds' or self.base.suit == 'Clubs') and (suit == 'Hearts' or suit == 'Spades' or suit == 'Diamonds' or suit == 'Clubs') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades + Smeared Joker flush pass.", "TOGAPack") end
			return true
		end
		if next(SMODS.find_card('j_toga_heartyspades')) and not SMODS.has_no_suit(self) and (self.base.suit == 'Hearts' or self.base.suit == 'Spades') and (suit == 'Hearts' or suit == 'Spades') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades flush pass.", "TOGAPack") end
			return true
		end
		return issuitref(self, suit, bypass_debuff, flush_calc)
	else
		if self.debuff and not bypass_debuff then return end
		if next(SMODS.find_card('j_toga_heartyspades')) and next(SMODS.find_card('j_smeared')) and not SMODS.has_no_suit(self)
		and (self.base.suit == 'Hearts' or self.base.suit == 'Spades' or self.base.suit == 'Diamonds' or self.base.suit == 'Clubs') and (suit == 'Hearts' or suit == 'Spades' or suit == 'Diamonds' or suit == 'Clubs') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades + Smeared Joker pass.", "TOGAPack") end
			return true
		end
		if next(SMODS.find_card('j_toga_heartyspades')) and not SMODS.has_no_suit(self) and (self.base.suit == 'Hearts' or self.base.suit == 'Spades') and (suit == 'Hearts' or suit == 'Spades') then
			if togabalatro.config.DoMoreLogging then sendInfoMessage("Hearty Spades pass.", "TOGAPack") end
			return true
		end
		return issuitref(self, suit, bypass_debuff, flush_calc)
	end
end

sendInfoMessage("Hooking Card:should_hide_front...", "TOGAPack")
local shfref = Card.should_hide_front
function Card:should_hide_front()
	local ret = shfref(self)
	if ret and next(SMODS.find_card('j_toga_cavingjkr')) then return false
	elseif self.config.center.key == 'm_toga_glowstone' then return false
	else return ret end
end

-- This really shuffled my brain...
sendInfoMessage("Hooking CardArea:shuffle...", "TOGAPack")
local sonicshuffle = CardArea.shuffle
function CardArea:shuffle(_seed)
	local r = sonicshuffle(self, _seed)
	if self == G.deck then
		local otherc, smsc = {}, {}
		for i, k in ipairs(self.cards) do
			if SMODS.has_enhancement(k, 'm_toga_sms') then
				smsc[#smsc+1] = k
			else
				otherc[#otherc+1] = k
			end
		end
		for _, card in ipairs(otherc) do
			table.insert(smsc, card)
		end
		self.cards = smsc
		self:set_ranks()
	end
	return r
end

-- hooking draw_from_deck_to_hand to remove the 'calculate' from Notification enhancement, replicating it in this hook.
sendInfoMessage("Hooking G.FUNCS.draw_from_deck_to_hand...", "TOGAPack")
local dfwdthref = G.FUNCS.draw_from_deck_to_hand
function G.FUNCS.draw_from_deck_to_hand(e)
	dfwdthref(e)
	if togabalatro.config.DoMoreLogging then sendInfoMessage("Executed original function or (potential) hook.", "TOGAPack") end
	G.E_MANAGER:add_event(Event({
		func = function()
			togabalatro.drawextracards()
			return true
		end
	}))
end

-- for a Boss/Showdown Blind...
sendInfoMessage("Hooking Blind:defeat...", "TOGAPack")
local blindkillref = Blind.defeat
function Blind:defeat(silent)
	if togabalatro.config.DoMoreLogging and togabalatro.config.DoEvenMoreLogging then sendDebugMessage("Blind:defeat hook.", "TOGAPack") end
	blindkillref(self, silent)
	if not G.GAME.dialupmodem and self.name == 'bl_toga_dialupmodem' then G.GAME.dialupmodem = true end
end

-- no disabley. :)
sendInfoMessage("Hooking Blind:disable...", "TOGAPack")
local bldisref = Blind.disable
function Blind:disable()
	if self.debuff.toga_no_disable then
		play_sound('toga_winxpcritstop', 1, 0.5)
		return
	end
	return bldisref(self)
end

sendInfoMessage("Hooking Game:update_game_over...", "TOGAPack")
local ugoref = Game.update_game_over
function Game:update_game_over(dt)
	if not G.STATE_COMPLETE then
		if G.GAME.selected_back.effect.center.key == 'b_toga_screamingdeck' and togabalatro.config.SFXWhenTriggered then play_sound('toga_soldierscream', 1, 0.4) end
		if next(SMODS.find_card('j_toga_spacecadetpinball', true)) and togabalatro.config.SFXWhenTriggered then play_sound('toga_pinballshutdown', 1, 0.4) end
	end
	ugoref(self, dt)
end

-- Hook for Strength-like stuff.
sendInfoMessage("Hooking SMODS.modify_rank...", "TOGAPack")
local modifyrankref = SMODS.modify_rank
function SMODS.modify_rank(card, amount, manual_sprites)
	local vscalc = {}
	SMODS.calculate_context({ vs_modify_rank = true }, vscalc)
	for _, eval in pairs(vscalc) do
		for key, eval2 in pairs(eval) do
			if eval2.amount and eval2.card then amount = amount + eval2.amount end
		end
	end
	local bonzicalc = {}
	SMODS.calculate_context({ bonzi_modify_rank = true }, bonzicalc)
	for _, eval in pairs(bonzicalc) do
		for key, eval2 in pairs(eval) do
			if eval2.amount and eval2.card then amount = amount * eval2.amount end
		end
	end
	return modifyrankref(card, amount, manual_sprites)
end

-- Hooking for rank/suit-specific stuff.
local changebaseref = SMODS.change_base
function SMODS.change_base(card, suit, rank, manual_sprites)
	if next(SMODS.find_card('j_toga_certserver')) and G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.certserver and G.GAME.current_round.togabalatro.certserver.rank and rank ~= nil then
		rank = G.GAME.current_round.togabalatro.certserver.rank
	end
	if next(SMODS.find_card('j_toga_regedit')) and G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.regedit and G.GAME.current_round.togabalatro.regedit.suit and suit ~= nil then
		suit = G.GAME.current_round.togabalatro.regedit.suit
	end
    return changebaseref(card, suit, rank, manual_sprites)
end

-- Voucher redeem calculation.
sendInfoMessage("Hooking Card:apply_to_run...", "TOGAPack")
local applytorunref = Card.apply_to_run
function Card:apply_to_run(center)
	applytorunref(self, center)
	SMODS.calculate_context({ redeem_individual_voucher = true, voucher = center or self })
end

-- Hooking for suit-specific stuff.
sendInfoMessage("Hooking Card:change_suit...", "TOGAPack")
local changesuitref = Card.change_suit
function Card:change_suit(new_suit)
	if next(SMODS.find_card('j_toga_regedit')) and G.GAME.current_round.togabalatro and G.GAME.current_round.togabalatro.regedit and G.GAME.current_round.togabalatro.regedit.suit then
		new_suit = G.GAME.current_round.togabalatro.regedit.suit
	end
	changesuitref(self, new_suit)
end

-- Hooking for influencing hand level changes.
sendInfoMessage("Hooking level_up_hand...", "TOGAPack")
local lvluphandref = level_up_hand
function level_up_hand(card, hand, instant, amount)
	amount = amount or to_big(1)
	if to_big(amount) > to_big(0) then
		local xpcalc = {}
		SMODS.calculate_context({ toga_xplvlup = true }, xpcalc)
		for _, eval in pairs(xpcalc) do
			for key, eval2 in pairs(eval) do
				if eval2.card and SMODS.pseudorandom_probability(eval2.card, "experiencethebest", 1, eval2.odds or eval2.card.ability.extra.odds or 4, 'yesyoucan') then
					amount = amount * 2
					SMODS.calculate_effect({message = localize('k_upgrade_ex')}, eval2.card)
				end
			end
		end
	end
	lvluphandref(card, hand, instant, amount)
end

togabalatro.chipmultopswap = {
	['chips'] = 'mult',
	['h_chips'] = 'h_mult',
	['chip_mod'] = 'mult_mod',
	['mult'] = 'chips',
	['h_mult'] = 'h_chips',
	['mult_mod'] = 'chip_mod',
	['x_chips'] = 'x_mult',
	['xchips'] = 'xmult',
	['Xchip_mod'] = 'Xmult_mod',
	['x_mult'] = 'x_chips',
	['xmult'] = 'xchips',
	['Xmult'] = 'xchips',
	['x_mult_mod'] = 'Xchip_mod',
	['Xmult_mod'] = 'Xchip_mod',
	-- Talisman.
	['e_mult'] = 'e_chips',
	['emult'] = 'echips',
	['ee_mult'] = 'ee_chips',
	['eemult'] = 'eechips',
	['eee_mult'] = 'eee_chips',
	['eeemult'] = 'eeechips',
	['hypermult'] = 'hyperchips',
	['hyper_mult'] = 'hyper_chips',
	['e_chips'] = 'e_mult',
	['echips'] = 'emult',
	['ee_chips'] = 'ee_mult',
	['eechips'] = 'eemult',
	['eee_chips'] = 'eee_mult',
	['eeechips'] = 'eeemult',
	['hyperchips'] = 'hypermult',
	['hyper_chips'] = 'hyper_mult',
	['Emult_mod'] = 'Echip_mod',
	['EEmult_mod'] = 'EEchip_mod',
	['EEEmult_mod'] = 'EEEchip_mod',
	['hypermult_mod'] = 'hyperchip_mod',
	['Echip_mod'] = 'Emult_mod',
	['EEchip_mod'] = 'EEmult_mod',
	['EEEchip_mod'] = 'EEEmult_mod',
	['hyperchip_mod'] = 'hypermult_mod',
	-- Other mods can add their custom operations to this table.
}

sendInfoMessage("Hooking SMODS.calculate_individual_effect...", "TOGAPack")
local calcindiveffectref = SMODS.calculate_individual_effect
SMODS.calculate_individual_effect = function(effect, scored_card, key, amount, from_edition)
	-- do stuff if only the table is actually a table and has not been mangled by external factors.
	if type(togabalatro.chipmultopswap) == 'table' and togabalatro.chipmultopswap[key] then
		local activesyncs = SMODS.find_card('j_toga_activesync')
		if next(activesyncs) then
			for i = 1, #activesyncs do
				if SMODS.pseudorandom_probability(activesyncs[i], "msactivesync", 1, activesyncs[i].ability.extra.odds or 8, 'msactivesync') then
					local msg
					if string.find(key, 'chip') then msg = localize('toga_activesyncmult') elseif string.find(key, 'mult') then msg = localize('toga_activesyncchip') end
					if msg and not (Talisman and Talisman.config_file.disable_anims) then
						card_eval_status_text(activesyncs[i], 'extra', nil, nil, nil, {message = msg, colour = string.find(key, 'chip') and G.C.CHIPS or string.find(key, 'mult') and G.C.MULT, delay = 0.2})
					end
					key = togabalatro.chipmultopswap[key]
				end
			end
		end
		local jarate = SMODS.find_card('j_toga_jarate')
		if next(jarate) and amount then
			for i = 1, #jarate do
				if SMODS.pseudorandom_probability(jarate[i], "tf2jarate", 1, jarate[i].ability.extra.odds or 15, 'tf2jarate') then
					if not (Talisman and Talisman.config_file.disable_anims) then
						card_eval_status_text(jarate[i], 'extra', nil, nil, nil, {
							message = localize('toga_jarated'),
							sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_jaratehit",
							pitch = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.randompitch(),
							volume = 0.3,
							delay = 0.2
						})
					end
					amount = amount*jarate[i].ability.extra.minicrit
				end
			end
		end
	end
	local ret = calcindiveffectref(effect, scored_card, key, amount, from_edition)
	if ret then return ret end
end

togabalatro.drawextracards = function()
	local anycarddrawn = false
	
	local allnotifcards = {}
	for i = 1, #G.deck.cards do
		if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_notification') then --if G.deck.cards[i].config.center_key == 'm_toga_notification' then
			allnotifcards[#allnotifcards+1] = G.deck.cards[i]
		end
	end
	if #allnotifcards > 0 then
		for i = 1, #G.deck.cards do
			for v = 1, #allnotifcards do
				if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_notification') and allnotifcards[v] == G.deck.cards[i] then
					if togabalatro.config.DoMoreLogging then sendInfoMessage("Additionally drawing Notification Card "..i.." ("..G.deck.cards[i].config.card.name..") from the deck...", "TOGAPack") end
					draw_card(G.deck, G.hand, i*100/#allnotifcards, 'up', true, G.deck.cards[i])
					anycarddrawn = true
				end
			end
		end
	end
	
	if anycarddrawn then
		G.E_MANAGER:add_event(Event({
			func = function()
				if togabalatro.config.DoMoreLogging then sendInfoMessage("save_run() so the additionally drawn cards are set...", "TOGAPack") end
				save_run() -- god.
				return true
			end}))
	end
end

function ReverseTable(t)
	local rt = {}
	for i = #t, 1, -1 do
		rt[#rt+1] = t[i]
	end
	return rt
end

function ShuffleMyTable(t, seed)
	seed = seed or 'shuffley'
	local rt = {}
	for i = 1, #t do
		rt[#rt+1] = t[i]
	end
	pseudoshuffle(rt, pseudoseed(seed))
	return rt
end

-- emem eht era uoy :VOP --
togabalatro.forcereverse = false
togabalatro.preprocess = function(context, input)
	local output = input or context.cardarea and context.cardarea.cards or nil
	if not output then
		if context.cardarea == G.play then output = context.full_hand
		elseif context.cardarea == G.hand then output = G.hand.cards
		elseif context.cardarea == 'unscored' then output = context.full_hand end
	end
	
	if not output then return end
	
	if G.GAME.modifiers.toga_reversedscore then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_reversedscore_sleeve then output = ReverseTable(output) end
	if togabalatro.forcereverse then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_randomscore then output = ShuffleMyTable(output, 'whotouchmygun') end
	
	return output
end

togabalatro.areaprocess = function(t)
	t = t or {}
	
	local output = t
	
	if G.GAME.modifiers.toga_reversedscore then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_reversedscore_sleeve then output = ReverseTable(output) end
	if G.GAME.modifiers.toga_randomscore then output = ShuffleMyTable(output, 'whotouchmygun') end
	
	return output
end

togabalatro.areaorderprocess = function(t)
	return togabalatro.areaprocess(t)
end

togabalatro.spacecadetsfx = {'toga_pinballsfx8', 'toga_pinballsfx14', 'toga_pinballsfx16', 'toga_pinballsfx21', 'toga_pinballsfx24', 'toga_pinballsfx26', 'toga_pinballsfx43', 'toga_pinballsfx49', 'toga_pinballsfx53', 'toga_pinballsfx55'}
togabalatro.spacecadetrndsfx = function()
	return togabalatro.spacecadetsfx[math.random(1, #togabalatro.spacecadetsfx)]
end

-- Any additional scoring with chips and what not.
togabalatro.extrascoring = function(context, scoring_hand)
	if context.cardarea == G.play then
		local spacecadetcalc = {}
		SMODS.calculate_context({spacecadetscore = true}, spacecadetcalc)
		for _, eval in pairs(spacecadetcalc) do
			for key, eval2 in pairs(eval) do
				local notyetscored = true
				if eval2.card then
					for i = 1, math.floor(to_number(tonumber(eval2.spacecadet)) or eval2.card and to_number(eval2.card.ability.extra.alltrig) or 1) do
						if (SMODS.pseudorandom_probability(card, "toga_spacecadetpinball", 1, 3, 'spacecadetpinball') or eval2.card.ability.cry_rigged) and scoring_hand then
							if notyetscored then notyetscored = false; card_eval_status_text(eval2.card, 'extra', nil, nil, nil, {message = localize('toga_pinballing'), sound = not silent and togabalatro.config.SFXWhenTriggered and togabalatro.spacecadetrndsfx()}) end
							SMODS.score_card(pseudorandom_element(context.scoring_hand, pseudoseed('spacecadet')), context)
						end
					end
				end
			end
		end
		local hammercalc = {}
		SMODS.calculate_context({hammerscore = true}, hammercalc)
		for _, eval in pairs(hammercalc) do
			for key, eval2 in pairs(eval) do
				local notyetscored = true
				if eval2.card then
					for i = 1, #G.hand.cards do
						if SMODS.has_enhancement(G.hand.cards[i], "m_glass") and G.hand.cards[i]:can_calculate() then
							if notyetscored then notyetscored = false; card_eval_status_text(eval2.card, 'extra', nil, nil, nil, {message = localize('toga_hammersmash')}) end
							SMODS.score_card(G.hand.cards[i], context)
							local smashchance = G.hand.cards[i].ability.name == 'Glass Card' and G.hand.cards[i].ability.extra or G.P_CENTERS.m_glass.config.extra
							if SMODS.pseudorandom_probability(G.hand.cards[i], 'glass', 1, smashchance/2, 'atomsmashererrorgenerator') then G.hand.cards[i].atomsmashed = true end
						end
					end
				end
			end
		end
		local rovercalc = {}
		SMODS.calculate_context({roverscore = true}, rovercalc)
		for _, eval in pairs(rovercalc) do
			for key, eval2 in pairs(eval) do
				local notyetscored = true
				if eval2.card then
					for i = 1, #G.deck.cards do
						if (SMODS.pseudorandom_probability(card, "toga_rover", 1, (eval2.rover or eval2.card.ability.extra and eval2.card.ability.extra.odds or 8), 'searchwithrover') or eval2.card.ability.cry_rigged) then
							if notyetscored then notyetscored = false; card_eval_status_text(eval2.card, 'extra', nil, nil, nil, {message = localize('toga_roverwoof'), sound = not silent and togabalatro.config.SFXWhenTriggered and "toga_roverbark"}) end
							SMODS.score_card(G.deck.cards[i], context)
						end
					end
				end
			end
		end
	end
end

-- Custom scoring of held in hand abilities.
togabalatro.heldinhandscoring = function(context, scoring_hand)
	if context.cardarea == G.hand then
		context.main_scoring = true
		if togabalatro.canareascore(context.cardarea) then togabalatro.scoreheldinhand(context) end
		
		local clippitcalc = {}
		SMODS.calculate_context({clippitscore = true, cardarea = context.cardarea}, clippitcalc)
		
		for _, eval in pairs(clippitcalc) do
			for key, eval2 in pairs(eval) do
				if eval2.card then
					for i = 1, math.floor(eval2.rescores or eval2.card.ability.extra and eval2.card.ability.extra.rescores or 1) do
						togabalatro.scoreheldinhand(context, true)
					end
				end
			end
		end
		context.main_scoring = nil
	end
end

togabalatro.scoreheldinhand = function(context, handrescore)
	local allcards = {}
	
	for i = 1, #G.playing_cards do
		if G.playing_cards[i] then allcards[#allcards+1] = G.playing_cards[i] end
	end
	
	allcards = togabalatro.preprocess(context, allcards)
	
	for i = 1, #allcards do
		local card, area = allcards[i], allcards[i].area
		if card then
			if area == G.hand and handrescore then
				SMODS.score_card(card, context)
			end
			if area ~= G.hand and card.seal == 'toga_urlseal' then
				SMODS.score_card(card, context)
			end
		end
	end
end

-- Special case for the sleeve scoring.
togabalatro.kartsleevescoring = function(context, scoring_hand)
	if G.GAME and G.GAME.modifiers and G.GAME.modifiers.toga_reversedscore_special_kart then
		togabalatro.forcereverse = true
		context.main_scoring = true
		calcmainscoreref(context, scoring_hand)
		togabalatro.forcereverse = false
		context.main_scoring = nil
	end
end

togabalatro.canareascore = function(cardarea)
	local can = true
	if cardarea then
		if cardarea == G.play and G.GAME.modifiers.toga_noplayedscore then can = false end
		if cardarea == G.hand and G.GAME.modifiers.toga_nohandscore then can = false end
	end
	return can
end

-- Hooking to do more funky scoring shenanigans.
sendInfoMessage("Hooking SMODS.calculate_main_scoring...", "TOGAPack")
local calcmainscoreref = SMODS.calculate_main_scoring
function SMODS.calculate_main_scoring(context, scoring_hand)
	if togabalatro.canareascore(context.cardarea) then calcmainscoreref(context, scoring_hand) end
	togabalatro.kartsleevescoring(context, scoring_hand)
	togabalatro.extrascoring(context, scoring_hand)
	togabalatro.heldinhandscoring(context, scoring_hand)
end

-- Yoinked from original SMODS.calculate_end_of_round_effects, but edited to target specific cards.
-- 100% hacky, there should be a better way for doing this...
togabalatro.eorproc = function(area, card, context, i)
	local reps = {1}
	local j = 1
	while j <= #reps do
		percent = percent or (i-0.999)/(#area.cards-0.998) + (j-1)*0.1
		if reps[j] ~= 1 then
			local _, eff = next(reps[j])
			SMODS.calculate_effect(eff, eff.card)
			percent = percent + 0.08
		end

		context.playing_card_end_of_round = true
		local effects = {eval_card(card, context)}
		SMODS.calculate_quantum_enhancements(card, effects, context)

		context.playing_card_end_of_round = nil
		context.individual = true
		context.other_card = card

		SMODS.calculate_card_areas('jokers', context, effects, { main_scoring = true })
		SMODS.calculate_card_areas('individual', context, effects, { main_scoring = true })

		local flags = SMODS.trigger_effects(effects, card)

		context.individual = nil
		context.repetition = true
		context.card_effects = effects
		if reps[j] == 1 then
			SMODS.calculate_repetitions(card, context, reps)
		end

		context.repetition = nil
		context.card_effects = nil
		context.other_card = nil
		j = j + (flags.calculated and 1 or #reps)
	end
end

-- This bit is 100% experimental... there should be a better way for doing this, right?
togabalatro.triggereof = function(context)
	local contextcopy = context
	contextcopy.cardarea = G.hand
	
	local allcards = {}
	
	for i = 1, #G.playing_cards do
		if G.playing_cards[i] then allcards[#allcards+1] = G.playing_cards[i] end
	end
	
	allcards = togabalatro.preprocess(context, allcards)
	
	for i = 1, #allcards do
		local card, area = allcards[i], allcards[i].area
		if area ~= G.hand and card.seal == 'toga_urlseal' then
			togabalatro.eorproc(area, card, contextcopy, i)
		end
	end
end

-- Hooking to run it back.
sendInfoMessage("Hooking SMODS.calculate_end_of_round_effects...", "TOGAPack")
local calcendroundref = SMODS.calculate_end_of_round_effects
function SMODS.calculate_end_of_round_effects(context)
	if togabalatro.canareascore(context.cardarea) then calcendroundref(context) end
	if G.GAME and G.GAME.modifiers and G.GAME.modifiers.toga_reversedscore_special_kart then
		togabalatro.forcereverse = true
		calcendroundref(context)
		togabalatro.forcereverse = false
	end
	
	if context.cardarea == G.hand and context.end_of_round then
		togabalatro.triggereof(context) -- initial end of round scoring of cards with Hyperlink Seals
		local clippitcalc = {}
		SMODS.calculate_context({clippitscore_eor = true, cardarea = context.cardarea}, clippitcalc)
		for _, eval in pairs(clippitcalc) do
			for key, eval2 in pairs(eval) do
				if eval2.card then
					for i = 1, math.floor(eval2.rescores or eval2.card.ability.extra and eval2.card.ability.extra.rescores or 1) do
						calcendroundref(context)
						togabalatro.triggereof(context) -- rescore...
					end
				end
			end
		end
	end
end

-- Check for HandLimitAPI...
togabalatro.handlimitapi = function()
	return (SMODS.change_play_limit and SMODS.change_discard_limit and SMODS.update_hand_limit_text) or false
end

-- Using HandLimitAPI if possible.
togabalatro.handlimitchange = function(val, set_to)
	val = val or 0
	if togabalatro.handlimitapi() then
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Using HandLimitAPI. "..tostring(set_to).." "..val, "TOGAPack") end
		SMODS.change_play_limit(set_to and G.GAME.starting_params.play_limit - val or val)
		SMODS.change_discard_limit(set_to and G.GAME.starting_params.discard_limit - val or val)
	else
		if togabalatro.config.DoMoreLogging then sendInfoMessage("Backwards compatibility... "..val, "TOGAPack") end
		G.hand.config.highlighted_limit = math.max(G.hand.config.highlighted_limit + val, val < 0 and 1 or 5)
	end
end

-- weaponized negativity.
local negweightref = G.P_CENTERS['e_negative'].get_weight
G.P_CENTERS['e_negative'].get_weight = function(self)
	return negweightref(self)*(G.GAME.toga_negchance or 1)
end

-- Golden Wrench...
sendInfoMessage("Hooking Card:start_dissolve...", "TOGAPack")
local startdisref = Card.start_dissolve
function Card:start_dissolve(dissolve_colours, silent, dissolve_time_fac, no_juice)
	if self and self.config and self.config.center_key == 'j_toga_goldenwrench' and not self.ability.sold then togabalatro.goldenwrench(self) end
	startdisref(self, dissolve_colours, silent, dissolve_time_fac, no_juice)
end

-- Golden Wrench destruction...
togabalatro.goldenwrench = function(card)
	if card and card.config and card.config.center_key ~= 'j_toga_goldenwrench' then return end
	G.E_MANAGER:add_event(Event({
		func = function()
			for i = 1, #G.playing_cards do
				G.playing_cards[i]:set_ability(G.P_CENTERS.m_gold)
				G.playing_cards[i]:juice_up()
			end
			if togabalatro.config.SFXWhenTriggered and not silent then play_sound('toga_goldenhit', 1, 0.7) end -- insert sound here.
			return true
		end
	}))
end

togabalatro.isplayingcardarea = function(target)
	local t = {}
	t[#t+1] = G.play
	t[#t+1] = G.hand
	t[#t+1] = G.deck
	t[#t+1] = G.discard
	-- TOGA-TARGET: add your own CardAreas for playing cards
	for i, v in ipairs(t) do
		if v == target then return true end
	end
	return false
end

sendInfoMessage("Hooking draw_card...", "TOGAPack")
local drawcardref = draw_card
function draw_card(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	drawcardref(from, to, percent, dir, sort, card, delay, mute, stay_flipped, vol, discarded_only)
	if togabalatro.isplayingcardarea(to) and togabalatro.isplayingcardarea(from) then SMODS.calculate_context({ individual_draw = true, from_area = from, to_area = to }) end
end

togabalatro.externalfontsloaded = {}
togabalatro.getexternalfontcount = function()
	local count = 0
	for k, v in pairs(togabalatro.externalfontsloaded or {}) do
		if k and v then count = count + 1 end
	end
	return count
end

sendInfoMessage("Hooking love.graphics.newFont...", "TOGAPack")
local newfontref = love.graphics.newFont
function love.graphics.newFont(arg1, arg2, arg3, arg4)
	togabalatro.externalfontsloaded = togabalatro.externalfontsloaded or {}
	if type(arg1) == 'string' and not togabalatro.externalfontsloaded[arg1] then togabalatro.externalfontsloaded[arg1] = true end
	
	return newfontref(arg1, arg2, arg3, arg4)
end

sendInfoMessage("Hooking Card:set_debuff...", "TOGAPack")
local setdebuffref = Card.set_debuff
function Card:set_debuff(should_debuff)
	local prevstate = self.debuff
	setdebuffref(self, should_debuff)
    if self.debuff ~= prevstate and self.debuff == true then SMODS.calculate_context({ debuffed_ups = true, card = self }) end
end

-- Do additional stuff when playing a hand.
togabalatro.playextracards = function()
	-- SMS enhancement.
	local sms_deck = {}
	if G.deck.cards and #G.deck.cards > 0 then
		for i = 1, #G.deck.cards do
			if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_sms') then
				sms_deck[#sms_deck+1] = G.deck.cards[i]
			end
		end
	end
	if #sms_deck > 0 then
		for i = 1, #G.deck.cards do
			for v = 1, #sms_deck do
				if SMODS.has_enhancement(G.deck.cards[i], 'm_toga_sms') and sms_deck[v] == G.deck.cards[i] then
					if G.deck.cards[i]:is_face() then inc_career_stat('c_face_cards_played', 1) end
					G.deck.cards[i].base.times_played = G.deck.cards[i].base.times_played + 1
					G.deck.cards[i].ability.played_this_ante = true
					G.GAME.round_scores.cards_played.amt = G.GAME.round_scores.cards_played.amt + 1
					draw_card(G.deck, G.play, i*100/#sms_deck, 'up', nil, G.deck.cards[i])
				end
			end
		end
	end
	-- Draw cards to hand by Solitaire Joker... if we actually have a Straight.
	if next(SMODS.find_card('j_toga_solitairejoker')) then
		local _, _, pokerhands = G.FUNCS.get_poker_hand_info(G.hand.highlighted)
		if next(pokerhands['Straight']) then
			local curcards = {}
			for i = 1, #G.deck.cards do
				if G.deck.cards[i]:get_id() == G.GAME.current_round.togabalatro.solitaire.id then curcards[#curcards+1] = G.deck.cards[i] end
			end
			for c = 1, #curcards do
				if curcards[c] then draw_card(G.deck, G.hand, c*100/#curcards, 'up', true, curcards[c]) end
			end
		end
	end
	-- Draw cards to hand by (attempting to be) played Redstone cards.
	for i = 1, #G.hand.highlighted do
		if not G.hand.highlighted[i].debuff and SMODS.has_enhancement(G.hand.highlighted[i], 'm_toga_redstone') then draw_card(G.deck, G.hand, 1, 'up') end
	end
end

togabalatro.getconscount = function()
	local count = 0
	if G.consumeables and G.consumeables.cards then
		for i = 1, #G.consumeables.cards do
			local stack, stackamount = togabalatro.stackingcompat(G.consumeables.cards[i])
			if stack then count = count + stackamount else count = count + 1 end
		end
	end
	return count
end

-- Check for Overflow or Incantation...
togabalatro.stackingcompat = function(consumable)
	-- The new and shiny Overflow!
	if Overflow and consumable and consumable.ability and consumable.ability.immutable and consumable.ability.immutable.overflow_amount then
		return true, consumable.ability.immutable.overflow_amount
	-- ...though, backwards compatibility wouldn't hurt...
	elseif Incantation and consumable and consumable.ability and consumable.ability.qty then
		return true, consumable.ability.qty
	end
end

-- In case Incantation is used, check if it is the specific fork version so that the consumeables don't do unintended things...
if SMODS.Mods['incantation'] and not SMODS.Mods['incantation'].togafork and not string.find(SMODS.Mods['incantation'].version, '-TOGA_fork') then
	error([[
	Please obtain TheOneGoofAli's fork of Incantation to prevent unintended behaviour of the consumeables
	added by TOGA's Stuff at https://github.com/TheOneGoofAli/JensBalatroCollection in order to continue.
	Otherwise, remove it or add a '.lovelyignore' file into its' folder to disable it.
	Alternatively, why not check out Overflow at https://github.com/lord-ruby/Overflow for stacking too?
	]], 0)
end

-- I've not done such loading since making Windows for SRB2, but as the content is split off from this main file, gotta do it!
for _, file in ipairs{"joker.lua", "deck.lua", "voucher.lua", "enhancement.lua", "consumables.lua", "seal.lua", "booster.lua", "tag.lua", "deckskin.lua", "blind.lua", "challenges.lua", "crossmod.lua"} do
	sendDebugMessage("Executing items/"..file, "TOGAPack")
	assert(SMODS.load_file("items/"..file))()
end