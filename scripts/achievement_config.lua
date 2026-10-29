local function createDayProgressAchievement(title)
    return {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            title = title,
            properties = {
                {
                    name = "Days",
                    type = "progress",
                    currentProperty = "AchievementTimeSurvivedSeconds",
                    targetProperty = "AchievementTargetTimeSeconds",
                    unit = "days",
                },
            }
        },
    }
end

local AchievementConfig = {
    BPC_LongWayRoundAchievement_C = {
        properties = {
            "CheckedBottomLeft",
            "CheckedBottomRight",
            "CheckedTopLeft",
            "CheckedTopRight",
        },
        ui = {
            title = "Long Way Round",
            properties = {
                { name = "Bottom left", type = "checkbox", property = "CheckedBottomLeft" },
                { name = "Bottom right", type = "checkbox", property = "CheckedBottomRight" },
                { name = "Top left", type = "checkbox", property = "CheckedTopLeft" },
                { name = "Top right", type = "checkbox", property = "CheckedTopRight" },
            },
        },
    },

    BPC_KibbleConnoisseurAchievement_C = {
        properties = {
            "AteAtLeaseOneAcceptedConsumable",
            "AchievementFailed",
        },
        ui = {
            title = "Kibble Connoisseur",
            properties = {
                { name = "Ate accepted consumable", type = "checkbox", property = "AteAtLeaseOneAcceptedConsumable" },
                { name = "Achievement failed", type = "checkbox", property = "AchievementFailed" },
            },
        },
    },

    BPC_HerbalistAchievement_C = {
        properties = {
            "AteAtLeaseOneAcceptedConsumable",
            "AchievementFailed",
        },
        ui = {
            title = "Herbalist",
            properties = {
                { name = "Ate accepted consumable", type = "checkbox", property = "AteAtLeaseOneAcceptedConsumable" },
                { name = "Achievement failed", type = "checkbox", property = "AchievementFailed" },
            },
        },
    },

    BPC_IWillSurviveAchievement_C = {
        properties = {
            "CurrentProgress",
            "Target",
        },
        ui = {
            title = "I Will Survive",
            properties = {
                { name = "Deaths", type = "progress", currentProperty = "CurrentProgress", targetProperty = "Target" },
            }
        },
    },

    BPC_CableGirlAchievement_C = {
        properties = {
            "CurrentTowersClimbed",
            "TargetTowersToClimb",
        },
        ui = {
            title = "Cable Girl",
            properties = {
                { name = "Towers", type = "progress", currentProperty = "CurrentTowersClimbed", targetProperty = "TargetTowersToClimb" },
            }
        },
    },

    BPC_TutorialCompleteAchievement_C = createDayProgressAchievement("Tutorial Complete"),

    BPC_RealGameStartsHereAchievement_C = createDayProgressAchievement("The Real Game Starts Here"),

    BPC_ObjectiveSurvive_AllWeekAchievement_C = createDayProgressAchievement("I can do this all week"),

    BPC_ObjectiveSurvive_AllMonthAchievement_C = createDayProgressAchievement("I can do this all month"),

    BPC_ThorHatesMeAchievement_C = {
        properties = {
            "StormsCount",
            "StormsForAchievement",
        },
        ui = {
            title = "Thor Hates Me",
            properties = {
                { name = "Storms", type = "progress", currentProperty = "StormsCount", targetProperty = "StormsForAchievement" },
            }
        },
    },

    BPC_DJAchievement_C = {
        properties = {
            "CassettesToFind",
            "CurrentInventory",
        },
    },

    BPC_WandererAchievement_C = {
        properties = {
            "TargetDistanceToRun",
        },
        externalProperties = {
            { class = "BP_Character_Lucy_C", properties = { "DistanceTravelled" } }
        },
        ui = {
            title = "Wanderer",
            properties = {
                { name = "Distance", type = "progress", currentProperty = "DistanceTravelled", targetProperty = "TargetDistanceToRun", targetMultiplier = 1000 },
            }
        },
    },

    BPC_SwissCommuteAchievement_c = {
        properties = {
            "EnteredNaked",
            "MinDistanceTravelledInRiver",
            "OnEnterRiverPosition",
        },
    }
}

return AchievementConfig