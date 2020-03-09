Config = {}
Config.__index = Config

function Config.New(data)
  local newConfig = {}
  setmetatable(newConfig, Config)

  for k, v in pairs(data) do
    newConfig[k] = v
  end

  return newConfig
end

function Config:GetAll()
  return self
end

function Config:GetValue(key)
  return self[key]
end

function Config:GetValues(keys)
  local data = {}

  for k, v in pairs(self) do
    for i = 1, #keys do
      if k == keys[i] then
        data[k] = v
      end
    end
  end

  return data
end

function FindTableValue(t, key)
  for a, av in pairs(t) do
    if a == key then
      if type(av) == "table" then
        return {}
      else
        return av
      end
    end
  end
end