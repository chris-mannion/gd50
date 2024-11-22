--[[
    ScoreState Class
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]

function ScoreState:init()
    self.bronze = love.graphics.newImage('bronze.png')
    self.silver = love.graphics.newImage('silver.png')
    self.gold = love.graphics.newImage('gold.png')
end

function ScoreState:enter(params)
    self.score = params.score -- Get the score passed in

    if self.score < 3 then
        self.medal = self.bronze
    elseif self.score < 6 then
        self.medal = self.silver
    else
        self.medal = self.gold
    end
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    -- Render the score and other text
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- Render the medal next to the score
    if self.medal then
        local medalScale = 0.1 -- Adjust the scale for appropriate size
        local medalWidth = self.medal:getWidth() * medalScale
        local medalHeight = self.medal:getHeight() * medalScale
        local medalX = (VIRTUAL_WIDTH / 2) - (medalWidth / 2)
        local medalY = 120

        love.graphics.draw(self.medal, medalX, medalY, 0, medalScale, medalScale)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end