using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{

    public class NodeManager : MonoBehaviour
    {
        public ResourceTypes resourceType;
        public float availableResource;
        public ParticleSystem explosionEffect;
        void Start()
        {
        }
        void Update()
        {
            if (availableResource <= 0)
            {
                
                Destroy(gameObject);
            }

            //TODO play a destroying thingy, like a particle effect or something
        }       
        public void Gather(int amount)
        {
            availableResource -= amount;
        }
    }

}
