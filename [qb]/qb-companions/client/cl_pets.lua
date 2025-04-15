QBCore = exports['qb-core']:GetCoreObject()
local HaveSpawned = false

local smallDogSkillList = {
    ["sit"] = true,
    ["bark"] = true,
    ["playdead"] = true,
}

local dogSkillList = {
    ["sit"] = true,
    ["laydown"] = true,
    ["bark"] = true,
    ["beg"] = true,
    ["attack"] = true,
    ["taunt"] = true,
    ["paw"] = true,
    ["playdead"] = true,
}

local bigCatSkillList = {
    ["laydown"] = true,
    ["attack"] = true,
    ["taunt"] = true
}

local catSkillList = {
    ["stretch"] = true,
    ["laydown"] = true,
}

local animalSkillList = {
    ["a_c_chop"] = dogSkillList,
    ["a_c_husky"] = dogSkillList,
    ["a_c_husky_np"] = dogSkillList,
    ["a_c_retriever"] = dogSkillList,
    ["a_c_retriever_np"] = dogSkillList,
    ["a_c_shepherd"] = dogSkillList,
    ["a_c_shepherd_np"] = dogSkillList,
    ["a_c_pit_np"] = dogSkillList,
    ["a_c_panther"] = bigCatSkillList,
    ["a_c_coyote"] = {
        ["laydown"] = true,
        ["howl"] = true
    },
    ["a_c_cat_01"] = catSkillList,
    ["a_c_westy"] = smallDogSkillList,
    ["a_c_pug"] = smallDogSkillList,
    ["a_c_poodle"] = smallDogSkillList,
    ["a_c_cow"] = {
        ["graze"] = true,
    },
    ["a_c_hen"] = {
        ["peck"] = true,
    },
    ["a_c_rabbit_01"] = {},
    ["a_c_pig"] = {
        ["graze"] = true,
    },
}

local lastCompanionId = nil
local lastCompanionAction = nil
local attackNextTarget = false
local spawnedAnimals = {}
local spawnedAnimalsCount = 0
local spawnedK9Units = {}
local ignoreServerIds = {}
local spawnedAnimalModels = {}

