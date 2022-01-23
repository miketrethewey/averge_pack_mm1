-- Instantiate Item
GoModeItem = class(CustomItem)

-- Initialize Item
function GoModeItem:init(name, code, imagePath)
    self:createItem(name)
    self.code = {}
    self.code[code]=true
    self:setProperty("active", false)
    self.activeImage = ImageReference:FromPackRelativePath(imagePath)
    self.disabledImage = ImageReference:FromImageReference(self.activeImage, "@disabled")
    self.ItemInstance.PotentialIcon = self.activeImage

    self:updateIcon()
end

-- Set state to Active
function GoModeItem:setActive(active)
    self:setProperty("active", active)
end

-- Get if it's In/Active
function GoModeItem:getActive()
    return self:getProperty("active")
end

-- Update Icon
function GoModeItem:updateIcon()
    if self:getActive() then
        self.ItemInstance.Icon = self.activeImage
    else
        self.ItemInstance.Icon = self.disabledImage
    end
end

-- OnLeftClick: Toggle
function GoModeItem:onLeftClick()
    self:setActive(not self:getActive())
end

-- OnRightClick: Use Left Click
function GoModeItem:onRightClick()
    self:onLeftClick()
end

-- True if code is present
function GoModeItem:canProvideCode(code)
    if self.code[code] ~= nil then
        return true
    else
        return false
    end
end

-- True if code is present and item is active
function GoModeItem:providesCode(code)
    if self.code[code]~=nil and self:getActive() then
        return 1
    end
    return 0
end

-- Add code to item
function GoModeItem:addCode(code)
    self.code[code] = true
end
-- Remove code from item
function GoModeItem:removeCode(code)
    self.code[code] = nil
end

function GoModeItem:advanceToCode(code)
    if code == nil or self.code[code] ~= nil then
        self:setActive(true)
    end
end

-- Save state
function GoModeItem:save()
    local saveData = {}
    saveData["active"] = self:getActive()
    return saveData
end

-- Load state
function GoModeItem:load(data)
    if data["active"] ~= nil then
        self:setActive(data["active"])
    end
    return true
end

-- Update icon if property is changed
function GoModeItem:propertyChanged(key, value)
    self:updateIcon()
end

local GoModeAuto = GoModeItem(
  "GoMode",
  "gomode-auto",
  "images/extras/gomode.png"
)

function tracker_on_accessibility_updated()
    if canGoMode() == 1 then
        GoModeAuto:setActive(true)
    end
end
