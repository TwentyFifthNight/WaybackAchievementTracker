local AchievementConfig = require("achievement_config")
local ModMenu = require("ModMenu.ModMenu")


local DisplayClassOrder = {
    "BPC_LongWayRoundAchievement_C",
    "BPC_WandererAchievement_C",
    "BPC_KibbleConnoisseurAchievement_C",
    "BPC_HerbalistAchievement_C",
    "BPC_IWillSurviveAchievement_C",
    "BPC_CableGirlAchievement_C",
    "BPC_TutorialCompleteAchievement_C",
    "BPC_RealGameStartsHereAchievement_C",
    "BPC_ThorHatesMeAchievement_C",
    "BPC_ObjectiveSurvive_AllWeekAchievement_C",
    "BPC_ObjectiveSurvive_AllMonthAchievement_C"
}

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

local function SafeGetClassName(obj)
    local ok, result = pcall(function()
        return obj:GetFullName()
    end)

    if not ok then
        return false, "Could not determine object class: " .. tostring(result)
    end

    local className = tostring(result):match("^([^%s]+)")
    if className == nil then
        return false, "Could not determine object class from full name: " .. tostring(result)
    end

    return true, className
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

local displayedAchievements = {}
local menuSections = {}

local function AddPropertiesToTable(obj, properties, tab)
    for _, propertyName in ipairs(properties or {}) do
        local success, value = SafeGetProperty(obj, propertyName)
        tab[propertyName] = {
            success = success,
            value = value,
        }
    end
end

local function LoadObjectPropertiesToInstance(object, properties, externalProperties)
    if object == nil then
        return nil
    end

    local instance = {
        name = SafeGetFullName(object),
        properties = {},
    }
    AddPropertiesToTable(object, properties or {}, instance.properties)

    for _, externalProperty in ipairs(externalProperties or {}) do
        local externalClass = externalProperty.class
        local found, externalObject = pcall(function()
            return FindFirstOf(externalClass)
        end)
        if found and externalObject ~= nil then
            AddPropertiesToTable(externalObject, externalProperty.properties or {}, instance.properties)
        end
    end

    return instance
end

local function RefreshDisplayedAchievements()
    displayedAchievements = {}

    for _, className in ipairs(DisplayClassOrder) do
        local config = AchievementConfig[className]
        local ui = config and config.ui
        local properties = config and config.properties
        local externalProperties = config and config.externalProperties

        if ui ~= nil then
            local ok, objects = pcall(function()
                return FindAllOf(className)
            end)
            local object

            if ok and objects ~= nil then
                for _, candidate in pairs(objects) do
                    local classOk, actualClassName = SafeGetClassName(candidate)
                    if classOk and actualClassName == className then
                        object = candidate
                        break
                    end
                end
            end

            local entry = {
                className = className,
                title = ui.title or className,
                ui = ui,
            }

            if not ok then
                entry.error = "Could not find achievement instance"
            elseif object == nil then
                entry.error = "No achievement instance found"
            else
                entry.instance = LoadObjectPropertiesToInstance(object, properties, externalProperties)
                if entry.instance == nil then
                    entry.error = "No achievement instance found"
                end
            end

            displayedAchievements[#displayedAchievements + 1] = entry
        end
    end
end

local function RegisterAchievementSections()
    for _, className in ipairs(DisplayClassOrder) do
        local config = AchievementConfig[className]
        local ui = config and config.ui

        if ui ~= nil then
            local section = {
                id = className,
                title = ui.title or className,
                items = {},
                tab = ui.mode,
            }
            local itemIds = {}

            for index, property in ipairs(ui.properties or {}) do
                local itemId = "property_" .. index
                itemIds[index] = itemId
                section.items[#section.items + 1] = {
                    type = "label",
                    id = itemId,
                    label = property.name .. ": Reading...",
                }
            end
            

            menuSections[className] = {
                ui = ui,
                itemIds = itemIds,
            }
            ModMenu.Register(section)
        end
    end
end

local function SetAchievementLabel(className, itemId, text)
    if not ModMenu.SetLabel(className, itemId, text) then
        Log(string.format("Could not update menu label %s.%s", className, itemId))
    end
end

local function FormatProgress(currentValue, targetValue, property)
    local currentNumber = tonumber(currentValue)
    local targetNumber = tonumber(targetValue)

    if property.targetMultiplier ~= nil then
        targetNumber = targetNumber * property.targetMultiplier
    end

    if currentNumber == nil or targetNumber == nil then
        return "Progress values are not present"
    end

    local bar = ""

    if targetNumber > 0 then
        local progress = math.max(0, math.min(1, currentNumber / targetNumber))
        local filled = math.floor(progress * 16)
        bar = string.format(
            " [%s%s]",
            string.rep("#", filled),
            string.rep("-", 16 - filled)
        )
    end

    local unit = property.unit and (" " .. property.unit) or ""

    if property.unit == "days" then
        local currentHours = math.floor(currentNumber / 3600)
        local currentMinutes = math.floor((currentNumber % 3600) / 60)
        local currentSeconds = math.floor(currentNumber % 60)
        local targetHours = math.floor(targetNumber / 3600)
        local targetMinutes = math.floor((targetNumber % 3600) / 60)
        local targetSeconds = math.floor(targetNumber % 60)
        return string.format(
            "%g%s %g%s %g%s / %g%s %g%s %g%s%s",
            currentHours, "h",
            currentMinutes, "m",
            currentSeconds, "s",
            targetHours, "h",
            targetMinutes, "m",
            targetSeconds, "s",
            bar
        )
    else
        return string.format(
            "%g / %g%s%s",
            math.floor(currentNumber),
            targetNumber,
            unit,
            bar
        )
    end
end

local function UpdateMenuLabels()
    for _, achievement in ipairs(displayedAchievements) do
        local section = menuSections[achievement.className]

        if section == nil then
            goto continue_achievement_loop
        end

        for index, property in ipairs(achievement.ui.properties or {}) do
            local label = ""

            if achievement.error ~= nil then
                label = property.name .. ": " .. achievement.error
            else
                local instance = achievement.instance
                if property.type == "checkbox" then
                    local value = instance.properties[property.property]
                    local state = "?"
                    if value and value.success and type(value.value) == "boolean" then
                        state = value.value and "✔" or "✖"
                    end

                    label = property.name .. ": " .. state
                elseif property.type == "progress" then
                    local current = instance.properties[property.currentProperty]
                    local target = instance.properties[property.targetProperty]
                    if current and target and current.success and target.success then
                        label = FormatProgress(
                            current.value,
                            target.value,
                            property
                        )
                    else
                        label = "Could not read current or target value"
                    end
                end
            end

            SetAchievementLabel(
                achievement.className,
                section.itemIds[index],
                label
            )
        end

        ::continue_achievement_loop::
    end
end

ModMenu.Init({
    title = "Wayback Achievement Tracker",
    instanceId = "WaybackAchievementTracker",
    key = Key.F7,
    keyHint = "F7",
    tabs = { "Wayback", "Survive" },
})

RegisterAchievementSections()
ModMenu.OnOpen(function()
    RefreshDisplayedAchievements()
    UpdateMenuLabels()
end)

Log("Loaded — open the ModMenu with F7")
