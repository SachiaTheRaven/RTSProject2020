using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;
namespace RTSGame
{

    public class ResourceManager : MonoBehaviour
    {
        [SerializeField]
        public List<ResourceDictionaryItem> resources;
        [SerializeField]
        public List<ResourceDictionaryItem> startResources;
        [SerializeField]
        public List<ResourceDictionaryItem> maxResources;

        public bool HasDisplay = true;

        //TODO DrawIf propertydrawer or child class bcuz the OOP gods are gonna hate us
        public TextMeshProUGUI stoneDisplay;
        public TextMeshProUGUI ironDisplay;
        public TextMeshProUGUI foodDisplay;
        public TextMeshProUGUI goldDisplay;
        public TextMeshProUGUI populationDisplay;

        void Start()
        {
            resources = new List<ResourceDictionaryItem>();

            foreach (var p in startResources)
            {
                resources.Add(new ResourceDictionaryItem(p));
            }
        }

        //TODO: auto-generate panels from prefabs
        void Update()
        {

            if (HasDisplay && FindObjectOfType<GameController>().UIon)
            {
                stoneDisplay.text = GetResourceAmount(ResourceTypes.STONE).ToString() + "/" + GetMaxResourceAmount(ResourceTypes.STONE).ToString();
                ironDisplay.text = GetResourceAmount(ResourceTypes.IRON).ToString() + "/" + GetMaxResourceAmount(ResourceTypes.IRON).ToString();
                foodDisplay.text = GetResourceAmount(ResourceTypes.FOOD).ToString() + "/" + GetMaxResourceAmount(ResourceTypes.FOOD).ToString(); //TODO consider if necessary
                goldDisplay.text = GetResourceAmount(ResourceTypes.GOLD).ToString() + "/" + GetMaxResourceAmount(ResourceTypes.GOLD).ToString();
                populationDisplay.text = GetResourceAmount(ResourceTypes.POPULATION).ToString() + "/" + GetMaxResourceAmount(ResourceTypes.POPULATION).ToString();
            }

        }

        public int RemainingCapacity(ResourceTypes type)
        {
            return GetMaxResourceAmount(type) - GetResourceAmount(type);
        }

        public void AddResource(ResourceTypes type, int amount)
        {
            if (resources != null)
            {
                int newAmount = GetResourceAmount(type) + amount;
                int maxAmount = GetMaxResourceAmount(type);
                if (newAmount <= 0) SetResourceAmount(type, 0);
                else if (newAmount <= maxAmount) SetResourceAmount(type, newAmount);
                else SetResourceAmount(type, maxAmount);
            }
        }
        public int GetResourceAmount(ResourceTypes type)
        {
            var res = resources.Where(x => x.key == type).FirstOrDefault();
            return res == null ? 0 : res.value;
        }
        public void ResetResources()
        {
            /*foreach(var res in resources)
            {
                SetResourceAmount(res.key, GetMaxResourceAmount(res.key));
            }*/
            SetResourceAmount(ResourceTypes.GOLD, GetMaxResourceAmount(ResourceTypes.GOLD));
        }
        public void SetResourceAmount(ResourceTypes type, int amount)
        {
            var res = resources.Where(x => x.key == type).FirstOrDefault();
            if (res != null) res.value = amount;
        }
        public int GetMaxResourceAmount(ResourceTypes type)
        {
            var res = maxResources.Where(x => x.key == type).FirstOrDefault();
            return res == null ? 0 : res.value;
        }
    }
}