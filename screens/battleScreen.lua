local BattleScreen = {}

function BattleScreen.new()
    local self = {}

    local UnitBuilder = require("units.unit")

    local leftUnit = nil
    local rightUnit = nil

    local buttons = {}

    local function buttonTapped(event)
        print(event.target.name..' TAPPED!')
    end

    local function createButton(text)
        local button = display.newGroup()
        button.name = text

        local background = display.newRoundedRect(button, 0, 0, global.contentWidth * 0.75, 200, 30 )
        background.strokeWidth = 10
        background:setFillColor(colorsRGB.actualColorRGB('green'))

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

        button:addEventListener("tap", buttonTapped)

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
        leftUnit = UnitBuilder.new('Knight Sword', 1)
        rightUnit = UnitBuilder.new('Orc Spear', nil)

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
