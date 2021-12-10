using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RTSGame
{
    public class CreateUnitButtonScript : MonoBehaviour
    {
        // Start is called before the first frame update
        public GameObject unitPrefab; //to be set when instantiated
        public TaskManager tmg;
        public CreateUnitPanel parentPanel;

        void Start()
        {
            //TODO set pic

            GetComponentInChildren<TextMeshProUGUI>().text = unitPrefab.name;
        }

        public void OnClickCreate()
        {
            tmg.CreateTask(unitPrefab, ActionType.BUILD,0); //create build action
            parentPanel.Hide();
        }


    }
}