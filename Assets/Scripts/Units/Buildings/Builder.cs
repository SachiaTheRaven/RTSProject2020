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

        // Update is called once per frame
        void Update()
        {

        }

        public void PlaceBuilding(GameObject prototype, Vector3 position)
        {
            var objectInfo = prototype.GetComponent<GeneralBuilding>();
            if (player.resourceManager.GetResourceAmount(ResourceTypes.GOLD) > objectInfo.price)
            {
                player.resourceManager.AddResource(ResourceTypes.GOLD, -objectInfo.price);
                player.resourceManager.AddResource(ResourceTypes.BUILDINGS, 1);
                GameObject newGO = Instantiate(prototype);
                newGO.transform.position = position;
                newGO.GetComponent<GeneralBuilding>().player = player;
                player.buildings.Add(newGO);

            }
            else Debug.Log("Not enough money");
           
        }
    }

}
