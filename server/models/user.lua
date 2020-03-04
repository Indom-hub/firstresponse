User = {}
User.__index = User

function User.New(playerObject)
  local newUser = {}
  setmetatable(newUser, User)
  
  -- User Runtime Data
  newUser.source = playerObject.source
  newuser.license = playerObject.license
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

  return newUser
end

-- [[ MOVE THIS FUNCTION TO A DATABASE HELPERS RESOURCE... NOT NEED FOR ITS USE HERE ]] -- 
-- function User.FromDB(keys, playerObject)
--   local newUser = {}

--   newUser.source = playerObject.source
--   newUser.ping = function()
--     return GetPlayerPing(newUser.source)
--   end

--   local q = "SELECT * FROM `users` "

--   for k, v in pairs(keys) do
--     if type(v) == "string" then v = "'" .. v .. "'" end
--     q = q .. "WHERE `" .. k .. "` = " .. v
--   end

--   q = q .. " LIMIT 1"

--   local results = exports.externalsql:AsyncQuery({
--     query = q,
--     data = {}
--   })

--   local data = results.data[1]

--   if #data >= 1 then
--     newUser.id = data.id
--     newUser.name = data.name
--   end

--   return newUser
-- end
-- [[ ^^^^ MOVE THIS FUNCTION TO A DATABASE HELPERS RESOURCE... NOT NEED FOR ITS USE HERE ^^^^ ]] -- 

function User.FromDB(playerObject)
  local newUser = {}

  newUser.source = playerObject.source
  newuser.license = playerObject.license
  newUser.ping = function() return GetPlayerPing(newUser.source) end

  local q = [[ SELECT * FROM `users` WHERE `license` = :license LIMIT 1 ]]
  local results = exports.externalsql:AsyncQuery({
    query = q,
    data = { license = playerObject.license }
  })

  if #data >= 1 then
    newUser.id = data.id
    newUser.name = data.name
  end
end

function User:Save()
  -- Trigger Save Data
end

function User:Ban()
  -- Ban User
end

function User:Kick(reason)
  DropPlayer(self.source, reason)
end

function User:Warn(reason)
  -- Warn User
  -- Notify User
  -- self:TriggerEvent("FirstResponse:WarnUserNotification")
end

function User:TriggerEvent(event, args...)
  TriggerClientEvent(event, self.source, args)
end

Citizen.CreateThread(function()

end)