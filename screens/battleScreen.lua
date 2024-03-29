local BattleScreen = {}

function BattleScreen.new()
    local self = {}

    local UnitBuilder = require("units.unit")

    local leftUnit = nil
    local rightUnit = nil

    local buttons = {}

    local floatingText = nil

    local score = 0

    local floatingTextY = nil

    function self.displayFloatingText(text)
        floatingText.text = text
        floatingText.x = (global.contentWidth * 0.5)
        floatingText.y = floatingTextY
        floatingText.alpha = 100
        floatingText:toFront()

        transition.to( floatingText, { time=3000, alpha=0} )
    end

    function self.displayScore(text)
        floatingText.text = text
        floatingText.x = (global.contentWidth * 0.5)
        floatingText.y = floatingTextY

        -- transition.to( floatingText, { time=3000, alpha=0} )
    end

    local function issueOrdersToAI()
        local aiAttack = math.random(3)
        --print('Random Attack: '..aiAttack)
        if aiAttack == 1 then
            rightUnit.performStrongAttack()

            self.displayFloatingText('AI choose Strong Attack!')
        elseif aiAttack == 2 then
            rightUnit.performLightAttack()

            self.displayFloatingText('AI choose Light Attack!')
        elseif aiAttack == 3 then
            rightUnit.performBlock()

            self.displayFloatingText('AI choose to Block')
        end
    end

    function self.animationComplete(unit)
        print('Unit Has Completed Action: '..unit.lastAttack)

        -- If the human unit is done, let the AI take a turn
        -- Also cause damage

        if unit.onLeft then
            issueOrdersToAI()

            if unit.lastAttack == 'Strong' then
                rightUnit.takeDamage(leftUnit.settings.strongAttackDamage)
            elseif unit.lastAttack == 'Light' then
                rightUnit.takeDamage(leftUnit.settings.lightAttackDamage)
            elseif unit.lastAttack == 'Block' then
            end
        else
            if unit.lastAttack == 'Strong' then
                leftUnit.takeDamage(rightUnit.settings.strongAttackDamage)
            elseif unit.lastAttack == 'Light' then
                leftUnit.takeDamage(rightUnit.settings.lightAttackDamage)
            elseif unit.lastAttack == 'Block' then
            end
        end
    end

    function self.addScore() 
        score = score + 1
        self.displayScore(score)
    end

    local function issueOrders(order)
        print('Order: '..order)

        if order == 'Strong Attack' then
            leftUnit.performStrongAttack()
        elseif order == 'Light Attack' then
            leftUnit.performLightAttack()
        elseif order == 'Block Attack' then
            leftUnit.performBlock()
        end
    end

    local function buttonTapped(event)
        print(event.target.name..' TAPPED!!!')
    end

    local function buttonTouched(event)
        -- print('OnTouch '..event.phase..' '..event.target.name)
        local t = event.target

        local phase = event.phase

        if "began" == phase then
            display.currentStage:setFocus(t)
            t.isFocus = true

            t.background:setFillColor(colorsRGB.actualColorRGB('darkgreen'))
        elseif t.isFocus then
            if phase == 'ended' then
                t.isFocus = false
                display.currentStage:setFocus(nil)

                t.background:setFillColor(colorsRGB.actualColorRGB('green'))

                issueOrders(t.name)
            end
        end
        -- Important to return true. This tells the system that the event
        -- should not be propagated to listeners of any objects underneath.
        return true
    end

    local function createButton(text)
        local button = display.newGroup()
        button.name = text

        local background = display.newRoundedRect(button, 0, 0, global.contentWidth * 0.75, 200, 30 )
        background.strokeWidth = 10
        background:setFillColor(colorsRGB.actualColorRGB('green'))

        button.background = background

        local options = 
        {
            parent = button,
            text = text,     
            x = background.x,
            y = background.y,
            font = 'dungeon.ttf',   
            fontSize = 150
        }            
        local displayText = display.newText(options)

        button.displayText = displayText

        -- button:addEventListener("tap", buttonTapped)
        button:addEventListener("touch", buttonTouched)

        return button
    end

    local function showButtons()
        local strongButton = createButton('Strong Attack')
        strongButton.y = strongButton.height * 1.2
        strongButton.x = global.contentWidth * 0.5
        -- Strong, Light, Block

        local lightButton = createButton('Light Attack')
        lightButton.y = strongButton.y + strongButton.height * 1.25
        lightButton.x = global.contentWidth * 0.5

        local blockButton = createButton('Block Attack')
        blockButton.y = lightButton.y + lightButton.height * 1.25
        blockButton.x = global.contentWidth * 0.5

        floatingTextY = blockButton.y + blockButton.height
        --floatingText.y = strongButton.y - strongButton.height
    end

    local function showUnits()
        -- leftUnit = UnitBuilder.new('Knight Sword', 1)
        leftUnit = UnitBuilder.new('Knight Spear', 1)
        -- rightUnit = UnitBuilder.new('Orc Spear', nil)
        rightUnit = UnitBuilder.new('Skeleton Spear', nil)
        -- rightUnit = UnitBuilder.new('Advanced Orc Spear', nil)

        leftUnit.walkToCenter()
        rightUnit.walkToCenter()

        self.displayScore(score)
    end

    local function createFloatingText()
        local options = 
        {
            parent = game.textLayer,
            text = 'TEST',     
            x = 0,
            y = 0,
            font = 'dungeon.ttf',   
            fontSize = 150
        }            
        floatingText = display.newText(options)

        floatingText:setFillColor( colorsRGB.RGB("black"))

        floatingText.alpha = 0
    end

    local function createBackgroundImage()
        local imageName = "images/background_grass.png"
        self.backgroundImage = display.newImageRect(game.gameLayer, imageName, global.contentWidth, global.contentHeight)
        self.backgroundImage.x = global.contentWidth * 0.5
        self.backgroundImage.y = global.contentHeight * 0.5
        self.backgroundImage:toBack()
    end

    function self.setupScreen()
        createFloatingText()
        showButtons()
        showUnits()
        createBackgroundImage()
    end

    local function initialize()
    end

    initialize()

    return self
end

return BattleScreen
