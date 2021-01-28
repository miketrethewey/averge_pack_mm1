function has(code, level)
  if level == nil then
    level = 1
  end

  local num = Tracker:ProviderCountForCode(code)
  if num >= level then
    return 1
  else
    return 0
  end
end

function canTeleportDrone()
  if has("remotedrone") and has("droneteleport") then
    return 1
  else
    return 0
  end
end

function canEnhancedDroneLaunch()
  if has("remotedrone") and has("enhanceddronelaunch") then
    return 1
  else
    return 0
  end
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