local function supportedAnimals()
    return {
        ["chop_lspd"] = {
            id = "chop_lspd",
            name = "lspd Chop",
            appearance = {
                model = "a_c_chop",
                components = {
                    {
                        componentId = 3,
                        drawableId = 1,
                        textureId = 0,
                        paletteId = 0,
                    },
                },
            },
            speedModifier = 1.2,
            maxHealth = 1000,
        },
        ["chop_bcso"] = {
            id = "chop_bcso",
            name = "BCSO Chop",
            appearance = {
            model = "a_c_chop",
            components = {
                {
                    componentId = 3,
                    drawableId = 1,
                    textureId = 2,
                    paletteId = 0,
                },
            },
            },
            speedModifier = 1.2,
            maxHealth = 1000,
        },
      ["chop_troopers"] = {
        id = "chop_troopers",
        name = "Troopers Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_doc"] = {
        id = "chop_doc",
        name = "DOC Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_rangers"] = {
        id = "chop_rangers",
        name = "Rangers Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["chop_therapy"] = {
        id = "chop_therapy",
        name = "Therapy Chop",
        appearance = {
          model = "a_c_chop",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_lspd"] = {
        id = "husky_lspd",
        name = "lspd Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_bcso"] = {
        id = "husky_bcso",
        name = "BCSO Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_troopers"] = {
        id = "husky_troopers",
        name = "Troopers Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_doc"] = {
        id = "husky_doc",
        name = "DOC Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_rangers"] = {
        id = "husky_rangers",
        name = "Rangers Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["husky_therapy"] = {
        id = "husky_therapy",
        name = "Therapy Husky",
        appearance = {
          model = "a_c_husky_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_lspd"] = {
        id = "retriever_lspd",
        name = "lspd Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_bcso"] = {
        id = "retriever_bcso",
        name = "BCSO Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_troopers"] = {
        id = "retriever_troopers",
        name = "Troopers Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_doc"] = {
        id = "retriever_doc",
        name = "DOC Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_rangers"] = {
        id = "retriever_rangers",
        name = "Rangers Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["retriever_therapy"] = {
        id = "retriever_therapy",
        name = "Therapy Retriever",
        appearance = {
          model = "a_c_retriever_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_lspd"] = {
        id = "shepherd_lspd",
        name = "lspd Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_bcso"] = {
        id = "shepherd_bcso",
        name = "BCSO Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_troopers"] = {
        id = "shepherd_troopers",
        name = "Troopers Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_doc"] = {
        id = "shepherd_doc",
        name = "DOC Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_rangers"] = {
        id = "shepherd_rangers",
        name = "Rangers Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["shepherd_therapy"] = {
        id = "shepherd_therapy",
        name = "Therapy Shepherd",
        appearance = {
          model = "a_c_shepherd_np",
          components = {
            {
              componentId = 11,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 0,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_lspd"] = {
        id = "pit_lspd",
        name = "lspd Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_bcso"] = {
        id = "pit_bcso",
        name = "BCSO Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 1,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_troopers"] = {
        id = "pit_troopers",
        name = "Troopers Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 2,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_doc"] = {
        id = "pit_doc",
        name = "DOC Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 3,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_rangers"] = {
        id = "pit_rangers",
        name = "Rangers Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 4,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["pit_therapy"] = {
        id = "pit_therapy",
        name = "Therapy Pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 1,
              textureId = 5,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["panther"] = {
        id = "panther",
        name = "Panther",
        appearance = {
          model = "a_c_panther",
        },
        speedModifier = 1.2,
        maxHealth = 1000,
      },
      ["coyote"] = {
        id = "coyote",
        name = "Coyote",
        appearance = {
          model = "a_c_coyote",
        },
        speedModifier = 1.0,
        maxHealth = 1000,
      },
      ["pit"] = {
        id = "pit",
        name = "pit",
        appearance = {
          model = "a_c_pit_np",
          components = {
            {
              componentId = 3,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
            {
              componentId = 4,
              drawableId = 0,
              textureId = 0,
              paletteId = 0,
            },
          },
        },
        speedModifier = 1.0,
        maxHealth = 1000,
      },
      ["cat"] = {
        id = "cat",
        name = "cat",
        appearance = {
          model = "a_c_cat_01"
        },
        speedModifier = 2,
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["pug"] = {
        id = "pug",
        name = "pug",
        appearance = {
          model = "a_c_pug"
        },
        maxHealth = 1000,
      },
      ["poodle"] = {
        id = "poodle",
        name = "poodle",
        appearance = {
          model = "a_c_poodle"
        },
        maxHealth = 1000,
      },
      ["westy"] = {
        id = "westy",
        name = "westy",
        appearance = {
          model = "a_c_westy"
        },
        maxHealth = 1000,
      },
      ["cow"] = {
        id = "cow",
        name = "cow",
        appearance = {
          model = "a_c_cow"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["hen"] = {
        id = "hen",
        name = "hen",
        appearance = {
          model = "a_c_hen"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["rabbit"] = {
        id = "rabbit",
        name = "rabbit",
        appearance = {
          model = "a_c_rabbit_01"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
      ["pig"] = {
        id = "pig",
        name = "pig",
        appearance = {
          model = "a_c_pig"
        },
        maxSpeed = 1,
        maxHealth = 1000,
      },
    }
end

local function hasSpawnedK9Unit()
    local k9UnitSpawned = false
    for k, v in pairs(spawnedK9Units) do
        k9UnitSpawned = k9UnitSpawned or spawnedK9Units[k]
    end
    return k9UnitSpawned
end

local function modelHasSkill(id, skill)
    return animalSkillList[spawnedAnimalModels[id]][skill]
end

local function showCompanionOptions(companionId)
    local items = {}

    items[#items + 1] = {
      header = "To move",
      txt = "Makes him move to the next target",
      params = {
        event = "qb-pets:companionAction",
        args = { companionId = companionId, action = "move" },
      }
    }

    items[#items + 1] = {
      header = "Follow",
      txt = "Make him follow you",
      params = {
        event = "qb-pets:companionAction",
        args = { companionId = companionId, action = "follow" },
      }
    }

    if modelHasSkill(companionId, "sit") then
        items[#items + 1] = {
          header = "Sit",
          txt = "Make him sit!",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "sit" },
          }
        }
    end

    if modelHasSkill(companionId, "laydown") then
        items[#items + 1] = {
          header = "Lay Down",
          txt = "Rest a little",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "laydown" },
          }
        }
    end

    if modelHasSkill(companionId, "bark") then
        items[#items + 1] = {
          header = "Bark",
          txt = "Woof woof",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "bark" },
          }
        }
    end

    items[#items + 1] = {
      header = "Wander around",
      txt = "Make him busy",
      params = {
        event = "qb-pets:companionAction",
        args = { companionId = companionId, action = "wander" },
      }
    }

    if spawnedK9Units[companionId] then
        items[#items + 1] = {
          header = "Track",
          txt = "Start tracking for someone",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "track" },
          }
        }
    end

    if modelHasSkill(companionId, "taunt") then
        items[#items + 1] = {
          header = "Taunt",
          txt = "Shows who is the boss",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "taunt" },
          }
        }
    end

    if modelHasSkill(companionId, "stretch") then
        items[#items + 1] = {
          header = "Warm",
          txt = "It's ready for racing",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "stretch" },
          }
        }
    end

    if modelHasSkill(companionId, "beg") then
        items[#items + 1] = {
          header = "Beg",
          txt = "Who's the good boy?",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "beg" },
          }
        }
    end

    if modelHasSkill(companionId, "paw") then
        items[#items + 1] = {
          header = "Paw",
          txt = "Give me the paw",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "paw" },
          }
        }
    end

    if modelHasSkill(companionId, "peck") then
        items[#items + 1] = {
          header = "Peck",
          txt = "Look for things to chew",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "peck" },
          }
        }
    end

    if modelHasSkill(companionId, "graze") then
        items[#items + 1] = {
          header = "Graze",
          txt = "Nom nom nom",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "graze" },
          }
        }
    end

    if modelHasSkill(companionId, "howl") then
        items[#items + 1] = {
          header = "Howl",
          txt = "Awooooooooo",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "howl" },
          }
        }
    end

    if modelHasSkill(companionId, "playdead") then
        items[#items + 1] = {
          header = "Player Dead",
          txt = "Play to die",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "playdead" },
          }
        }
    end

    if modelHasSkill(companionId, "attack") then
        items[#items + 1] = {
          header = "Attack",
          txt = "Attacks the desired target",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "attack" },
          }
        }
    end
    exports['qb-menu']:openMenu(items)
