local Unit = {}

function Unit.new(name, onLeft, startingHealth)
    local self = {}

    self.sprite = nil
    self.health = startingHealth

    self.spriteGroup = nil
    self.healthBar = nil

    local isAttacking = nil

    local function stand()
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

    function self.performStrongAttack()
        isAttacking = 1

        if onLeft then
            self.sprite:setSequence('attackSwordRight')
            self.sprite:play()
        else
            self.sprite:setSequence('thrustLeft')
            self.sprite:play()
        end
    end

    function self.performLightAttack()
        isAttacking = 1

        if onLeft then
            self.sprite:setSequence('attackRight')
            self.sprite:play()
        else
            self.sprite:setSequence('attackLeft')
            self.sprite:play()
        end
    end

    function self.performBlock()
        isAttacking = 1
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

        -- transition.to( self.sprite, { time=1000, x=endX, onComplete=stand} )
        transition.to( self.spriteGroup, { time=1000, x=endX, onComplete=stand} )
    end

    local function spriteListener( event )
        if isAttacking then
            if event.phase == 'ended' then
                print('Animation Complete!')

                isAttacking = nil

                stand()
            end
        end
    end

    local function initialize()
        self.spriteGroup = display.newGroup()

        self.sprite = game.spriteSheetBuilder.generateSprite(self.spriteGroup, name)
        self.sprite:scale(8,8)

        self.spriteGroup.y = 400

        if onLeft == nil then
            self.spriteGroup.x = global.contentWidth + self.sprite.width
        else
            self.spriteGroup.x = -self.sprite.width - self.sprite.width
        end

        self.healthBar = display.newRect(self.spriteGroup, 0, 0, 200, 30)
        self.healthBar.y = -self.healthBar.height * 6
        self.healthBar.strokeWidth = 0
        self.healthBar:setFillColor( colorsRGB.RGB("green") )

        self.sprite:addEventListener( "sprite", spriteListener )
    end

    initialize()

    return self
end

return Unit
