using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public enum ResourceTypes
    {
        STONE

    };
    public class NodeManager : MonoBehaviour
    {
        // Start is called before the first frame update
      

        public ResourceTypes resourceType;

        public float harvestTime;
        public float availableResource;

        private int numberOfGatherers=0;

        private int excessGatherers = 0;
        
        void Start()
        {
            StartCoroutine("ResourceTick");

        }

        // Update is called once per frame
        void Update()
        {
            if (availableResource <= 0) Destroy(gameObject);
        }
        public void ResourceGather()
        {
            //TODO: remove gatherer when not gathering

            if (numberOfGatherers>0)
                availableResource-=numberOfGatherers;
        }
        IEnumerator ResourceTick()
        {
            while (true)
            {
                yield return new WaitForSeconds(1);
                ResourceGather();
                numberOfGatherers -= excessGatherers;
                excessGatherers = 0;
            }
        }

        public void ReduceGatherers(int number)
        {
            excessGatherers += number;
        }

        internal void AddGatherers(int number)
        {
            numberOfGatherers += number;
        }
    }

}
