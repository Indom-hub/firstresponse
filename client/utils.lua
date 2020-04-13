Utils = {}

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