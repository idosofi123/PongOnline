-- conf.lua

-- Global variable definition
resolutionWidth  = 1280
resolutionHeight = 720

function love.conf(settings)
  settings.window.title = "Pong Online - Project M.T.O.I"
  settings.window.width = resolutionWidth
  settings.window.height = resolutionHeight
  settings.window.fullscreen = false
  settings.console = true
end
