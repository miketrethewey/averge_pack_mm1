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
