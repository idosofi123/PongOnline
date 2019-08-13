-- main.lua

-- libraries and Utilities
Roomy           = require 'Libraries/roomy'
Keyboard        = require 'Utilities/Keyboard'
TextureSupplier = require 'Utilities/TextureSupplier'

-- Screens
MenuScreen   = require 'Screening/Screens/Menu'
InGameScreen = require 'Screening/Screens/InGame'

-- Main Game Members
local screenManager

function love.load()

  TextureSupplier:loadTextures()

-- Hook the keyboard singleton to LOVE's callbacks.
  Keyboard:hookLoveEvents()

-- Initialize the screen manager, hook it to LOVE's callbacks and set it to
-- display the menu screen.
  screenManager = Roomy.new()
  screenManager:hook()
  screenManager:switch(MenuScreen)

end

function love.update(dt)
  -- body --
end

function love.draw()
  -- body --
end
