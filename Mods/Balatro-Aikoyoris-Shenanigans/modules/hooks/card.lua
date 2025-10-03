local caSave = CardArea.save
function CardArea:save(cardAreaTable)
    if G.GAME.akyrs_any_drag and cardAreaTable then
        cardAreaTable.akyrs_drag_to_target_save = self.states.collide.can
    end
    return caSave(self,cardAreaTable)
end
local caLoad = CardArea.load
function CardArea:load(cardAreaTable)
    
    if G.GAME.akyrs_any_drag and cardAreaTable then
        self.states.collide.can = cardAreaTable.akyrs_drag_to_target_save
    end
    return caLoad(self,cardAreaTable)
end
local v_scu = set_consumeable_usage
function set_consumeable_usage(card)
    

    return v_scu(card)
end


function Card:akyrs_flip_y()
    if self.facing == 'front' then 
        self.flipping = 'akyrs_f2b_y'
        self.facing='back'
        self.pinch.y = true
    elseif self.facing == 'back' then
        self.ability.wheel_flipped = nil
        self.flipping = 'akyrs_b2f_y'
        self.facing='front'
        self.pinch.y = true
    end
end
-- basically function get_front_spriteinfo(_front) returns pos n shit
AKYRS.sprite_info_override = function (_center,_front, card, orig_a, orig_p)
    --if not _center or not _front then return end
    --print(card.config.center_key,_front.suit,_front.value)
    _center = _center or card.config.center
    _front = _front or card.base
    if card and card.ability and card.ability.akyrs_special_card_type == "suit" then
        return AKYRS.suit_to_atlas(_front.suit, card)
    end
    if card and card.ability and card.ability.akyrs_special_card_type == "rank" then
        return AKYRS.rank_to_atlas(_front.value, card)
    end

    return orig_a, orig_p
end


AKYRS.should_playing_card_loc_hooks = function (_c, card)
    if not _c or not card then return false end
    --print(_c)
    return not not card.ability.akyrs_special_card_type
end

AKYRS.playing_card_loc_hooks = function (_c,full_UI_table,specific_vars,card)
    if card and card.ability and card.ability.akyrs_special_card_type == "rank" then
        localize{type = 'other', key = 'akyrs_playing_card_rank', set = 'Other', nodes = full_UI_table.name, vars = {localize(specific_vars.value, 'ranks'), localize(specific_vars.suit, 'suits_plural'), colours = {specific_vars.colour}}}
    end
    if card and card.ability and card.ability.akyrs_special_card_type == "suit" then
        localize{type = 'other', key = 'akyrs_playing_card_suit', set = 'Other', nodes = full_UI_table.name, vars = {localize(specific_vars.value, 'ranks'), localize(specific_vars.suit, 'suits_plural'), colours = {specific_vars.colour}}}
    end
end

AKYRS.should_score_chips = function (_c, card)
    --print(_c)
    if card.is_null then return false end
    if card.ability.akyrs_special_card_type == "suit" then
        return false
    end
    return true
end

AKYRS.mod_card_displays = function(_c,card,desc_nodes,specific_vars)
    if card and card.ability and card.ability.akyrs_special_card_type == "rank" then
        localize{type = 'other', key = 'akyrs_no_suit', nodes = desc_nodes}
    end
    if card and card.ability and card.ability.akyrs_special_card_type == "suit" then
        localize{type = 'other', key = 'akyrs_no_rank', nodes = desc_nodes}
    end
end


local cardSetSpriteHook = Card.set_sprites
function Card:set_sprites(_c,_f)
    local x = cardSetSpriteHook(self,_c,_f)
    _c = _c or self.config.center
    if _c and AKYRS.should_conceal_card(self, _c) then
        for key, spriters in pairs(self.children) do
            if self.children[key] and key ~= "center" and key ~= "shadow" and key ~= "back" and key ~= "front" then
                if spriters.atlas then
                    spriters.atlas = G.ASSET_ATLAS["akyrs_blank"]
                    spriters:set_sprite_pos({ x = 0, y = 0})
                end
            elseif key == "center" then
                spriters.atlas = G.ASSET_ATLAS["akyrs_eggymariHatenaSprite"]
                spriters.scale.x = 71
                spriters.scale.y = 95
                spriters.T.w = G.CARD_W
                spriters.T.h = G.CARD_H
                spriters:set_sprite_pos({ x = 0, y = 0})
            end
        end
    end
    
    if AKYRS.should_draw_letter(self) then
        if self:get_letter_with_pretend() then
            local letters = AKYRS.word_splitter(self:get_letter_with_pretend())
            if self.akyrs_letter and type(self.akyrs_letter) == "table" then
                for _,lt in ipairs(self.akyrs_letter) do
                    lt:remove()
                end
                self.akyrs_letter = nil
            end
            for i = #letters, 1, -1 do
                local letter_to_render = letters[i]
                local _atlas, _pos = AKYRS.get_sprite_for_letter(self,letter_to_render)
                if _atlas and _pos then
                    self.akyrs_letter = self.akyrs_letter or {}
                    if self.akyrs_letter[i] then self.akyrs_letter[i]:remove() end
                    self.akyrs_letter[i] = Sprite(self.T.x, self.T.y, self.T.w, self.T.h, _atlas, _pos)
                    self.akyrs_letter[i].states.hover = self.states.hover
                    self.akyrs_letter[i].states.click = self.states.click
                    self.akyrs_letter[i].states.drag = self.states.drag
                    self.akyrs_letter[i].states.collide.can = false
                    local maj = self.akyrs_letter[i + 1] or self
                    self.akyrs_letter[i]:set_role({role_type = "Minor", major = maj, draw_major = maj, xy_bond = "Strong", r_bond = "Strong"})
                end
            end
        end
    end
    return x
