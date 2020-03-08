String = {}

function String.Interpolate(value, data)
  for k, v in pairs(data) do
    value = string.gsub(value, "{" .. k .. "}", v)
  end
  return value
end