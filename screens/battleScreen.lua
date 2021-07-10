local BattleScreen = {}

function BattleScreen.new()
    local self = {}

    local UnitBuilder = require("units.unit")

    local leftUnit = nil
    local rightUnit = nil

    local buttons = {}

    local function issueOrders(order)
        print('Order: '..order)

        if order == 'Strong Attack' then
            leftUnit.performStrongAttack()
            rightUnit.performStrongAttack()
        elseif order == 'Light Attack' then
            leftUnit.performLightAttack()
            rightUnit.performLightAttack()
        elseif order == 'Block Attack' then
            leftUnit.performBlock()
            rightUnit.performBlock()
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
    end

    local function showUnits()
        leftUnit = UnitBuilder.new('Knight Sword', 1, 10)
        rightUnit = UnitBuilder.new('Orc Spear', nil, 10)

        leftUnit.walkToCenter()
        rightUnit.walkToCenter()
    end

    function self.setupScreen()
        showButtons()
        showUnits()
    end

    local function initialize()
    end

    initialize()

    return self
end

return BattleScreen
