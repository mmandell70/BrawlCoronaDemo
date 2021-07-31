local UnitSettings = {}

function UnitSettings.new()
    local self = {}

    self.unitList = {
        {
            name = 'Knight Sword',
            health = 20,
            strongAttackType = 'attackSword',
            strongAttackDamage = 10,
            lightAttackType = 'attack',
            lightAttackDamage = 5,
            defendAmount = 5,
        },
        {
            name = 'Orc Spear',
            health = 100,
            strongAttackType = 'thrust',
            strongAttackDamage = 10,
            lightAttackType = 'attack',
            lightAttackDamage = 5,
            defendAmount = 5,
        },
        {
            name = 'Knight Spear',
            health = 100,
            strongAttackType = 'thrust',
            strongAttackDamage = 10,
            lightAttackType = 'attack',
            lightAttackDamage = 5,
            defendAmount = 5,
        },
        {
            name = 'Advanced Orc Spear',
            health = 100,
            strongAttackType = 'thrust',
            strongAttackDamage = 10,
            lightAttackType = 'attack',
            lightAttackDamage = 5,
            defendAmount = 5,
        },
        {
            name = 'Skeleton Spear',
            health = 100,
            strongAttackType = 'thrust',
            strongAttackDamage = 10,
            lightAttackType = 'attack',
            lightAttackDamage = 5,
            defendAmount = 5,
        },
    }

    function self.findByName(name)
        for x=1,#self.unitList do
            local item = self.unitList[x]
            if (item.name == name or item.shortName == name) then
                return item
            end
        end
        return nil
    end

    local function initialize()
    end

    initialize()
    return self
end

return UnitSettings