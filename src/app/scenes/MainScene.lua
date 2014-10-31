local Player = import("..roles.Player")
local Enemy1 = import("..roles.Enemy1")

local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
--    cc.ui.UILabel.new({
--            UILabelType = 2, text = "Hello, World", size = 64})
--        :align(display.CENTER, display.cx, display.cy)
--        :addTo(self)

    -- background
    local background = display.newSprite("image/background.png", display.cx, display.cy)
    self:addChild(background)
    -- player
    self.player = Player.new()
    self.player:setPosition(display.left + self.player:getContentSize().width/2, display.cy)
    self:addChild(self.player)
    -- enemy1
    self.enemy1 = Enemy1.new()
    self.enemy1:setPosition(display.right - self.player:getContentSize().width/2, display.cy)
    self:addChild(self.enemy1)
    -- touchEvent
    self:addTouchLayer()
end

function MainScene:onEnter()
end

function MainScene:onExit()
end

function MainScene:addTouchLayer()
    local function onTouch(eventName, x, y)
        if eventName == "began" then
            self.player:walkTo({x=x, y=y})
        end
    end
    
    self.layerTouch = display.newLayer()
    self.layerTouch:addNodeEventListener(cc.NODE_TOUCH_EVENT, function(event)
        return onTouch(event.name,event.x,event.y)
    end)
    self.layerTouch:setTouchEnabled(true)
    self.layerTouch:setPosition(cc.p(0,0))
    self.layerTouch:setContentSize(cc.size(display.width, display.height))
    self:addChild(self.layerTouch)
end


return MainScene
