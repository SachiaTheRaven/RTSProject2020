﻿using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
namespace RTSGame
{
    public class PlayerController : MonoBehaviour
    {
        // Start is called before the first frame update
        public int gold;
        public int stone;
        public GameObject goldText;
        public GameObject stoneText;
        public List<GameObject> units;

        public List<GameObject> selected;
        void Start()
        {
            units = new List<GameObject>();
            selected = new List<GameObject>();
        }

        // Update is called once per frame
        void Update()
        {
            //goldText.GetComponent<TextMeshProUGUI>().text = gold.ToString();
            // Debug.Log(goldText.GetComponent<TextMeshProUGUI>());
            //stoneText.GetComponent<TextMeshProUGUI>().text = stone.ToString();
        }
    }
}