-- Packet.ua

local Packet = {}
Packet.__index = Packet

-- Static definitions
Packet.Commands = {
  enterGame = 0x0,
  disconnect = 0x1,
  move = 0x2
}

-- TODO: Generate the key-sets by code

Packet.CommandsKeySet = {
  "enterGame",
  "disconnect",
  "move"
}

Packet.Props = {
  null = 0x0,
  up = 0x1,
  down = 0x2,
  success = 0x3,
  error = 0x4
}

-- TODO: Generate the key-sets by code

Packet.PropsKeySet = {
  "null",
  "up",
  "down",
  "success",
  "error"
}

function Packet.generatePacket(command, props)
  props = props or Packet.Props.null
  local packetData = 0x00
  packetData = ((command * 2^4) + props)
  return packetData
end

function Packet:new(byteData)
  local instance = {
    _command = Packet.Commands[Packet.CommandsKeySet[math.floor(byteData / 2^4) + 1]],
    _props   = Packet.Props[Packet.PropsKeySet[math.floor(byteData % 2^4) + 1]]
  }
  setmetatable(instance, self)
  return instance
end

return Packet
