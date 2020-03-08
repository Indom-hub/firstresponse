Configs = {}

function Configs.Add(key, config)
  if Configs[key] == key then return "Config Already Exists" end
  Configs[key] = config
  return "Config Created!"
end

function Configs.Get(key)
  return Configs[key]
end