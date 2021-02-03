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

function canUseRemoteDrone()
  return has("remotedrone")
end

function canDroneTeleport()
  return canUseRemoteDrone() and has("droneteleport")
end

function canEnhancedDroneLaunch()
  return canUseRemoteDrone() and has("enhanceddronelaunch")
end

function canShootLong()
  return has("rangelong")
end

function canShootMedium()
  return canShootLong() or has("rangemedium")
end

function canShootShort()
  return canShootLong() or canShootMedium() or has("rangeshort")
end

function canAirport3()
  return has("airport3")
end
function canAirport2()
  return has("airport2") or canAirport3()
end
function canAirport1()
  return has("airport1") or canAirport2()
end

function canTeleport3()
  return has("teleport3") or canAirport3()
end
function canTeleport2()
  return has("teleport2") or canAirport2() or canTeleport3()
end
function canTeleport1()
  return has("teleport1") or canAirport1() or canTeleport2()
end
