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
        public UnitTasks task;
        public ResourceManager resourceManager;
        public PlayerController player;


        public bool isSelected = false;
        public string objectName;
        public int heldResource;
        public ResourceTypes heldResourceType;

        public int maxHeldResource;
        public bool isGathering = false;

        private GameObject gatheringFrom = null;
        public GameObject selectionMarker;

        List<GameObject> dropPoints;

        int taskRoundLimit;
        int taskRoundsFinished;
        void Start()
        {
            StartCoroutine("GatherTick");
            task = UnitTasks.IDLE;
            resourceManager = FindObjectOfType<ResourceManager>();
            if (resourceManager == null) throw new Exception("No ResourceManager found!");
        }

        // Update is called once per frame
        void Update()
        {
            if ((heldResource >= maxHeldResource || gatheringFrom == null) && isGathering)
            {
                //go back to drop-off point
                StopGathering();
            }
        }

        //TODO move to sep. component
        public void OnTriggerEnter(Collider other)
        {
            GameObject hitObject = other.gameObject;
            switch (hitObject.tag)
            {
                case "Resource":
                    {
                        if (task == UnitTasks.GATHERING)
                        {
                            StartGathering(hitObject);
                        }
                    }
                    break;
                case "DropPoint":
                    {
                        if (task == UnitTasks.DELIVERING)
                        {
                            if (resourceManager.stone + heldResource > resourceManager.maxStone || 
                                (taskRoundLimit!=0 && taskRoundsFinished==taskRoundLimit))
                            {
                                MovementController mc = GetComponent<MovementController>();
                                mc.Move(mc.rallyPoint.transform.position);
                            }
                            else
                            {
                                resourceManager.stone += heldResource;
                                heldResource = 0;
                                if(taskRoundLimit!=0) taskRoundsFinished++;
                                GetComponent<MovementController>().Move(gatheringFrom.transform.position);
                                SetTask(UnitTasks.GATHERING);

                            }
                        }
                    }
                    break;
            }


        }


        public void OnTriggerExit(Collider other)
        {
            GameObject hitObject = other.gameObject;
            if (hitObject.CompareTag("Resource") && isGathering)
            {
                StopGathering();
            }
        }

        public IEnumerator GatherTick()
        {
            while (true)
            {
                yield return new WaitForSeconds(1);
                if (isGathering && heldResource < maxHeldResource) heldResource++;

            }
        }


        private GameObject GetClosestOf(List<GameObject> points)
        {
            return points.OrderBy(x =>
            {
                return Vector3.Distance((x as GameObject).transform.position, transform.position);
            }).FirstOrDefault();

        }

        private void StartGathering(GameObject hitObject)
        {
            gatheringFrom = hitObject;
            hitObject.GetComponent<NodeManager>().AddGatherers(1);
            heldResourceType = hitObject.GetComponent<NodeManager>().resourceType;
            isGathering = true;

        }
        private void StopGathering()
        {
            if (gatheringFrom != null)
            {
                gatheringFrom.GetComponent<NodeManager>().ReduceGatherers(1);
                DeliverResources();
            }
            else
            {
                if (heldResource != 0)
                {
                    DeliverResources();
                }
                else
                {
                    MovementController mc = GetComponent<MovementController>();
                    mc.Move(mc.rallyPoint.transform.position);
                }
            }
            isGathering = false;
        }

        public void SetTask(UnitTasks newTask,int roundLimit=0)
        {
            //TODO to tskmgr
            task = newTask;
            taskRoundLimit = roundLimit;
            taskRoundsFinished = 0;
        }

        private void DeliverResources()
        {
            //TODO: move to a separate class (Interface? Separate component?)
            dropPoints = new List<GameObject>(GameObject.FindGameObjectsWithTag("DropPoint"));
            gameObject.GetComponent<MovementController>().Move(GetClosestOf(dropPoints).transform.position);
            task = UnitTasks.DELIVERING;
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