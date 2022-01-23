-- Version
ScriptHost:LoadScript("scripts/ver.lua")

-- Items
Tracker:AddItems("items/inventory.json")        -- All Inventory items

-- Story Markers
Tracker:AddItems("items/storymarkers.json")     -- Story Markers

-- Extras
Tracker:AddItems("items/extras.json")           -- Extra items

-- Custom Items
print("")
print("Loading Custom Items:")
ScriptHost:LoadScript("scripts/items/class.lua")        -- Class Helper class
ScriptHost:LoadScript("scripts/items/custom_item.lua")  -- Custom Item Helper class
ScriptHost:LoadScript("scripts/items/gomode.lua")       -- Go Mode

-- Grids
Tracker:AddLayouts("layouts/grids/upgrades.json")     -- Upgrades grid
Tracker:AddLayouts("layouts/grids/weapons.json")      -- Weapons grid

Tracker:AddLayouts("layouts/grids/grids.json") -- Combined grid

if string.find(Tracker.ActiveVariantUID, "map") then
  -- Inventory Logic
  print("")
  print("Loading Inventory Logic:")
  ScriptHost:LoadScript("scripts/inventory.lua")

  -- Grids
  Tracker:AddLayouts("layouts/grids/notes.json")        -- Notes grid
  Tracker:AddLayouts("layouts/grids/powerups.json")     -- Powerups grid
  Tracker:AddLayouts("layouts/grids/secretworlds.json") -- Secret Worlds grid

  -- Maps
  Tracker:AddMaps("maps/maps.json")

  -- Locations
  --- Item Locations

  print("")
  print("Loading Item Location Data:")
  for _,area in ipairs({
    "sudra",
    "eribu",
    "absu",
    "zi",
    "kur",
    "indi",
    "ukkinna",
    "edin",
    "ekurmah",
    "maruru"
  }) do
    for _,filename in ipairs({
      "locations/" .. area .. ".json",                    -- Area
      "locations/inter/inter-" .. area .. ".json",        -- Inter-Area
      "locations/saves/saves-" .. area .. ".json",        -- Saves-Area
      "locations/secretworld/secret-" .. area .. ".json"  -- Secret-Area
    }) do
      Tracker:AddLocations(filename)
    end
  end
end

print("")
print("Loading Variant Data:")
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
