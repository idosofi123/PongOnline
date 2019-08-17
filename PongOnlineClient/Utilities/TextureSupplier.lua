local TextureSupplier = {}

-- Hook to the LOVE load callback and load the game's textures.
function TextureSupplier:loadTextures()
    self.map  = love.graphics.newImage("Assets/Backgrounds/Map.png")
    self.menu = love.graphics.newImage("Assets/Backgrounds/Menu.png")
end

return TextureSupplier