end

local function hasAnimalWithSkill(skill)
    for k, v in pairs(spawnedAnimals) do
        if v and modelHasSkill(k, skill) then
            return true
        end
    end
    return false
end

local function showPlayerOptions(companionId, pedId)
    local items = {
        {
          header = "To move",
          txt = "Moves to that person",
          params = {
            event = "qb-pets:companionPlayerAction",
            args = { companionId = companionId, action = "move", pedId = pedId },
          }
        },
        {
          header = "Observe",
          txt = "Keep your eyes open",
          params = {
            event = "qb-pets:companionAction",
            args = { companionId = companionId, action = "watch", pedId = pedId },
          }
        },
    }

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
          header = "Sniff",
          txt = "Any contraband?",
          params = {
            event = "qb-pets:companionPlayerAction",
            args = { companionId = companionId, action = "sniff", pedId = pedId },
          }
        }
    end

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
          header = "Untrack",
          txt = "Untrack",
          params = {
            event = "qb-pets:companionPlayerAction",
            args = { companionId = companionId, action = "untrack", pedId = pedId },
          }
        }
    end

    if hasAnimalWithSkill("attack") then
        items[#items + 1] = {
          header = "Attack",
          txt = "Attack!",
          params = {
            event = "qb-pets:companionPlayerAction",
            args = { companionId = companionId, action = "attack", pedId = pedId },
          }
        }
    end
    exports['qb-menu']:openMenu(items)
