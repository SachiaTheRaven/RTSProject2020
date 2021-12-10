using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using UnityEditor;
using UnityEngine;

namespace RTSGame
{
    [Serializable]
    public class PlayerStats
    {
        //meaning Units & Buildings
        public ObservableCollection<GameObject> Units= new ObservableCollection<GameObject>();
        
        public ResourceManager PlayerResourceManager;
        public Dictionary<GUID, GameObject> EnemiesInRange = new Dictionary<GUID, GameObject>();
        public GameEvent GameEventManager { get; set; }




        public void AddFriendlyUnit(GameObject unit)
        {
            Units.Add(unit);
            PlayerResourceManager.AddResource(ResourceTypes.POPULATION, 1);
        }

        public void KillUnit(GameObject unit)
        {
            var tm = unit.GetComponent<TaskManager>();

            PlayerResourceManager.AddResource(ResourceTypes.POPULATION, -1);
            if(tm!=null)
            {
                GameEventManager.OnObjectActionSent -= tm.CreateTask;
                GameEventManager.OnPositionActionSent -= tm.CreateTask;
            }
            Units.Remove(unit);
        }
        internal void RemoveEnemyFromRange(GameObject gameObject)
        {
            EnemiesInRange.Remove(EnemiesInRange.Where(x => x.Value == gameObject).FirstOrDefault().Key);
        }

        //when an enemy unit crosses its range border, any friendly unit will report it here
        internal void AddEnemyInRange(GameObject gameObject)
        {
            EnemiesInRange.Add(GUID.Generate(), gameObject);
        }
    }
}