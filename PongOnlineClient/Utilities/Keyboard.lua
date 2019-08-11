local Keyboard = {
    keyStates = {}
}

function Keyboard:update(delta)
  for key, val in pairs(self.keyStates) do
    self.keyStates[key] = nil
  end
end

function Keyboard:hookLoveEvents()

  function love.keypressed(key, scancode, isrepeat)
    self.keyStates[key] = true
  end

  function love.keyreleased(key)
    self.keyStates[key] = false
  end

end

function Keyboard:isKeyDown(key)
  return love.keyboard.isDown(key)
end

function Keyboard:wasKeyJustPressed(key)
  return self.keyStates[key]
end

function Keyboard:wasKeyJustReleased(key)
  return not self.keyStates[key]
end

return Keyboard
