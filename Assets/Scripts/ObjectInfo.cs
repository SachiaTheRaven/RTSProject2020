using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.AI;
namespace RTSGame
{
    public class ObjectInfo : MonoBehaviour
    {
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
        }

        // Update is called once per frame
        void Update()
        {
            if (heldResource >= maxHeldResource && isGathering)
            {
                //go back to drop-off point
                StopGathering();
                dropPoints = new List<GameObject>(GameObject.FindGameObjectsWithTag("DropPoint"));
                gameObject.GetComponent<MovementController>().Move(GetClosestOf(dropPoints).transform.position);

            }
        }


        public void OnTriggerEnter(Collider other)
        {
            GameObject hitObject = other.gameObject;

            if (hitObject.CompareTag("Resource"))
            {
                StartGathering(hitObject);
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
            gatheringFrom.GetComponent<NodeManager>().ReduceGatherers(1);
            isGathering = false;
            gatheringFrom = null;
        }
    }
}