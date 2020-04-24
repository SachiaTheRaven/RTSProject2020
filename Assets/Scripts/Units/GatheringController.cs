using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UIElements;

namespace RTSGame
{

    public class GatheringController : MonoBehaviour
    {
        //references to other components of this go we use multiple times
        MovementController movementController;
        ObjectInfo objectInfo;
        TaskManager taskManager;

        //references to components of other go's
        public ResourceManager resourceManager;

        public int heldResource;
        public ResourceTypes heldResourceType;
        public int maxHeldResource;
        public bool isGathering = false;
        private GameObject gatheringFrom = null;
        List<GameObject> dropPoints;



        void Start()
        {
            resourceManager = FindObjectOfType<ResourceManager>();
            if (resourceManager == null) throw new Exception("No ResourceManager found!");

            //TODO maybe [requirecomponent]?
            movementController = GetComponent<MovementController>();
            if (movementController == null) throw new Exception("No MovementController found!");
            objectInfo = GetComponent<ObjectInfo>();
            if (objectInfo == null) throw new Exception("No ObjectInfo found!");
            taskManager = GetComponent<TaskManager>();
            if (taskManager == null) throw new Exception("No TaskManager found!");

            //todo sounds like wasting resources
            StartCoroutine("GatherTick");
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

        private void StartGathering(GameObject resourceGameObject)
        {
            gatheringFrom = resourceGameObject;
            isGathering = true;

            NodeManager nodeManager = resourceGameObject.GetComponent<NodeManager>();
            nodeManager.AddGatherers(1);
            heldResourceType = nodeManager.resourceType;
        }

        private void StopGathering()
        {
            if (heldResource != 0)
            {
                DeliverResources();
            }
            if (gatheringFrom != null)
            {
                gatheringFrom.GetComponent<NodeManager>().ReduceGatherers(1);
            }
            else
            {
                //TODO return to rally point function
                movementController.Move(movementController.rallyPoint.transform.position);
            }
            isGathering = false;
        }

        private void DeliverResources()
        {
            //TODO is it really necessary to get this list every time we deliver?
            dropPoints = new List<GameObject>(GameObject.FindGameObjectsWithTag("DropPoint"));
            movementController.Move(GetClosestOf(dropPoints).transform.position);
            objectInfo.Status = UnitStatus.DELIVERING;
        }

        //TODO this is pretty generic, are you sure this belongs here?
        private GameObject GetClosestOf(List<GameObject> points)
        {
            return points.OrderBy(x =>
            {
                return Vector3.Distance((x as GameObject).transform.position, transform.position);
            }).FirstOrDefault();
        }
        public void OnTriggerEnter(Collider other)
        {
            GameObject hitObject = other.gameObject;
            switch (hitObject.tag)
            {
                case "Resource":
                    {
                        if (objectInfo.Status == UnitStatus.GATHERING)
                        {
                            StartGathering(hitObject);
                        }
                    }
                    break;
                case "DropPoint":
                    {
                        if (objectInfo.Status == UnitStatus.DELIVERING)
                        {
                            UnloadResources();
                            if (!taskManager.taskInProgress.IsFinished())
                            {
                                movementController.Move(gatheringFrom.transform.position);
                                objectInfo.Status = UnitStatus.GATHERING;
                            }
                            else
                            {
                                movementController.Move(movementController.rallyPoint.transform.position);

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

        void UnloadResources()
        {
            //todo make it general, use a map
            int remainingCapacity = resourceManager.maxStone - resourceManager.stone;
            if (remainingCapacity >= heldResource)
            {
                resourceManager.stone += heldResource;
                heldResource = 0;
                if ((taskManager.taskInProgress as ActionOnObject).HasRoundLimit) (taskManager.taskInProgress as ActionOnObject).roundsFinished++;

            }
            else
            {
                heldResource -= remainingCapacity;
                resourceManager.stone = resourceManager.maxStone;
                (taskManager.taskInProgress as ActionOnObject).roundsFinished = (taskManager.taskInProgress as ActionOnObject).maxRounds;
            }
        }

    }

}
