Map7 = Class{}

require 'rEnemy'

function Map7:initialise()
    ready = 0

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

    dynamic2_x = 0
    dynamic2_y = 0
    dynamic2_dx = 0
    dynamic2_dy = 0

    dynamic3_x = 0
    dynamic3_y = 0
    dynamic3_dx = 0
    dynamic3_dy = 0

    dynamic4_x = 0
    dynamic4_y = 0
    dynamic4_dx = 0
    dynamic4_dy = 0

    dynamic5_x = 0
    dynamic5_y = 0
    dynamic5_dx = 0
    dynamic5_dy = 0
end

function Map7:render()
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

    -- render 4 pink rEnemy
    love.graphics.setColor(1,92 / 255, 206 / 255 ,1)
    rEnemy:render(eBoundary_width + dynamic_x , eBoundary_height + eZone_height / 4 + dynamic_y , 5, 5)
    rEnemy:render(eBoundary_width + dynamic2_x , eBoundary_height + (3 * eZone_height) / 4 + dynamic2_y , 5, 5)
    rEnemy:render(eBoundary_width + eZone_width / 2 + dynamic3_x , eBoundary_height + dynamic3_y , 5, 5)
    rEnemy:render(eBoundary_width + eZone_width / 2 + dynamic4_x , eBoundary_height + eZone_height - 5 + dynamic4_y , 5, 5)

    -- render purple rEnemy
    love.graphics.setColor(1/2, 0, 1/2, 1)
    rEnemy:render(eBoundary_width + eZone_width - 5 + dynamic5_x , eBoundary_height + eZone_height / 2 + dynamic5_y , 5, 5)

    love.graphics.setColor(1, 1, 1, 1)
end