end

local function showVehicleOptions(vehicleId)
    local items = {
        {
          header = "To Move",
          txt = "Go to the vehicle",
          params = {
            event = "qb-pets:companionVehicleAction",
            args = { vehicleId = vehicleId, action = "move" },
          }
        },
        {
          header = "Enter Vehicle",
          txt = "Enter Vehicle",
          params = {
            event = "qb-pets:companionVehicleAction",
            args = { vehicleId = vehicleId, action = "vehicle" },
          }
        },
        {
          header = "Observe",
          txt = "Keep your eyes open",
          params = {
            event = "qb-pets:companionVehicleAction",
            args = { vehicleId = vehicleId, action = "watch" },
          }
        },
    }

    if hasSpawnedK9Unit() then
        items[#items + 1] = {
          header = "Sniff",
          txt = "Any contraband?",
          params = {
            event = "qb-pets:companionVehicleAction",
            args = { vehicleId = vehicleId, action = "sniff" },
          }
        }
    end
    exports['qb-menu']:openMenu(items)
end

function trackPlayers(companionId)
  local player, distance = QBCore.Functions.GetClosestPlayer()
    if player ~= -1 and distance < 20.0 then
      local playerPed = GetPlayerPed(player)
      local closestCoords = GetEntityCoords(playerPed)
      exports["qb-companions"]:perform("move", companionId or "", { x = closestCoords.x, y = closestCoords.y, z = closestCoords.z, speed = 0.8 })
      exports["qb-companions"]:deselect()
    else
      exports["qb-companions"]:perform("sit", companionId or "")
      TriggerEvent("QBCore:Notify", "He doesn't seem to be interested.", 'error')
      exports["qb-companions"]:deselect()
    end
end

local function doSniffAction(pType, pCompanionId)
    exports["qb-companions"]:perform("move", pCompanionId)
    Wait(1000)
    local target = exports["qb-companions"]:getSelection()
    if pType == "ped" then
        QBCore.Functions.TriggerCallback("qb-pets:sniffTarget",function(hasContraband)
          if hasContraband then
            TriggerEvent("QBCore:Notify", "Your pet found something!", 'success')
            exports["qb-companions"]:perform("bark", pCompanionId)
            Wait(1000)
            exports["qb-companions"]:perform("sit", pCompanionId)
        else
            TriggerEvent("QBCore:Notify", "Your animal found nothing.", 'error')
        end
      end, pType, GetPlayerServerId(NetworkGetPlayerIndexFromPed(target.entityId)))
    elseif pType == "vehicle" then
        local plate = GetVehicleNumberPlateText(target.entityId)
        QBCore.Functions.TriggerCallback("qb-pets:sniffTarget",function(hasContraband)
          if hasContraband then
            TriggerEvent("QBCore:Notify", "Your pet found something!", 'success')
            exports["qb-companions"]:perform("bark", pCompanionId)
            Wait(1000)
            exports["qb-companions"]:perform("sit", pCompanionId)
          else
              TriggerEvent("QBCore:Notify", "Your animal found nothing.", 'error')
          end
        end, pType, plate)
    end
    exports["qb-companions"]:deselect()
end

RegisterNetEvent("qb-pets:usePet", function(info)

    local characterId = QBCore.Functions.GetPlayerData().citizenid

    if tonumber(info.Owner) ~= tonumber(characterId) then
        TriggerEvent("QBCore:Notify", "They don't know you.", 'error')
        return
    end

    local id = info.id
    if spawnedAnimals[id] then
        HaveSpawned = false
        spawnedAnimals[id] = false
        spawnedK9Units[id] = false
        spawnedAnimalsCount = spawnedAnimalsCount - 1
        exports["qb-companions"]:dismiss(id)
        exports["qb-companions"]:deselect()
        return
    end

    if not HaveSpawned then

      HaveSpawned = true

      spawnedAnimals[id] = true
      spawnedAnimalsCount = spawnedAnimalsCount + 1
      spawnedK9Units[id] = info.k9

      local animal = supportedAnimals()[info.key]

      if  info.cVariation ~= -1 and animal.appearance and animal.appearance.components and animal.appearance.components[2] then
          animal.appearance.components[2].textureId = info.cVariation
      end

      animal.id = id
      spawnedAnimalModels[id] = animal.appearance.model

      exports["qb-companions"]:summon({ animal }, function()
          local veh = GetVehiclePedIsIn(PlayerPedId(), false)
          if not veh or veh == 0 then
              exports["qb-companions"]:perform("follow", animal.id)
          end
      end)
    else
      TriggerEvent('QBCore:Notify', 'You Have Already Spawned Animal', 'error')
    end
end)

