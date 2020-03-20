using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame
{


    public class BaseUnit : MonoBehaviour
    {
        // Start is called before the first frame update
        public int price = 1;
        public PlayerController player;
        public bool selected = false;

        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {


        }
        public void ToggleSelection()
        {
            if (selected)
            {
                player.selected.Remove(gameObject);
                selected = false;
            }
            else
            {
                player.selected.Add(gameObject);
                selected = true;
            }
        }
    }
}