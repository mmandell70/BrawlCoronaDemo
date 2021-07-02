local Unit = {}

function Unit.new(name, onLeft)
    local self = {}

    self.sprite = nil

    local function walkCenterComplete()
        if onLeft then
            self.sprite:pause()
            self.sprite:setSequence('standRight')
            self.sprite:setFrame(1)
        else
            self.sprite:pause()
            self.sprite:setSequence('standLeft')
            self.sprite:setFrame(1)
        end
    end

    function self.walkToCenter()
        local endX = nil

        if onLeft then
            endX = self.sprite.width * 2
            self.sprite:setSequence('walkRight')
        else
            endX = global.contentWidth - self.sprite.width * 2
            self.sprite:setSequence('walkLeft')
        end
        self.sprite:play()

        transition.to( self.sprite, { time=1000, x=endX, onComplete=walkCenterComplete} )
    end

    local function initialize()
        self.sprite = game.spriteSheetBuilder.generateSprite(game.unitLayer, name)
        self.sprite:scale(8,8)

        self.sprite.y = 400

        if onLeft == nil then
            self.sprite.x = global.contentWidth + self.sprite.width
        else
            self.sprite.x = -self.sprite.width - self.sprite.width
        end
    end

    initialize()

    return self
end

return Unit
