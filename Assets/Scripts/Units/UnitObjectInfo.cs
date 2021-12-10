using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame
{
    public class UnitObjectInfo : ObjectInfo
    {
        //public UnitStatus status;
        internal bool isSelected { get; set; }

        public GameObject selectionMarker;


        protected override void Awake()
        {
            base.Awake();
            status = UnitStatus.IDLE;

        }

        public void ToggleSelection(bool direction)
        {
            isSelected = direction;
            selectionMarker.SetActive(direction);
            if (direction)
            {
                Player.Stats.GameEventManager.OnObjectActionSent += GetComponent<TaskManager>().CreateTask;
                Player.Stats.GameEventManager.OnPositionActionSent += GetComponent<TaskManager>().CreateTask;
            }
            else
            {
                Player.Stats.GameEventManager.OnObjectActionSent -= GetComponent<TaskManager>().CreateTask;
                Player.Stats.GameEventManager.OnPositionActionSent -= GetComponent<TaskManager>().CreateTask;
            }
        }
      


        
    }


}