end


local gen_voucher_key_hook = get_next_voucher_key
function get_next_voucher_key(tag)
    local x = gen_voucher_key_hook(tag)
    if x then
        G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers = G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers or {}
        G.GAME.akyrs_generated_but_not_redeemed_vouchers_check = G.GAME.akyrs_generated_but_not_redeemed_vouchers_check or {}
        G.GAME.akyrs_generated_but_not_redeemed_vouchers_check[x] = true
        table.insert(G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers,x)
        AKYRS.remove_dupes(G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers)
    end
    return x
end

local get_next_vouchers_hook = SMODS.get_next_vouchers
function SMODS.get_next_vouchers(vouchers)
    local v = get_next_vouchers_hook(vouchers)
    if v and #v > 0 then
        for _,x in ipairs(v) do
            G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers = G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers or {}
            G.GAME.akyrs_generated_but_not_redeemed_vouchers_check = G.GAME.akyrs_generated_but_not_redeemed_vouchers_check or {}
            G.GAME.akyrs_generated_but_not_redeemed_vouchers_check[x] = true
            table.insert(G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers,x)
        end
        AKYRS.remove_dupes(G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers)

    end
    return v
end

-- remove redeemed voucher from the pool of possible pool
local cardRedeem = Card.redeem
function Card:redeem()
    local x = {cardRedeem(self)}
    
    if self.ability.set == "Voucher" then
        G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers = G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers or {}
        G.GAME.akyrs_generated_but_not_redeemed_vouchers_check = G.GAME.akyrs_generated_but_not_redeemed_vouchers_check or {}

        G.GAME.akyrs_generated_but_not_redeemed_vouchers_check[self.config.center_key] = nil
        AKYRS.remove_value_from_table(G.GAME.akyrs_list_of_generated_but_not_redeemed_vouchers,self.config.center_key)

    end
    return unpack(x)
end

AKYRS.hand_display_mod = function(hand,text,disp_text,poker_hands)
    if not hand then return end
    local are_pure = true
    for _,c in ipairs(hand) do
        if not c.ability.akyrs_special_card_type then
            are_pure = false
            break
        end
    end
    if are_pure and #hand > 0 then
        G.GAME.akyrs_pure_hand_modifier = G.GAME.akyrs_pure_hand_modifier or { multiplier = 2, power = 1, level = 1, played = 0 }
        -- what the fuck balatro why is this tostring function essential to it working????
        local _ = tostring(rawget(G.GAME.hands[text], "mult") or 1)
        local _2 = tostring(rawget(G.GAME.hands[text], "chips") or 1)
        local pre_mult = rawget(G.GAME.hands[text], "mult") or 1
        local pre_chips = rawget(G.GAME.hands[text], "chips") or 1
        --print(rawget(G.GAME.hands[text], "mult"))
        local hm = G.GAME.akyrs_pure_hand_modifier
        local final_mult, final_chips
        if Talisman and type(hm) == "table" and type(to_big(hm.multiplier)) == "table" then
            hm.multiplier = to_big(hm.multiplier)
            hm.power = to_big(hm.power)
            pre_mult = to_big(pre_mult)
            pre_chips = to_big(pre_chips)
            -- i fucking hate this
            local _,_2 = tostring(pre_mult),tostring(pre_chips)
            final_mult = pre_mult * to_big(hm.multiplier):pow(hm.power)
            final_chips = pre_chips * to_big(hm.multiplier):pow(hm.power)
        else
            final_mult = pre_mult * hm.multiplier ^ hm.power
            final_chips = pre_chips * hm.multiplier ^ hm.power
        end
        local m_d = "+"..tostring(final_mult-pre_mult)..""
        local h_d = "+"..tostring(final_chips-pre_chips)..""
        local m = final_mult
        local h = final_chips
        local hand_name = localize{ type = "variable", key = "k_akyrs_pure", vars = {disp_text}}
        update_hand_text({immediate = true, nopulse = true, delay = 0}, {handname=hand_name, level=G.GAME.hands[text].level, mult = m_d, chips = h_d, StatusText = true})
        update_hand_text({immediate = nil, nopulse = true, delay = 0}, {handname=hand_name, level=G.GAME.hands[text].level .."×"..tostring(hm.level), mult = m, chips = h})
        
        return true
    end
