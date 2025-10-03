function Card:resize(mod, force_save)
    self:hard_set_T(self.T.x, self.T.y, self.T.w * mod, self.T.h * mod)
    remove_all(self.children)
    self.children = {}
    self.children.shadow = Moveable(0, 0, 0, 0)
    self:set_sprites(self.config.center, self.base.id and self.config.card)
end

local mainmenuref2 = Game.main_menu
Game.main_menu = function(change_context)

    local ret = mainmenuref2(change_context)

        --Replace j_unik_unik with 'j_perkeo' or any other card
    local newcard = SMODS.create_card({key='j_perkeo', edition='e_negative',area = G.title_top})
	G.title_top.T.w = G.title_top.T.w * 1.7675
	G.title_top.T.x = G.title_top.T.x - 0.8
    G.title_top:emplace(newcard)
    newcard:start_materialize()
    newcard:resize(1.1 * 1.2)
    newcard.no_ui = true
    return ret
end

SMODS.current_mod.optional_features = function()
    return {
      retrigger_joker = true
    }
  end
  
  --loads mod componets

assert(SMODS.load_file('jokers.lua'))()
assert(SMODS.load_file('rarity.lua'))()
assert(SMODS.load_file('consumeables.lua'))()
