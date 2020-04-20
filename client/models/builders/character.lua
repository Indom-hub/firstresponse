local componentEnum = Enums.Get("PedComponents")
local propEnum = Enums.Get("PedProps")
local faceFeaturesEnum = Enums.Get("PedFaceFeatures")

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

  -- Face Features
  newCharacterBuilder.facefeatures = {}
  for k, v in pairs(faceFeaturesEnum) do
    newCharacterBuilder.facefeatures[v] = 0.0
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

-- Set Model Method
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
function CharacterBuilder:SetComponentDrawable(component, value)
  component = componentEnum[component]

  if not component then return end

  local drawableCount = GetNumberOfPedDrawableVariations(self.ped, component) - 1
  local currentDrawable = self.components[component].drawable

  if type(value) == "number" then
    
    if value > drawableCount then
      value = 0
    elseif value < 0 then
      value = drawableCount
    end

    SetPedComponentVariation(self.ped, component, value, 0, GetPedPaletteVariation(self.ped, component))
    self.components[component].drawable = value
    self.components[component].texture = 0
  elseif type(value) == "string" then
    local incType = "+"
    local incrimental = 0

    if string.match(value, "+") then
      incType = "+"
    elseif string.match(value, "-") then
      incType = "-"
    end

    local stringNumber = value:gsub(incType, "")

    incrimental = tonumber(stringNumber)

    local newDrawable = Utils.IncrimentNumber(incType, incrimental, 1, currentDrawable, 0, drawableCount)
    SetPedComponentVariation(self.ped, component, newDrawable, 0, GetPedPaletteVariation(self.ped, component))
    self.components[component].drawable = newDrawable
    self.components[component].texture = 0
  end
end

function CharacterBuilder:SetComponentTexture(component, value)
  component = componentEnum[component]

  if not component then return end

  local textureCount = GetNumberOfPedTextureVariations(self.ped, component, self.components[component].drawable) - 1
  local currentTexture = self.components[component].texture

  if type(value) == "number" then

    if value > textureCount then
      value = 0
    elseif value < 0 then
      value = textureCount
    end

    SetPedComponentVariation(self.ped, component, self.components[component].drawable, value, GetPedPaletteVariation(self.ped, component))
    self.components[component].texture = value
  elseif type(value) == "string" then
    local incType = "+"
    local incrimental = 0

    if string.match(value, "+") then
      incType = "+"
    elseif string.match(value, "-") then
      incType = "-"
    end

    local stringNumber = value:gsub(incType, "")

    incrimental = tonumber(stringNumber)

    local newTexture = Utils.IncrimentNumber(incType, incrimental, 1, currentTexture, 0, textureCount)
    SetPedComponentVariation(self.ped, component, self.components[component].drawable, newTexture, GetPedPaletteVariation(self.ped, component))
    self.components[component].texture = newTexture
  end
end

-- Prop Methods
function CharacterBuilder:SetPropDrawable(prop, value)
  prop = propEnum[prop]

  if not prop then return end

  local drawableCount = GetNumberOfPedPropDrawableVariations(self.ped, prop) - 1
  local currentProp = self.props[prop].drawable

  if type(value) == "number" then
    
    if value > drawableCount then
      value = 0
    elseif value < 0 then
      value = drawableCount
    end

    SetPedPropIndex(self.ped, prop, value, 0, true)
    self.props[prop].drawable = value
    self.props[prop].texture = 0
  elseif type(value) == "string" then
    local incType = "+"
    local incrimental = 0

    if string.match(value, "+") then
      incType = "+"
    elseif string.match(value, "-") then
      incType = "-"
    end

    
    local stringNumber = value:gsub(incType, "")

    incrimental = tonumber(stringNumber)

    local newDrawable = Utils.IncrimentNumber(incType, incrimental, 1, currentProp, 0, drawableCount)
    SetPedPropIndex(self.ped, prop, newDrawable, 0, true)
    self.props[prop].drawable = newDrawable
    self.props[prop].texture = 0
  end
end

