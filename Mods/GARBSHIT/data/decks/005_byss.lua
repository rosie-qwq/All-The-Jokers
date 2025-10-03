return {
 SMODS.Back {
        key = 'byss',
        config = {},
        atlas = 'GarbDecks',
        pos = { x = 1, y = 1 },    
        unlocked = false,
        discovered = true,
        config = {
            slots = 1,
            joker_slot = -4
        },
        loc_vars = function(self, info_queue, card)
            return {vars = {self.config.slots}}
        end,
        apply = function(self, back)
            
        end,
        calculate = function(self,card,context)
            if context.end_of_round and G.GAME.blind.boss and not context.individual and not context.repetition then
                G.jokers.config.card_limit = G.jokers.config.card_limit + 1
                play_sound('generic1', 0.9 + math.random()*0.1, 0.8)
                play_sound('garb_bisso')    
                card_eval_status_text(G.jokers, 'extra', nil, nil, nil, {message = "+1 Slots!", colour = G.C.DARK_EDITION})                    
            end
        end,
        unlock_condition = {type = 'win_deck', deck = 'b_garb_cycle'},
        check_for_unlock = function(self, args)
            if args.type == "win_deck" then
                if get_deck_win_stake(self.unlock_condition.deck) > 0 then
                    return true
                end
            end          
        end,    
    },
}