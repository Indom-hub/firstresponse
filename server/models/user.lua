User = {}
User.__index = User

function User.New(playerObject)
  local newUser = {}
  setmetatable(newUser, User)
  
  -- User Runtime Data
  newUser.license = playerObject.license

  -- User Data
  newUser.id = nil
  newUser.name = playerObject.name
  newUser.license = playerObject.license
  newUser.group = 0
  newUser.whitelisted_at = nil
  newUser.banned_at = nil
  newUser.banned_reason = nil
  newUser.banned_by = nil
  newUser.created_at = nil

  exports.externalsql:AsyncQuery({
    query = [[ INSERT INTO `users` (`name`, `license`, `group`) VALUES (:name, :license, :group) ]],
    data = {
      name = newUser.name,
      license = newUser.license,
      group = newUser.group
    }
  })

  return newUser
end

function User.FromDB(playerObject)
  local newUser = {}
  setmetatable(newUser, User)

  newUser.source = playerObject.source

  local defaultRole = Configs.Get("roles"):GetValue("user")

  local results = exports.externalsql:AsyncQuery({
    query = [[ SELECT * FROM `users` WHERE `license` = :license LIMIT 1 ]],
    data = { license = playerObject.license }
  })

  local data = results.data[1]

  if data ~= nil then
    newUser.id = data.id
    newUser.name = data.name
    newUser.license = data.license
    newUser.group = defaultRole
    newUser.whitelisted_at = data.whitelisted_at
    newUser.banned_at = data.banned_at
    newUser.banned_reason = data.banned_reason
    newUser.banned_by = data.banned_by
    newUser.created_at = data.created_at
  end
  
  return newUser
end

function User.DoesUserExist(license)
  local results = exports.externalsql:AsyncQuery({
    query = [[ SELECT * FROM `users` WHERE `license` = :license LIMIT 1 ]],
    data = { license = license }
  })

  local data = results.data[1]
  if data ~= nil then
    return true
  end
  return false
end

function User:Save()
  -- Save User Data
end

function User:Ban()
  -- Update User Ban Data
end

function User:Warn(reason)
  -- Inser User Warn
end