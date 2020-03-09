String = {}

function String.Interpolate(value, data)
  for k, v in pairs(data) do
    value = string.gsub(value, "{" .. k .. "}", v)
  end
  return value
end

function String.Split(s, sep)
  local result = {}
  if sep == nil then
    sep = "%s"
  end
  for match in string.gmatch(s, "([^" .. sep .. "]+)") do
    table.insert(result, match)
  end
  return result
end