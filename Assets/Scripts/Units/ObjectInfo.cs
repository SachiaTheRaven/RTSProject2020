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
        public UnitStatus Status
        {
            get; set;
        }
        public PlayerController player;


        public bool isSelected = false;
        public string objectName;


        public GameObject selectionMarker;


        void Start()
        {
            Status = UnitStatus.IDLE;

        }

        // Update is called once per frame
        void Update()
        {

        }

        public void ToggleSelection()
        {

            if (isSelected)
            {
                //TODO maybe store with player somehow
                isSelected = false;
                selectionMarker.SetActive(false);
            }
            else
            {
                isSelected = true;
                selectionMarker.SetActive(true);
            }

        }
    }
}