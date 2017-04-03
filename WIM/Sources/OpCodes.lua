-- This file contains a table of W2W & Communication OpCodes.
-- W2W Protocol v2
-- Goals: Reduce bandwidth & traffic volume of W2W data.

--Command OpCodes
WIM.O = {
    ["NEGOTIATE"]       = 1,
    ["SERVICES"]        = 2,
    ["TYPING_START"]    = 3,
    ["TYPING_STOP"]     = 4,
    ["LOC_REQUEST"]     = 5,
    ["LOC"]             = 6,
};

-- temp backwards compatibility for old protocol.
if(not WIM.useProtocol2) then
    for k, _ in pairs(WIM.O) do
        WIM.O[k] = k;
    end
end


--Service opCodes
WIM.S = {
    ["Typing"]          = 1,
    ["Coordinates"]     = 2,
    ["Talent Spec"]     = 3,
    ["Profiles"]        = 4,
};


--[[

When Convo is opened:
    - Say Hello, if response, send services.
    *Services are automatically resent whenever changed, ie: w2w privacy options changed.
    
Services Packet contains a list of "English" strings of available services. Example: Coordinates, Typing
    if Coodinates, need an exchange process of current location. One side doesn't need to have a convo
        opened. Currently using a Ping/Pong method. Problems: Waste of traffic. Solution, transmit less bits on request.
        
    if Typing, Sender only sends on/off bit when typing. Avoid resending the same bit values. only send on if previous bit was off.
    
Profiles: Alerted in Service packet. Hashed by modification date.
    - Profile hash should be sent with Services. ie: Profile:1234567
        -to be parsed as "Profile" with hash "1234567'.
        -Receiver checks if there is a record of profile 1234567, if not, request profile.
        -profile should be stored within the window object.
        -Since hash is stored in services, if profile is changed, services are updated and receiver can request profile again.
        
    GetProfile - called to user to return serialized profile data. (Includes most recent hash)
    
    Avatars: Subclass of Profiles. 2 types.
        1. static - sends texture file name.
        2. Stewmat - sends avatar hash (again timestamp of modified)
            - User can then request this using: GetAvatar:7654321
            - UI can use socket data to display progressbar of transmission.
            *Depending on Drawing time, one canvas should be shared between all
                instances showing the avatar. Canvases are messy.
                
Depending on solution of location sharing, a second method might be required for minimap tracking.

Ideas for sharing location:
    - User 1 sends user 2 a request for coordinates.
    - User 2 will send all requestees updated coordinates until asked to stop.
    - User 1 ends convo with user 2 and sends a stop message to user 2 to stop serving their location.
    - User 1 will keep timestamp of last loc update. If not received in theshhold time (ex: 30 seconds),
        send another request. (User might have reloaded their UI or DC'd.)
    - User 2 should every threshhold seconds (ie: 1 min) ask user 1 if loc is still wanted. If no response
        in additional theshhold (ie: 10 seconds), request has expired, stop serving.
    * determined theshholds are important to not cause delayed looping. Meaning, every minute, location is
        no longer being served and user 1 has to re-request. Should be a continuous motion.
    * Additionally, a safe C/D should be set for loc refresh. Don't want constant stream of loc when flying.


]]