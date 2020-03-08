RegisterServerEvent("FirstResponse:PlayerJoined")

AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
  deferrals.defer()
  
  local src = source
  local license = Helpers.GetIdentifierType("license", src)
  local playerObject = {source = src, license = license, name = playerName}
  local serverWhitelisted = Configs.Get("server"):GetValue("whitelisted")
  local lang = Locales.Get("en"):GetValues({
    "licensemissing",
    "notwhitelisted",
    "banned"
  })

  if license == nil then
    deferrals.done(lang.licensemissing or "LICENSEMISSING_NOT_LOADING")
    return
  end
  
  local userExists = User.DoesUserExist(license)

  if userExists then
    local user = User.FromDB(playerObject)

    if serverWhitelisted then
      if user.whitelisted_at == nil then
        deferrals.done(lang["notwhitelisted"] or "NOTWHITELISTED_NOT_LOADING")
      end
    end

    if user.banned_at ~= nil then
      local banMessage = String.Interpolate(lang.banned, { reason = "Testing_Reason", by = "Xander1998", time = "forever" })
      deferrals.done(banMessage or "BAN_MESSAGE_NOT_LOADING")
    end

    deferrals.done()
  else
    User.New(playerObject)
    if serverWhitelisted then
      deferrals.done(lang.notwhitelisted or "NOTWHITELISTED_NOT_LOADING")
    end
  end
  deferrals.done()
end)

AddEventHandler("FirstResponse:PlayerJoined", function()
  local src = source
  local license = Helpers.GetIdentifierType("license", src)
  local lang = Locales.Get("en"):GetValue("licensemissing")

  if license == nil then
    DropPlayer(src, lang or "LICENSEMISSING_NOT_LOADING")
  end

  Players.Add({ name = GetPlayerName(src), source = src, license = license })
end)