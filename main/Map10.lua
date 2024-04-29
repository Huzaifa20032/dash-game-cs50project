Map10 = Class{}

require 'rEnemy'

dx3_variable = 0
ddx3_variable = 2
dy3_variable = 0
ddy3_variable = 1

dx4_variable = 0
ddx4_variable = 1
dy4_variable = 0
ddy4_variable = 0.4

eBoundary_height_2 = 0

dy5_variable = 0

stop = 0

function Map10:initialise()
    dx_variable = 0
    ddx_variable = 1
    dy_variable = 0
    ddy_variable = 1
    dx2_variable = 0
    ddx2_variable = 1
    dy2_variable = 0
    ddy2_variable = 1

    eZone_height = 100
    eZone_width = 200
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2) - 50
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2) - eZone_height / 2

    eBoundary_height_2 = eBoundary_height + eZone_height + 20

    -- drawing starting area
    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width

    stop = 0

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

function Map10:render()
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width + eZone_width, eBoundary_height, eZone_height, eZone_width + 10)

    love.graphics.setColor(1, 0, 0, 1)

    -- render rEnemy horizontal tunnel
    gap = 25
    x = 0
    while x < 5 * 6 do
        translation = 0
        rEnemy:render(translation + eBoundary_width + eZone_width - 10 , x + eBoundary_height + 15 , 10 + math.min(75 - translation, dy4_variable), 5)
        rEnemy:render(translation + eBoundary_width + eZone_width + math.max(0 - translation, dy4_variable) + gap , x + eBoundary_height + 15, 10 + 100 - dy4_variable - gap, 5)
        x = x + 5
    end

    while x < 5 * 12 and x >= 5 * 6 do
        translation = 5
        rEnemy:render(translation + eBoundary_width + eZone_width - 10 , x + eBoundary_height + 15 , 10 + math.min(75 - translation, dy4_variable), 5)
        rEnemy:render(translation + eBoundary_width + eZone_width + math.max(0 - translation, dy4_variable) + gap , x + eBoundary_height + 15, 10 + 100 - dy4_variable - gap, 5)
        x = x + 5
    end

    while x < 5 * 24 and x >= 5 * 12 do
        translation = 10
        rEnemy:render(translation + eBoundary_width + eZone_width - 10 , x + eBoundary_height + 15 , 10 + math.min(75 - translation, dy4_variable), 5)
        rEnemy:render(translation + eBoundary_width + eZone_width + math.max(0 - translation, dy4_variable) + gap , x + eBoundary_height + 15, 10 + 100 - dy4_variable - gap, 5)
        x = x + 5
    end

    while x < 5 * 30 and x >= 5 * 24 do
        translation = 5
        rEnemy:render(translation + eBoundary_width + eZone_width - 10 , x + eBoundary_height + 15 , 10 + math.min(75 - translation, dy4_variable), 5)
        rEnemy:render(translation + eBoundary_width + eZone_width + math.max(0 - translation, dy4_variable) + gap , x + eBoundary_height + 15, 10 + 100 - dy4_variable - gap, 5)
        x = x + 5
    end

    while x < 5 * 36 and x >= 5 * 30 do
        translation = 0
        rEnemy:render(translation + eBoundary_width + eZone_width - 10 , x + eBoundary_height + 15 , 10 + math.min(75 - translation, dy4_variable), 5)
        rEnemy:render(translation + eBoundary_width + eZone_width + math.max(0 - translation, dy4_variable) + gap , x + eBoundary_height + 15, 10 + 100 - dy4_variable - gap, 5)
        x = x + 5
    end

    -- drawing actual area
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height + eZone_height + 10, eZone_width, eZone_height)

    -- drawing starting area
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height + eZone_height + 20, startZone_height, startZone_width)

    -- drawing rEnemy(s) and checking for collisions
    love.graphics.setColor(1, 155 / 255, 0, 1)

    -- render 2, circular movement rEnemy figures
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

    -- render yellow rEnemys
    love.graphics.setColor(1, 1, 0, 1)
    rEnemy:render(eBoundary_width + dx3_variable , eBoundary_height + 20 + dy3_variable, 5, 5)
    rEnemy:render(eBoundary_width + dx3_variable , eBoundary_height + (eZone_height - 20 - 5) - dy3_variable, 5, 5)

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height + eZone_height, eZone_width, 20)
    love.graphics.rectangle('fill', eBoundary_width + eZone_width + 100, eBoundary_height, eZone_width, eZone_height * 2 + 20)

    -- THIRD ZONE
    love.graphics.setColor(1, 0, 0, 1)

    -- render alternating rEnemys
    x = 0
    while x < 14 do
        rEnemy:render(eBoundary_width + 14 * x, eBoundary_height_2 + eZone_height / 2 - 2 + dy5_variable, 5, 5)
        x = x + 1
    end

    -- render 4 pink rEnemys and 1 purple rEnemy
    love.graphics.setColor(1, 92 / 255, 206 / 255 ,1)
    rEnemy:render(eBoundary_width + dynamic_x , eBoundary_height_2 + eZone_height / 4 + dynamic_y , 5, 5)
    rEnemy:render(eBoundary_width + dynamic2_x , eBoundary_height_2 + (3 * eZone_height) / 4 + dynamic2_y , 5, 5)
    rEnemy:render(eBoundary_width + eZone_width / 2 + dynamic3_x , eBoundary_height_2 + dynamic3_y , 5, 5)
    rEnemy:render(eBoundary_width + eZone_width / 2 + dynamic4_x , -11 + eBoundary_height_2 + eZone_height - 5 + dynamic4_y , 5, 5)
    love.graphics.setColor(1/2, 0, 1/2, 1)
    rEnemy:render(eBoundary_width + eZone_width - 5 + dynamic5_x , eBoundary_height_2 + eZone_height / 2 + dynamic5_y , 5, 5)
    love.graphics.setColor(1, 1, 1, 1)
