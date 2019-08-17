-- Button.lua

Screen = require '../Screening/Screen'

local Button = {}
Button.__index = Button

function Button:new(label, callback, uiBoxWidth, uiBoxHeight)
  local calcW, calcH = Screen.convertUiDimensionsToPxDimensions(uiBoxWidth, uiBoxHeight)
  local instance = {
    _label = label,
    _callback = callback,
    _width = calcW,
    _height = calcH
  }
  setmetatable(instance, self)
  return instance
end

function Button:click()
  self._callback()
end

function Button:draw(x, y)
  local textWidth = love.graphics.getFont():getWidth(self._label)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.rectangle("line", x, y, self._width, self._height)
  love.graphics.print(self._label,
                      x + self._width / 2 - math.floor(textWidth / 2),
                      y + self._height / 2 - math.floor(love.graphics.getFont():getHeight() / 2))
end

return Button
