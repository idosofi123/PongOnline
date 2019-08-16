Screen = require '../Screen'
TextureSupplier = require '.../Utilities/TextureSupplier'

local MenuScreen = {}
setmetatable(MenuScreen, Screen)

function MenuScreen:draw()

  -- Draw UI elements (super method)
  getmetatable(self).draw()
end

return MenuScreen
