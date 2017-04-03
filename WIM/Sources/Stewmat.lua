--[[
    Stewmat is a format dedicated to Stewarta
]]

-- imports
local WIM = WIM;
local _G = _G;
local string = string;
local CreateFrame = CreateFrame;
local table = table;

-- set namespace
setfenv(1, WIM);



function createCanvas()
    local canvas = CreateFrame("Frame");
    canvas:SetWidth(64); canvas:SetHeight(64);
    canvas.pixels = {};
    for i = 1, 64*64 do
        local pixel = canvas:CreateTexture(nil, "OVERLAY");
        pixel:SetWidth(1); pixel:SetHeight(1);
        pixel:SetTexture(i%2, i%2, i%2); -- test
        if(#canvas.pixels == 0) then
            pixel:SetPoint("TOPLEFT");
        else
            if(i%64 == 1) then
                pixel:SetPoint("TOPLEFT", canvas.pixels[#canvas.pixels-63], "BOTTOMLEFT");
            else
                pixel:SetPoint("TOPLEFT", canvas.pixels[#canvas.pixels], "TOPRIGHT");
            end
        end
        table.insert(canvas.pixels, pixel);
    end
    canvas.Clear = function(self)
        for i=1, #self.pixels do
            self.pixels[i]:SetTexture(nil);
        end
    end
    canvas.LoadImage = function(self, img)
        img = string.trim(img);
        self:Clear();
        local count = 0;
        for color in string.gmatch(img, "[0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z][0-9a-zA-Z]") do
            count = count + 1;
            if(count > #self.pixels) then
                dPrint("Received more then alotted pixels.");
                break;
            end
            self.pixels[count]:SetTexture(RGBHexToPercent(color));
        end
        dPrint(count.." points laoded.");
    end
    canvas:SetPoint("CENTER");
    return canvas;
end

