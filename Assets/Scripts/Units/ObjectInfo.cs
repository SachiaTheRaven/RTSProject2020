﻿using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.AI;
namespace RTSGame
{
    public class ObjectInfo : MonoBehaviour
    {
        public UnitTasks task;
        public ResourceManager resourceManager;

        public bool isSelected = false;
        public string objectName;
        public int heldResource;
        public ResourceTypes heldResourceType;

        public int maxHeldResource;
        public bool isGathering = false;

        private GameObject gatheringFrom = null;

        List<GameObject> dropPoints;
        void Start()
        {
            StartCoroutine("GatherTick");
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
                            if (resourceManager.stone + heldResource > resourceManager.maxStone)
                            {
                                SetTask(UnitTasks.IDLE);
                            }
                            else
                            {
                                resourceManager.stone += heldResource;
                                heldResource = 0;
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
            Debug.Log("Start Gathering");
            gatheringFrom = hitObject;
            hitObject.GetComponent<NodeManager>().AddGatherers(1);
            heldResourceType = hitObject.GetComponent<NodeManager>().resourceType;
            isGathering = true;

        }
        private void StopGathering()
        {
            Debug.Log("Stop gathering");
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
                    SetTask(UnitTasks.IDLE);
                }
            }
            isGathering = false;
            //gatheringFrom = null;
        }

        public void SetTask(UnitTasks newTask)
        {
            task = newTask;
        }

        private void DeliverResources()
        {
            dropPoints = new List<GameObject>(GameObject.FindGameObjectsWithTag("DropPoint"));
            gameObject.GetComponent<MovementController>().Move(GetClosestOf(dropPoints).transform.position);
            task = UnitTasks.DELIVERING;
        }
    }
}