function CharacterBuilder:SetPropTexture(prop, value)
  prop = propEnum[prop]

  if not prop then return end

  local textureCount = GetNumberOfPedTextureVariations(self.ped, prop, self.props[prop].drawable) - 1
  local currentTexture = self.props[prop].texture

  if type(value) == "number" then

    if value > textureCount then
      value = 0
    elseif value < 0 then
      value = textureCount
    end

    SetPedPropIndex(self.ped, prop, self.props[prop].drawable, value, true)
    self.props[prop].texture = value
  elseif type(value) == "string" then
    local incType = "+"
    local incrimental = 0

    if string.match(value, "+") then
      incType = "+"
    elseif string.match(value, "-") then
      incType = "-"
    end

    local stringNumber = value:gsub(incType, "")

    incrimental = tonumber(stringNumber)

    local newTexture = Utils.IncrimentNumber(incType, incrimental, 1, currentTexture, 0, textureCount)
    SetPedPropIndex(self.ped, prop, self.props[prop].drawable, newTexture, true)
    self.props[prop].texture = value
  end
end

-- Ped Eye Color
function CharacterBuilder:SetEyeColor(color, value)
  if Utils.IsMPPed(self.ped) then
    local eyeColorCount = 32
    local currentEyeColor = GetPedEyeColor(self.ped)

    if type(value) == "number" then
      if value > eyeColorCount then
        value = 0
      elseif value < 0 then
        value = eyeColorCount
      end

      SetPedEyeColor(self.ped, value)
      self.data.eyeColor = value
    elseif type(value) == "string" then
      local incType = "+"
      local incrimental = 0

      if string.match(value, "+") then
        incType = "+"
      elseif string.match(value, "-") then
        incType = "-"
      end

      local stringNumber = value:gsub(incType, "")

      incrimental = tonumber(stringNumber)

      local newEyeColor = Utils.IncrimentNumber(incType, incrimental, 1, currentEyeColor, 0, eyeColorCount)
      SetPedEyeColor(self.ped, newEyeColor)
      self.data.eyeColor = newEyeColor
    end
  end
end

-- Ped Face Feature
function CharacterBuilder:SetFaceFeature(feature, value)
  if Utils.IsMPPed(self.ped) then
    feature = faceFeaturesEnum[feature]

    if not feature then return end

    local currentRange = self.facefeatures[feature]

    if type(value) == "number" then

      if value > 1.0 then
        value = 0.0
      elseif value < 0.0 then
        value = 1.0
      end

      SetPedFaceFeature(self.ped, feature, value)
      self.facefeatures[feature] = value
    elseif type(value) == "string" then
      local incType = "+"
      local incrimental = 0

      if string.match(value, "+") then
        incType = "+"
      elseif string.match(value, "-") then
        incType = "-"
      end

      local stringNumber = value:gsub(incType, "")

      incrimental = tonumber(stringNumber)

      local newRange = Utils.IncrimentNumber(incType, incrimental, 10, currentRange * 100, -100, 100) / 100
      SetPedFaceFeature(self.ped, feature, newRange)
      self.facefeatures[feature] = newRange
    end
  end
end

-- Set Head Blend
function CharacterBuilder:SetHeadBlend_Parents(type, value)
  if Utils.IsMPPed(self.ped) then

  end
end

function CharacterBuilder:SetHeadBlend_Mix(value)
  if Utils.IsMPPed(self.ped) then
    
  end
end

-- Set Head Overlay

-- Set Head Overlay Color

-- Sets Ped Defaults
function CharacterBuilder:SetDefaults()
  SetPedDefaultComponentVariation(self.ped)

  -- Sets Components
  for _, v in pairs(componentEnum) do
    local currentDrawable = GetPedDrawableVariation(self.ped, v)
    local currentTexture = GetPedTextureVariation(self.ped, v)
    self.components[v] = { drawable = currentDrawable, texture = currentTexture }
  end

  -- Sets Props
  for _, v in pairs(propEnum) do
    local currentProp = GetPedPropIndex(self.ped, v)
    local currentTexture = GetPedPropTextureIndex(self.ped, v)
    self.props[v] = { prop = currentProp, texture = currentTexture }
  end

  -- Sets Eye Color
  self.data.eyeColor = GetPedEyeColor(self.ped)
end

-- Returns a structured object of character data and returns it
function CharacterBuilder:Build()
  return {
    data = self.data,
    parents = self.parents,
    components = self.components,
    props = self.props
  }
end