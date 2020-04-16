local componentEnum = Enums.Get("PedComponents")
local propEnum = Enums.Get("PedProps")

CharacterBuilder = {}
CharacterBuilder.__index = CharacterBuilder

-- Character Builder Default
function CharacterBuilder.New()
  local newCharacterBuilder = {}
  setmetatable(newCharacterBuilder, CharacterBuilder)

  newCharacterBuilder.ped = PlayerPedId()
  newCharacterBuilder.data = {
    eyeColor = 0
  }

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

-- Character Builder Ped Model Settings
function CharacterBuilder.FromPed(ped, data)
  local newCharacterBuilder = {}
  setmetatable(newCharacterBuilder, CharacterBuilder)

  newCharacterBuilder.ped = PlayerPedId()
  newCharacterBuilder.data = {
    eyeColor = 0
  }

  -- Data Overrides
  for k, v in pairs(data) do
    newCharacterBuilder.data[k] = v
  end

  -- Parent Data
  newCharacterBuilder.parents = { father = 0, mother = 0, mix = 0.5 }

  -- Components
  newCharacterBuilder.components = {}
  for _, v in pairs(componentEnum) do
    local currentDrawable = GetPedDrawableVariation(newCharacterBuilder.ped, v)
    local currentTexture = GetPedTextureVariation(newCharacterBuilder.ped, v)
    newCharacterBuilder.components[v] = { drawable = currentDrawable, texture = currentTexture }
  end

  -- Props
  newCharacterBuilder.props = {}
  for _, v in pairs(propEnum) do
    local currentProp = GetPedPropIndex(newCharacterBuilder.ped, v)
    local currentTexture = GetPedPropTextureIndex(newCharacterBuilder.ped, v)
    newCharacterBuilder.props[v] = { prop = currentProp, texture = currentTexture }
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
-- function CharacterBuilder:SetPropDrawable(prop, drawable)
--   prop = propEnum[prop]

--   if not prop then return end

--   local propCount = GetNumberOfPedPropDrawableVariations(self.ped, prop) - 1
--   local currentProp = self.props[prop].drawable

--   if drawable < 0 then
--     currentProp = propCount
--   elseif drawable > propCount then
--     currentProp = 0
--   end

--   SetPedPropIndex(self.ped, prop, drawable, 0, true)
--   self.props[prop].drawable = currentProp
--   self.props[prop].texture = 0
-- end

function CharacterBuilder:SetPropDrawable(prop, value)
  prop = propEnum[prop]

  if not prop then return end

  local propCount = GetNumberOfPedPropDrawableVariations(self.ped, prop) - 1
  local currentProp = self.props[prop].drawable

  if type(value) == "number" then
    
    if value > propCount then
      value = 0
    elseif value < 0 then
      value = propCount
    end

    SetPedPropIndex(self.ped, prop, value, 0, true)
    self.props[prop].drawable = value
    self.props[prop].texture = 0
  elseif type(value) == "string" then
    local type = "+"
    local incrimental = 0

    if string.match(value, "+") then
      type = "+"
    elseif string.match(value, "-") then
      type = "-"
    end

    incrimental = tonumber(value:gsub(type, ""))

    local newProp = Utils.IncrimentNumber(type, incrimental, currentProp, propCount)
    SetPedPropIndex(self.ped, prop, newProp, 0, true)
    self.props[prop].drawable = newProp
    self.props[prop].texture = 0
  end
end

function CharacterBuilder:SetPropTexture()

end

function CharacterBuilder:NextPropTexture()

end

function CharacterBuilder:PrevPropTexture()

end

-- Ped Eye Color
function CharacterBuilder:SetEyeColor()
  if Utils.IsMPPed(self.ped) then
    
  end
end

function CharacterBuilder:NextEyeColor()
  if Utils.IsMPPed(self.ped) then

  end
end

function CharacterBuilder:PrevEyeColor()
  if Utils.IsMPPed(self.ped) then

  end
end

function CharacterBuilder:SetDefaults()
  SetPedDefaultComponentVariation(PlayerPedId())
end

-- Returns a structured object of character data and returns it
function CharacterBuilder:Build()

end