end

function Map10:update(dt)
    eZone_height = 100

    -- Find on which zone we are

    if player.x > eBoundary_width + eZone_width then
        stop = 2
    elseif player.x < eBoundary_width + eZone_width and player.y > VIRTUAL_HEIGHT / 2 then
        stop = 3
    else
        stop = 1
    end

    -- FIRST ZONE

    -- update 2, rEnemy figures in circular motion
    if stop == 1 then
        dx3_variable = dx3_variable + ddx3_variable
        if (dx3_variable <= 0) or dx3_variable >= eZone_width - 5 then
            ddx3_variable = -ddx3_variable
        end

        dy3_variable = dy3_variable + ddy3_variable
        if (dy3_variable <= - 20) or (dy3_variable >= eZone_height - 20 - 5) then
            ddy3_variable = -ddy3_variable
        end

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
    end

    -- SECOND ZONE

    -- update tunnel
    if stop == 2 then
        dy4_variable = dy4_variable + ddy4_variable
        if (dy4_variable <= -10 - 2) or (dy4_variable >= eZone_height - 25 + 2) then
            ddy4_variable = -ddy4_variable
        end
    end

    -- THIRD ZONE

    -- update pink and purple rEnemys
    if stop == 3 then
        dy5_variable = dy5_variable + ddy_variable
        if (dy5_variable >= eZone_height / 2 - 13) or (dy5_variable <= -(eZone_height / 2) + 2) then
            ddy_variable = -ddy_variable
        end

        -- pink rEnemy
        if eBoundary_width + dynamic_x > player.x then
            dynamic_dx = math.max(-2, dynamic_dx - dynamic_ddx)
            dynamic_x = dynamic_x + dynamic_dx
        elseif eBoundary_width + dynamic_x < player.x then
            dynamic_dx = math.min(2, dynamic_dx + dynamic_ddx)
            dynamic_x = dynamic_x + dynamic_dx
        end
        if eBoundary_height_2 + eZone_height / 4 + dynamic_y > player.y then
            dynamic_dy = math.max(-2, dynamic_dy - dynamic_ddy)
            dynamic_y = dynamic_y + dynamic_dy
        elseif eBoundary_height_2 + eZone_height / 4 + dynamic_y < player.y then
            dynamic_dy = math.min(2, dynamic_dy + dynamic_ddy)
            dynamic_y = dynamic_y + dynamic_dy
        end
        if dynamic_x < 0 or dynamic_x > eZone_width - 5 or dynamic_y < -25 or dynamic_y > 75 - 11 - 5 then
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
        if eBoundary_height_2 + (3 * eZone_height) / 4 + dynamic2_y > player.y then
            dynamic2_dy = math.max(-2, dynamic2_dy - dynamic_ddy)
            dynamic2_y = dynamic2_y + dynamic2_dy
        elseif eBoundary_height_2 + (3 * eZone_height) / 4 + dynamic2_y < player.y then
            dynamic2_dy = math.min(2, dynamic2_dy + dynamic_ddy)
            dynamic2_y = dynamic2_y + dynamic2_dy
        end
        if dynamic2_x < 0 or dynamic2_x > eZone_width - 5 or dynamic2_y < -75 or dynamic2_y > 25 - 5 - 11 then
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
        if eBoundary_height_2 + dynamic3_y > player.y then
            dynamic3_dy = math.max(-2, dynamic3_dy - dynamic_ddy)
            dynamic3_y = dynamic3_y + dynamic3_dy
        elseif eBoundary_height_2 + dynamic3_y < player.y then
            dynamic3_dy = math.min(2, dynamic3_dy + dynamic_ddy)
            dynamic3_y = dynamic3_y + dynamic3_dy
        end
        if dynamic3_x < -(eZone_width / 2) or dynamic3_x > eZone_width / 2 - 5 or dynamic3_y < 0 or dynamic3_y > eZone_height - 5 - 11 then
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
        if -11 + eBoundary_height_2 + eZone_height - 5 + dynamic4_y > player.y then
            dynamic4_dy = math.max(-2, dynamic4_dy - dynamic_ddy)
            dynamic4_y = dynamic4_y + dynamic4_dy
        elseif -11 + eBoundary_height_2 + eZone_height - 5 + dynamic4_y < player.y then
            dynamic4_dy = math.min(2, dynamic4_dy + dynamic_ddy)
            dynamic4_y = dynamic4_y + dynamic4_dy
        end
        if dynamic4_x < -(eZone_width / 2) or dynamic4_x > eZone_width / 2 - 5 or dynamic4_y < -(eZone_height - 5) + 11 or dynamic4_y > 0 then
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
        if eBoundary_height_2 + eZone_height / 2 + dynamic5_y > player.y then
            dynamic5_dy = math.max(-2, dynamic5_dy - dynamic_ddy)
            dynamic5_y = dynamic5_y + dynamic5_dy
        elseif eBoundary_height_2 + eZone_height / 2 + dynamic5_y < player.y then
            dynamic5_dy = math.min(2, dynamic5_dy + dynamic_ddy)
            dynamic5_y = dynamic5_y + dynamic5_dy
        end
        if dynamic5_x > 0  then
            dynamic5_dx = -0.2
            dynamic5_dy = 0
        elseif dynamic5_x < -(eZone_width - 5) then
            dynamic5_dx = 0.2
            dynamic5_dy = 0
        elseif dynamic5_y < -(eZone_height / 2) then
            dynamic5_dx = 0
            dynamic5_dy = 0.2
        elseif dynamic5_y > eZone_height / 2 - 5 -11 then
            dynamic5_dx = 0
            dynamic5_dy = -0.2
        end
    end

    -- check if player crossed end zone
    if player.x < eBoundary_width and player.y >= eBoundary_height_2 + eZone_height / 2 - startZone_height / 2 and player.y <= eBoundary_height_2 + eZone_height / 2 + startZone_height / 2 then
        gameState = 'won'
        level = 0

        -- Prepare for first level
        Map:initialise()

        -- Send player to level 1's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2
    end
end