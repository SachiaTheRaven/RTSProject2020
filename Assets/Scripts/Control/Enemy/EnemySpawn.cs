using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace RTSGame
{
    public class EnemySpawn : ObjectInfo
    {
        public GameObject unitProto; //the type of units to spawn
        private ObjectInfo protoObjectInfo;
        private ResourceManager resourceManager;
        public float spawnCooldown = 10f;
        void Start()
        {
            protoObjectInfo = unitProto.GetComponent<ObjectInfo>();
            resourceManager = Player.Stats.PlayerResourceManager;
            StartCoroutine(SpawnNewUnitCoroutine());
        }

      

        IEnumerator SpawnNewUnitCoroutine()
        {
            while (true)
            {
                if (resourceManager.GetResourceAmount(ResourceTypes.GOLD) > protoObjectInfo.price)
                {
                    resourceManager.AddResource(ResourceTypes.GOLD, -protoObjectInfo.price);
                    CreateUnit();

                }
                yield return new WaitForSeconds(spawnCooldown);
            }
        }

        //TODO copypaste from Trainer, might need a common parent
        public void CreateUnit()
        {
            GameObject newGO = Instantiate(unitProto);
            Vector3 newPos = transform.position + Random.insideUnitSphere * Random.Range(2, 5);
            //TODO consider wether every unit has a movement controller
            newGO.GetComponent<NavMeshAgent>().Warp(newPos);
            var oinfo = newGO.GetComponent<ObjectInfo>();
            oinfo.Player = Player;
            oinfo.PlayerObject = PlayerObject;
        }
    }
}