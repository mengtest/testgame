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
    function onRequestFinished(event)
        local ok = (event.name == "completed")
        local request = event.request

        if not ok then
            -- 请求失败，显示错误代码和错误消息
            print("Request failed, code:",request:getErrorCode(), request:getErrorMessage())
            return
        end

        local code = request:getResponseStatusCode()
        if code ~= 200 then
            -- 请求结束，但没有返回 200 响应代码
            print("Request is over, code:", code)
            return
        end

        -- 请求成功，显示服务端返回的内容
        local response = request:getResponseString()
        print(response)
    end

    local function onTouch(eventName, x, y)    
        if eventName == "began" then
            self.player:walkTo({x=x, y=y})
            local url = ''
            local request = network.createHTTPRequest(onRequestFinished, "118.192.77.18:8005","POST")
            request:addPOSTValue("pet1", "dabao")
            request:addPOSTValue("pet2", "xiaobao")
            request:start()
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
