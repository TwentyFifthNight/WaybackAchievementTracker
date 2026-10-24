
local AchievementConfig = require("achievement_config")

local function Log(message)
    print("[AchievementTracker] " .. tostring(message))
end

local function SafeGetFullName(obj)
    local ok, result = pcall(function()
        return obj:GetFullName()
    end)

    if ok then
        return tostring(result)
    end

    return "<unknown object>"
end

local function SafeGetProperty(obj, propertyName)
    local ok, value = pcall(function()
        return obj:GetPropertyValue(propertyName)
    end)

    if not ok then
        return false, "Could not read property: " .. tostring(value)
    end

    return true, value
end

local function FormatValue(value)
    if value == nil then
        return "nil"
    end

    if type(value) == "boolean" then
        return value and "true" or "false"
    end

    return tostring(value)
end

local function ScanAchievementClass(className, config)
    Log("Scanning class: " .. className)

    local ok, objects = pcall(function()
        return FindAllOf(className)
    end)

    if not ok or objects == nil then
        Log("  Failed to find objects for " .. className)
        return
    end

    local foundCount = 0

    for _, obj in pairs(objects) do
        if obj ~= nil then
            foundCount = foundCount + 1

            Log("  Instance: " .. SafeGetFullName(obj))

            for _, propertyName in ipairs(config.properties or {}) do
                local success, value = SafeGetProperty(obj, propertyName)

                if success then
                    Log("    " .. propertyName .. " = " .. FormatValue(value))
                else
                    Log("    " .. propertyName .. " — " .. tostring(value))
                end
            end
        end
    end

    Log("  Instances found: " .. foundCount)
end

local function ScanAllAchievements()
    Log("Starting achievement scan")

    for className, config in pairs(AchievementConfig) do
        ScanAchievementClass(className, config)
    end

    Log("Achievement scan complete")
end

ScanAllAchievements()
