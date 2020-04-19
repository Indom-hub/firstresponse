Utils = {}

function Utils.IsMPPed(ped)
  local mpFemaleHash = GetHashKey("mp_f_freemode_01")
  local mpMaleHash = GetHashKey("mp_m_freemode_01")
  local model = GetEntityModel(ped)
  if model == mpFemaleHash or model == mpMaleHash then
    return true
  end
  return false
end

function Utils.GetPedType(ped)
  local mpFemaleHash = GetHashKey("mp_f_freemode_01")
  local mpMaleHash = GetHashKey("mp_m_freemode_01")
  local model = GetEntityModel(ped)
  if model == mpFemaleHash then
    return "mp_female"
  elseif model == mpMaleHash then
    return "mp_male"
  else
    return "normal"
  end
end

function Utils.IncrimentNumber(type, amount, incAmount, baseIndex, maxIndex)
  local newIndex = baseIndex
  for a = 1, amount do
    if type == "+" then
      newIndex = newIndex + incAmount
      if newIndex > maxIndex then
        newIndex = 0
      end
    elseif type == "-" then
      newIndex = newIndex - incAmount
      if newIndex < 0.0 then
        newIndex = maxIndex
      end
    end
  end
  return newIndex
end