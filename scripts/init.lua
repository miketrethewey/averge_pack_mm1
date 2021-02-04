-- Items
Tracker:AddItems("items/inventory.json")        -- All Inventory items
ScriptHost:LoadScript("scripts/inventory.lua")  -- Inventory Logic

-- Grids
Tracker:AddLayouts("layouts/grids/notes.json")        -- Notes grid
Tracker:AddLayouts("layouts/grids/powerups.json")     -- Powerups grid
Tracker:AddLayouts("layouts/grids/secretworlds.json") -- Secret Worlds grid
Tracker:AddLayouts("layouts/grids/upgrades.json")     -- Upgrades grid
Tracker:AddLayouts("layouts/grids/weapons.json")      -- Weapons grid

Tracker:AddLayouts("layouts/grids/grids.json") -- Combined grid

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
Tracker:AddLocations("locations/indi.json")                   -- Indi
Tracker:AddLocations("locations/edin.json")                   -- Edin
Tracker:AddLocations("locations/ukkinna.json")                -- Ukkin-Na
Tracker:AddLocations("locations/ekurmah.json")                -- E-Kur-Mah
Tracker:AddLocations("locations/maruru.json")                 -- Mar-Uru
--- Secret World Locations
Tracker:AddLocations("locations/secretworld/secret-maruru.json") -- Mar-Uru

if string.find(Tracker.ActiveVariantUID, "items_only") then
  -- Default/Items-Only
  Tracker:AddLayouts("layouts/tracker.json")    -- Main Tracker
  Tracker:AddLayouts("layouts/broadcast.json")  -- Broadcast View
  Tracker:AddLayouts("layouts/capture.json")    -- Capture Grid
end

if string.find(Tracker.ActiveVariantUID, "standard_map") then
  -- Standard with Map
  Tracker:AddLayouts("layouts/maps/sudra.json")                       -- Sudra Map
  Tracker:AddLayouts("variants/standard_map/layouts/tracker.json")    -- Main Tracker
  Tracker:AddLayouts("variants/standard_map/layouts/broadcast.json")  -- Broadcast View
  Tracker:AddLayouts("layouts/capture.json")                          -- Capture Grid
end
