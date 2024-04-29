rEnemy = Class{}

--[[
    Expects a player as an argument and returns true or false, depending
    on whether their rectangles overlap.
]]
function rEnemy:collides(player)
    -- first, check to see if the left edge of either is farther to the right
    -- than the right edge of the other
    if self.x > player.x + player.width or player.x > self.x + self.width then
        return false
    end

    -- then check to see if the bottom edge of either is higher than the top
    -- edge of the other
    if self.y > player.y + player.height or player.y > self.y + self.height then
        return false
    end 

    -- if the above aren't true, they're overlapping
    ready = 0
    return true
end

rEnemy_stop = 0

function rEnemy:render(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height

    if level == 1 then
        rEnemy_stop = 1
    end
    
    if rEnemy_stop == 1 and rEnemy:collides(player) == true then
        if level == 10 then
            Map10:initialise()
        elseif level == 7 then
            Map7:initialise()
        elseif level == 4 then
            Map4:initialise()
        end
        
        player.x = startBoundary_width + startZone_width / 2 - 4 / 2
        player.y = startBoundary_height + startZone_height / 2 - 4 / 2

        deaths = deaths + 1
        sounds['player_hit']:play()
    end

    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
end