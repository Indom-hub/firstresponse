local componentEnum = Enums.Get("PedComponents")
local propEnum = Enums.Get("PedProps")

CharacterBuilder = {}
CharacterBuilder.__index = CharacterBuilder

function CharacterBuilder.New()
  local newCharacterBuilder = {}
  setmetatable(newCharacterBuilder, CharacterBuilder)

  newCharacterBuilder.ped = PlayerPedId()
  newCharacterBuilder.data = {}
  newCharacterBuilder.parents = {}
  newCharacterBuilder.components = {}
  newCharacterBuilder.props = {}

  for k, v in pairs(componentEnum) do
    newCharacterBuilder.components[k] = { drawable = 0, texture = 0 }
  end

  for k, v in pairs(componentEnum) do
    newCharacterBuilder.props[k] = { drawable = 0, texture = 0 }
  end

  return newCharacterBuilder
end

function CharacterBuilder:SetModel(model)
  model = GetHashKey(model)
  local timeStart = GetGameTimer()
  local timeOffset = 5000
  local success = false
  Citizen.CreateThread(function()
    RequestModel(model)
    while not HasModelLoaded(model) do
      if (timeStart + timeOffset) < GetGameTimer() then
        print("[FirstResponse]: COULDN'T LOAD PLAYER MODEL")
        return
      end
      Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    self:SetDefaults()
    self.ped = PlayerPedId()
  end)
end

function CharacterBuilder:SetComponentIndex(component, index)
  local drawableCount = GetNumberOfPedDrawableVariations(self.ped, component)
  if index > drawableCount or index < 0 then
    index = 0
  end
  SetPedComponentVariation(self.ped, component, index, 0, GetPedPaletteVariation(ped, component))
end

function CharacterBuilder:NextComponent()

end

function CharacterBuilder:PrevComponent()

end

function CharacterBuilder:SetComponentTexture()

end

function CharacterBuilder:NextComponentTexture()

end

function CharacterBuilder:PrevComponentTexture()

end

function CharacterBuilder:SetPropIndex()

end

function CharacterBuilder:SetPropTexture()

end

function CharacterBuilder:SetEyeColor()

end

function CharacterBuilder:SetDefaults()
  SetPedDefaultComponentVariation(PlayerPedId())
end

-- Returns a structured object of character data and returns it
function CharacterBuilder:Build()

end