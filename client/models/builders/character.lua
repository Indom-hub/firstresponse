-- Enums
local componentEnum = Enums.Get("PedComponents")
local propEnum = Enums.Get("PedProps")
local faceFeaturesEnum = Enums.Get("PedFaceFeatures")
local overlays = Enums.Get("PedOverlays")

-- Vars
local overlayColorTypes = { 
  [1] = { 2, 1, 10 },
  [2] = { 5, 8 }
}

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

  -- Overlays
  newCharacterBuilder.overlays = {}
  for k1, v1 in pairs(overlays) do
    newCharacterBuilder.overlays[v1] = { index = 0, opacity = 0.0 }

    for k2, v2 in pairs(overlayColorTypes) do
      for a = 1, #v2 do
        if v2[a] == v1 then
          newCharacterBuilder.overlays[v1].color = 0
          newCharacterBuilder.overlays[v1].colortwo = 0
        end
      end
    end
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

  -- Overlays
  newCharacterBuilder.overlays = {}
  for k1, v1 in pairs(overlays) do
    newCharacterBuilder.overlays[v1] = { index = 0, opacity = 0.0 }

    for k2, v2 in pairs(overlayColorTypes) do
      for a = 1, #v2 do
        if v2[a] == v1 then
          newCharacterBuilder.overlays[v1].color = 0
          newCharacterBuilder.overlays[v1].colortwo = 0
        end
      end
    end
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

-- Set Head Blend newCharacterBuilder.parents = { father = 0, mother = 0, mix = 0.5 }
function CharacterBuilder:SetHeadBlendParents(parent, value)
  if Utils.IsMPPed(self.ped) then
    if type(parent) ~= "string" then return end
    if parent ~= "mother" and parent ~= "father" then return end
  
    parent = parent:lower()

    if type(value) == "number" then
      if value > 46 then
        value = 0
      elseif value < 0 then
        value = 46
      end

      self.parents[parent] = value
      SetPedHeadBlendData(self.ped, self.parents.father, self.parents.mother, 0, self.parents.father, self.parents.mother, 0, self.parents.mix, self.parents.mix, self.parents.mix, false)
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

      local newParent = Utils.IncrimentNumber(incType, incrimental, 1, self.parents[parent], 0, 46)
      self.parents[parent] = newParent

      print(json.encode(self.parents))

      SetPedHeadBlendData(self.ped, self.parents.father, self.parents.mother, 0, self.parents.father, self.parents.mother, 0, self.parents.mix, self.parents.mix, self.parents.mix, false)
    end
  end
end

function CharacterBuilder:SetHeadBlendMix(value)
  if Utils.IsMPPed(self.ped) then
    if type(value) == "number" then
      if value > 1.0 then
        value = 0.0
      elseif value < 0.0 then
        value = 1.0
      end
      self.parents.mix = value
      SetPedHeadBlendData(self.ped, self.parents.father, self.parents.mother, 0, self.parents.father, self.parents.mother, 0, self.parents.mix, self.parents.mix, self.parents.mix, false)
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

      local newRange = Utils.IncrimentNumber(incType, incrimental, 10, self.parents.mix * 100, 0, 100) / 100
      self.parents.mix = newRange
      SetPedHeadBlendData(self.ped, self.parents.father, self.parents.mother, 0, self.parents.father, self.parents.mother, 0, self.parents.mix, self.parents.mix, self.parents.mix, false)
    end

    print(json.encode(self.parents))
  end
end

-- Set Head Overlay
function CharacterBuilder:SetHeadOverlay(overlay, value)
  if Utils.IsMPPed(self.ped) then
    
  end
end

-- Set Head Overlay Color
function CharacterBuilder:SetHeadOverlayColor(overlay, value)
  if Utils.IsMPPed(self.ped) then

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
      print(self.facefeatures[feature])
    end
  end
end

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