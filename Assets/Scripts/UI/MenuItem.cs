using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace RTSGame
{
    public class MenuItem : MonoBehaviour
    {
        //TODO let's not do this
        //make this automatic when you're finally awake pls
        public GameObject prototype;
        public Menucontroller menu;
        public Selector selector;
        TextMeshProUGUI ButtonText;
        private void Start()
        {
            ButtonText = GetComponentInChildren<TextMeshProUGUI>();
            if (prototype != null)
            {
                ButtonText.text = prototype.GetComponent<GeneralBuilding>().buildingName;

            }
        }
        public void BuildClick()
        {
            Debug.Log("bump "+ButtonText.text );
            if(prototype!=null)
            {
                //make wheel disappear
                menu.ToggleMenuVisibility();

                //get click of position
                selector.StartBuilding(prototype);
            }


        }

    }

}
