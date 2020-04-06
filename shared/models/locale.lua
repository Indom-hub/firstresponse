Locale = {}
Locale.__index = Locale

function Locale.New(data)
  local newLocale = {}
  setmetatable(newLocale, Locale)

  newLocale.data = {}

  for k, v in pairs(data) do
    newLocale.data[k] = v
  end
  
  return newLocale
end

function Locale:GetAll()
  return self.data
end

function Locale:GetValue(path)
  local results = {}
  local keys = String.Split(path, ".")
  local keyIndex = 1

  local searchThrough = self.data
  for a = 1, #keys do
    local found = FindData(keys[a], searchThrough)
    if type(found) == "table" then
      searchThrough = found
      if a == #keys then
        results = found
      end
    else
      results = found
    end
  end

  return results
end

function Locale:GetValues(paths)
  local results = {}

  for a = 1, #paths do
    local keys = String.Split(paths[a], ".")
    local keyIndex = 1

    local searchThrough = self.data
    for b = 1, #keys do
      local found = FindData(keys[b], searchThrough)
      if type(found) == "table" then
        searchThrough = found
        if a == #keys then
          results[a] = found
        end
      else
        results[a] = found
      end
    end
  end

  return results
end

-- FUNCTIONS --
function FindData(key, object)
  for k, v in pairs(object) do
    if k == key then
      return v
    end
  end
end