Screen = require '.../Screening/Screen'
TextureSupplier = require '.../Utilities/TextureSupplier'

local InGameScreen = {}

-- Apply inheritance (InGameScreen extends from Screen)
local super = Screen:new()
super.__index = super
setmetatable(InGameScreen, super)

function InGameScreen:draw()
  love.graphics.draw(TextureSupplier.map)

  -- Draw UI elements (super method)
  getmetatable(self):draw()
end

return InGameScreen
