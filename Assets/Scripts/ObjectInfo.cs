using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
namespace RTSGame
{
    public class ObjectInfo : MonoBehaviour
    {
        public bool isSelected = false;
        public string objectName;
        public NavMeshAgent agent;
        public int heldResource;
        public ResourceTypes heldResourceType;

        public int maxHeldResource;
        public bool isGathering = false;
        // Start is called before the first frame update
        void Start()
        {
            StartCoroutine("GatherTick");
        }

        // Update is called once per frame
        void Update()
        {
            if(heldResource>=maxHeldResource)
            {
                //go back to drop-off point
            }
        }

        public void OnTriggerEnter(Collider other)
        {
            GameObject hitObject = other.gameObject;

            if (hitObject.CompareTag("Resource"))
            {
                hitObject.GetComponent<NodeManager>().numberOfGatherers++;
                heldResourceType = hitObject.GetComponent<NodeManager>().resourceType;
                isGathering = true;

            }
        }
        public void OnTriggerExit(Collider other)
        {
            GameObject hitObject = other.gameObject;
            if (hitObject.CompareTag("Resource"))
            {
                hitObject.GetComponent<NodeManager>().numberOfGatherers--;
                isGathering = false;
            }
        }

        public IEnumerator GatherTick()
        {
            while(true)
            {
                yield return new WaitForSeconds(1);
               if(isGathering && heldResource<maxHeldResource) heldResource++;

            }
        }
    }
}