function Map7:update(dt)
    eZone_height = 150

    -- limit when to start updating pink and purple rEnemys
    if player.x > eBoundary_width + 5 then
        ready = 1
    end

    -- render rEnemy(s)
    if ready == 1 then
        -- pink rEnemy
        if eBoundary_width + dynamic_x > player.x then
            dynamic_dx = math.max(-2, dynamic_dx - dynamic_ddx)
            dynamic_x = dynamic_x + dynamic_dx
        elseif eBoundary_width + dynamic_x < player.x then
            dynamic_dx = math.min(2, dynamic_dx + dynamic_ddx)
            dynamic_x = dynamic_x + dynamic_dx
        end
        if eBoundary_height + eZone_height / 4 + dynamic_y > player.y then
            dynamic_dy = math.max(-2, dynamic_dy - dynamic_ddy)
            dynamic_y = dynamic_y + dynamic_dy
        elseif eBoundary_height + eZone_height / 4 + dynamic_y < player.y then
            dynamic_dy = math.min(2, dynamic_dy + dynamic_ddy)
            dynamic_y = dynamic_y + dynamic_dy
        end
        if dynamic_x < 0 or dynamic_x > eZone_width - 5 or dynamic_y < -(eZone_width / 4) or dynamic_y > eZone_width - (eZone_width / 4) - 5 then
            dynamic_dx = 0
            dynamic_dy = 0
        end

        if eBoundary_width + dynamic2_x > player.x then
            dynamic2_dx = math.max(-2, dynamic2_dx - dynamic_ddx)
            dynamic2_x = dynamic2_x + dynamic2_dx
        elseif eBoundary_width + dynamic2_x < player.x then
            dynamic2_dx = math.min(2, dynamic2_dx + dynamic_ddx)
            dynamic2_x = dynamic2_x + dynamic2_dx
        end
        if eBoundary_height + (3 * eZone_height) / 4 + dynamic2_y > player.y then
            dynamic2_dy = math.max(-2, dynamic2_dy - dynamic_ddy)
            dynamic2_y = dynamic2_y + dynamic2_dy
        elseif eBoundary_height + (3 * eZone_height) / 4 + dynamic2_y < player.y then
            dynamic2_dy = math.min(2, dynamic2_dy + dynamic_ddy)
            dynamic2_y = dynamic2_y + dynamic2_dy
        end
        if dynamic2_x < 0 or dynamic2_x > eZone_width - 5 or dynamic2_y < -(3 * eZone_height / 4) or dynamic2_y > eZone_width - (3 * eZone_height / 4) - 5 then
            dynamic2_dx = 0
            dynamic2_dy = 0
        end

        if eBoundary_width + eZone_width / 2 + dynamic3_x > player.x then
            dynamic3_dx = math.max(-2, dynamic3_dx - dynamic_ddx)
            dynamic3_x = dynamic3_x + dynamic3_dx
        elseif eBoundary_width + eZone_width / 2 + dynamic3_x < player.x then
            dynamic3_dx = math.min(2, dynamic3_dx + dynamic_ddx)
            dynamic3_x = dynamic3_x + dynamic3_dx
        end
        if eBoundary_height + dynamic3_y > player.y then
            dynamic3_dy = math.max(-2, dynamic3_dy - dynamic_ddy)
            dynamic3_y = dynamic3_y + dynamic3_dy
        elseif eBoundary_height + dynamic3_y < player.y then
            dynamic3_dy = math.min(2, dynamic3_dy + dynamic_ddy)
            dynamic3_y = dynamic3_y + dynamic3_dy
        end
        if dynamic3_x < -(eZone_width / 2) or dynamic3_x > eZone_width / 2 - 5 or dynamic3_y < 0 or dynamic3_y > eZone_height - 5 then
            dynamic3_dx = 0
            dynamic3_dy = 0
        end

        if eBoundary_width + eZone_width / 2 + dynamic4_x > player.x then
            dynamic4_dx = math.max(-2, dynamic4_dx - dynamic_ddx)
            dynamic4_x = dynamic4_x + dynamic4_dx
        elseif eBoundary_width + eZone_width / 2 + dynamic4_x < player.x then
            dynamic4_dx = math.min(2, dynamic4_dx + dynamic_ddx)
            dynamic4_x = dynamic4_x + dynamic4_dx
        end
        if eBoundary_height + eZone_height - 5 + dynamic4_y > player.y then
            dynamic4_dy = math.max(-2, dynamic4_dy - dynamic_ddy)
            dynamic4_y = dynamic4_y + dynamic4_dy
        elseif eBoundary_height + eZone_height - 5 + dynamic4_y < player.y then
            dynamic4_dy = math.min(2, dynamic4_dy + dynamic_ddy)
            dynamic4_y = dynamic4_y + dynamic4_dy
        end
        if dynamic4_x < -(eZone_width / 2) or dynamic4_x > eZone_width / 2 - 5 or dynamic4_y < -(eZone_height - 5) or dynamic4_y > 0 then
            dynamic4_dx = 0
            dynamic4_dy = 0
        end

        -- purple rEnemy
        if eBoundary_width + eZone_width - 5 + dynamic5_x > player.x then
            dynamic5_dx = math.max(-2, dynamic5_dx - dynamic_ddx)
            dynamic5_x = dynamic5_x + dynamic5_dx
        elseif eBoundary_width + eZone_width - 5 + dynamic5_x < player.x then
            dynamic5_dx = math.min(2, dynamic5_dx + dynamic_ddx)
            dynamic5_x = dynamic5_x + dynamic5_dx
        end
        if eBoundary_height + eZone_height / 2 + dynamic5_y > player.y then
            dynamic5_dy = math.max(-2, dynamic5_dy - dynamic_ddy)
            dynamic5_y = dynamic5_y + dynamic5_dy
        elseif eBoundary_height + eZone_height / 2 + dynamic5_y < player.y then
            dynamic5_dy = math.min(2, dynamic5_dy + dynamic_ddy)
            dynamic5_y = dynamic5_y + dynamic5_dy
        end
        if dynamic5_x > 0  then
            dynamic5_dx = -0.2
            dynamic5_dy = 0
        elseif dynamic5_x < -(eZone_width / 2 - 5) then
            dynamic5_dx = 0.2
            dynamic5_dy = 0
        elseif dynamic5_y < -(eZone_height / 2) then
            dynamic5_dx = 0
            dynamic5_dy = 0.2
        elseif dynamic5_y > eZone_height / 2 - 5 then
            dynamic5_dx = 0
            dynamic5_dy = -0.2
        end
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then
        -- Preparing for next level
        Map8:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        level = level + 1
    end
end