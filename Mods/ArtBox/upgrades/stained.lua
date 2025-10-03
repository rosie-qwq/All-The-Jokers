SMODS.Enhancement({
  key = "stained",
  pos = { x = 1, y = 0 },
  discovered = true,
  no_rank = true,
  no_suit = true,
  replace_base_card = true,
  config = {
    extra = {
        n=1,
        d=3,
        super_n=1,
        super_d=10
      }
  },

  loc_vars = function(self, info_queue, card)
    info_queue[#info_queue + 1] = G.P_TAGS.tag_artb_creative
    local n, d = SMODS.get_probability_vars(card, card.ability.extra.n,  card.ability.extra.d, 'stained')
    local super_n, super_d = SMODS.get_probability_vars(card, card.ability.extra.super_n,  card.ability.extra.super_d, 'stained')
    return {
      vars = {
        n, d, super_n, super_d
      }
    }
  end,

  calculate = function(self, card, context)
    if context.discard then
      if context.other_card == card then
        if SMODS.pseudorandom_probability(card, 'stained', card.ability.extra.n, card.ability.extra.d, 'stained') and #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
          G.GAME.consumeable_buffer=G.GAME.consumeable_buffer+1
          G.E_MANAGER:add_event(Event({
            func = function()
            SMODS.add_card {
              set = 'art',
              key_append = 'stained'
            }
            G.GAME.consumeable_buffer = 0
            return true
            end
          }))
          SMODS.calculate_effect({extra = { message = localize('artb_plus_art')}}, card)
        end
        if SMODS.pseudorandom_probability(card, 'stained', card.ability.extra.super_n, card.ability.extra.super_d, 'stained') then
          local tag = Tag("tag_artb_creative")
          add_tag(tag)
          return {
            message = localize('artb_plus_tag')
          }
        end
      end
    end
  end,
})

-- Render actual Stained sprite
SMODS.DrawStep {
  key = 'stained',
  order = 25,
  func = function(self, layer)
    if SMODS.has_enhancement(self, 'm_artb_stained') then
      if not ArtBox.stained_sprite then
        ArtBox.stained_sprite = Sprite(0, 0, G.CARD_W, G.CARD_H, G.ASSET_ATLAS['artb_enhancers_atlas'], { x = 1, y = 0 })
      end
      ArtBox.stained_sprite.role.draw_major = self
      if self.edition and not self.delay_edition then
        for k, v in pairs(G.P_CENTER_POOLS.Edition) do
          if self.edition[v.key:sub(3)] and v.shader then
            if type(v.draw) == 'function' then
              v:draw(self, layer)
            else
              ArtBox.stained_sprite:draw_shader(v.shader, nil, self.ARGS.send_to_shader, nil, self.children.center)
            end
          end
        end
        if self.edition.negative then
          ArtBox.stained_sprite:draw_shader('negative_shine', nil, self.ARGS.send_to_shader, nil, self.children.center)
        end
      elseif not self:should_draw_base_shader() then
        -- Don't render base dissolve shader.
      elseif not self.greyed then
        ArtBox.stained_sprite:draw_shader('dissolve', nil, nil, nil, self.children.center)
      end
    end
  end,
  conditions = { vortex = false, facing = 'front' },
}

local shf = Card.should_hide_front
function Card:should_hide_front()
  if SMODS.has_enhancement(self, 'm_artb_stained') then return false end
  return shf(self)
end

-- Edition drawstep
SMODS.DrawStep {
    key = 'Stained_Edition',
    order = 21,
    func = function(self, layer)
        if self.edition and not self.delay_edition then
            for k, v in pairs(G.P_CENTER_POOLS.Edition) do
                if self.edition[v.key:sub(3)] and v.shader then
                    if type(v.draw) == 'function' then
                        v:draw(self, layer)
                    else
                        if self.children.front and SMODS.has_enhancement(self, 'm_artb_stained') then
                            self.children.front:draw_shader(v.shader, nil, self.ARGS.send_to_shader)
                        end
                    end
                end
            end
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Debuff drawstep
SMODS.DrawStep {
    key = 'Stained_Debuff',
    order = 71,
    func = function(self, layer)
        if self.debuff and self.children.front and SMODS.has_enhancement(self, 'm_artb_stained') then
            self.children.front:draw_shader('debuff', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}

-- Greyed drawstep
SMODS.DrawStep {
    key = 'Stained_Greyed',
    order = 81,
    func = function(self, layer)
        if self.greyed and self.children.front and SMODS.has_enhancement(self, 'm_artb_stained') then
            self.children.front:draw_shader('played', nil, self.ARGS.send_to_shader)
        end
    end,
    conditions = { vortex = false, facing = 'front' },
}