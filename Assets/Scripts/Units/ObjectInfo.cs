using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.AI;

//TODO: cancel tasks --> auto-sense finishing criteria?
namespace RTSGame
{
    public class ObjectInfo : MonoBehaviour
    {
        public UnitStatus status;
        public PlayerController player;
        public int price = 1;



        internal bool isSelected { get; set; }
        public string objectName;

        RallyPoint rallyPoint;

        public GameObject selectionMarker;


        void Start()
        {
            status = UnitStatus.IDLE;

            if(player!=null)
            {
                player.units.Add(gameObject);
                player.AddFriendlyUnit(this.gameObject);
            }

        }

        public void ToggleSelection(bool direction)
        {
            isSelected = direction;
            selectionMarker.SetActive(direction);
            if (direction)
            {
                GameEvent.current.OnObjectActionSent += GetComponent<TaskManager>().CreateTask;
                GameEvent.current.OnPositionActionSent += GetComponent<TaskManager>().CreateTask;
            }
            else
            {
                GameEvent.current.OnObjectActionSent -= GetComponent<TaskManager>().CreateTask;
                GameEvent.current.OnPositionActionSent -= GetComponent<TaskManager>().CreateTask;
            }
        }
        
        public void SetRallyPoint(RallyPoint pos)
        {
            rallyPoint = pos;
        }
        private void OnTriggerEnter(Collider other)
        {
            if(other.CompareTag("Enemy"))
            {
                player.AddEnemyInRange(other.gameObject);
            }
        }

        private void OnTriggerExit(Collider other)
        {
            if(other.CompareTag("Enemy"))
            {
                player.RemoveEnemyFromRange(other.gameObject);
            }
        }
    }

    
}