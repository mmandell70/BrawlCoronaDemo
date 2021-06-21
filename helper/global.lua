local Global = {}

function Global.new()
    local self = {}

    self.orientation = 'portrait'

    self.actualHeight = display.actualContentHeight
    self.actualWidth = display.actualContentWidth
    self.contentHeight = display.contentHeight
    self.contentWidth = display.contentWidth

    self.notchSize = 0

    print('Actual Dimensions: '..self.actualWidth..' x '..self.actualHeight)
    print('Content Dimensions: '..self.contentWidth..' x '..self.contentHeight)

    -- which environment are we running on?
    self.isDevice = (system.getInfo("environment") == "device")

    local function initialize()
        display.setStatusBar( display.HiddenStatusBar )
        math.randomseed( os.time() )

        self.notchSize = 0
        if display.safeActualContentHeight < display.actualContentHeight then
            self.notchSize = display.actualContentHeight - display.safeActualContentHeight
            self.notchSize = self.notchSize * 0.5
            print("NOTCH!")
        end
    end

    function self.longestSide()
        if (self.contentHeight > self.contentWidth) then
            return self.contentHeight
        else
            return self.contentWidth
        end
    end

    function self.shortestSide()
        if (self.contentHeight < self.contentWidth) then
            return self.contentHeight
        else
            return self.contentWidth
        end
    end

    function self.dimensionsByOrientation()
        local isLandscape = nil
        local width = 0
        local height = 0

        if (self.orientation == 'portrait' or self.orientation == 'portraitUpsideDown') then
            width = self.contentWidth
            height = self.contentHeight
        else
            width = self.contentHeight
            height = self.contentWidth
            isLandscape = 1
        end

        return {
            width = width,
            height = height,
            isLandscape = isLandscape
        }
    end

    initialize()
    return self
end

return Global