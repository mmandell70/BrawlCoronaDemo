local Game = {}

function Game.new()
    local self = {}

    local MenuBuilder = require("menu.menu")

    self.menu = nil


    self.totalGameTime = 0

    -- *************************************************
    -- Layers
    -- *************************************************

    self.gameLayer = display.newGroup()

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

    function self.setup()
        self.menu.setup()
    end

    local function initialize()
        self.menu = MenuBuilder.new()
    end

    initialize()

    return self
end

return Game
