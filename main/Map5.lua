Map5 = Class{}

require 'rEnemy'

function Map5:initialise()
    dx_variable = 0
    dy_variable = 0
    ddx_variable = 1
    ddy_variable = 1


    dx2_variable = 0
    ddx2_variable = 1
    dy2_variable = 0
    ddy2_variable = 1

    dy_corner = 0
    ddy_corner = 2
    dx_corner = 0
    ddx_corner = 2

    eZone_height = 200
    eZone_width = 200
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2)
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2)
    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width
end

function Map5:render()
    -- drawing actual area
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    -- drawing starting area
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width + eZone_width + startZone_width, startBoundary_height, startZone_height, startZone_width)
    love.graphics.setColor(1, 1, 1, 1)

    -- drawing rEnemy(s) and checking for collisions

    -- render 4, rEnemy formation showing circular motion
    love.graphics.setColor(1, 155 / 255, 0, 1)
    x = 0
    while x < 200 do
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
        x = x + 100
    end

    x = 0
    y = 100
    while x < 200 do
        rEnemy:render(x + (eBoundary_width + dx_variable), y + (eBoundary_height + 50) + dy_variable, 5, 5)
        rEnemy:render(x + 25 + eBoundary_width + (dx_variable * 0.5), y +  (eBoundary_height + 50) + (dy_variable * 0.5), 5, 5)
        rEnemy:render(x + 37.5 + eBoundary_width + (dx_variable * 0.25), y + (eBoundary_height + 50) + (dy_variable * 0.25), 5, 5)
        rEnemy:render(x + 95 + (eBoundary_width - dx_variable), y + (eBoundary_height + 50) - dy_variable - 5, 5, 5)
        rEnemy:render(x + (95 - 25) + eBoundary_width - (dx_variable * 0.5), y + (eBoundary_height + 50) - (dy_variable * 0.5) - 5, 5, 5)
        rEnemy:render(x + (95 - 37.5) + eBoundary_width - (dx_variable * 0.25), y + (eBoundary_height + 50) - (dy_variable * 0.25) - 5, 5, 5)
        rEnemy:render(x + 45 + eBoundary_width - (dx2_variable), y +  -45 + (eBoundary_height + 50) + (dy2_variable) - 5, 5, 5)
        rEnemy:render(x + 45 + eBoundary_width - (dx2_variable * 0.5), y +  -45 + 25 + (eBoundary_height + 50) + (dy2_variable * 0.5) - 5, 5, 5)
        rEnemy:render(x + 45 + eBoundary_width - (dx2_variable * 0.25), y + -45 + 37.5 + (eBoundary_height + 50) + (dy2_variable * 0.25) - 5, 5, 5)
        rEnemy:render(x + 50 + eBoundary_width + (dx2_variable), y + 50 + (eBoundary_height + 50) - (dy2_variable) - 5, 5, 5)
        rEnemy:render(x + 50 + eBoundary_width + (dx2_variable * 0.5), y + (50 - 25) + (eBoundary_height + 50) - (dy2_variable * 0.5) - 5, 5, 5)
        rEnemy:render(x + 50 + eBoundary_width + (dx2_variable * 0.25), y + (50 - 37.5) + (eBoundary_height + 50) - (dy2_variable * 0.25) - 5, 5, 5)
        x = x + 100
    end

    -- render yellow rEnemy 
    love.graphics.setColor(1, 1, 0, 1)
    rEnemy:render(eBoundary_width + dx_corner , eBoundary_height + 20 + dy_corner, 5, 5)
    rEnemy:render(eBoundary_width + dx_corner , eBoundary_height + (eZone_height - 20 - 5) - dy_corner, 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
end

function Map5:update(dt)
    eZone_height = 200

    -- update yellow rEnemy
    dx_corner = dx_corner + ddx_corner
    if (dx_corner <= 0) or dx_corner >= eZone_width - 5 then
        ddx_corner = -ddx_corner
    end

    dy_corner = dy_corner + ddy_corner
    if (dy_corner <= - 20) or (dy_corner >= eZone_height - 20 - 5) then
        ddy_corner = -ddy_corner
    end

    -- update 4, rEnemy formation showing circular motion
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
        -- prepare for next level
        Map6:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        level = level + 1
    end
end