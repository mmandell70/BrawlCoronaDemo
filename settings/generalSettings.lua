local GeneralSettings = {}

function GeneralSettings.new()
    local self = {}

    local UnitSettings = require("settings.unitSettings")

    self.unit = nil

    local function initialize()
        self.unit = UnitSettings.new()
    end

    initialize()
    return self
end

return GeneralSettings