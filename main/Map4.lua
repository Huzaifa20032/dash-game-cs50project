Map4 = Class{}

require 'rEnemy'

dynamic_x = 0
dynamic_y = 0
dynamic_dx = 0
dynamic_dy = 0
dynamic_ddx = 0.01
dynamic_ddy = 0.01

ready = 0

function Map4:initialise()
    ready = 0

    dy_variable = 0
    ddy_variable = 1

    eZone_height = 150
    eZone_width = 150
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2)
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2)

    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width

    dynamic_x = 0
    dynamic_y = 0
    dynamic_dx = 0
    dynamic_dy = 0
    dynamic_ddx = 0.005
    dynamic_ddy = 0.005
end

function Map4:render()
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

    -- render pipes
    gap = 30
    x = 0
    love.graphics.setColor(1,0,0,1)
    while x < 5 * 30 do
        rEnemy:render(x + eBoundary_width , eBoundary_height, 5, dy_variable)
        rEnemy:render(x + eBoundary_width , eBoundary_height + dy_variable + gap, 5, eZone_height - dy_variable - gap)
        x = x + 35
    end

    -- render pink rEnemy
    love.graphics.setColor(1,92 / 255, 206 / 255 ,1)
    if ready == 1 then
        rEnemy:render(eBoundary_width + dynamic_x , eBoundary_height + eZone_height / 2 + dynamic_y , 5, 5)
    end
    love.graphics.setColor(1, 1, 1, 1)
end

function Map4:update(dt)
    eZone_height = 150

    -- update pipes
    dy_variable = dy_variable + ddy_variable
    if (dy_variable <= 0) or (dy_variable >= eZone_height - 30) then
        ddy_variable = -ddy_variable
    end

    -- limit when to start updating pink rEnemy
    if player.x > eBoundary_width + 35 then
        ready = 1
    end

    -- update dynamic variable for pink rEnemy
    if ready == 1 then
        if eBoundary_width + dynamic_x > player.x then
            dynamic_dx = math.max(-0.5, dynamic_dx - dynamic_ddx)
            dynamic_x = dynamic_x + dynamic_dx
        elseif eBoundary_width + dynamic_x < player.x then
            dynamic_dx = math.min(0.5, dynamic_dx + dynamic_ddx)
            dynamic_x = dynamic_x + dynamic_dx
        end
        if dynamic_x < 0 or dynamic_x > eZone_width - 5 then
            dynamic_dx = 0
            dyanmic_dy = 0
        end

        if eBoundary_height + eZone_height / 2 + dynamic_y > player.y then
            dynamic_dy = math.max(-0.5, dynamic_dy - dynamic_ddy)
            dynamic_y = dynamic_y + dynamic_dy
        elseif eBoundary_height + eZone_height / 2 + dynamic_y < player.y then
            dynamic_dy = math.min(0.5, dynamic_dy + dynamic_ddy)
            dynamic_y = dynamic_y + dynamic_dy
        end
        if dynamic_y < -(eZone_height / 2) or dynamic_y > eZone_height / 2 - 5 then
            dynamic_dx = 0
            dynamic_dy = 0
        end
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then
        -- Preparing for next level
        Map5:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        ready = 0

        level = level + 1
    end
end