using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{

    public class NodeManager : ObjectInfo
    {
        public ResourceTypes resourceType;
        public float availableResource;
        public ParticleSystem explosionEffect;
       
        void Update()
        {
            if (availableResource <= 0)
            {
                if(Player!=null && Player is AIPlayer aiPlayer)
                {
                    Debug.Log("Ending episode due to no more mining thingy");
                    aiPlayer.EndEpisode();

                }
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
