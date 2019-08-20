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
  love.graphics.setColor(1, 1, 1, 1)
  local recMode = self._isHovered and "fill" or "line"
  love.graphics.rectangle(recMode, x, y, self._width, self._height)
  if self._isHovered then love.graphics.setColor(23 / 255, 19 / 255, 55 / 255, 1) else love.graphics.setColor(1, 1, 1, 1) end
  love.graphics.print(self._label,
                      x + self._width / 2 - math.floor(textWidth / 2),
                      y + self._height / 2 - math.floor(love.graphics.getFont():getHeight() / 2))
  love.graphics.setColor(1, 1, 1, 1)
end

return Button
