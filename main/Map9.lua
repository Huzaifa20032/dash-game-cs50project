Map9 = Class{}

require 'rEnemy'

function Map9:initialise()
    eZone_height = 100
    eZone_width = 150
    eBoundary_width = VIRTUAL_WIDTH / 2 - (eZone_width / 2)
    eBoundary_height = VIRTUAL_HEIGHT / 2 - (eZone_height / 2)

    startZone_height = 30
    startZone_width = 30
    startBoundary_height = eBoundary_height + ((eZone_height / 2) - startZone_height / 2)
    startBoundary_width = eBoundary_width - startZone_width

    dy_variable = 0
    ddy_variable = 0.4
end

function Map9:render()
    -- drawing actual area
    love.graphics.setColor(50/255, 55/255, 62/255, 255/255)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height, eZone_width, eZone_height)

    -- drawing starting area
    love.graphics.setColor(0,1,0,1)
    love.graphics.rectangle('fill', startBoundary_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing ending area
    love.graphics.rectangle('fill', startBoundary_width + eZone_width + startZone_width, startBoundary_height, startZone_height, startZone_width)

    -- drawing rEnemy(s) and checking for collisions

    love.graphics.setColor(1, 0, 0, 1)

    -- render rEnemy tunnel
    gap = 25
    x = 0
    while x < 5 * 5 do
        rEnemy:render(x + eBoundary_width , -10 + eBoundary_height, 5, 10 + math.min(75, dy_variable))
        rEnemy:render(x + eBoundary_width , eBoundary_height + math.max(0 , dy_variable) + gap, 5, 10 + eZone_height - dy_variable - gap)
        x = x + 5
    end

    while x < 5 * 10 and x >= 5 * 5 do
        translation = 5
        rEnemy:render(x + eBoundary_width , translation + -10 + eBoundary_height, 5, 10 + math.min(75 - translation, dy_variable))
        rEnemy:render(x + eBoundary_width , translation + eBoundary_height + math.max(0 - translation , dy_variable) + gap, 5, 10 + eZone_height - dy_variable - gap)
        x = x + 5
    end

    while x < 5 * 20 and x >= 5 * 10 do
        translation = 10
        rEnemy:render(x + eBoundary_width , translation + -10 + eBoundary_height, 5, 10 + math.min(75 - translation, dy_variable))
        rEnemy:render(x + eBoundary_width , translation + eBoundary_height + math.max(0 - translation , dy_variable) + gap, 5, 10 + eZone_height - dy_variable - gap)
        x = x + 5
    end

    while x < 5 * 25 and x >= 5 * 20 do
        translation = 5
        rEnemy:render(x + eBoundary_width , translation + -10 + eBoundary_height, 5, 10 + math.min(75 - translation, dy_variable))
        rEnemy:render(x + eBoundary_width , translation + eBoundary_height + math.max(0 - translation , dy_variable) + gap, 5, 10 + eZone_height - dy_variable - gap)
        x = x + 5
    end

    while x < 5 * 30 and x >= 5 * 25 do
        translation = 0
        rEnemy:render(x + eBoundary_width , translation + -10 + eBoundary_height, 5, 10 + math.min(75 - translation, dy_variable))
        rEnemy:render(x + eBoundary_width , translation + eBoundary_height + math.max(0 - translation , dy_variable) + gap, 5, 10 + eZone_height - dy_variable - gap)
        x = x + 5
    end

    love.graphics.setColor(0, 0, 0, 1)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height + eZone_height, eZone_width, eZone_height)
    love.graphics.rectangle('fill', eBoundary_width, eBoundary_height - eZone_height, eZone_width, eZone_height)

    love.graphics.setColor(1, 1, 1, 1)
end

function Map9:update(dt)
    eZone_height = 100

    -- update rEnemy tunnel
    dy_variable = dy_variable + ddy_variable
    if (dy_variable <= -10 - 2) or (dy_variable >= eZone_height - 25 + 2) then
        ddy_variable = -ddy_variable
    end

    -- check if player crossed end zone
    if player.x >= startBoundary_width + eZone_width + startZone_width and player.y >= startBoundary_height and player.y <= startBoundary_height + startZone_height then
        -- Preparing for next level
        Map10:initialise()

        -- Send player to next level's start zone
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2
        
        level = level + 1
    end
end