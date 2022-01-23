-- Version
ScriptHost:LoadScript("scripts/ver.lua")

-- Items
Tracker:AddItems("items/inventory.json")        -- All Inventory items

-- Story Markers
Tracker:AddItems("items/storymarkers.json")     -- Story Markers

-- Extras
Tracker:AddItems("items/extras.json")           -- Extra items

-- Custom Items
ScriptHost:LoadScript("scripts/items/class.lua")        -- Class Helper class
ScriptHost:LoadScript("scripts/items/custom_item.lua")  -- Custom Item Helper class
ScriptHost:LoadScript("scripts/items/gomode.lua")       -- Go Mode

-- Grids
Tracker:AddLayouts("layouts/grids/upgrades.json")     -- Upgrades grid
Tracker:AddLayouts("layouts/grids/weapons.json")      -- Weapons grid

Tracker:AddLayouts("layouts/grids/grids.json") -- Combined grid

if string.find(Tracker.ActiveVariantUID, "map") then
  -- Inventory Logic
  ScriptHost:LoadScript("scripts/inventory.lua")

  -- Grids
  Tracker:AddLayouts("layouts/grids/notes.json")        -- Notes grid
  Tracker:AddLayouts("layouts/grids/powerups.json")     -- Powerups grid
  Tracker:AddLayouts("layouts/grids/secretworlds.json") -- Secret Worlds grid

  -- Maps
  Tracker:AddMaps("maps/maps.json")

  -- Locations
  --- Item Locations
  Tracker:AddLocations("locations/sudra.json")                  -- Sudra
  Tracker:AddLocations("locations/inter/inter-sudra.json")      -- Inter-Sudra
  Tracker:AddLocations("locations/eribu.json")                  -- Eribu
  Tracker:AddLocations("locations/inter/inter-eribu.json")      -- Inter-Eribu
  Tracker:AddLocations("locations/absu.json")                   -- Absu
  Tracker:AddLocations("locations/inter/inter-absu.json")       -- Inter-Absu
  Tracker:AddLocations("locations/zi.json")                     -- Zi
  Tracker:AddLocations("locations/inter/inter-zi.json")         -- Inter-Zi
  Tracker:AddLocations("locations/kur.json")                    -- Kur
  Tracker:AddLocations("locations/inter/inter-kur.json")        -- Inter-Kur
  Tracker:AddLocations("locations/indi.json")                   -- Indi
  Tracker:AddLocations("locations/inter/inter-ukkinna.json")    -- Inter-Ukkin-Na
  Tracker:AddLocations("locations/ukkinna.json")                -- Ukkin-Na
  Tracker:AddLocations("locations/edin.json")                   -- Edin
  Tracker:AddLocations("locations/ekurmah.json")                -- E-Kur-Mah
  Tracker:AddLocations("locations/maruru.json")                 -- Mar-Uru
  --- Secret World Locations
  Tracker:AddLocations("locations/secretworld/secret-maruru.json") -- Mar-Uru
end

if Tracker.ActiveVariantUID == "items_only" then
  -- Default/Items-Only
  Tracker:AddLayouts("variants/" .. Tracker.ActiveVariantUID .. "/layouts/tracker.json")    -- Main Tracker
  Tracker:AddLayouts("variants/" .. Tracker.ActiveVariantUID .. "/layouts/broadcast.json")  -- Broadcast View
end

if Tracker.ActiveVariantUID == "standard_map" then
  -- Standard with Map
  -- Settings Popup
  Tracker:AddItems("items/settings.json")
  Tracker:AddLayouts("variants/" .. Tracker.ActiveVariantUID .. "/layouts/settings.json")

  Tracker:AddLayouts("layouts/maps/sudra.json")                                             -- Sudra Map
  Tracker:AddLayouts("variants/" .. Tracker.ActiveVariantUID .. "/layouts/tracker.json")    -- Main Tracker
  Tracker:AddLayouts("variants/" .. Tracker.ActiveVariantUID .. "/layouts/broadcast.json")  -- Broadcast View
  Tracker:AddLayouts("layouts/capture.json")                                                -- Capture Grid
end
