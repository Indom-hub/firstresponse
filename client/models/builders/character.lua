local componentEnum = Enums.Get("PedComponents")
local propEnum = Enums.Get("PedProps")

CharacterBuilder = {}
CharacterBuilder.__index = CharacterBuilder

function CharacterBuilder.New()
  local newCharacterBuilder = {}
  setmetatable(newCharacterBuilder, CharacterBuilder)

  newCharacterBuilder.ped = PlayerPedId()
  newCharacterBuilder.data = {}

  -- Parent Data
  newCharacterBuilder.parents = { father = 0, mother = 0, mix = 0.5 }

  -- Components
  newCharacterBuilder.components = {}
  for k, v in pairs(componentEnum) do
    newCharacterBuilder.components[v] = { drawable = 0, texture = 0 }
  end

  -- Props
  newCharacterBuilder.props = {}
  for k, v in pairs(componentEnum) do
    newCharacterBuilder.props[v] = { drawable = 0, texture = 0 }
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
        return
      end
      Citizen.Wait(0)
    end
    SetPlayerModel(PlayerId(), model)
    self:SetDefaults()
    self.ped = PlayerPedId()
  end)
end

-- Component Methods
function CharacterBuilder:SetComponentDrawable(component, drawable)
  component = componentEnum[component]

  if not component then return end

  local drawableCount = GetNumberOfPedDrawableVariations(self.ped, component) - 1

  if drawable > drawableCount then
    drawable = 0
  elseif drawable < 0 then
    drawable = drawableCount
  end

  SetPedComponentVariation(self.ped, component, drawable, 0, GetPedPaletteVariation(self.ped, component))

  self.components[component].drawable = drawable
  self.components[component].texture = 0
end

function CharacterBuilder:NextComponentDrawable(component)
  component = componentEnum[component]

  if not component then return end

  local drawableCount = GetNumberOfPedDrawableVariations(self.ped, component) - 1
  local currentDrawable = self.components[component].drawable + 1
  if currentDrawable > drawableCount then
    currentDrawable = 0
  end

  SetPedComponentVariation(self.ped, component, currentDrawable, 0, GetPedPaletteVariation(self.ped, component))
  self.components[component].drawable = currentDrawable
  self.components[component].texture = 0
end

function CharacterBuilder:PrevComponentDrawable(component)
  component = componentEnum[component]

  if not component then return end

  local drawableCount = GetNumberOfPedDrawableVariations(self.ped, component) - 1
  local currentDrawable = self.components[component].drawable - 1
  if currentDrawable < 0 then
    currentDrawable = drawableCount
  end

  SetPedComponentVariation(self.ped, component, currentDrawable, 0, GetPedPaletteVariation(self.ped, component))
  self.components[component].drawable = currentDrawable
  self.components[component].texture = 0
end

-- Texture Methods
function CharacterBuilder:SetComponentTexture(component, texture)
  component = componentEnum[component]

  if not component then return end

  local textureCount = GetNumberOfPedTextureVariations(self.ped, component, self.components[component].drawable, texture) - 1

  if texture > textureCount then
    texture = 0
  elseif texture < 0 then
    texture = textureCount
  end
  
  SetPedComponentVariation(self.ped, component, self.components[component], texture, GetPedPaletteVariation(self.ped, component))
  self.components[component].texture = texture
end

function CharacterBuilder:NextComponentTexture(component)
  component = componentEnum[component]

  if not component then return end

  local textureCount = GetNumberOfPedTextureVariations(self.ped, component, self.components[component].drawable, texture) - 1
  local currentTexture = self.components[component].texture + 1

  if currentTexture > textureCount then
    currentTexture = 0
  end

  SetPedComponentVariation(self.ped, component, self.components[component].drawable, currentTexture, GetPedPaletteVariation(self.ped, component))
  self.components[component].texture = currentTexture
end

function CharacterBuilder:PrevComponentTexture(component)
  component = componentEnum[component]

  if not component then return end

  local textureCount = GetNumberOfPedTextureVariations(self.ped, component, self.components[component].drawable, texture) - 1
  local currentTexture = self.components[component].texture - 1

  if currentTexture < 0 then
    currentTexture = textureCount
  end

  SetPedComponentVariation(self.ped, component, self.components[component].drawable, currentTexture, GetPedPaletteVariation(self.ped, component))
  self.components[component].texture = currentTexture
end

-- Prop Methods
function CharacterBuilder:SetProp()

end

function CharacterBuilder:NextProp()

end

function CharacterBuilder:PrevProp()

end

function CharacterBuilder:SetPropTexture()

end

function CharacterBuilder:NextPropTexture()

end

function CharacterBuilder:PrevPropTexture()

end

-- Ped Eye Color
function CharacterBuilder:SetEyeColor()
  if Utils.GetPedType(self.ped) then

  end
end

function CharacterBuilder:SetDefaults()
  SetPedDefaultComponentVariation(PlayerPedId())
end

-- Returns a structured object of character data and returns it
function CharacterBuilder:Build()

end