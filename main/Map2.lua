Map2 = Class{}

require 'rEnemy'

function Map2:initialise()
    dx_variable = 0
    ddx_variable = 1
    dy_variable = 0
    ddy_variable = 1
    dx2_variable = 0
    ddx2_variable = 1
    dy2_variable = 0
    ddy2_variable = 1
end

function Map2:render()
    -- drawing actual area
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    -- drawing starting area
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width + eZone_width + startZone_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing rEnemy(s) and checking for collisions
    love.graphics.setColor(1, 155 / 255, 0, 1)

    -- render rEnemy(s) with circular motion
    x = 0
    rEnemy:render(x + (eBoundary_width + dx_variable), (eBoundary_height + 50) + dy_variable, 5, 5)
    rEnemy:render(x + 25 + eBoundary_width + (dx_variable * 0.5), (eBoundary_height + 50) + (dy_variable * 0.5), 5, 5)
    rEnemy:render(x + 37.5 + eBoundary_width + (dx_variable * 0.25), (eBoundary_height + 50) + (dy_variable * 0.25), 5, 5)
    rEnemy:render(x + 95 + (eBoundary_width - dx_variable), (eBoundary_height + 50) - dy_variable - 5, 5, 5)
    rEnemy:render(x + (95 - 25) + eBoundary_width - (dx_variable * 0.5), (eBoundary_height + 50) - (dy_variable * 0.5) - 5, 5, 5)
    rEnemy:render(x + (95 - 37.5) + eBoundary_width - (dx_variable * 0.25), (eBoundary_height + 50) - (dy_variable * 0.25) - 5, 5, 5)
    rEnemy:render(x + 45 + eBoundary_width - (dx2_variable), -45 + (eBoundary_height + 50) + (dy2_variable) - 5, 5, 5)
    rEnemy:render(x + 45 + eBoundary_width - (dx2_variable * 0.5), -45 + 25 + (eBoundary_height + 50) + (dy2_variable * 0.5) - 5, 5, 5)
    rEnemy:render(x + 45 + eBoundary_width - (dx2_variable * 0.25), -45 + 37.5 + (eBoundary_height + 50) + (dy2_variable * 0.25) - 5, 5, 5)
    rEnemy:render(x + 50 + eBoundary_width + (dx2_variable), 50 + (eBoundary_height + 50) - (dy2_variable) - 5, 5, 5)
    rEnemy:render(x + 50 + eBoundary_width + (dx2_variable * 0.5), (50 - 25) + (eBoundary_height + 50) - (dy2_variable * 0.5) - 5, 5, 5)
    rEnemy:render(x + 50 + eBoundary_width + (dx2_variable * 0.25), (50 - 37.5) + (eBoundary_height + 50) - (dy2_variable * 0.25) - 5, 5, 5)

    love.graphics.setColor(1, 1, 1, 1)
end

function Map2:update(dt)
    eZone_height = 100

    -- update variables for rEnemy(s) circular motion
    dx_variable = dx_variable + ddx_variable
    dx2_variable = dx2_variable + ddx2_variable
    if dx_variable == 0 or dx_variable >= 100 - 5 then
        ddx_variable = -ddx_variable
        ddy2_variable = -ddy2_variable
    end

    dy_variable = dy_variable + ddy_variable
    dy2_variable = dy2_variable + ddy2_variable
    if (dy_variable >= 100 / 2 - 5) or (dy_variable <= -(100 / 2)) then
        ddy_variable = -ddy_variable
        ddx2_variable = -ddx2_variable
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then
        -- Preparing for next level
        Map3:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        level = level + 1
    end
end