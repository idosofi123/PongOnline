Screen = require '.../Screening/Screen'
Button = require '.../UI/Button'
TextureSupplier = require '.../Utilities/TextureSupplier'

local MenuScreen = {}

-- Apply inheritance (MenuScreen extends from Screen)
local super = Screen:new()
super.__index = super
setmetatable(MenuScreen, super)

-- Set UI
super:addElement(Button:new("Connect", function() end, 2, 1), 5, 7)

function MenuScreen:draw()
  love.graphics.draw(TextureSupplier.menu)

  -- Draw UI elements (super method)
  getmetatable(self):draw()
end

return MenuScreen
