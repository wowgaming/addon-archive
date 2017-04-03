
if false then

function Recount:DPrint(str)
end

--Recount.DPrint = function() end

else

Recount.Debug = true

function Recount:GetDebugFrame()
	for i=1,NUM_CHAT_WINDOWS do
		local windowName = GetChatWindowInfo(i);
		if windowName == "Debug" then
			return getglobal("ChatFrame" .. i)
		end
	end
end

function Recount:DPrint(str)
	local debugframe = Recount:GetDebugFrame()

	if debugframe then
		Recount:Print(debugframe, str)
	end
end

function Recount.TestCLLoad(load)
   local timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags
   
   timestamp = GetTime()
   eventtype = "SWING_DAMAGE"
   srcGUID = 0x00000000007DB5FD
   srcName = "Renetta"
   srcFlags = 0x511
   dstGUID = 0xF530005DDA2EA33A
   --dstName = "Fanggore Worg"
   dstName = "Archimonde"
   dstFlags = 0x10a48
   local earg1,earg2,earg3,earg4,earg5,earg6,earg7,earg8,earg9= 158,0,1,0,0,0,nil,nil,nil
   for i=1,load do
      Recount:CombatLogEvent(_,timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags,earg1,earg2,earg3,earg4,earg5,earg6,earg7,earg8,earg9)
      Recount:CombatLogEvent(_,timestamp, eventtype, dstGUID, dstName, dstFlags, srcGUID, srcName, srcFlags,earg1,earg2,earg3,earg4,earg5,earg6,earg7,earg8,earg9)
--      3/7 17:29:14.878  SWING_DAMAGE,0xF530005DDA2EA33A,"Fanggore Worg",0x10a48,0x00000000007DB5FD,"Renetta",0x511,158,0,1,0,0,0,nil,nil,nil

   end
end
end
