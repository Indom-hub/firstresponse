Player = {}
Player.__index = Player

function Player.New(playerObject)
  local newPlayer = {}
  setmetatable(newPlayer, Player)

  newPlayer.name = playerObject.name
  newPlayer.source = playerObject.source
  newPlayer.license = playerObject.license
  newPlayer.user = User.FromDB(playerObject)

  return newPlayer
end

function Player:Ping()
  return GetPlayerPing(self.source)
end

function Player:Kick(reason)
  DropPlayer(self.source, reason)
end

function  Player:Ban()
  self.user:Ban()
  self:Kick()
end

function Player:Warn()
  self.user:Warn()
  -- self:TriggerEvent("FirstResponse:WarnNotification", "Testing_Message_Here")
end

function Player:Save()
  self.user:Save()
end

function Player:TriggerEvent(event, ...)
  TriggerClientEvent(event, self.source, ...)
end