using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
namespace RTSGame
{
    public class ResourceManager : MonoBehaviour
    {
        public int stone;
        public int maxStone;
        public int iron;
        public int maxIron;
        public int food;
        public int maxFood;
        public int gold;
        public int maxGold;
        public int population;
        public int maxPopulation;

        public TextMeshProUGUI stoneDisplay;
        public TextMeshProUGUI ironDisplay;
        public TextMeshProUGUI foodDisplay;
        public TextMeshProUGUI goldDisplay;
        public TextMeshProUGUI populationDisplay;
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            stoneDisplay.text = stone.ToString() + "/" + maxStone.ToString();
            ironDisplay.text = iron.ToString() + "/" + maxIron.ToString();
            foodDisplay.text = food.ToString() + "/" + maxFood.ToString();
            goldDisplay.text = gold.ToString() + "/" + maxGold.ToString();
            populationDisplay.text = population.ToString() + "/" + maxPopulation.ToString();
        }
    }
}