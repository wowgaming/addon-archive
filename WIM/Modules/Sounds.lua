--imports
local WIM = WIM;
local _G = _G;
local PlaySoundFile = PlaySoundFile;
local SML = _G.LibStub:GetLibrary("LibSharedMedia-3.0");
local SOUND = SML.MediaType.SOUND;
local string = string;

--set namespace
setfenv(1, WIM);

db_defaults.sounds = {
    whispers = {
        msgin = true,
        msgin_sml = "IM",
        msgout = false,
        msgout_sml = "IM",
        friend = false,
        friend_sml = "IM",
        guild = false,
        guild_sml = "IM",
        bnet = false,
        bnet_sml = "IM"
    },
    chat = {
        msgin = true,
        msgin_sml = "Chat Blip",
        msgout = false,
        msgout_sml = "Chat Blip",
        
        guild_sml = "Chat Blip",
        officer_sml = "Chat Blip",
        party_sml = "Chat Blip",
        raid_sml = "Chat Blip",
        raidleader_sml = "Chat Blip",
        battleground_sml = "Chat Blip",
        battlegroundleader_sml = "Chat Blip",
        say_sml = "Chat Blip",
        world_sml = "Chat Blip",
        custom_sml = "Chat Blip",
    }
};

local function playSound(smlKey)
    local path = SML:Fetch(SOUND, smlKey);
    if path then
        PlaySoundFile(path);
    end
end

--Whisper Sounds
local Sounds = CreateModule("Sounds", true);

-- Sound events
function Sounds:PostEvent_Whisper(...)
    if(db and db.sounds.whispers.msgin) then
        local msg, user = ...;
        if(db.sounds.whispers.bnet and windows.active.whisper[user].isBN) then
            playSound(db.sounds.whispers.bnet_sml);
        elseif(db.sounds.whispers.friend and lists.friends[user]) then
            playSound(db.sounds.whispers.friend_sml);
        elseif(db.sounds.whispers.guild and lists.guild[user]) then
            playSound(db.sounds.whispers.guild_sml);
        else
            playSound(db.sounds.whispers.msgin_sml);
        end
    end
end

function Sounds:PostEvent_WhisperInform(...)
    if(db and db.sounds.whispers.msgout) then
        playSound(db.sounds.whispers.msgout_sml);
    end
end


--Chat Sounds
local ChatSounds = CreateModule("ChatSounds", true);

-- Sound events
function ChatSounds:PostEvent_ChatMessage(event, ...)
    local arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9 = ...;
    local isWorld = arg7 and arg7 > 0;
    if(arg2 == _G.UnitName("player")) then
        --message sent
        if(db and db.sounds.chat.msgout) then
            playSound(db.sounds.chat.msgout_sml);
        end
    else
        --message received.
        if(db and db.sounds.chat.msgin) then
            local d = db.sounds.chat;
            if(d.guild and event == "CHAT_MSG_GUILD") then
                playSound(db.sounds.chat.guild_sml);
            elseif(d.officer and event == "CHAT_MSG_OFFICER") then
                playSound(db.sounds.chat.officer_sml);
            elseif(d.party and (event == "CHAT_MSG_PARTY" or event == "CHAT_MSG_PARTY_LEADER")) then
                playSound(db.sounds.chat.party_sml);
            elseif(d.raidleader and event == "CHAT_MSG_RAID_LEADER") then
                playSound(db.sounds.chat.raidleader_sml);
            elseif(d.raid and (event == "CHAT_MSG_RAID" or event == "CHAT_MSG_RAID_LEADER")) then
                playSound(db.sounds.chat.raid_sml);
            elseif(d.raid and event == "CHAT_MSG_BATTLEGROUND_LEADER") then
                playSound(db.sounds.chat.battlegroundleader_sml);    
            elseif(d.raid and (event == "CHAT_MSG_BATTLEGROUND" or event == "CHAT_MSG_BATTLEGROUND_LEADER")) then
                playSound(db.sounds.chat.battleground_sml);    
            elseif(d.say and event == "CHAT_MSG_SAY") then
                playSound(db.sounds.chat.say_sml);
            elseif(event == "CHAT_MSG_CHANNEL" and isWorld) then
                local channelName = string.split(" - ", arg9);
                local noSound = db.chat["world"] and db.chat["world"].channelSettings and
                                db.chat["world"].channelSettings[channelName] and
                                db.chat["world"].channelSettings[channelName].noSound;
                if(not noSound) then
                    if(d.world) then
                        playSound(db.sounds.chat.world_sml);
                    else
                        playSound(db.sounds.chat.msgin_sml);
                    end
                end
            elseif(event == "CHAT_MSG_CHANNEL") then
                local channelName = string.split(" - ", arg9);
                local noSound = db.chat["custom"] and db.chat["custom"].channelSettings and
                                db.chat["custom"].channelSettings[channelName] and
                                db.chat["custom"].channelSettings[channelName].noSound;
                if(not noSound) then
                    if(d.custom) then
                        playSound(db.sounds.chat.custom_sml);
                    else
                        playSound(db.sounds.chat.msgin_sml);
                    end
                end
            else
                -- default sound
                playSound(db.sounds.chat.msgin_sml);
            end
        end
    end
end





-- import WIM's stock sounds into LibSharedMedia-3.0
SML:Register(SOUND, "IM", "Interface\\AddOns\\"..addonTocName.."\\Sounds\\wisp.wav");
SML:Register(SOUND, "iChat In", "Interface\\AddOns\\"..addonTocName.."\\Sounds\\ichatIn.mp3");
SML:Register(SOUND, "iChat Out", "Interface\\AddOns\\"..addonTocName.."\\Sounds\\ichatOut.mp3");
SML:Register(SOUND, "Chat Blip", "Interface\\AddOns\\"..addonTocName.."\\Sounds\\chat.mp3");

--[[ Test Scrolling Dropdown menu.
for i=1,20 do
    SML:Register(SOUND, "Test "..i, "Interface\\AddOns\\"..addonTocName.."\\Sounds\\ichatOut.mp3");
end
]]

-- This is a core module and must always be loaded...
Sounds.canDisable = false;
Sounds:Enable();
ChatSounds.canDisable = false;
ChatSounds:Enable();