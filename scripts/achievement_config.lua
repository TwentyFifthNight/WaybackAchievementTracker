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

    BPC_TutorialCompleteAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            title = "Tutorial Complete",
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
    },

    BPC_RealGameStartsHereAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            title = "The Real Game Starts Here",
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
    },

    BPC_ObjectiveSurvive_AllWeekAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            title = "I can do this all week",
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
    },

    BPC_ObjectiveSurvive_AllMonthAchievement_C = {
        properties = {
            "AchievementTimeSurvivedSeconds",
            "AchievementTargetTimeSeconds",
            "AchievementTargetDaysDuration"
        },
        ui = {
            title = "I can do this all month",
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
    },

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
                { name = "Distance", type = "progress", currentProperty = "DistanceTravelled", targetProperty = "TargetDistanceToRun" },
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