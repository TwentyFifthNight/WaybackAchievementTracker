local AchievementConfig = {
    BPC_LongWayRoundAchievement_C = {
        properties = {
            "CheckedBottomLeft",
            "CheckedBottomRight",
            "CheckedTopLeft",
            "CheckedTopRight",
        },
        ui = {
            type = "checkboxes",
            title = "Long Way Round",
            properties = {
                { name = "Bottom left", property = "CheckedBottomLeft" },
                { name = "Bottom right", property = "CheckedBottomRight" },
                { name = "Top left", property = "CheckedTopLeft" },
                { name = "Top right", property = "CheckedTopRight" },
            },
        },
    },

    BPC_KibbleConnoisseurAchievement_C = {
        properties = {
            "AteAtLeaseOneAcceptedConsumable",
            "AchievementFailed",
        },
        ui = {
            type = "checkboxes",
            title = "Kibble Connoisseur",
            properties = {
                { name = "Ate accepted consumable", property = "AteAtLeaseOneAcceptedConsumable" },
                { name = "Achievement failed", property = "AchievementFailed" },
            },
        },
    },

    BPC_HerbalistAchievement_C = {
        properties = {
            "AchievementFailed",
        },
        ui = {
            type = "checkboxes",
            title = "Herbalist",
            properties = {
                { name = "Achievement failed", property = "AchievementFailed" },
            },
        },
    },

    -- BPC_PyrophobiaAchievement_C = {
    --     properties = {
    --         "AchievementFailed",
    --     },
    --     ui = {
    --         type = "checkboxes",
    --         title = "Pyrophobia",
    --         properties = {
    --             { name = "Achievement failed", property = "AchievementFailed" },
    --         },
    --     },
    -- },

    BPC_IWillSurviveAchievement_C = {
        properties = {
            "CurrentProgress",
            "Target",
        },
        ui = {
            type = "progress",
            title = "I Will Survive",
            currentProperty = "CurrentProgress",
            targetProperty = "Target",
        },
    },

    BPC_CableGirlAchievement_C = {
        properties = {
            "CurrentTowersClimbed",
            "TargetTowersToClimb",
        },
        ui = {
            type = "progress",
            title = "Cable Girl",
            currentProperty = "CurrentTowersClimbed",
            targetProperty = "TargetTowersToClimb",
        },
    },

    BPC_TutorialCompleteAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            type = "progress",
            title = "Tutorial Complete",
            currentProperty = "AchievementTimeSurvivedSeconds",
            targetProperty = "AchievementTargetDaysDuration",
            currentScale = 1 / 86400,
            currentFormat = "%.2f",
            unit = "days",
        },
    },

    BPC_RealGameStartsHereAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            type = "progress",
            title = "The Real Game Starts Here",
            currentProperty = "AchievementTimeSurvivedSeconds",
            targetProperty = "AchievementTargetDaysDuration",
            currentScale = 1 / 86400,
            currentFormat = "%.2f",
            unit = "days",
        },
    },

    BPC_ObjectiveSurvive_AllWeekAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            type = "progress",
            title = "I can do this all week",
            currentProperty = "AchievementTimeSurvivedSeconds",
            targetProperty = "AchievementTargetDaysDuration",
            currentScale = 1 / 86400,
            currentFormat = "%.2f",
            unit = "days",
        },
    },

    BPC_ObjectiveSurvive_AllMonthAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            type = "progress",
            title = "I can do this all month",
            currentProperty = "AchievementTimeSurvivedSeconds",
            targetProperty = "AchievementTargetDaysDuration",
            currentScale = 1 / 86400,
            currentFormat = "%.2f",
            unit = "days",
        },
    },

    BPC_ThorHatesMeAchievement_C = {
        properties = {
            "StormsCount",
            "StormsForAchievement",
        },
        ui = {
            type = "progress",
            title = "Thor Hates Me",
            currentProperty = "StormsCount",
            targetProperty = "StormsForAchievement",
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