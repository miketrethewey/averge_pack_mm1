function hasAmount(code)
  local num = Tracker:ProviderCountForCode(code)
  return num
end

function has(code, level)
  if level == nil then
    level = 1
  end
  return hasAmount(code) >= level
end

-- Drone
function canUseRemoteDrone()
  return has("remotedrone")
end
-- Drone && Teleport
function canDroneTeleport()
  return canUseRemoteDrone() and has("droneteleport")
end
-- Drone && Enhanced Drone Launch
function canEnhancedDroneLaunch()
  return canUseRemoteDrone() and has("enhanceddronelaunch")
end

-- Long Range
function canShootLong()
  return has("rangelong")
end
-- Medium or Long Range
function canShootMedium()
  return canShootLong() or has("rangemedium")
end
-- Short or Medium or Long Range
function canShootShort()
  return canShootLong() or canShootMedium() or has("rangeshort")
end

-- Big Glitch
function canGlitchBomb()
  return has("addressbomb")
end
-- Glitch Gun 2 or Address Bomb
function canGlitchGun2()
  return has("addressdisruptor2") or canGlitchBomb()
end
-- Glich Gun 1 or Glitch Gun 2 or Address Bomb
function canGlitchGun1()
  return has("addressdisruptor1") or canGlitchGun2()
end

-- Airport 3
function canAirport3()
  return has("airport3")
end
-- Airport 2 or 3
function canAirport2()
  return has("airport2") or canAirport3()
end
-- Airport 1, 2 or 3
function canAirport1()
  return has("airport1") or canAirport2()
end

-- Teleport 3 or Airport 3
function canTeleport3()
  return has("teleport3") or canAirport3()
end
-- Teleport 2 or 3 or Airport 2 or 3
function canTeleport2()
  return has("teleport2") or canAirport2() or canTeleport3()
end
-- Teleport 1, 2 or 3 or Airport 1 or 2 or 3
function canTeleport1()
  return has("teleport1") or canAirport1() or canTeleport2()
end

-- Logic for GoMode activation
function canGoMode()
  -- Default/Advanced
  --  Red Coat
  --  Remote Drone
  --  Enhanced Drone Launch
  --  Remote Drone Teleport
  if
    (
      has("progdefault") or
      has("progadvanced") or
      has("progmasochist")
    ) and
    canAirport3() and
    canEnhancedDroneLaunch() and
    canDroneTeleport()
    then
    return 1
  end

  -- Maso
  --  Red Coat
  --  Field Disruptor (Hi-Jump Boots)
  --  Grapple
  if
    (
      has("progmasochist")
    ) and
    canAirport3() and
    has("fielddisruptor") and
    has("grapple")
    then
    return 1
  end

  return 0
end
