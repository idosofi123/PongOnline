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
  success = 0x1,
  error = 0x2,
  up = 0x3,
  down = 0x4
}

-- TODO: Generate the key-sets by code

Packet.PropsKeySet = {
  "null",
  "success",
  "error",
  "up",
  "down"
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
