Player = Class{}

require 'Map'

function Player:init(x, y, width, height)
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.dy = 0
    self.dx = 0
end

function Player:update(dt)
    if gameState ~= 'start' and gameState ~= 'lost' and gameState ~= 'won' and level < 10 then

        -- checking for collisions with boundaries of zone on y axis
        -- moving player on y axis
        if self.dy == -PLAYER_SPEED then
            if self.x >= eBoundary_width and self.x <= eBoundary_width + eZone_width then
                self.y = math.max(eBoundary_height, self.y + self.dy * dt)
            elseif self.x >= eBoundary_width or self.x <= eBoundary_width + eZone_width then
                self.y = math.max(eBoundary_height + eZone_height / 2 - startZone_height / 2, self.y + self.dy * dt)
            end
        elseif self.dy == PLAYER_SPEED then
            if self.x >= eBoundary_width and self.x <= eBoundary_width + eZone_width then
                self.y = math.min(eBoundary_height + eZone_height - 4, self.y + self.dy * dt)
            elseif self.x >= eBoundary_width or self.x <= eBoundary_width + eZone_width then
                self.y = math.min(eBoundary_height + eZone_height / 2 + startZone_height / 2 - 4, self.y + self.dy * dt)
            end
        end

        -- checking for collisions with boundaries of zone on x axis
        -- moving player on x axis
        if self.dx == PLAYER_SPEED then
            if self.y < startBoundary_height or self.y > startBoundary_height + startZone_height - 4 then
                self.x = math.min(eBoundary_width + eZone_width - 4, self.x + self.dx * dt)
            else
                self.x = self.x + self.dx * dt
            end
        elseif self.dx == -PLAYER_SPEED then
            if self.y < startBoundary_height or self.y > startBoundary_height + startZone_height - 4 then
                self.x = math.max(eBoundary_width, self.x + self.dx * dt)
            else
                self.x = math.max(startBoundary_width, self.x + self.dx * dt)
            end
        end
    
    -- FOR THE SPECIAL CASE (level 10)
    elseif level == 10 then
        if stop == 1 then
            -- checking for collisions with boundaries of zone on y axis
            -- moving player on y axis
            if self.dy == -PLAYER_SPEED then
                if self.x >= eBoundary_width and self.x <= eBoundary_width + eZone_width then
                    self.y = math.max(eBoundary_height, self.y + self.dy * dt)
                elseif self.x >= eBoundary_width or self.x <= eBoundary_width + eZone_width then
                    self.y = math.max(eBoundary_height + eZone_height / 2 - startZone_height / 2, self.y + self.dy * dt)
                end
            elseif self.dy == PLAYER_SPEED then
                if self.x >= eBoundary_width and self.x <= eBoundary_width + eZone_width then
                    self.y = math.min(eBoundary_height + eZone_height - 4, self.y + self.dy * dt)
                elseif self.x >= eBoundary_width or self.x <= eBoundary_width + eZone_width then
                    self.y = math.min(eBoundary_height + eZone_height / 2 + startZone_height / 2 - 4, self.y + self.dy * dt)
                end
            end

            -- checking for collisions with boundaries of zone on x axis
            -- moving player on x axis
            if self.dx == -PLAYER_SPEED then
                if self.y < startBoundary_height or self.y > startBoundary_height + startZone_height - 4 then
                    self.x = math.max(eBoundary_width, self.x + self.dx * dt)
                else
                    self.x = math.max(startBoundary_width, self.x + self.dx * dt)
                end
            elseif self.dx == PLAYER_SPEED then
                self.x = self.x + self.dx * dt
            end

        elseif stop == 2 then
            -- checking for collisions with boundaries of zone on y axis
            -- moving player on y axis
            if self.dy == -PLAYER_SPEED then
                self.y = math.max(eBoundary_height, self.y + self.dy * dt)
            elseif self.dy == PLAYER_SPEED then
                self.y = math.min(eBoundary_height + 220 - 10 - 4, self.y + self.dy * dt)
            end

            -- checking for collisions with boundaries of zone on x axis
            -- moving player on x axis
            if self.dx == PLAYER_SPEED then
                self.x = math.min(eBoundary_width + eZone_width + 100 - 4, self.x + self.dx * dt)
            elseif self.dx == -PLAYER_SPEED then
                self.x = math.max(eBoundary_width + eZone_width, self.x + self.dx * dt)
            end

        elseif stop == 3 then
            if self.dy == -PLAYER_SPEED then
                self.y = math.max(eBoundary_height_2 - 10, self.y + self.dy * dt)
            elseif self.dy == PLAYER_SPEED then
                self.y = math.min(eBoundary_height_2 + eZone_height - 10 - 4, self.y + self.dy * dt)
            end
    
            -- checking for collisions with boundaries of zone on x axis
            -- moving player on x axis
            if self.dx == -PLAYER_SPEED then
                if self.y < startBoundary_height + eZone_height + 20 or self.y > startBoundary_height + eZone_height + 20 + startZone_height - 4 then
                    self.x = math.max(eBoundary_width, self.x + self.dx * dt)
                else
                    self.x = self.x + self.dx * dt
                end
            elseif self.dx == PLAYER_SPEED then
                self.x = self.x + self.dx * dt
            end
        end
    end
end

function Player:reset()
    self.x = startBoundary_width + startZone_width / 2
    self.y = startBoundary_height + startZone_height / 2
end

function Player:render()
    love.graphics.setColor(0,0,1,1)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1,1,1,1)
end