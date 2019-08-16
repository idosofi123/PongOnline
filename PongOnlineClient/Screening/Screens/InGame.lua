Screen = require '../Screen'
TextureSupplier = require '.../Utilities/TextureSupplier'

local InGameScreen = {}
setmetatable(InGameScreen, Screen)

function InGameScreen:draw()
  love.graphics.draw(TextureSupplier.map)

  -- Draw UI elements (super method)
  getmetatable(self).draw()
end

return InGameScreen
