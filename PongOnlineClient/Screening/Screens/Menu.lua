Screen = require '.../Screening/Screen'
Button = require '.../UI/Button'
TextureSupplier = require '.../Utilities/TextureSupplier'

local MenuScreen = {}

-- Apply inheritance (MenuScreen extends from Screen)
local super = Screen:new()
super.__index = super
setmetatable(MenuScreen, super)

-- UI Definition
super:addElement(Button:new("Connect", function() love.event.push('connectToServer') end, 4, 1), 6, 7)
super:addElement(Button:new("Exit", function() love.event.quit() end, 4, 1), 6, 9)


function MenuScreen:draw()
  love.graphics.draw(TextureSupplier.menu)

  -- Draw UI elements (super method)
  getmetatable(self):draw()
end

return MenuScreen
