-- Ball.lua

BALL_RADIUS = 20

local Ball = {}
Ball.__index = Ball

function Ball:new(x, y)
  local instance = {
    _x = x,
    _y = y
  }
  setmetatable(instance, self)
  return instance
end

function Ball:update(dt)

end

function Ball:draw()
  love.graphics.circle("fill", self._x, self._y, BALL_RADIUS)
end

return Ball
