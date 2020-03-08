Locale = {}
Locale.__index = Locale

function Locale.New(data)
  local newLocale = {}
  setmetatable(newLocale, Locale)

  for k, v in pairs(data) do
    newLocale[k] = v
  end
  
  return newLocale
end

function Locale:GetAll()
  return self
end

function Locale:GetValue(key)
  return self[key]
end

function Locale:GetValues(keys)
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