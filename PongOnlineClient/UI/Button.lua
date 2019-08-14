local Button = {}
Button.__index = Button

function Button:new(label, x, y, callback)
  local instance = {
    _label = label,
    _x = x,
    _y = y,
    _callback = callback
  }
  instance.setmetatable(self)
  return instance
end

function Button:draw()
  -- body...
end

return Button
