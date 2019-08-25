-- Packet.ua

local Packet = {}
Packet.__index = Packet

-- Static definitions
Packet.Commands = {
  enterGame = 0x1,
  disconnect = 0x2,
  move = 0x3
}

Packet.Props = {
  null = 0x0,
  up = 0x1,
  down = 0x2
}

function Packet.generatePacket(command, props)
  props = props or Packet.Props.null
  local packetData = 0x00
  packetData = ((packetData | command) * (2 ^ 4)) | props
  return packetData
end

return Packet
