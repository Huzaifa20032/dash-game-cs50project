Map = Class{}

require 'rEnemy'

-- Initialising all the variables for use in all the maps

ready = 0

dx_variable = 0
ddx_variable = 1
dy_variable = 0
ddy_variable = 1
dx2_variable = 0
ddx2_variable = 1
dy2_variable = 0
ddy2_variable = 1

dy_corner = 0
ddy_corner = 2
dx_corner = 0
ddx_corner = 2

dy3_variable = 0
ddy3_variable = 1 * 0.25

dynamic_x = 0
dynamic_y = 0
dynamic_dx = 0
dynamic_dy = 0
dynamic_ddx = 0.01
dynamic_ddy = 0.01

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

-- For initialising Map after winning / losing
function Map:initialise()
    eZone_height = 100
    eZone_width = 100
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2)
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2)

    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width

    dy_variable = 0
    ddy_variable = 1
end

function Map:render()
    -- drawing actual area
    eZone_height = 100
    eZone_width = 100
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2)
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2)
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    -- drawing starting area
    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width + eZone_width + startZone_width, startBoundary_height, startZone_height, startZone_width)

    -- draw rEnemy(s) and checking for collisions
    love.graphics.setColor(1, 0, 0, 1)

    -- render alternating rEnemy(s)
    x = 0
    while x < 7 do
        rEnemy:render(eBoundary_width + 14 * x, (VIRTUAL_HEIGHT / 2 - 2) + dy_variable, 5, 5)
        x = x + 1
    end

    love.graphics.setColor(1, 1, 1, 1)
end

function Map:update(dt)
    eZone_height = 100

    -- update variables for alternating rEnemy(s)
    dy_variable = dy_variable + ddy_variable
    if (dy_variable >= eZone_height / 2 - 2) or (dy_variable <= -(eZone_height / 2) + 2) then
        ddy_variable = -ddy_variable
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then
        gameState = 'play'

        -- Preparing for next level
        Map2:initialise()

        -- Sending player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2
        level = level + 1
    end
end