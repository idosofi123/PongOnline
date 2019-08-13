TextureSupplier = require '.../Utilities/TextureSupplier'

local InGameScreen = {}

function InGameScreen:update(dt)

end

function InGameScreen:draw()
  love.graphics.print("In Game", 50, 50)
  love.graphics.draw(TextureSupplier.map)
end

return InGameScreen
