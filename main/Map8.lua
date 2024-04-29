Map8 = Class{}

require 'rEnemy'

function Map8:initialise()
    dx_variable = 0
    ddx_variable = 1

    dy_corner = 0
    ddy_corner = 2
    dx_corner = 0
    ddx_corner = 1.05

    eZone_height = 160
    eZone_width = 80
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2)
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2)

    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width
end

function Map8:render()
    -- drawing actual area
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    -- drawing starting area
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width + eZone_width + startZone_width, startBoundary_height, startZone_height, startZone_width)

    love.graphics.setColor(1, 0, 0, 1)

    -- render horizontally moving alternate adjacent rEnemys
    x = 0
    while x < 10 do
        rEnemy:render(eBoundary_width + eZone_width / 2 - 2.5 + dx_variable, 2 + eBoundary_height + 14 * x, 5, 5)
        rEnemy:render(eBoundary_width + eZone_width / 2 - 2.5 - dx_variable, 2 + 7 + eBoundary_height + 14 * x, 5, 5)
        x = x + 1
    end
    rEnemy:render(eBoundary_width + eZone_width / 2 - 2 + dx_variable, 2 + eBoundary_height + 14 * 10, 5, 5)

    love.graphics.setColor(1, 1, 0, 1)

    -- render yellow rEnemy
    rEnemy:render(eBoundary_width + dx_corner, -2.5 + eBoundary_height + eZone_height / 2 + dy_corner, 5, 5)

    love.graphics.setColor(1, 1, 1, 1)
end

function Map8:update(dt)
    eZone_height = 150

    -- update horizontally moving alternate adjacent rEnemys
    dx_variable = dx_variable + ddx_variable
    if (dx_variable >= eZone_width / 2 - 2.5) or (dx_variable <= -(eZone_width / 2) + 2.5) then
        ddx_variable = -ddx_variable
    end

    -- update yellow rEnemys
    dx_corner = dx_corner + ddx_corner
    if dx_corner >= eZone_width - 5 then
        ddx_corner = -ddx_corner
    elseif dx_corner <= 0 then
        dy_corner = 0
        dx_corner = 0
        ddx_corner = -ddx_corner
    end
    dy_corner = dy_corner + ddy_corner
    if (dy_corner >= eZone_height / 2 - 3) or (dy_corner <= -(eZone_height / 2 - 3)) then
        ddy_corner = -ddy_corner
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then
        -- Preparing for next level
        Map9:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        level = level + 1
    end
end