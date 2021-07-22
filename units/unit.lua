local Unit = {}

function Unit.new(name, onLeft, startingHealth)
    local self = {}

    self.sprite = nil
    self.health = startingHealth
    self.maxHealth = startingHealth

    self.spriteGroup = nil
    self.healthBar = nil
    self.damageBar = nil

    self.onLeft = onLeft

    self.lastAttack = nil
    local isAttacking = nil

    function self.takeDamage(amount)
        print('Damaged for '..amount)

        self.health = self.health - amount
        -- print('Max Health: '..self.maxHealth..' Health: '..self.health)

        if amount <= 0 then
            print('DIED!')
        end

        local barWidth = self.health / self.maxHealth
        self.healthBar.width = self.damageBar.width * barWidth
    end

    local function stand()
        if self.onLeft then
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

        if self.onLeft then
            self.sprite:setSequence('attackSwordRight')
            self.sprite:play()
        else
            self.sprite:setSequence('thrustLeft')
            self.sprite:play()
        end

        self.lastAttack = 'Strong'
    end

    function self.performLightAttack()
        isAttacking = 1

        if self.onLeft then
            self.sprite:setSequence('attackRight')
            self.sprite:play()
        else
            self.sprite:setSequence('attackLeft')
            self.sprite:play()
        end

        self.lastAttack = 'Light'
    end

    function self.performBlock()
        isAttacking = 1
        self.lastAttack = 'Block'

        game.battleScreen.animationComplete(self)
    end

   function self.walkToCenter()
        local endX = nil

        if self.onLeft then
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

                game.battleScreen.animationComplete(self)
            end
        end
    end

    local function initialize()
        self.spriteGroup = display.newGroup()

        self.sprite = game.spriteSheetBuilder.generateSprite(self.spriteGroup, name)
        self.sprite:scale(8,8)

        self.spriteGroup.y = 400

        if self.onLeft == nil then
            self.spriteGroup.x = global.contentWidth + self.sprite.width
        else
            self.spriteGroup.x = -self.sprite.width - self.sprite.width
        end

        self.damageBar = display.newRect(self.spriteGroup, 0, 0, 200, 30)
        self.damageBar.anchorX = 0
        self.damageBar.y = -self.damageBar.height * 6
        self.damageBar.x = -self.damageBar.width * 0.5
        self.damageBar.strokeWidth = 0
        self.damageBar:setFillColor( colorsRGB.RGB("red") )

        self.healthBar = display.newRect(self.spriteGroup, 0, 0, 200, 30)
        self.healthBar.anchorX = 0
        self.healthBar.y = self.damageBar.y
        self.healthBar.x = -self.healthBar.width * 0.5
        self.healthBar.strokeWidth = 0
        self.healthBar:setFillColor( colorsRGB.RGB("green") )

        self.sprite:addEventListener( "sprite", spriteListener )
    end

    initialize()

    return self
end

return Unit
