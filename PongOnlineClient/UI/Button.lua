BUTTON_WIDTH = 45
BUTTON_HEIGHT = 20

local Button = {}
Button.__index = Button

function Button:new(label, callback, x, y, w, h)
  w = w or BUTTON_WIDTH
  h = h or BUTTON_HEIGHT
  local instance = {
    _label = label,
    _callback = callback,
    _x = x,
    _y = y,
    _w = w,
    _h = h,
  }
  instance.setmetatable(self)
  return instance
end

function Button:click()
  self._callback()
end

function Button:draw()
  -- body...
end

return Button
