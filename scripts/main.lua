local AchievementConfig = require("achievement_config")
local ModMenu = require("ModMenu.ModMenu")


local DisplayClassOrder = {
    "BPC_LongWayRoundAchievement_C",
    "BPC_KibbleConnoisseurAchievement_C",
    "BPC_HerbalistAchievement_C",
    -- "BPC_PyrophobiaAchievement_C",
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

local function RefreshDisplayedAchievements()
    displayedAchievements = {}

    for _, className in ipairs(DisplayClassOrder) do
        local config = AchievementConfig[className]
        local ui = config and config.ui

        if ui ~= nil then
            local ok, objects = pcall(function()
                return FindAllOf(className)
            end)

            local entry = {
                className = className,
                title = ui.title or className,
                type = ui.type,
                ui = ui,
                instances = {},
            }

            if not ok then
                entry.error = "Could not find achievement instances: " .. tostring(objects)
            elseif objects == nil then
                entry.error = "No achievement instances found"
            else
                for _, obj in pairs(objects) do
                    if obj ~= nil then
                        local instance = {
                            name = SafeGetFullName(obj),
                            properties = {},
                        }

                        local propertyNames = {}
                        if ui.type == "checkboxes" then
                            for _, property in ipairs(ui.properties or {}) do
                                propertyNames[#propertyNames + 1] = property.property
                            end
                        elseif ui.type == "progress" then
                            propertyNames = { ui.currentProperty, ui.targetProperty }
                        end

                        for _, propertyName in ipairs(propertyNames) do
                            local success, value = SafeGetProperty(obj, propertyName)
                            instance.properties[propertyName] = {
                                success = success,
                                value = value,
                            }
                        end

                        entry.instances[#entry.instances + 1] = instance
                    end
                end

                if #entry.instances == 0 then
                    entry.error = "No achievement instances found"
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
            }
            local itemIds = {}

            if ui.type == "checkboxes" then
                for index, property in ipairs(ui.properties or {}) do
                    local itemId = "property_" .. index
                    itemIds[index] = itemId
                    section.items[#section.items + 1] = {
                        type = "label",
                        id = itemId,
                        label = property.name .. ": Reading...",
                    }
                end
            elseif ui.type == "progress" then
                itemIds[1] = "progress"
                section.items[#section.items + 1] = {
                    type = "label",
                    id = "progress",
                    label = "Reading achievement progress...",
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

local function FormatProgress(currentValue, targetValue, ui)
    local currentNumber = tonumber(currentValue)
    local targetNumber = tonumber(targetValue)

    if currentNumber == nil or targetNumber == nil then
        return "Current: " .. currentValue .. "    Target: " .. targetValue
    end

    currentNumber = currentNumber * (ui.currentScale or 1)
    local unit = ui.unit and (" " .. ui.unit) or ""
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

    local currentFormat = ui.currentFormat and ui.currentFormat or "%g"

    return string.format(
        currentFormat .. " / %g%s%s",
        currentNumber,
        targetNumber,
        unit,
        bar
    )
end

local function UpdateMenuLabels()
    for _, achievement in ipairs(displayedAchievements) do
        local section = menuSections[achievement.className]

        if section ~= nil then
            if achievement.type == "checkboxes" then
                for index, property in ipairs(achievement.ui.properties or {}) do
                    local label

                    if achievement.error ~= nil then
                        label = property.name .. ": " .. achievement.error
                    else
                        local states = {}
                        for _, instance in ipairs(achievement.instances) do
                            local value = instance.properties[property.property]
                            local state = "?"
                            if value and value.success and type(value.value) == "boolean" then
                                state = value.value and "✔" or "✖"
                            end
                            states[#states + 1] = state
                        end

                        label = property.name .. ": " .. table.concat(states, " / ")
                    end

                    SetAchievementLabel(
                        achievement.className,
                        section.itemIds[index],
                        label
                    )
                end
            elseif achievement.type == "progress" then
                local label

                if achievement.error ~= nil then
                    label = achievement.error
                else
                    local values = {}
                    for _, instance in ipairs(achievement.instances) do
                        local current = instance.properties[achievement.ui.currentProperty]
                        local target = instance.properties[achievement.ui.targetProperty]
                        if current and target and current.success and target.success then
                            values[#values + 1] = FormatProgress(
                                current.value,
                                target.value,
                                achievement.ui
                            )
                        else
                            values[#values + 1] = "Could not read current or target value"
                        end
                    end
                    label = table.concat(values, "\n")
                end

                SetAchievementLabel(achievement.className, section.itemIds[1], label)
            end
        end
    end
end

ModMenu.Init({
    title = "Wayback Achievement Tracker",
    instanceId = "WaybackAchievementTracker",
    key = Key.F7,
    keyHint = "F7",
})

RegisterAchievementSections()
ModMenu.OnOpen(function()
    RefreshDisplayedAchievements()
    UpdateMenuLabels()
end)

Log("Loaded — open the ModMenu with F7")
