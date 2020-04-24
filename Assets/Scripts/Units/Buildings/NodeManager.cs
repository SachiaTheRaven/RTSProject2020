using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    
    public class NodeManager : MonoBehaviour
    {    
        public ResourceTypes resourceType;

        public float harvestTime;
        public float availableResource;

        private int numberOfGatherers=0;

        private int excessGatherers = 0;
        
        void Start()
        {
            StartCoroutine("ResourceTick");
        }
        void Update()
        {
            if (availableResource <= 0) Destroy(gameObject);
            //TODO play a destroying thingy, like a particle effect or something
        }
        public void ResourceGather()
        {
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
