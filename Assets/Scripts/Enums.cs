using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame
{
    public enum UnitStatus
    {
       IDLE,
        MOVING,
        GATHERING,
        BUILDING,
        ATTACKING,
        DELIVERING
    }

    [Serializable]
    public enum ActionType
        {
        MOVE,
        HARVEST,
        ATTACK,
        BUILD
    }
    [Serializable]
    public enum ResourceTypes
    {
        STONE,
        IRON,
        GOLD,
        FOOD,
        POPULATION,
        BUILDINGS

    };

    public enum GameState
    {
        RUNNING,
        WON,
        LOST
    }   
    
    public enum UnitType
    {
        BIG_BAD_BUG,
        SMOL_BUG,
        BASIC_ORC,
        BUILDING
    }
}

