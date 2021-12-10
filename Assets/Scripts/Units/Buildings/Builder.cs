using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class Builder : MonoBehaviour
    {
        PlayerController player;
        // Start is called before the first frame update
        public List<GameObject> buildingPrototypes;
        void Start()
        {
            player = GetComponent<PlayerController>();
        }

       
        public void PlaceBuilding(GameObject prototype, RaycastHit hit)
        {
            var objectInfo = prototype.GetComponent<ObjectInfo>();
            if (player.Stats.PlayerResourceManager.GetResourceAmount(ResourceTypes.GOLD) > objectInfo.price)
            {
                player.Stats.PlayerResourceManager.AddResource(ResourceTypes.GOLD, -objectInfo.price);
                player.Stats.PlayerResourceManager.AddResource(ResourceTypes.BUILDINGS, 1);
                GameObject newGO = Instantiate(prototype);
                newGO.transform.position = hit.point;
                newGO.transform.rotation = Quaternion.FromToRotation(Vector3.up, hit.normal);
                newGO.GetComponent<ObjectInfo>().Player = player;
                player.Stats.Units.Add(newGO);

            }
            else Debug.Log("Not enough money");
           
        }
    }

}
