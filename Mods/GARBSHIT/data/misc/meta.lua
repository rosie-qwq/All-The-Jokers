return {

-- META STUFF

SMODS.UndiscoveredSprite{
    key = 'Stamp',
    atlas = 'Stamps',
    pos = { x = 0, y = 0 }
},

SMODS.Atlas({
	key = "GarbPartner",
	path = "partners.png",
	px = 46,
	py = 58,
}),

SMODS.Atlas({
	key = "modicon",
	path = "garb_icon.png",
	px = 32,
	py = 32,
}),

SMODS.Atlas({
	key = "GarbTags",
	path = "tags.png",
	px = 34,
	py = 34,
}),

SMODS.Atlas({
	key = "GarbSleeves",
	path = "Sleeves.png",
	px = 73,
	py = 95,
}),


SMODS.Atlas({
	key = "GarbVouchers",
	path = "Vouchers.png",
	px = 71,
	py = 95,
}),

SMODS.Atlas{
    key = 'GarbJokers', --atlas key
    path = 'Jokers.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
},

SMODS.Atlas{
    key = 'GarbBoosters', --atlas key
    path = 'Boosters.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
},

SMODS.Atlas{
    key = 'Stamps', --atlas key
    path = 'Stamps.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
  },

SMODS.Atlas{
  key = 'GarbConsumables', --atlas key
  path = 'Consumables.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71, --width of one card
  py = 95 -- height of one card
},

SMODS.Atlas{
    key = 'GarbDecks', --atlas key
    path = 'Decks.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
    px = 71, --width of one card
    py = 95 -- height of one card
  },

SMODS.Atlas{
  key = 'GarbEnhancements', --atlas key
  path = 'Enhancements.png', --atlas' path in (yourMod)/assets/1x or (yourMod)/assets/2x
  px = 71, --width of one card
  py = 95 -- height of one card
},

	SMODS.Sound {
    key = "mirrorz",
    path = {
        ["default"] = "mirror2.ogg"
    }
	},
	
	SMODS.Sound {
    key = "abadeus1",
    path = {
        ["default"] = "abadeus2.ogg"
    },
	volume = 0.5
	},
	
	SMODS.Sound {
    key = "explosion",
    path = {
        ["default"] = "explosion.ogg"
    },
	volume = 0.5
	},
	
	SMODS.Sound {
    key = "surge",
    path = {
        ["default"] = "surge2.ogg"
    },
	volume = 0.4
	},
	
	SMODS.Sound {
    key = "surge",
    path = {
        ["default"] = "surge2.ogg"
    },
	volume = 0.2
	},
	
	SMODS.Sound {
    key = "squeak",
    path = {
        ["default"] = "squeak.wav"
    },
	volume = 0.4
	},

  SMODS.Sound {
    key = "scopacane",
    path = {
        ["default"] = "scopacane2.ogg"
    },
	volume = 0.5
	},

  
  SMODS.Sound {
    key = "jimboss_defeat",
    path = {
        ["default"] = "jimboss_defeat.ogg"
    },
	volume = 0.5
	},

  SMODS.Sound {
    key = "jimboss_hit",
    path = {
        ["default"] = "jimboss_hit.wav"
    },
	volume = 0.5
	},

  SMODS.Sound {
    key = "infect",
    path = {
        ["default"] = "infect.ogg"
    },
	volume = 0.5
	},

    SMODS.Sound {
        key = "snap",
        path = {
            ["default"] = "snap_nodrama.ogg"
        }
        },

    SMODS.Sound {
       key = "bisso",
        path = {
            ["default"] = "bisso.ogg"
        }
        },
    
    SMODS.Sound {
        key = "gong",
        path = {
            ["default"] = "gong.ogg"
        },
	    volume = 0.5
	    },

    SMODS.Sound {
        key = "gunshot",
        path = {
            ["default"] = "gunshot.ogg"
        },
        volume = 0.4
	    },

        
    SMODS.Sound {
        key = "music_stamps",
        path = {
            ["default"] = "music_stamps.ogg"
        },
        sync = true,
        pitch = 1,
        select_music_track = function()
          return G.pack_cards
          and G.pack_cards.cards
          and G.pack_cards.cards[1]
          and G.pack_cards.cards[1].ability.set == "Stamp"
        end
    },

  SMODS.Sound {
    key = "music_fukkireta",
    path = {
        ["default"] = "music_fukkireta.ogg"
    },
    sync = false,
    pitch = 1,
    select_music_track = function()
      return next(SMODS.find_card("j_garb_teto")) and 20 and config.fukkireta or false
    end
}

}