B1999 = {}
B1999.VERSATILE = 0
B1999.VERSATILE_HAND = 0

SMODS.current_mod.optional_features = function()
    return {
		cardareas = {
			deck = true,
			discard = true
		},
        post_trigger = true,
		retrigger_joker = true
    }
end



SMODS.load_file("hooksmayhaps.lua")()
SMODS.load_file("oof, gimmicky/reverse.lua")()

SMODS.load_file("content/jokers/anjo.lua")()
SMODS.load_file("content/jokers/pavia.lua")()
SMODS.load_file("content/jokers/door.lua")()
SMODS.load_file("content/jokers/fmstuff.lua")()
SMODS.load_file("content/jokers/orange.lua")()
SMODS.load_file("content/jokers/windsong.lua")()
SMODS.load_file("content/jokers/lopera.lua")()
SMODS.load_file("content/jokers/jokernia.lua")()
SMODS.load_file("content/jokers/carbuncles.lua")()
SMODS.load_file("content/jokers/loggerhead.lua")()
SMODS.load_file("content/jokers/tf.lua")()
SMODS.load_file("content/jokers/rainemblem.lua")()
SMODS.load_file("content/jokers/mradio.lua")()
SMODS.load_file("content/jokers/catch.lua")()
SMODS.load_file("content/jokers/creame.lua")()
SMODS.load_file("content/jokers/kala.lua")()
SMODS.load_file("content/jokers/gross.lua")()
SMODS.load_file("content/jokers/will.lua")()
SMODS.load_file("content/jokers/papper.lua")()
SMODS.load_file("content/jokers/hissabeth.lua")()
SMODS.load_file("content/vouchers/pneuma.lua")()
SMODS.load_file("content/decks/timekeeper.lua")()
SMODS.load_file("content/decks/stormd.lua")()
SMODS.load_file("content/spectral/storm.lua")()
SMODS.load_file("content/spectral/acoustica.lua")()
SMODS.load_file("content/acoustica/acousticatype.lua")()
SMODS.load_file("content/acoustica/draft.lua")()

B1999.compat = {
	partner = (SMODS.Mods['partner'] or {}).can_load or false,
}

if B1999.compat.partner then 
	SMODS.load_file('content/partners/slice.lua')() 
	SMODS.load_file('content/partners/fmpart.lua')() 
	SMODS.load_file('content/partners/wspart.lua')() 
	SMODS.load_file('content/partners/mradio.lua')() 
	SMODS.load_file('content/partners/hisspart.lua')() 
end


SMODS.Atlas {
	key = "B1999",
	path = "B1999.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "buncles",
	path = "buncles.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "tune",
	path = "tune.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "seal",
	path = "seal.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "ba",
	path = "ba.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "vouch",
	path = "vouch.png",
	px = 71,
	py = 95
}

SMODS.Atlas {
	key = "spectr",
	path = "spectr.png",
	px = 71,
	py = 95
}

SMODS.Atlas{
    key = "acoustica",
	path = "acoustica.png",
    px = 71,
	py = 95
}

SMODS.Atlas{
    key = "enhance",
	path = "enhance.png",
    px = 71,
	py = 95
}

SMODS.Atlas{
    key = "part",
    px = 46,
    py = 58,
    path = "parts.png"
}


-- ngl... Completely stole this from Handsome Devils mod
function B1999.poll_tag(seed, options, exclusions)
  local pool = options or get_current_pool('Tag')
  if exclusions then
    for excluded_index = 1, #exclusions do
      for pool_index = 1, #pool do
        if exclusions[excluded_index] == pool[pool_index] then
          table.remove(pool, pool_index)
          break
        end
      end
    end
  end
  local tag_key = pseudorandom_element(pool, pseudoseed(seed))
  while tag_key == 'UNAVAILABLE' do
    tag_key = pseudorandom_element(pool, pseudoseed(seed))
  end
  local tag = Tag(tag_key)
  if tag_key == "tag_orbital" then
    local available_hands = {}
    for k, hand in pairs(G.GAME.hands) do
      if hand.visible then
        available_hands[#available_hands + 1] = k
      end
    end
    tag.ability.orbital_hand = pseudorandom_element(available_hands, pseudoseed(seed .. '_orbital'))
  end
  return tag
end
if not Card.scale_value then
	function Card:scale_value(applied_value, scalar)
		return applied_value + scalar
	end
end

function versatileIncrease(num)
    SMODS.change_play_limit(num)
    SMODS.change_discard_limit(num)
    B1999.VERSATILE = B1999.VERSATILE + num
end

function versatileUpd()
	if G.hand then
    	SMODS.change_play_limit(-B1999.VERSATILE)
    	SMODS.change_discard_limit(-B1999.VERSATILE)
    	B1999.VERSATILE = 0
  	end
end