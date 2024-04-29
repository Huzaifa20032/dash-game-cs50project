-- push is a library that will allow us to draw our game at a virtual
-- resolution, instead of however large our window is; used to provide
-- a more retro aesthetic
--
-- https://github.com/Ulydev/push
push = require 'push'

-- the "Class" library we're using will allow us to represent anything in
-- our game as code, rather than keeping track of many disparate variables and
-- methods
Class = require 'class'

-- our Player class, which stores position and dimensions for the player
-- and the logic for rendering them
require 'Player'

-- our rEnemy class, which isn't much different than a Player structure-wise
-- but which will mechanically function very differently
require 'rEnemy'

-- our 'Map' classes, will initialise, render, and update levels along with their rEnemys
-- every 'Map' class will initialise the next when the level gets appended by 1
require 'Map'
require 'Map2'
require 'Map3'
require 'Map4'
require 'Map5'
require 'Map6'
require 'Map7'
require 'Map8'
require 'Map9'
require 'Map10'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 432
VIRTUAL_HEIGHT = 243

-- speed at which we will move our Player; multiplied by dt in update
PLAYER_SPEED = 40

-- Loading necessary things for game to run
function love.load()
    -- set love's default filter to "nearest-neighbor", which essentially
    -- means there will be no filtering of pixels (blurriness), which is
    -- important for a nice crisp, 2D look
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- set the title of our application window
    love.window.setTitle('Dash')

    -- "seed" the RNG so that calls to random are always random
    -- use the current time, since that will vary on startup every time
    math.randomseed(os.time())

    -- initialize our nice-looking retro text fonts
    smallFont = love.graphics.newFont('font.ttf', 8)
    largeFont = love.graphics.newFont('font.ttf', 16)
    scoreFont = love.graphics.newFont('font.ttf', 32)
    titleFont = love.graphics.newFont('font.ttf', 64)
    love.graphics.setFont(smallFont)

    -- set up our sound effects; later, we can just index this table and
    -- call each entry's `play` method
    sounds = {
        ['player_hit'] = love.audio.newSource('sounds/paddle_hit.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),
        ['wall_hit'] = love.audio.newSource('sounds/wall_hit.wav', 'static')
    }

    -- initialize window with virtual resolution
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = true,
        vsync = true
    })

    -- initialize score variables, used for rendering on the screen and keeping
    -- track of the winner
    deaths = 0

    -- initialize player
    Map:render()
    Map2:render()
    player = Player((startBoundary_width + startZone_width / 2) - 4 / 2, (startBoundary_height + startZone_height / 2) - 4 / 2, 4, 4)

    -- Put game in 'start title' mode
    gameState = 'start'
    level = 0
end

--[[
    Called by LÖVE whenever we resize the screen; here, we just want to pass in the
    width and height to push so our virtual resolution can be resized as needed.
]]
function love.resize(w, h)
    push:resize(w, h)
end

--[[
    Runs every frame, with "dt" passed in, our delta in seconds 
    since the last frame, which LÖVE2D supplies us.
]]
-- Update the map corresponding to the level
function love.update(dt)
    if level == 10 then
        Map10:update()
    elseif level == 1 then
        Map:update()
    elseif level == 2 then
        Map2:update()
    elseif level == 3 then
        Map3:update()
    elseif level == 4 then
        Map4:update()
    elseif level == 5 then
        Map5:update()
    elseif level == 6 then
        Map6:update()
    elseif level == 7 then
        Map7:update()
    elseif level == 8 then
        Map8:update()
    elseif level == 9 then
        Map9:update()
    end

    -- set a limit of 200 for deaths
    if deaths == 200 then
        level = 0
        Map:initialise()
        gameState = 'lost'
    end

    -- player movement
    -- Preventing diagonal movement
    if love.keyboard.isDown('up') then
        player.dy = -PLAYER_SPEED
        player.dx = 0
    elseif love.keyboard.isDown('down') then
        player.dy = PLAYER_SPEED
        player.dx = 0
    elseif love.keyboard.isDown('right') then
        player.dx = PLAYER_SPEED
        player.dy = 0
    elseif love.keyboard.isDown('left') then
        player.dx = -PLAYER_SPEED
        player.dy = 0
    else
        player.dx = 0
        player.dy = 0
    end

    -- update player
    player:update(dt)
end

