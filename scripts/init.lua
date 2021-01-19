-- Items
Tracker:AddItems("items/inventory.json") -- All Inventory items

-- Grids
Tracker:AddLayouts("layouts/grids/notes.json") -- Notes grid
Tracker:AddLayouts("layouts/grids/powerups.json") -- Powerups grid
Tracker:AddLayouts("layouts/grids/upgrades.json") -- Upgrades grid
Tracker:AddLayouts("layouts/grids/weapons.json")  -- Weapons grid

Tracker:AddLayouts("layouts/grids/grids.json") -- Combined grid

-- Maps
Tracker:AddMaps("maps/maps.json")

-- Locations
--- Item Locations
Tracker:AddLocations("locations/sudra.json") -- Sudra
Tracker:AddLocations("locations/eribu.json") -- Eribu
Tracker:AddLocations("locations/absu.json")  -- Absu
Tracker:AddLocations("locations/zi.json")    -- Zi
Tracker:AddLocations("locations/kur.json")   -- Kur
--- Secret World Locations
Tracker:AddLocations("locations/secret-maruru.json") -- Mar-Uru

if string.find(Tracker.ActiveVariantUID, "items_only") then
  -- Default/Items-Only
  Tracker:AddLayouts("layouts/tracker.json") -- Main Tracker
  Tracker:AddLayouts("layouts/broadcast.json") -- Broadcast View
end

if string.find(Tracker.ActiveVariantUID, "standard_map") then
  -- Standard with Map
  Tracker:AddLayouts("layouts/maps/sudra.json") -- Sudra Map
  Tracker:AddLayouts("variants/standard_map/layouts/tracker.json") -- Main Tracker
  Tracker:AddLayouts("variants/standard_map/layouts/broadcast.json") -- Broadcast View
end