end
AKYRS.base_cm_mod = function(hand,poker_info,b_chip,b_mult,already_ran)
    if not hand then return end
    local are_pure = true
    for _,c in ipairs(hand) do
        if not c.ability.akyrs_special_card_type then
            are_pure = false
            break
        end
    end
    if are_pure and #hand > 0 then
        for _,c in ipairs(hand) do
            c:set_debuff(false)
        end
        local text = poker_info[1]
        G.GAME.akyrs_pure_unlocked = true
        G.GAME.akyrs_pure_hand_modifier = G.GAME.akyrs_pure_hand_modifier or { multiplier = 2, power = 1, level = 1, played = 0 }
        -- this function runs twice so
        G.GAME.akyrs_pure_hand_modifier.played = (G.GAME.akyrs_pure_hand_modifier.played or 0) + (already_ran and 0 or 1)
        -- what the fuck balatro why is this tostring function essential to it working????
        local _ = tostring(rawget(G.GAME.hands[text], "mult") or 1)
        local _2 = tostring(rawget(G.GAME.hands[text], "chips") or 1)
        local pre_mult = rawget(G.GAME.hands[text], "mult") or 1
        local pre_chips = rawget(G.GAME.hands[text], "chips") or 1
        --print(rawget(G.GAME.hands[text], "mult"))
        local hm = G.GAME.akyrs_pure_hand_modifier
        local final_mult, final_chips
        if Talisman and type(hm) == "table" and type(to_big(hm.multiplier)) == "table" then
            hm.multiplier = to_big(hm.multiplier)
            hm.power = to_big(hm.power)
            pre_mult = to_big(pre_mult)
            pre_chips = to_big(pre_chips)
            -- i fucking hate this
            local _,_2 = tostring(pre_mult),tostring(pre_chips)
            final_mult = pre_mult * to_big(hm.multiplier):pow(hm.power)
            final_chips = pre_chips * to_big(hm.multiplier):pow(hm.power)
        else
            final_mult = pre_mult * hm.multiplier ^ hm.power
            final_chips = pre_chips * hm.multiplier ^ hm.power
        end
        local hand_name = localize{ type = "variable", key = "k_akyrs_pure", vars = {poker_info[2]}}
        mult = mod_mult(final_mult)
        hand_chips = mod_chips(final_chips)
        update_hand_text({immediate = true, delay = 0 }, {handname=hand_name, chips = hand_chips, mult = mult})
        return true
    end
end

function Card:akyrs_get_perma_score()
    
    if self.debuff then return 0 end
    local ret = (self.ability.akyrs_perma_score or 0)
    -- TARGET: akyrs_get_perma_score
    return ret
end
function Card:akyrs_get_perma_h_score()
    
    if self.debuff then return 0 end
    local ret = (self.ability.akyrs_perma_h_score or 0)
    -- TARGET: akyrs_get_perma_h_score
    return ret
end

local smods_eternal = SMODS.is_eternal
function SMODS.is_eternal(card,trigger)
    if card and type(card) == "table" then
        if card.ability.akyrs_sigma or card.ability.akyrs_stay_sigma then
            return true
        end
        if card.ability.akyrs_attention then
            return true
        end
    end
    return smods_eternal(card,trigger)
end

local cardarea_sort = CardArea.sort
function CardArea:sort(method)
    if G.GAME and G.GAME.akyrs_character_stickers_enabled and not method then
        self.config.sort = nil
        return cardarea_sort(self,self.config.sort)
    end
    return cardarea_sort(self,method)
end

local func_bfs = G.FUNCS.buy_from_shop

G.FUNCS.buy_from_shop = function (e)
    local c1 = e.config.ref_table
    if c1.config.center_key == "j_akyrs_blue_portal" and not AKYRS.has_room(G.jokers, c1, 1) then
        --print("!!!!")
        alert_no_space(c1,G.jokers)
        e.disable_button = nil
        return false
    else
        return func_bfs(e)
    end
end

local card_click = Card.click
function Card:click()
    return card_click(self)
end

AKYRS.should_conceal_card = function(card, center)
    if not card and center then return G.GAME.akyrs_hatena_everything end
    if not card then return G.GAME.akyrs_hatena_deck or G.GAME.akyrs_hatena_everything end
    local config = (card.config and card.config.center or center)
    return (G.GAME.akyrs_hatena_deck and config.set == "Joker") or (G.GAME.akyrs_hatena_everything) or (card.ability and card.ability.akyrs_concealed)
end