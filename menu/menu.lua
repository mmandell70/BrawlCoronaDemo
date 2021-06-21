local Menu = {}

function Menu.new()
    local self = {}

    local backgroundImageFileName = 'images/background.png'
    self.backgroundImage = nil

    self.menuLayer = display.newGroup()

    local function startMenuTapped(event)
        print('Start Menu Tapped')

        transition.to(self.menuLayer, { time=500, alpha=0} )
        -- self.menuLayer.alpha = 0
    end
    
    -- ************************************************************
    -- Initialization
    -- ************************************************************

    local function setupBackgroundImage()
        self.backgroundImage = display.newImageRect(self.menuLayer, backgroundImageFileName, global.contentWidth, global.contentHeight)
        self.backgroundImage.x = global.contentWidth * 0.5
        self.backgroundImage.y = global.contentHeight * 0.5
    end

    local function setupMenuText()
        -- Main Title
        local mainTitle = display.newText(self.menuLayer, '- BRAWL -', 0, 0, 'dungeon.ttf', 200)
        mainTitle:setFillColor(0, 0, 0)
        mainTitle.x = global.contentWidth * 0.5
        mainTitle.y = global.contentHeight * 0.3

        -- Start
        local startMenu = display.newText(self.menuLayer, 'Start', 0, 0, 'dungeon.ttf', 150)
        startMenu:setFillColor(0, 1, 0)
        startMenu.x = global.contentWidth * 0.5
        startMenu.y = mainTitle.y + startMenu.height * 2

        startMenu:addEventListener("tap", startMenuTapped)
    end

    function self.setup()
        game.gameLayer:insert(self.menuLayer)

        setupBackgroundImage()
        setupMenuText()
    end

    local function initialize()
    end

    initialize()

    return self
end

return Menu
