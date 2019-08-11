-- Player.lua

PLAYER_WIDTH = 20
PLAYER_HEIGHT = 80

local Player = {}
Player.__index = Player

function Player:new(x)
  local instance = {
    _x     = x,
    _y     = 0,
    _speed = 0
  }
  setmetatable(instance, self)
  return instance
end

function Player:update(dt)
  _y = _y + _speed * dt
end

function Player:draw()
  love.graphics.rectangle("fill", self._x, self._y, PLAYER_WIDTH, PLAYER_HEIGHT)
end

return Player
