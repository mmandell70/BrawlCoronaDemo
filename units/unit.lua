local Unit = {}

function Unit.new(name, onLeft)
    local self = {}

    self.sprite = nil
    self.health = nil
    self.maxHealth = nil

    self.settings = nil

    self.spriteGroup = nil
    self.healthBar = nil
    self.damageBar = nil

    self.onLeft = onLeft

    self.lastAttack = nil
    local isAttacking = nil

    self.isDead = false

    function self.takeDamage(amount)
        if self.lastAttack == 'Block' then
            -- Sheild takes some of the damage (or all)
            amount = amount - self.settings.defendAmount

            if amount < 0 then
                amount = 0
            end
        end

        print('Damaged for '..amount)

        self.health = self.health - amount


        print('Max Health: '..self.maxHealth..' Health: '..self.health)

        if self.health <= 0 then
            self.health = 0
            self.isDead = true
            print('DIED!')
            self.sprite:setSequence('die')
            self.sprite:play()
            if self.onLeft then 
                game.battleScreen.displayFloatingText('You died')
            else 
                game.battleScreen.displayFloatingText('You defeated the enemy')
                game.battleScreen.addScore()
            end
        
        end

        local barWidth = self.health / self.maxHealth
        self.healthBar.width = self.damageBar.width * barWidth
    end

    local function stand()
        local action = 'stand'
        if self.onLeft then
            action = action..'Right'
        else
            action = action..'Left'
        end

        self.sprite:pause()
        self.sprite:setSequence(action)
        self.sprite:setFrame(1)
    end

    function self.performStrongAttack()
        isAttacking = 1

        local attackAction = self.settings.strongAttackType

        if self.onLeft then
            attackAction = attackAction..'Right'
        else
            attackAction = attackAction..'Left'
        end

        self.sprite:setSequence(attackAction)
        self.sprite:play()

        self.lastAttack = 'Strong'
    end

    function self.performLightAttack()
        isAttacking = 1

        local attackAction = self.settings.lightAttackType

        if self.onLeft then
            attackAction = attackAction..'Right'
        else
            attackAction = attackAction..'Left'
        end

        self.sprite:setSequence(attackAction)
        self.sprite:play()

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

    local function setupHealthBar()
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
    end

    local function initialize()
        self.settings = settings.unit.findByName(name)
        self.health = self.settings.health
        self.maxHealth = self.settings.health

        self.spriteGroup = display.newGroup()

        self.sprite = game.spriteSheetBuilder.generateSprite(self.spriteGroup, name)
        self.sprite:scale(8,8)

        self.spriteGroup.y = 2000
        self.spriteGroup.y = global.contentHeight - (self.spriteGroup.height * 0.75)

        if self.onLeft == nil then
            self.spriteGroup.x = global.contentWidth + self.sprite.width
        else
            self.spriteGroup.x = -self.sprite.width - self.sprite.width
        end

        setupHealthBar()

        self.sprite:addEventListener( "sprite", spriteListener )
    end

    initialize()

    return self
end

return Unit
