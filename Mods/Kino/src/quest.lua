-- Quests should check at the following moments
-- After scoring, check if the scored hand is quest compatible
-- When the blind ends, check if everything is quest compatible
-- When the shop is left, check if everything is quest compatible
-- When an item is used 

-- Quest object layout
-- {
-- trigger = nil, 
-- type = nil,
-- condition = nil,
-- alt_text = {
--     "Destroy 5 cards of",
--     "different ranks"
-- }, 

-- LIST OF QUEST TRIGGERS
-- "after"
-- "end_of_round"
-- "setting_blind"
-- "using_consumeable"

-- LIST OF QUEST TYPES
-- "scoring_hand_type"

function Card:quest_calc(card, quest, _index, context)
    -- only check if quest list is passed through
    if quest == nil then return end
    if context.blueprint or context.retrigger then return end

    -- prevent need for repetitive behaviour
    local _increment = 0
    local _quest_completed = false

    -- after scoring
    if context.after and quest.trigger == "after" then
        
        if quest.type == "hand_type" and context.scoring_name == quest.condition then
            _increment = _increment + 1
        end

        for _, _card in ipairs(context.scoring_hand) do
            if quest.type == "card_rank" and _card:get_id() == quest.condition then
                _increment = _increment + 1
            end
            if quest.type == "card_suit" and _card:is_suit(quest.condition) then
                _increment = _increment + 1
            end
            if quest.type == "card_enhancement" and SMODS.has_enhancement(_card, quest.condition) then
                _increment = _increment + 1
            end
            if quest.type == "card_seal" and _card.seal == quest.condition then
                _increment = _increment + 1
            end
            if quest.type == "card_edi" and _card.edition == quest.condition then
                _increment = _increment + 1
            end
        end 
    end

    -- after blind
    if context.end_of_round and quest.trigger == "end_of_round" then
        
    end

    -- leaving shop
    if context.setting_blind and quest.trigger == "setting_blind" then
        
    end

    -- using consumeable
    if context.using_consumeable and quest.trigger == "using_consumeable" then

    end

    -- Increment quest progression or set it to done
    quest.times = quest.times +  _increment 

    if quest.times >= quest.goal then
        quest.completion = true
        _quest_completed = true
    end

    return {
        incremented = _increment,
        completed = _quest_completed,
    }
end

function Kino.create_quest(trigger, quest_type, condition, goal)
    local _triggers = {
        "after",
        "end_of_round",
        "setting_blind",
        "using_consumeable",
    }

    local _types = {
        after = {
            "hand_type",
            "card_rank",
            "card_suit",
            "card_enhancement",
            "card_seal",
            "card_edi"
        },
        -- end_of_round = {
            
        -- },
        -- setting_blind = {

        -- },
        -- using_consumeable = {

        -- }
    }

    local _goals = {1, 2, 3, 4, 5}

    local _conditions = {
        hand_type = get_random_hand(),
        card_suit = {"Hearts", "Spades", "Diamonds", "Clubs"},
        card_rank = {1,2,3,4,5,6,7,8,9,10,11,12,13,14},
        card_enhancement = SMODS.poll_enhancement({key = 'quest_poll', guaranteed = true}),
        card_seal = SMODS.poll_seal({key = 'quest_poll', guaranteed = true}),
        card_edi = poll_edition('quest_poll', nil, true, true)
    }

    if trigger == nil then
        trigger = pseudorandom_element(_triggers, pseudoseed("quest_trigger"))
    end
    if quest_type == nil then
        quest_type = pseudorandom_element(_types[trigger], pseudoseed("quest_type"))
    end
    if condition == nil then
        if type(_conditions[quest_type]) ~= "table" then
            condition = _conditions[quest_type]
        else
            condition = pseudorandom_element(_conditions[quest_type], pseudoseed("quest_condition"))
        end
    end

    if goal == nil then
        goal = pseudorandom_element(_goals, pseudoseed("quest_goals"))
    end

    -- local _alt_text = "{Trigger: " .. trigger .. " |\n Type: " ..quest_type .. " |\n Condition: " .. condition .. " |\n goal: " .. goal .. " }" 

    local _localize_key = quest_type == "hand_type" and "hand_type" or "card_type"

    local _alt_text = localize({
        type = 'variable',
        key = 'v_kino_quest_' .. _localize_key,
        vars = {
            localize({type="name", set="Enhanced", key="m_bonus"}),
            goal > 1 and localize({type='variable', key='v_kino_questtimer', vars = {goal}}) or nil
        }
    })

    return {
        trigger =  trigger,
        type = quest_type,
        condition = condition,
        alt_text = _alt_text,
        localize_func = "",
        times = 0, 
        goal = goal,
        completed = false
    }
end

-- Play a [Hand type name] [If: goal > 1 then "X times"]
-- Score a [Card quality] card [If: goal > 1 then "X times"]
