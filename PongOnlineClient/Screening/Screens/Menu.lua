Screen = require '.../Screening/Screen'
TextureSupplier = require '.../Utilities/TextureSupplier'

local MenuScreen = {}

-- Apply inheritance (MenuScreen extends from Screen)
local super = Screen:new()
super.__index = super
setmetatable(MenuScreen, super)

function MenuScreen:draw()

  -- Draw UI elements (super method)
  getmetatable(self):draw()
end

return MenuScreen
