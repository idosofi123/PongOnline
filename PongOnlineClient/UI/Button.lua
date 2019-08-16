local Button = {}
Button.__index = Button

function Button:new(label, callback, uiBoxWidth, uiBoxHeight)
  local instance = {
    _label = label,
    _callback = callback,
    _uiBoxWidth = uiBoxWidth,
    _uiBoxHeight = uiBoxHeight
  }
  instance.setmetatable(self)
  return instance
end

function Button:click()
  self._callback()
end

function Button:draw(x, y)
  -- body...
end

return Button
