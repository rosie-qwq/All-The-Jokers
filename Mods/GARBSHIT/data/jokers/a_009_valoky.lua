return {
 SMODS.Joker {
  key = 'valoky',
  loc_txt = {
    name = 'Valoky',
    text = {
      "First {C:attention}Skip Tag{} of",
      "ante is always a",
      "{C:attention}Carnival Tag"
    },
    unlock = {
      "{E:1,s:1.3}?????"
    }
  },
  config = { extra = { } },
  rarity = 4,
  atlas = 'GarbJokers',
  pos = { x = 3, y = 8 },
  soul_pos = { x = 4, y = 8 },
  cost = 20,

  unlocked = false, 
  discovered = false, --whether or not it starts discovered
  blueprint_compat = true, --can it be blueprinted/brainstormed/other
  eternal_compat = false, --can it be eternal
  perishable_compat = false, --can it be perishable

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue+1] = {set = "Tag", key = "tag_garb_carnival", specific_vars = {}}
    return { vars = { } }
  end,

  add_to_deck = function(self, card)
    G.GAME.round_resets.blind_tags.Small = 'tag_garb_carnival'
    check_for_unlock({ type = "discover_valoky" })
  end,
},


-- TITLE JOKERS

}