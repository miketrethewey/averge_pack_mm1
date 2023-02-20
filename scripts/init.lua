-- Version
ScriptHost:LoadScript("scripts/ver.lua")

local variant = Tracker.ActiveVariantUID
if variant == "" then
  variant = "items_only"
end

-- Items
print("Loading Items")
Tracker:AddItems("items/inventory.json")        -- All Inventory items

-- Story Markers
Tracker:AddItems("items/storymarkers.json")     -- Story Markers

-- Extras
Tracker:AddItems("items/extras.json")           -- Extra items

-- Custom Items
ScriptHost:LoadScript("scripts/items/class.lua")        -- Class Helper class
ScriptHost:LoadScript("scripts/items/custom_item.lua")  -- Custom Item Helper class
ScriptHost:LoadScript("scripts/items/gomode.lua")       -- Go Mode

-- Inventory Logic
ScriptHost:LoadScript("scripts/inventory.lua")
print("")

-- Grids
print("Loading Grids")
Tracker:AddLayouts("layouts/grids/upgrades.json")     -- Upgrades grid
Tracker:AddLayouts("layouts/grids/weapons.json")      -- Weapons grid

Tracker:AddLayouts("layouts/grids/grids.json") -- Combined grid
print("")

if string.find(variant, "map") then
  print("Map Variant; load map stuff")

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
  print("")
else
  -- Legacy
  print("Satisfy Legacy Loads")
  Tracker:AddMaps("maps/maps.json")
  Tracker:AddLocations("locations/sudra.json")
  print("")
end

if variant == "standard_map" then
  print("Load extra map stuff")
  -- Standard with Map
  -- Settings Popup
  Tracker:AddItems("items/settings.json")
  Tracker:AddLayouts("variants/" .. variant .. "/layouts/settings.json")

  Tracker:AddLayouts("layouts/maps/sudra.json") -- Sudra Map
  Tracker:AddLayouts("layouts/capture.json")    -- Capture Grid
  print("")
end

if variant ~= "items_only" then
  print("Loading Variant")
  -- Layout Overrides
  Tracker:AddLayouts("variants/" .. variant .. "/layouts/tracker.json")   -- Main Tracker
  Tracker:AddLayouts("variants/" .. variant .. "/layouts/broadcast.json") -- Broadcast View
  print("")
else
  print("Not a Variant; load default stuff")
  -- Layout Defaults
  Tracker:AddLayouts("layouts/tracker.json")
  Tracker:AddLayouts("layouts/broadcast.json")
end
