User = {}
User.__index = User

function User.New(playerObject)
  local newUser = {}
  setmetatable(newUser, User)
  
  -- User Runtime Data
  newUser.source = playerObject.source
  newUser.license = playerObject.license
  newUser.ping = function()
    return GetPlayerPing(newUser.source)
  end

  -- User Data
  newUser.id = nil
  newUser.name = playerObject.name
  newUser.license = playerObject.license
  newUser.group = 0 -- Use Config Default Value [ Eventually use group enums ]
  newUser.whitelisted_at = nil
  newUser.banned_at = nil
  newUser.banned_reason = nil
  newUser.banned_by = nil
  newUser.created_at = nil

  local results = exports.externalsql:AsyncQuery({
    query = [[ INSERT INTO `users` (`name`, `license`, `group`) VALUES (:name, :license, :group) ]],
    data = {
      name = newUser.name,
      license = newUser.license,
      group = newUser.group
    }
  })

  print(json.encode(results))

  return newUser
end

function User.FromDB(playerObject)
  local newUser = {}
  setmetatable(newUser, User)

  newUser.source = playerObject.source
  --newUser.ping = function() return GetPlayerPing(newUser.source) end

  local q = [[ SELECT * FROM `users` WHERE `license` = :license LIMIT 1 ]]
  local results = exports.externalsql:AsyncQuery({
    query = q,
    data = { license = playerObject.license }
  })

  local data = results.data[1]

  if data ~= nil then
    newUser.id = data.id
    newUser.name = data.name
    newUser.license = data.license
    newUser.group = 0 -- Use Config Default Value [ Eventually use group enums ]
    newUser.whitelisted_at = data.whitelisted_at
    newUser.banned_at = data.banned_at
    newUser.banned_reason = data.banned_reason
    newUser.banned_by = data.banned_by
    newUser.created_at = data.created_at
  end
  
  return newUser
end

function User.DoesUserExist(playerObject)
  local q = [[ SELECT * FROM `users` WHERE `license` = :license LIMIT 1 ]]
  local results = exports.externalsql:AsyncQuery({
    query = q,
    data = { license = playerObject.license }
  })

  local data = results.data[1]
  if data ~= nil then
    return true
  end
  return false
end

function User:Save()
  print("SAVING USER!")
end

function User:Ban()
  print("BANNING USER")
end

function User:Kick(reason)
  DropPlayer(self.source, reason)
end

function User:Warn(reason)
  -- Warn User
  -- Notify User
  -- self:TriggerEvent("FirstResponse:WarnUserNotification")
end

function User:TriggerEvent(event, ...)
  TriggerClientEvent(event, self.source, ...)
end

Citizen.CreateThread(function()
  local userFound = User.FromDB({ source = 1, license = "license:12345" })
  userFound:Save()
end)