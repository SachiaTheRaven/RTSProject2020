using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace RTSGame
{
    public class Trainer : GeneralBuilding
    {
        public GameObject unitPrototype;
        public GameObject rallyPoint;
        public GameObject rallyFlag;
        public Transform taskListPanel;
        GameObject unitParent;
        public TextMeshPro cdText;
        bool isDone = true;
        bool movingFlag = false;
        void Start()
        {
            unitParent = new GameObject("UnitParent");
            cdText.enabled = false;
        }

        IEnumerator CountdownCoroutine(int cooldown)
        {
            cdText.enabled = true;
            isDone = false;
            for (int i = 0; i < cooldown; i++)
            {
                cdText.text = (cooldown - i).ToString();
                yield return new WaitForSeconds(1.0f);

            }
            CreateUnit();
            isDone = true;
            cdText.enabled = false;
        }
        public void CreateUnit()
        {
            GameObject newGO = Instantiate(unitPrototype, unitParent.transform);
            Vector3 newPos = transform.position+ Random.insideUnitSphere * Random.Range(1, 5);
            newGO.transform.position = new Vector3(newPos.x, 0.5f, newPos.z);

            newGO.GetComponent<MovementController>().rallyPoint = rallyPoint;
            newGO.GetComponent<ObjectInfo>().player = this.player;
            player.units.Add(newGO);
        }

        public void SetNewRallyPoint(Vector3 point)
        {
            rallyFlag.transform.position = point + Vector3.up * 0.5f;
            rallyPoint.transform.position = point;
        }

        public void TrainNew()
        {
            if (isDone)
            {
                ObjectInfo objectInfo = unitPrototype.GetComponent<ObjectInfo>();
                if (player.resourceManager.GetResourceAmount(ResourceTypes.GOLD) > objectInfo.price)
                {
                    player.resourceManager.AddResource(ResourceTypes.GOLD,-objectInfo.price);
                    player.resourceManager.AddResource(ResourceTypes.POPULATION,1);
                    StartCoroutine("CountdownCoroutine", 3);
                }
                else Debug.Log("Not enough money");

            }
            else Debug.Log("Not ready yet!");
        }
    }
}