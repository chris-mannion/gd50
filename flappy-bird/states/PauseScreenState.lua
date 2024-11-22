--[[
    PauseScreenState Class
    
    Author: Colton Ogden
    cogden@cs50.harvard.edu

    The PauseScreenState is activated when the game is paused. It displays "Paused"
    and a message to resume the game by pressing Enter.
]]

PauseScreenState = Class{__includes = BaseState}

function PauseScreenState:init()
    -- nothing for now
end

function PauseScreenState:enter(params)
    -- Save the play state data passed from PlayState
    self.bird = params.bird
    self.pipePairs = params.pipePairs
    self.timer = params.timer
    self.score = params.score
    self.lastY = params.lastY
end

function PauseScreenState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        -- Return to PlayState with the saved game state
        gStateMachine:change('play', {
            bird = self.bird,
            pipePairs = self.pipePairs,
            timer = self.timer,
            score = self.score,
            lastY = self.lastY
        })
    end
end


function PauseScreenState:render()
    -- Render the paused message
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Paused', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press Enter to Resume', 0, 100, VIRTUAL_WIDTH, 'center')

    -- Optionally, dim the screen behind the pause message
    love.graphics.setColor(0, 0, 0, 0.5) -- Transparent black
    love.graphics.rectangle('fill', 0, 0, VIRTUAL_WIDTH, VIRTUAL_HEIGHT)
    love.graphics.setColor(1, 1, 1, 1) -- Reset color to white
end
