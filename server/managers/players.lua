Players = {}

function Players.Add(playerObject)
  local newPlayer = Player.New(playerObject)
  table.insert(Players, newPlayer)
end

function Players.RemoveBySource(source)
  for i = 1, #Players do
    if Players[i].source == source then
      table.remove(Players, i)
    end
  end
end

function Players.FindByIndex(index)
  return Players[index]
end

function Players.FindByLicense(license)
  for i = 1, #Players do
    if Players[i].license == license then
      return Players[i]
    end
  end
  return nil
end

function Players.FindBySource(source)
  for i = 1, #Players do
    if Players[i].source == source then
      return Players[i]
    end
  end
  return nil
end