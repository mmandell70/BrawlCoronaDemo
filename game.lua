local Game = {}

function Game.new()
    local self = {}

    local MenuBase = require("menu.menu")
    local BattleScreenBase = require("screens.battleScreen")
    local SpriteSheetBase = require("helper.spritesheet")

    self.menu = nil
    self.battleScreen = nil
    self.spriteSheetBuilder = nil

    self.totalGameTime = 0

    -- *************************************************
    -- Layers
    -- *************************************************

    self.gameLayer = display.newGroup()
    self.unitLayer = display.newGroup()
    self.textLayer = display.newGroup()

    -- ************************************************************
    -- System Events
    -- ************************************************************

    function self.keyEvent(event)
        local message = "Game Key '" .. event.keyName .. "' was pressed " .. event.phase
        print( message )

        -- if (event.phase == 'down') then
        --     if (event.keyName == 'e' or event.keyName == '=') then
        --     end
        --     if (event.keyName == 'q' or event.keyName == '-') then
        --     end
        -- end
    end

    function self.orientationChange(event)
    end

    -- ************************************************************
    -- Game Time
    -- ************************************************************

    function self.think(dt)
        self.totalGameTime = self.totalGameTime + dt
    end

    -- ************************************************************
    -- Initialization
    -- ************************************************************

    local function setupLayers()
        self.gameLayer:insert(self.unitLayer)
        self.gameLayer:insert(self.textLayer)
    end

    local function walkDone(knight)
        knight:setSequence('attackSwordRight')
        knight:play()
    end

    function self.setup()
        -- self.menu.setup()
        game.battleScreen.setupScreen()
    end

    local function initialize()
        setupLayers()

        self.menu = MenuBase.new()
        self.spriteSheetBuilder = SpriteSheetBase.new()
        self.battleScreen = BattleScreenBase.new()
    end

    initialize()

    return self
end

return Game
