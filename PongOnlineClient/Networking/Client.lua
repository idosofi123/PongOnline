-- Client.lua

local luasocket = require 'socket'
local Packet    = require 'Networking.Packet'

local SERVER_IP           = "176.230.40.219"
local SERVER_PORT         = 17420
local SERVER_CONN_TIMEOUT = 10

local Client = {
  _socket = {}
}

function Client:connectToServer()
  self._socket = luasocket.tcp()
  self._socket:settimeout(SERVER_CONN_TIMEOUT)
  local res, err = self._socket:connect(SERVER_IP, SERVER_PORT)
  return err
end

function Client:startMatchmaking()
  self._socket:settimeout(0)
  local packetData = Packet.generatePacket(Packet.Commands.enterGame)
  self._socket:send(packetData)
end

return Client
