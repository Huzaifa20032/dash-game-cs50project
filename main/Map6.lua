Map6 = Class{}

require 'rEnemy'

function Map6:initialise()
    dynamic_x = 0
    dynamic_y = 0
    dynamic_dx = 0
    dynamic_dy = 0
    dynamic_ddx = 0.01
    dynamic_ddy = 0.01

    dy_variable = 0
    ddy_variable = 1

    dy2_variable = 0
    ddy2_variable = 1 * 0.5

    dy3_variable = 0
    ddy3_variable = 1 * 0.25

    eZone_height = 100
    eZone_width = 200
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2)
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2)
    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width
end

function Map6:render()
    -- drawing actual area
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    -- drawing starting area
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width + eZone_width + startZone_width, startBoundary_height, startZone_height, startZone_width)

    love.graphics.setColor(1, 0, 0, 1)

    -- render alternate adjacent rEnemy
    x = 0
    while x < 4 do
        -- at 100% speed
        rEnemy:render(7 + (eBoundary_width + 42 * x), (VIRTUAL_HEIGHT / 2 - 2) - dy_variable, 5, 5)
        -- at 50% speed
        rEnemy:render(7 * 2 + (eBoundary_width + 42 * x), (VIRTUAL_HEIGHT / 2 - 2) - dy2_variable, 5, 5)
        -- at 25% speed
        rEnemy:render(7 * 3 + (eBoundary_width + 42 * x), (VIRTUAL_HEIGHT / 2 - 2) - dy3_variable, 5, 5)

        rEnemy:render(7 * 4 + eBoundary_width + 42 * x, (VIRTUAL_HEIGHT / 2 - 2) + dy_variable, 5, 5)
        rEnemy:render(7 * 5 + eBoundary_width + 42 * x, (VIRTUAL_HEIGHT / 2 - 2) + dy2_variable, 5, 5)
        rEnemy:render(7 * 6 + eBoundary_width + 42 * x, (VIRTUAL_HEIGHT / 2 - 2) + dy3_variable, 5, 5)
        x = x + 1
    end

    love.graphics.setColor(1, 1, 1, 1)
end

function Map6:update(dt)
    eZone_height = 100

    -- update alternate adjacent rEnemy

    -- at 100% speed
    dy_variable = dy_variable + ddy_variable
    if (dy_variable >= eZone_height / 2 - 2) or (dy_variable <= -(eZone_height / 2) + 2) then
        ddy_variable = -ddy_variable
    end

    -- at 50% speed
    dy2_variable = dy2_variable + ddy2_variable
    if (dy2_variable >= eZone_height / 2 - 2) or (dy2_variable <= -(eZone_height / 2) + 2) then
        ddy2_variable = -ddy2_variable
    end

    -- at 25% speed
    dy3_variable = dy3_variable + ddy3_variable
    if (dy3_variable >= eZone_height / 2 - 2) or (dy3_variable <= -(eZone_height / 2) + 2) then
        ddy3_variable = -ddy3_variable
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then
        -- Preparing for next level
        Map7:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        level = level + 1
    end
end