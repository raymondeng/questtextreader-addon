HOST = 'http://questtextreader.parseapp.com'
BASE_URL = HOST .. "?name=%s&sex=%s&class=%s&race=%s&questLog=%s";

active = true

questIds = {};
pointer = 0;

MyAddon = LibStub("AceAddon-3.0"):NewAddon("Quest Text Reader",
    "AceConsole-3.0",
    "AceEvent-3.0",
    "AceTimer-3.0")

function MyAddon:ShowUrl()
    --MyAddon:Print("Timer executed")
    show_url(build_url(questIds));
end

MyAddon:RegisterChatCommand("questtextreader", "MySlashProcessorFunc")
MyAddon:RegisterChatCommand("qtr", "MySlashProcessorFunc")

function MyAddon:MySlashProcessorFunc(input)
    if input == "on" then
        active = true
    elseif input == "off" then
        active = false
    elseif input == "show" then
        --MyAddon:Print("Before Timer")
        self:ScheduleTimer("ShowUrl", 0.01)
    else
        MyAddon:Print("Usage:")
        MyAddon:Print("on - Enable showing the url on new quest")
        MyAddon:Print("off - Disable showing the url on new quest")
        MyAddon:Print("show - Show the current url")
        self:ScheduleTimer("ShowUrl", 0.01)
    end
end

function MyAddon:QUEST_ACCEPTED(eventName, index, questId)
    --MyAddon:Print("Quest accepted: " .. questId)
    UpdateQuestIds()
    if active == true then
        show_url(build_url(questIds))
    end
end

function MyAddon:UNIT_QUEST_LOG_CHANGED(eventName, unit)
    if unit == 'player' then
        UpdateQuestIds()
    end
end

-- get the quest ids of all quests in the quest log
function UpdateQuestIds()
    questIds = {}
    pointer = 0
    --MyAddon:Print("WTF?")
    for questIndex = 0, GetNumQuestLogEntries() do
        local title, level, suggestedGroup, isHeader, isCollapsed, isComplete, frequency, questID = GetQuestLogTitle(questIndex)
        --MyAddon:Print(questIndex .. ": " .. questID)
        if questID ~= 0 then
            questIds[pointer] = questID
            pointer = pointer + 1
        end
    end
end

-- get the current quest log on startup, then unregister the event
-- QUEST_LOG_UPDATE fires far more often then UNIT_QUEST_LOG_CHANGED, but the later does not fire on startup.
function MyAddon:QUEST_LOG_UPDATE(eventName)
    UpdateQuestIds()
    MyAddon:UnregisterEvent("QUEST_LOG_UPDATE")
end

MyAddon:RegisterEvent("QUEST_ACCEPTED")
MyAddon:RegisterEvent("UNIT_QUEST_LOG_CHANGED")
MyAddon:RegisterEvent("QUEST_LOG_UPDATE")

-- inserts the character specifics (name, quest log, etc) into the base url
function build_url(questIds)
    --local name = UnitName("player")
    --local class, dotcare, race = GetPlayerInfoByGUID(UnitGUID("player"))
    local dontcare, class, dontcare2, race, sex, name, realm = GetPlayerInfoByGUID(UnitGUID("player"))
    local questLog = mkString(questIds, ',')
    local link = string.format(BASE_URL, name, sex, class, race, questLog)
    return link
end

-- much crap, such stupid
function mkString(questIds, with)
    local qs = ""
    if pointer >= 1 then
        qs = qs .. questIds[0]
        if pointer >= 2 then
            for i = 1, (pointer - 1) do
                qs = qs .. with .. questIds[i]
            end
        end
    end
    return qs
end

-- opens the chat, inserts the url and highlights it
function show_url(url)
    --MyAddon:Print("Show!111")
    if url then
        local ChatFrameEditBox = ChatEdit_ChooseBoxForSend()
        ChatEdit_ActivateChat(ChatFrameEditBox)
        ChatFrameEditBox:Insert(url)
        ChatFrameEditBox:HighlightText()
    end
end

-- not used anymore
function urlEscape(url)
    return string.gsub(url, "([^A-Za-z0-9_:/?&=.-])",
        function(ch)
            return string.format("%%%02x", string.byte(ch))
        end)
end
