using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

//TODO rally point
namespace RTSGame
{
    public class Trainer : MonoBehaviour
    {
        // Start is called before the first frame update
        public GameObject unitPrototype;
        public GameObject rallyPoint;
        public GameObject rallyFlag;
        GameObject unitParent;
        public PlayerController player;
        public int price;
        public TextMeshPro cdText;
        bool isDone = true;
        bool movingFlag = false;
        void Start()
        {
            unitParent = new GameObject("UnitParent");
            cdText.enabled = false;
            //Instantiate(unitParent);
        }

        // Update is called once per frame
        void Update()
        {

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
            Vector3 newPos = newGO.transform.position + Random.insideUnitSphere * Random.Range(1, 5);
            newGO.transform.position = new Vector3(newPos.x, 0.5f, newPos.z);

            newGO.GetComponent<MovementController>().rallyPoint = rallyPoint;
            newGO.GetComponent<BaseUnit>().player = this.player;
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
                if (player.gold > unitPrototype.GetComponent<BaseUnit>().price)
                {
                    player.gold -= unitPrototype.GetComponent<BaseUnit>().price;
                    StartCoroutine("CountdownCoroutine", 3);
                }
                else Debug.Log("Not enough money");

            }
            else Debug.Log("Not ready yet!");
        }
    }
}