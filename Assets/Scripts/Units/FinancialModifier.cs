using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame {
    public class FinancialModifier : MonoBehaviour
    {
        // Start is called before the first frame update
        ResourceManager resourceManager;
        public int waitPeriod = 1;
        public int amountMade = 1;


        public void StartFinances()
        {
            resourceManager = GetComponent<ObjectInfo>().Player.Stats.PlayerResourceManager;
            StartCoroutine(DoFinances());
        }

       IEnumerator DoFinances() //the clumsiest name I've ever given to a function. Just imagine small gremlins doing finances and grumbling about it, okay?
        {
            while(true)
            {
                resourceManager.AddResource(ResourceTypes.GOLD,amountMade);
                yield return new WaitForSeconds(waitPeriod);
            }
        }
    }
}