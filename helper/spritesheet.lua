local SpriteSheet = {}

function SpriteSheet.new()
    local self = {}

    self.sheetOptions = {
        ["Standard"] = {
            width = 64,
            height = 64,
            numFrames = 273
        },
        ["Large Weapon"] = {
            width = 192,
            height = 192,
            numFrames = 32
        },
        ["Blood Explosion"] = {
            width = 512,
            height = 512,
            numFrames = 6
        },
    }

    self.spriteList = {
        ["Blood Explosion"] = {
            sheet = graphics.newImageSheet( "images/tilesheets/blood_explosion.png", self.sheetOptions["Blood Explosion"] ),
            sequenceName = 'BloodExplode',
        },
        ["Knight Sword"] = {
            sheet = graphics.newImageSheet( "images/tilesheets/Knight_Sword.png", self.sheetOptions["Standard"] ),
            sequenceName = 'Standard',
        },
        ["Knight Sword Only"] = {
            sheet = graphics.newImageSheet( "images/tilesheets/Knight_Sword_BigSwing.png", self.sheetOptions["Large Weapon"] ),
            sequenceName = 'None',
        },
        ["Orc Spear"] = {
            sheet = graphics.newImageSheet( "images/tilesheets/Orc_Spear.png", self.sheetOptions["Standard"] ),
            sequenceName = 'Standard',
        },
    }

    self.sequences = {
        ["Standard"] = {
            {
                name = "walkRight",
                -- start = 144,
                start = 145,
                -- count = 9,
                count = 8,
                time = 800,
                loopCount = 0,
                loopDirection = "forward"
            },
            {
                name = "standRight",
                start = 144,
                count = 1,
                time = 800,
                loopCount = 0,
                loopDirection = "forward"
            },
            {
                name = "walkDown",
                start = 131,
                count = 9,
                time = 800,
                loopCount = 0,
                loopDirection = "forward"
            },
            {
                name = "standLeft",
                start = 118,
                count = 1,
                time = 800,
                loopCount = 0,
                loopDirection = "forward"
            },
            {
                name = "walkLeft",
                start = 118,
                count = 9,
                time = 800,
                loopCount = 0,
                loopDirection = "forward"
            },
            {
                name = "walkUp",
                start = 105,
                count = 9,
                time = 800,
                loopCount = 0,
                loopDirection = "forward"
            },
            {
                name = "attackRight",
                start = 196,
                count = 6,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "attackDown",
                start = 183,
                count = 6,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "attackLeft",
                start = 170,
                count = 6,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "attackUp",
                start = 157,
                count = 6,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "thrustRight",
                start = 91,
                count = 8,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "thrustDown",
                start = 78,
                count = 8,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "thrustLeft",
                start = 65,
                count = 8,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "thrustUp",
                start = 52,
                count = 8,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                name = "die",
                start = 261,
                count = 6,
                time = 800,
                loopCount = 1,
                loopDirection = "forward"
            },
            {
                sheet = self.spriteList["Blood Explosion"].sheet,
                name = "bloodExplode",
                start = 1,
                count = 6,
                time = 800,
                loopCount = 1,
                loopDirection = "forward"
            },
            {
                sheet = self.spriteList["Knight Sword Only"].sheet,
                name = "attackSwordRight",
                start = 25,
                count = 6,
                time = 800,
                loopCount = 1,
                loopDirection = "loop"
            },
            -- {
            --     sheet = self.spriteList["Knight Sword Only"].sheet,
            --     name = "attackSwordDown",
            --     start = 17,
            --     count = 6,
            --     time = 800,
            --     loopCount = 0,
            --     loopDirection = "loop"
            -- },
            -- {
            --     sheet = self.spriteList["Knight Sword Only"].sheet,
            --     name = "attackSwordLeft",
            --     start = 9,
            --     count = 6,
            --     time = 800,
            --     loopCount = 0,
            --     loopDirection = "loop"
            -- },
            -- {
            --     sheet = self.spriteList["Knight Sword Only"].sheet,
            --     name = "attackSwordUp",
            --     start = 1,
            --     count = 6,
            --     time = 800,
            --     loopCount = 0,
            --     loopDirection = "loop"
            -- },
            -- {
            --     sheet = self.spriteList["Knight Spear Only"].sheet,
            --     name = "attackSpearRight",
            --     start = 25,
            --     count = 8,
            --     time = 800,
            --     loopCount = 0,
            --     loopDirection = "loop"
            -- },
            -- {
            --     sheet = self.spriteList["Knight Spear Only"].sheet,
            --     name = "attackSpearDown",
            --     start = 17,
            --     count = 8,
            --     time = 800,
            --     loopCount = 0,
            --     loopDirection = "loop"
            -- },
            -- {
            --     sheet = self.spriteList["Knight Spear Only"].sheet,
            --     name = "attackSpearLeft",
            --     start = 9,
            --     count = 8,
            --     time = 800,
            --     loopCount = 0,
            --     loopDirection = "loop"
            -- },
            -- {
            --     sheet = self.spriteList["Knight Spear Only"].sheet,
            --     name = "attackSpearUp",
            --     start = 1,
            --     count = 8,
            --     time = 800,
            --     loopCount = 0,
            --     loopDirection = "loop"
            -- },
            {
                -- sheet = sheetSkeletonArcher,
                name = "attackBowRight",
                -- start = 248,
                start = 252,
                count = 9,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                -- sheet = sheetSkeletonArcher,
                name = "attackBowDown",
                -- start = 235,
                start = 239,
                count = 9,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                -- sheet = sheetSkeletonArcher,
                name = "attackBowLeft",
                start = 226,
                -- start = 222,
                count = 9,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },
            {
                -- sheet = sheetSkeletonArcher,
                name = "attackBowUp",
                -- start = 209,
                start = 213,
                count = 9,
                time = 800,
                loopCount = 0,
                loopDirection = "loop"
            },            
        },
    }

    function self.generateSprite(layer, name)
        local sprite = nil

        if self.spriteList[name] then
            local spriteInfo = self.spriteList[name]

            sprite = display.newSprite( layer, spriteInfo.sheet, self.sequences[spriteInfo.sequenceName] )
        else
            print('BAD SPRITE: '..name)
        end

        return sprite
    end

    return self
end

return SpriteSheet