--[[
    Keyboard handling, called by LÖVE2D each frame; 
    passes in the key we pressed so we can access.
]]
function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    -- if we press enter during either the start, lost, or won phase, it should
    -- transition to the next appropriate state
    elseif key == 'enter' or key == 'return' then
        if gameState == 'start' then
            gameState = 'play'
            level = level + 1
        elseif gameState == 'lost' then
            -- game is simply in a restart phase here
            level = 1
            gameState = 'play'

            -- reset scores to 0
            deaths = 0
        elseif gameState == 'won' then
            level = 1
            gameState = 'play'

            deaths = 0
        end
    end

    if key == 'q' then
        player.x = player.x + 250
    elseif key == 'w' then
        player.x = player.x + 250
        player.y = player.y - 40
    elseif key == 'e' then
        player.y = 220
    elseif key == 'r' then
        player.x = player.x - 224
        player.y = player.y - 30
    end
end

--[[
    Called after update by LÖVE2D, used to draw anything to the screen, 
    updated or otherwise.
]]
function love.draw()
    push:apply('start')

    -- clear the screen with a specific color;
    love.graphics.clear(0, 0, 0, 0)

    love.graphics.setFont(smallFont)

    -- render Map corresponding to the level
    -- render player only if level > 0
    if level == 10 then
        Map10:render()
        player:render()
    elseif level == 1 then
        Map:render()
        player:render()
    elseif level == 2 then
        Map2:render()
        player:render()
    elseif level == 3 then
        Map3:render()
        player:render()
    elseif level == 4 then
        Map4:render()
        player:render()
    elseif level == 5 then
        Map5:render()
        player:render()
    elseif level == 6 then
        Map6:render()
        player:render()
    elseif level == 7 then
        Map7:render()
        player:render()
    elseif level == 8 then
        Map8:render()
        player:render()
    elseif level == 9 then
        Map9:render()
        player:render()
    end

    -- draw title screen
    if gameState == 'start' then
        love.graphics.setFont(titleFont)
        love.graphics.printf('Welcome to Dash!', 0, 15, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(largeFont)
        love.graphics.printf('Press Enter to begin!', 0, 150, VIRTUAL_WIDTH, 'center')
    -- draw UI message for when playing the game
    elseif level > 0 then
        displayScore()
        love.graphics.print('Level: ' .. tostring(level), VIRTUAL_WIDTH - 80, 5)
    -- draw losing screen
    elseif gameState == 'lost' then
        love.graphics.setFont(titleFont)
        love.graphics.printf('You lose!',
            0, 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to try again!', 0, 120, VIRTUAL_WIDTH, 'center')
    -- draw winning screen
    elseif gameState == 'won' then
        love.graphics.setFont(titleFont)
        love.graphics.printf('You win!', 0, 40, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(largeFont)
        love.graphics.printf('with ' .. tostring(deaths) .. ' deaths', 0, 100, VIRTUAL_WIDTH, 'center')
        if deaths > 99 then
            love.graphics.printf('In the end, it is finishing that counts, not the position, even if it was worse than a toddlers!!', 0, 125, VIRTUAL_WIDTH, 'center')
        elseif deaths > 50 then
            love.graphics.printf('Are double digits an achievement for you?', 0, 140, VIRTUAL_WIDTH, 'center')
        elseif deaths > 10 then
            love.graphics.printf('Mediocre.', 0, 140, VIRTUAL_WIDTH, 'center')
        elseif deaths > 3 then
            love.graphics.printf('Impressive!', 0, 140, VIRTUAL_WIDTH, 'center')
        elseif deaths > 1 then
            love.graphics.printf('Excellent!!', 0, 140, VIRTUAL_WIDTH, 'center')
        elseif deaths > 0 then
            love.graphics.printf('So close to perfection!!!', 0, 140, VIRTUAL_WIDTH, 'center')
        elseif deaths == 0 then
            love.graphics.printf('You did it, you absolute madlad, you did it!!!!', 0, 140, VIRTUAL_WIDTH, 'center')
        end
        love.graphics.setFont(smallFont)
        love.graphics.printf('Press Enter to restart!', 0, 160, VIRTUAL_WIDTH, 'center')
        displayScore()
    else
        -- no UI messages to display
    end

    -- render the currrent FPS
    displayFPS()

    push:apply('end')
end

function displayFPS()
    -- simple FPS display across all states
    love.graphics.setFont(smallFont)
    love.graphics.setColor(0, 255, 0, 255)
    love.graphics.print('FPS: ' .. tostring(love.timer.getFPS()), 10, 10)
end

--[[
    Simply draws the score to the screen.
]]
function displayScore()
    love.graphics.setFont(largeFont)
    love.graphics.print('Deaths: ' .. tostring(deaths), 50, 
        5)
end
