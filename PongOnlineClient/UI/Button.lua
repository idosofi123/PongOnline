-- Button.lua

Screen = require '../Screening/Screen'

local Button = {}
Button.__index = Button

function Button:new(label, callback, uiBoxWidth, uiBoxHeight)
  local calcW, calcH = Screen.convertUiDimensionsToPxDimensions(uiBoxWidth, uiBoxHeight)
  local instance = {
    _label = label,
    _callback = callback,
    _uiBoxWidth = uiBoxWidth,
    _uiBoxHeight = uiBoxHeight,
    _width = calcW,
    _height = calcH,
    _isHovered = false
  }
  setmetatable(instance, self)
  return instance
end

function Button:getUiDimensions()
  return self._uiBoxWidth, self._uiBoxHeight
end

function Button:click()
  self._callback()
end

function Button:mousemoved(isHover)
  self._isHovered = isHover
end

function Button:draw(x, y)
  local textWidth = love.graphics.getFont():getWidth(self._label)
  if self._isHovered then love.graphics.setColor(1, 1, 1, 1) else love.graphics.setColor(1, 1, 1, 0.3) end
  love.graphics.rectangle("line", x, y, self._width, self._height)
  love.graphics.setColor(1, 1, 1, 1)
  love.graphics.print(self._label,
                      x + self._width / 2 - math.floor(textWidth / 2),
                      y + self._height / 2 - math.floor(love.graphics.getFont():getHeight() / 2))
end

return Button
