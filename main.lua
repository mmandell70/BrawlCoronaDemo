-----------------------------------------------------------------------------------------
--
-- main.lua
--
-- Thomas Mandell
-----------------------------------------------------------------------------------------

require "helper.colors-rgb"
require "helper.angle-functions"

local GameBuilder = require("game")
local SettingsBuilder = require("settings.generalSettings")
local GlobalBuilder = require("helper.global")

-- Do NOT make local so everyone can have access
game = nil
global = GlobalBuilder.new()
settings = nil

function setup()
    settings = SettingsBuilder.new()
    game = GameBuilder.new()
    game.setup()
end

local lastOrientation = nil
local function onOrientationChange( event )
    local currentOrientation = event.type
    print( "Current orientation: " .. currentOrientation )

    if (system.orientation == 'faceUp' or system.orientation == 'faceDown') then
        print('IGNORED')
        return
    end

    -- Ignore if same orientation
    if lastOrientation then
        if lastOrientation == currentOrientation then
            return
        end
    end
    lastOrientation = currentOrientation

    global.orientation = system.orientation

    game.orientationChange(event)
end

Runtime:addEventListener( "orientation", onOrientationChange )

setup()

-- ************************************************
-- Game Loop
-- ************************************************

local runtime = 0
local totalTime = 0
 
local function getDeltaTime()
    local temp = system.getTimer()  -- Get current game time in ms
    local dt = (temp-runtime) / (1000/60)  -- 60 fps or 30 fps as base
    runtime = temp  -- Store game time
    return dt
end

-- Frame update function
local function frameUpdate()
 
    -- Delta Time value
    local dt = getDeltaTime()

    totalTime = totalTime + dt

    -- print('Frame Update: '..dt..' Total: '..totalTime)

    game.think(dt)
end

-- Frame update listener
Runtime:addEventListener( "enterFrame", frameUpdate )

-- ************************************************
-- Keyboard
-- ************************************************

local function onKeyEvent( event )
 
    -- Print which key was pressed down/up
    local message = "Key '" .. event.keyName .. "' was pressed " .. event.phase
    print( message )
 
    -- game.keyEvent(event)

    -- IMPORTANT! Return false to indicate that this app is NOT overriding the received key
    -- This lets the operating system execute its default handling of the key
    return false
end

if (global.isDevice == false) then
    Runtime:addEventListener( "key", onKeyEvent )
end

-- ************************************************
-- Collisions
-- ************************************************

local function onGlobalCollision( event )
    print('-------> Collision! '..event.phase)

    if (event.phase == 'began') then
        -- if (event.object1.object.teamColor ~= event.object2.object.teamColor) then
            local pawn1 = event.object1.object
            local pawn2 = event.object2.object
            print('----------------------')
            print('Battle between '..pawn1.monsterType..' and '..pawn2.monsterType)
            -- print('Collision!')

        --     pawn1.fight(pawn2)
        --     pawn2.fight(pawn1)
        -- end
    end
end

-- Global collisions
-- Runtime:addEventListener( "collision", onGlobalCollision )