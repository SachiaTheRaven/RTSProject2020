using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
namespace RTSGame
{
    public class ResourceManager : MonoBehaviour
    {

        Dictionary<ResourceTypes, int> resources;
        Dictionary<ResourceTypes, int> maxResources;

        public TextMeshProUGUI stoneDisplay;
        public TextMeshProUGUI ironDisplay;
        public TextMeshProUGUI foodDisplay;
        public TextMeshProUGUI goldDisplay;
        public TextMeshProUGUI populationDisplay;
        void Start()
        {
            resources = new Dictionary<ResourceTypes, int>();
            maxResources = new Dictionary<ResourceTypes, int>();

            //TODO: körülményes, máshogy kéne
            resources.Add(ResourceTypes.FOOD, 0);
            resources.Add(ResourceTypes.IRON, 0);
            resources.Add(ResourceTypes.STONE, 0);
            resources.Add(ResourceTypes.POPULATION, 0);
            resources.Add(ResourceTypes.GOLD, 150);
            resources.Add(ResourceTypes.BUILDINGS, 3);
            
            maxResources.Add(ResourceTypes.FOOD, 100);
            maxResources.Add(ResourceTypes.IRON, 100);
            maxResources.Add(ResourceTypes.STONE, 100);
            maxResources.Add(ResourceTypes.POPULATION, 100);
            maxResources.Add(ResourceTypes.GOLD, 1000);
            maxResources.Add(ResourceTypes.BUILDINGS, 10);
        }

        //TODO: auto-generate panels from prefabs
        void Update()
        {
            
            if(FindObjectOfType<GameController>().UIon)
            {
                stoneDisplay.text = resources[ResourceTypes.STONE].ToString() + "/" + maxResources[ResourceTypes.STONE].ToString();
                ironDisplay.text = resources[ResourceTypes.IRON].ToString() + "/" + maxResources[ResourceTypes.IRON].ToString();
                foodDisplay.text = resources[ResourceTypes.FOOD].ToString() + "/" + maxResources[ResourceTypes.FOOD].ToString();
                goldDisplay.text = resources[ResourceTypes.GOLD].ToString() + "/" + maxResources[ResourceTypes.GOLD].ToString();
                populationDisplay.text = resources[ResourceTypes.POPULATION].ToString() + "/" + maxResources[ResourceTypes.POPULATION].ToString();
            }
            
        }

        public int RemainingCapacity(ResourceTypes type)
        {
            return maxResources[type] - resources[type];
        }

        public void AddResource(ResourceTypes type, int amount)
        {
            if (resources[type] + amount <= maxResources[type]) resources[type] += amount;
            else resources[type] = maxResources[type];
        }
        public int GetResourceAmount(ResourceTypes type)
        { return resources[type]; }
    }
}