AddEventHandler("qb-pets:companionAction", function(params)
    if params.action == "move" or params.action == "attack" then
        lastCompanionId = params.companionId
        lastCompanionAction = params.action
        return
    end

    if params.action == "track" then
        trackPlayers(params.companionId)
        return
    end

    exports["qb-companions"]:perform(params.action, params.companionId)
    exports["qb-companions"]:deselect()
end)

AddEventHandler("qb-pets:companionPlayerAction", function(params)
    if params.action == "sniff" then
        doSniffAction("ped", params.companionId)
        return
    end

    if params.action == "untrack" then
        local sid = GetPlayerServerId(NetworkGetPlayerIndexFromPed(params.pedId))
        ignoreServerIds[sid] = not ignoreServerIds[sid]
        exports["qb-companions"]:deselect()
        return
    end

    if params.companionId == nil or params.companionId == "" then
        for k, v in pairs(spawnedAnimals) do
            if spawnedAnimals[k] and modelHasSkill(k, params.action) then
                exports["qb-companions"]:perform(params.action, k)
            end
        end
    else
        exports["qb-companions"]:perform(params.action, params.companionId)
    end

    exports["qb-companions"]:deselect()
end)

AddEventHandler("qb-pets:companionVehicleAction", function(params)
    if params.action == "sniff" then
        doSniffAction("vehicle", params.companionId)
        return
    end

    exports["qb-companions"]:perform(params.action)
    exports["qb-companions"]:deselect()
end)

AddEventHandler("qb-companions:pedSelected", function(pedId, companionId)

    if companionId then
        showCompanionOptions(companionId)
        return
    end

    if lastCompanionId then
        exports["qb-companions"]:perform(lastCompanionAction, lastCompanionId)
        exports["qb-companions"]:deselect()
        lastCompanionId = nil
        return
    end

    if attackNextTarget then
        exports["qb-companions"]:perform("attack")
        exports["qb-companions"]:deselect()
        attackNextTarget = false
        return
    end

    if IsPedAPlayer(pedId) then
        showPlayerOptions(companionId, pedId)
    end
end)

AddEventHandler("qb-companions:vehicleSelected", function(vehicleId)
  showVehicleOptions(vehicleId)
end)

AddEventHandler("qb-companions:groundSelected", function()
    exports["qb-companions"]:perform("move", lastCompanionId)
    lastCompanionId = nil
end)

AddEventHandler('qb-pet:radial:StartSelect', function()
  if spawnedAnimalsCount > 0 then
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if not veh or veh == 0 then
      exports["qb-companions"]:startSelecting()
    end
  end
end)

AddEventHandler('qb-pet:radial:SelectTarget', function()
  exports["qb-companions"]:stopSelecting()
end)

AddEventHandler('qb-pet:radial:StopSelect', function()
  exports["qb-companions"]:deselect()
end)

AddEventHandler('qb-pet:radial:FollowSelf', function()
  exports["qb-companions"]:perform("follow")
end)

AddEventHandler('qb-pet:radial:FollowVehicle', function()
  exports["qb-companions"]:perform("vehicle")
end)

AddEventHandler('qb-pet:radial:Attack', function()
  attackNextTarget = true
  lastCompanionId = nil
end)

AddEventHandler('qb-pet:radial:track', function()
  trackPlayers()
end)