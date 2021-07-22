local BattleScreen = {}

function BattleScreen.new()
    local self = {}

    local UnitBuilder = require("units.unit")

    local leftUnit = nil
    local rightUnit = nil

    local buttons = {}

    local floatingText = nil

    local function displayFloatingText(text)
        floatingText.text = text
        floatingText.x = (global.contentWidth * 0.5)
        floatingText.y = 800
        floatingText.alpha = 100

        transition.to( floatingText, { time=3000, alpha=0} )
    end

    local function issueOrdersToAI()
        local aiAttack = math.random(3)
        --print('Random Attack: '..aiAttack)
        if aiAttack == 1 then
            rightUnit.performStrongAttack()

            displayFloatingText('AI choose Strong Attack!')
        elseif aiAttack == 2 then
            rightUnit.performLightAttack()

            displayFloatingText('AI choose Light Attack!')
        elseif aiAttack == 3 then
            rightUnit.performBlock()

            displayFloatingText('AI choose to Block')
        end
    end

    function self.animationComplete(unit)
        print('Unit Has Completed Action: '..unit.lastAttack)

        -- If the human unit is done, let the AI take a turn
        -- Also cause damage
        if unit.onLeft then
            issueOrdersToAI()

            if unit.lastAttack == 'Strong' then
                rightUnit.takeDamage(10)
            elseif unit.lastAttack == 'Light' then
                rightUnit.takeDamage(5)
            elseif unit.lastAttack == 'Block' then
            end
        else
            if unit.lastAttack == 'Strong' then
                leftUnit.takeDamage(10)
            elseif unit.lastAttack == 'Light' then
                leftUnit.takeDamage(5)
            elseif unit.lastAttack == 'Block' then
            end
        end
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
        strongButton.y = 1000
        strongButton.x = global.contentWidth * 0.5
        -- Strong, Light, Block

        local lightButton = createButton('Light Attack')
        lightButton.y = strongButton.y + strongButton.height * 1.25
        lightButton.x = global.contentWidth * 0.5

        local blockButton = createButton('Block Attack')
        blockButton.y = lightButton.y + lightButton.height * 1.25
        blockButton.x = global.contentWidth * 0.5

        --floatingText.y = strongButton.y - strongButton.height
    end

    local function showUnits()
        leftUnit = UnitBuilder.new('Knight Sword', 1, 100)
        rightUnit = UnitBuilder.new('Orc Spear', nil, 100)

        leftUnit.walkToCenter()
        rightUnit.walkToCenter()
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

        floatingText.alpha = 0
    end

    function self.setupScreen()
        createFloatingText()
        showButtons()
        showUnits()
    end

    local function initialize()
    end

    initialize()

    return self
end

return BattleScreen
