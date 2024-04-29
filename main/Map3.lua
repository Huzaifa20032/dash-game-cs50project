Map3 = Class{}

require 'rEnemy'

function Map3:initialise()
    dy_variable = 0
    ddy_variable = 1
end

function Map3:render()
    -- drawing actual area
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    -- drawing starting area
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width + eZone_width + startZone_width, startBoundary_height, startZone_height, startZone_width)

    love.graphics.setColor(1, 0, 0, 1)

    -- render alternative adjacent rEnemy(s)
    x = 0
    while x < 7 do
        rEnemy:render(7 + (eBoundary_width + 14 * x), (VIRTUAL_HEIGHT / 2 - 2) - dy_variable, 5, 5)
        rEnemy:render(eBoundary_width + 14 * x, (VIRTUAL_HEIGHT / 2 - 2) + dy_variable, 5, 5)
        x = x + 1
    end

    love.graphics.setColor(1, 1, 1, 1)
end

function Map3:update(dt)
    eZone_height = 100

    -- update alternate adjacent rEnemy(s)
    dy_variable = dy_variable + ddy_variable
    if (dy_variable >= eZone_height / 2 - 2) or (dy_variable <= -(eZone_height / 2) + 2) then
        ddy_variable = -ddy_variable
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then

        -- Preparing for next level
        Map4:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        level = level + 1
    end
end