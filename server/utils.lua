Utils = {}

Utils.GetIdentifierType = function(type, id)
  local identifiers = GetPlayerIdentifiers(id)
  for i = 1, #identifiers do
    if string.find(identifiers[i], type, 1) ~= nil then
      return identifiers[i]
    end
  end
  return nil
end