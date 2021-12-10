using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using UnityEditor.Experimental.GraphView;
using UnityEngine;
using UnityEngine.UIElements;

namespace RTSGame
{
    [RequireComponent(typeof(MovementController))]
    public class GatheringController : MonoBehaviour
    {
        //references to other components of this go we use multiple times
        MovementController movementController;
        UnitObjectInfo objectInfo;
        TaskManager taskManager;

        //references to components of other go's
        public ResourceManager resourceManager;

        public Dictionary<ResourceTypes, ResourceBlock> heldResources = new Dictionary<ResourceTypes, ResourceBlock>();
        public int maxHeldResourcePerBlock = 5;
        public bool isGathering = false;
        private GameObject gatheringFrom = null;
        private NodeManager nodeManager = null;
        List<GameObject> dropPoints;




        void Start()
        {
            movementController = GetComponent<MovementController>();
            if (movementController == null) throw new Exception("No MovementController found!");

            objectInfo = GetComponent<UnitObjectInfo>();
            if (objectInfo == null) throw new Exception("No ObjectInfo found!");

            resourceManager =objectInfo.Player.Stats.PlayerResourceManager;
            if (resourceManager == null) throw new Exception("No ResourceManager found!");


            taskManager = GetComponent<TaskManager>();
            if (taskManager == null) throw new Exception("No TaskManager found!");

            //todo sounds like wasting resources
            StartCoroutine(GatherTick());
        }

        // Update is called once per frame
        void Update()
        {
            if (nodeManager != null && heldResources.ContainsKey(nodeManager.resourceType))
            {
                ResourceBlock blockToUpdate = heldResources[nodeManager.resourceType];
                if ((blockToUpdate.amount == blockToUpdate.maxAmount || gatheringFrom == null) && isGathering)
                {
                    //go back to drop-off point
                    StopGathering();
                }
            }

        }

        private void StartGathering(GameObject resourceGameObject)
        {
            gatheringFrom = resourceGameObject;
            nodeManager = resourceGameObject.GetComponent<NodeManager>();
            isGathering = true;
            if (!heldResources.ContainsKey(nodeManager.resourceType) ||heldResources[nodeManager.resourceType].amount==0)
            {
                ResourceBlock newBlock = new ResourceBlock();
                newBlock.amount = 0;
                newBlock.maxAmount = maxHeldResourcePerBlock;
                newBlock.type = nodeManager.resourceType;
                heldResources[nodeManager.resourceType] = newBlock;

                if(objectInfo.isSelected)
                    FindObjectOfType<UnitUIManager>()?.InsertInventoryItem(this, nodeManager.resourceType,GetComponent<ObjectInfo>());

            }

        }

        private void StopGathering()
        {

            if (heldResources[nodeManager.resourceType].amount != 0)
            {
                DeliverResources();
            }
            isGathering = false;
        }

        private void DeliverResources()
        {
            //TODO is it really necessary to get this list every time we deliver?
            dropPoints = new List<GameObject>(GameObject.FindGameObjectsWithTag("DropPoint"));
            movementController.Move(GetClosestOf(dropPoints).transform.position);
            objectInfo.status = UnitStatus.DELIVERING;
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
                        if (objectInfo.status == UnitStatus.GATHERING && !isGathering)
                        {
                            StartGathering(hitObject);
                        }
                    }
                    break;
                case "DropPoint":
                    {
                        if (objectInfo.status == UnitStatus.DELIVERING)
                        {
                            UnloadResources();
                            if(taskManager.taskInProgress!=null &&!taskManager.taskInProgress.IsFinished() && gatheringFrom!=null)
                            {
                                movementController.Move(gatheringFrom.transform.position);
                                objectInfo.status = UnitStatus.GATHERING;
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
                if (isGathering && !heldResources[nodeManager.resourceType].IsFull && gatheringFrom!=null)
                {
                    gatheringFrom.GetComponent<NodeManager>().Gather(1);
                    heldResources[nodeManager.resourceType].AddResource(1);
                }
            }
        }

        void UnloadResources()
        {
            foreach (ResourceTypes type in heldResources.Keys)
            {
                int remainingCapacity = resourceManager.RemainingCapacity(type);

                resourceManager.AddResource(type, heldResources[type].amount);
                heldResources[type].AddResource(-Math.Min(remainingCapacity, heldResources[type].amount));

                ActionOnObject currentAction = taskManager.taskInProgress as ActionOnObject;
                if(currentAction!=null)
                {
                    if (resourceManager.RemainingCapacity(type) == 0)
                        currentAction.roundsFinished = currentAction.maxRounds;
                    else currentAction.roundsFinished++;
                }               
                

            }

        }

    }

}
