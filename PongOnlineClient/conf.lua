-- conf.lua

-- Global variable definition
_G.RESOLUTION_WIDTH  = 1280
_G.RESOLUTION_HEIGHT = 720

function love.conf(settings)
  settings.window.title = "Pong Online - Project M.T.O.I"
  settings.window.width = _G.RESOLUTION_WIDTH
  settings.window.height = _G.RESOLUTION_HEIGHT
  settings.window.fullscreen = false
  settings.console = true
end
