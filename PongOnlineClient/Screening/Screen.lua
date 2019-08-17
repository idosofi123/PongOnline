-- Screen.lua (ABSTRACT)

UI_GRID_COLUMNS = 12
UI_GRID_ROWS = 12
UI_BOX_WIDTH = _G.RESOLUTION_WIDTH / UI_GRID_COLUMNS
UI_BOX_HEIGHT = _G.RESOLUTION_HEIGHT / UI_GRID_ROWS

local Screen = {}
Screen.__index = Screen

function Screen:new()
  local instance = {
    _ui = {},
    _drawUi = {}
  }
  setmetatable(instance, self)
  return instance
end

function  Screen:addElement(element, uiBoxCol, uiBoxRow)
  local uiBoxWidth, uiBoxHeight = element:getUiDimensions()

-- Fill the grid with references to the UI element to enable spatial hashing
  for i = uiBoxCol, uiBoxCol + uiBoxWidth do
    for j = uiBoxRow, uiBoxRow + uiBoxHeight do
      self._ui[j * UI_GRID_COLUMNS + i] = element
    end
  end

  self._drawUi[uiBoxCol + uiBoxRow * UI_GRID_COLUMNS] = element
end

function Screen:mousepressed(x, y, button, isTouch)
  local clickUiBox = Screen.calculateUiBox(x, y)
  if self._ui[clickUiBox] ~= nil and button == 1 then
    self._ui[clickUiBox]:click()
  end  self._ui.originalBox = true
end

function Screen:draw()
  for uiBox, element in pairs(self._drawUi) do
    if self._drawUi[uiBox] ~= nil then
      local x, y = Screen.calculatePosOfUiBox(uiBox)
      self._drawUi[uiBox]:draw(x, y)
    end
  end
end

-- Static functions/fields
function Screen.calculateUiBox(x, y)
  return math.floor(x / UI_BOX_WIDTH) + (math.floor(y / UI_BOX_HEIGHT) * UI_GRID_COLUMNS)
end

function Screen.calculatePosOfUiBox(uiBox)
  local x = math.floor((uiBox % (_G.RESOLUTION_WIDTH / UI_BOX_WIDTH)) * UI_BOX_WIDTH)
  local y = math.floor((uiBox / (_G.RESOLUTION_WIDTH / UI_BOX_WIDTH)) * UI_BOX_HEIGHT)
  return x, y
end

function Screen.convertUiDimensionsToPxDimensions(uiBoxWidth, uiBoxHeight)
  return math.floor(uiBoxWidth * (_G.RESOLUTION_WIDTH / UI_GRID_COLUMNS)),
         math.floor(uiBoxHeight * (_G.RESOLUTION_HEIGHT / UI_GRID_ROWS))
end

return Screen
