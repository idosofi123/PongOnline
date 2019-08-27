-- Client.lua

local luasocket = require 'socket'
local Packet    = require 'Networking.Packet'

local SERVER_IP           = "176.230.40.219"
local SERVER_PORT         = 17420
local PACKET_SIZE         = 1
local SERVER_CONN_TIMEOUT = 10
local MATCHMAKING_TIMEOUT = 300

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

-- Waiting for a response from the server
  self._socket:settimeout(MATCHMAKING_TIMEOUT)
  local serverResponse = self._socket:receive(PACKET_SIZE)
  if serverResponse ~= nil then
    local serverPacket = Packet:new(string.byte(serverResponse))
    if serverPacket._props == Packet.Props.success then
      love.event.push("foundGame")
    else
      -- TODO: Handle no match found
    end
  else
    -- TODO: Handle no server response
  end

end

return Client
