-- Version
ScriptHost:LoadScript("scripts/ver.lua")

local variant = Tracker.ActiveVariantUID
if variant == "" then
  variant = "items_only"
end

function inTable(tbl, item)
  for k,v in pairs(tbl) do
    if v == item then return k end
  end
  return false
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
Tracker:AddLayouts("layouts/grids/secretworlds.json")

Tracker:AddLayouts("layouts/grids/grids.json") -- Combined grid
print("")

if string.find(variant, "map") then
  print("Map Variant; load map stuff")

  -- Grids
  print("Loading Grids")
  Tracker:AddLayouts("layouts/grids/notes.json")        -- Notes grid
  Tracker:AddLayouts("layouts/grids/powerups.json")     -- Powerups grid
  Tracker:AddLayouts("layouts/grids/secretworlds.json") -- Secret Worlds grid

  -- Maps
  print("Loading Maps")
  Tracker:AddMaps("maps/maps.json")

  -- Locations
  --- Item Locations
  print("Loading Locations")
  dir = ""
  regions = {
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
  }
  for _, region in ipairs(regions) do
    Tracker:AddLocations("locations/" .. region .. ".json")
    if not inTable({
      "edin",
      "ekurmah",
      "indi",
      "maruru"
    }, region) then
      Tracker:AddLocations("locations/inter/inter-" .. region .. ".json")
    end
  end

  --- Secret World Locations
  print("Loading Secret World Locations")
  for _, region in ipairs(regions) do
    if not inTable({
      "sudra"
    }, region) then
      Tracker:AddLocations("locations/secretworld/secret-" .. region .. ".json")
    end
  end
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
  Tracker:AddLayouts("variants/" .. variant .. "/layouts/tracker-horizontal.json")  -- Horizontal Tracker
  Tracker:AddLayouts("variants/" .. variant .. "/layouts/tracker-vertical.json")    -- Vertical Tracker
  Tracker:AddLayouts("variants/" .. variant .. "/layouts/tracker.json")             -- Main Tracker
  Tracker:AddLayouts("variants/" .. variant .. "/layouts/broadcast.json")           -- Broadcast View
  print("")
else
  print("Not a Variant; load default stuff")
  -- Layout Defaults
  Tracker:AddLayouts("layouts/tracker-horizontal.json") -- Horizontal Tracker
  Tracker:AddLayouts("layouts/tracker-vertical.json")   -- Vertical Tracker
  Tracker:AddLayouts("layouts/tracker.json")            -- Main Tracker
  Tracker:AddLayouts("layouts/broadcast.json")          -- Broadcast View
end
