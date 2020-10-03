using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame
{
    public enum UnitStatus
    {
        GATHERING,
        MOVING,
        IDLE,
        BUILDING,
        ATTACKING,
        DELIVERING
    }

    [Serializable]
    public enum ActionType
        {
        MOVE,
        HARVEST,
        ATTACK
    }
    public enum ResourceTypes
    {
        STONE,
        IRON,
        GOLD,
        FOOD,
        POPULATION

    };

    public enum GameState
    {
        RUNNING,
        WON,
        LOST
    }   
}

