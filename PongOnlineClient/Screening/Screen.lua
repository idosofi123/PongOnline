-- Screen.lua (ABSTRACT)

UI_BOX_WIDTH = _G.RESOLUTION_WIDTH / 12
UI_BOX_HEIGHT = _G.RESOLUTION_HEIGHT / 12

local Screen = {}
Screen.__index = Screen

function Screen:new()
  local instance = {
    _ui = {}
  }
  setmetatable(instace, self)
  instance.hookLoveEvents()
  return instance
end

function Screen:mousepressed(x, y, button, isTouch)
  local clickUiBox = calculateUiBox(x, y)
  if self._ui[clickUiBox] ~= nil and button == 1 then
    self._ui[clickUiBox].click()
  end
end

function Screen:draw()
  for uiBox, element in pairs(self._ui) do
    if self._ui[uiBox] ~= nil then
      local x, y = calculatePosOfUiBox(uiBox)
      self._ui[uiBox].draw(x, y)
    end
  end
end

-- Static functions/fields
function calculateUiBox(x, y)
  return x / UI_BOX_WIDTH + ((y / UI_BOX_HEIGHT) * (_G.RESOLUTION_WIDTH / UI_BOX_WIDTH))
end

function calculatePosOfUiBox(uiBox)
  local x = (uiBox % (_G.RESOLUTION_WIDTH / UI_BOX_WIDTH)) * UI_BOX_WIDTH
  local y = (uiBox / (_G.RESOLUTION_WIDTH / UI_BOX_WIDTH)) * UI_BOX_HEIGHT
  return x, y
end

return Screen
