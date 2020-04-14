Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

    if IsControlJustPressed(0, 172) then
      Up()
    end

    if IsControlJustPressed(0, 173) then
      Down()
    end

    if IsControlJustPressed(0, 174) then
      Reverse()
    end

    if IsControlJustPressed(0, 175) then
      Forward()
    end
  end
end)

local charBuilder = CharacterBuilder.New()

function Up()
  charBuilder:NextComponentTexture("Shoes")
end

function Down()
  charBuilder:PrevComponentTexture("Shoes")
end

function Reverse()
  charBuilder:PrevComponentDrawable("Shoes")
end

function Forward()
  charBuilder:NextComponentDrawable("Shoes")
end

local characterData = charBuilder:Build()

-- Component Natives
-- SetPedComponentVariation(ped, componentId, drawableId, textureId, paletteId)
-- GetNumberOfPedDrawableVariations(ped, componentId)
-- GetNumberOfPedTextureVariations(ped, componentId, drawableId)
-- GetPedPaletteVariation(ped, componentId)
-- GetPedDrawableVariation(ped, componentId)
-- GetPedTextureVariation(ped, componentId)

-- Prop Natives
-- SetPedPropIndex(ped, componentId, drawableId, textureId, attach)
-- GetPedPropIndex(ped, componentId)
-- GetNumberOfPedPropDrawableVariations(ped, propId)
-- GetNumberOfPedPropTextureVariations(ped, propId, drawableId)

-- MP Character Specifics
-- SetPedEyeColor(ped, index)
-- GetPedEyeColor(ped)
-- SetPedFaceFeature(ped, index, scale)
-- GetPedFaceFeature(ped, index)
-- SetPedHeadOverlay(ped, overlayID, index, opacity)
-- SetPedHeadOverlayColor(ped, overlayID, colorType, colorID, secondColorID)
-- GetPedHeadOverlayData(ped, index)
-- GetPedHeadOverlayValue(ped, overlayID)
-- SetPedHeadBlendData(ped, shapeFirstID, shapeSecondID, shapeThirdID, skinFirstID, skinSecondID, skinThirdID, shapeMix, skinMix, thirdMix, isParent)
-- GetPedHeadBlendData(ped, headBlendData)