-- main.lua

-- libraries and Utilities
Roomy           = require 'Libraries.roomy'
Keyboard        = require 'Utilities.Keyboard'
TextureSupplier = require 'Utilities.TextureSupplier'
Client          = require 'Networking.Client'

-- Screens
MenuScreen   = require 'Screening.Screens.Menu'
InGameScreen = require 'Screening.Screens.InGame'

-- Main Game Members
local screenManager

function love.load()

  TextureSupplier:loadTextures()

-- Set default font (TEMPORARY)
  love.graphics.setFont(love.graphics.newFont("Assets/Fonts/Rajdhani-Regular.ttf", 32))

-- Hook the keyboard singleton to LOVE's callbacks.
  Keyboard:hookLoveEvents()

-- Initialize the screen manager, hook it to LOVE's callbacks and set it to
-- display the menu screen.
  screenManager = Roomy.new()
  screenManager:hook()
  screenManager:switch(MenuScreen)

end

-- Define connection to server
function love.handlers.connectToServer()
  if Client:connectToServer() == nil then
    love.event.push("connectionSuccessful")
  else
    -- TODO: Handle error
  end
end

function love.handlers.startGame()
  Client:startMatchmaking()
end

function love.handlers.foundGame()
  screenManager:switch(InGameScreen)
end

function love.update(dt)
  -- body --
end

function love.draw()
  -- body --
end
