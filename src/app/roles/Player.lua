local Player = class("Player", function()
    local sprite = display.newSprite("#player1-1-1.png")
    return sprite
end)

function Player:ctor()
    self:addAnimation()
end

function Player:addAnimation()
    local animationNames = {"walk", "attack", "dead"}
    local animationFrameNum = {4, 4, 4}
    
    for i = 1, #animationNames do
        local frames = display.newFrames("player1-" .. i .. "-%d.png", 1, animationFrameNum[i])
        local animation = display.newAnimation(frames, 0.2)
        display.setAnimationCache("player1-" .. animationNames[i], animation)
    end
end

function Player:walkTo(pos, callback)
    
    local function moveStop()
        transition.stopTarget(self)
        if callback then
            callback()
        end
    end
    
    local currentPos = cc.p(self:getPositionX(), self:getPositionY())
    local destPos = cc.p(pos.x, pos.y)
    local posDiff = cc.pGetDistance(currentPos, destPos)
    local seq = transition.sequence({cc.MoveTo:create(5 * posDiff / display.width, cc.p(pos.x, pos.y)), cc.CallFunc:create(moveStop)})
    transition.playAnimationForever(self, display.getAnimationCache("player1-walk"))
    self:runAction(seq)
    return true
end

function Player:attack()
    transition.playAnimationOnce(self,display.getAnimationCache("player1-attack"))
end

function Player:dead()
    transition.playAnimationOnce(self,display.getAnimationCache("player1-dead"))
end
return Player 