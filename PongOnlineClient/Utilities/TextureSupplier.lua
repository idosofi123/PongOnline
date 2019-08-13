local TextureSupplier = {}

-- Hook to the LOVE load callback and load the game's textures.
function TextureSupplier:loadTextures()
    print("Loading textures...")
    self.map = love.graphics.newImage("Assets/Backgrounds/Map.png")
end

return TextureSupplier
