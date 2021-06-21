-- returns the degrees between (0,0) and pt (note: 0 degrees is 'east')
function angleOfPoint( pt )
   local x, y = pt.x, pt.y
   local radian = math.atan2(y,x)
   local angle = radian*180/math.pi
   if angle < 0 then angle = 360 + angle end
   return angle
end

-- returns the degrees between two points (note: 0 degrees is 'east')
function angleBetweenPoints( a, b )
   local x, y = b.x - a.x, b.y - a.y
   local angle = angleOfPoint( { x=x, y=y } )
   if (angle > 360) then
        angle = angle - 360
   end
   return angle
end

-- returns the smallest angle between the two angles
-- ie: the difference between the two angles via the shortest distance
function smallestAngleDiff( target, source )
   local a = target - source
   
   if (a > 180) then
      a = a - 360
   elseif (a < -180) then
      a = a + 360
   end
   
   return a
end

function distanceBetweenPoints ( pt1, pt2 )
    local dx = pt1.x - pt2.x
    local dy = pt1.y - pt2.y
    return math.sqrt ( dx * dx + dy * dy )
end

function normalizeAngle(angle)
    angle = angle % 360
    if (angle < 0) then
        angle = angle + 360
    end

    return angle
end

function findClosestAngle(source, target, minimumAngleToTurn)
    local difference = math.abs(source - target)
    local rotateFromTo

    if (difference < 180 and target > source) then
        rotateFromTo = 1
    end
    if (difference < 180 and target < source) then
        rotateFromTo = -1
    end
    if (difference > 180 and target > source) then
        rotateFromTo = -1
    end
    if (difference > 180 and target < source) then
        rotateFromTo = 1
    end
    if (difference == 180 or difference == 0) then
        rotateFromTo = 1
    end
    --print('source '..source..' target '..target..' difference '..difference)
    if (difference < minimumAngleToTurn) then
        rotateFromTo = 0
    end

    return rotateFromTo
end

-- local speed = 5  
-- -- How fast is object moving
-- object.x = object.x + math.sin(rotation) * speed
-- object.y = object.y + math.cos(rotation) * speed

function calculateMidPoint( a, b )
   local x = (b.x + a.x) * 0.5
   local y = (b.y + a.y) * 0.5
   return {x=x, y=y}
end

-- Find the destination (x,y) given a starting point, angle and distance
function angle2Vector(startX, startY, angle, distance)
    local degToRadFactor = math.pi/180

    angle = angle*degToRadFactor

    return {
        x=startX + math.cos(angle) * distance, 
        y=startY + math.sin(angle) * distance,
    }
end
