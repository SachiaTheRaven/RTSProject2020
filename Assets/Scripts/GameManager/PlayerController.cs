using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
namespace RTSGame
{
    public class PlayerController : MonoBehaviour
    {
        // Start is called before the first frame update
        public List<GameObject> units;
        public Selector selector;
        public ResourceManager resourceManager;
        void Start()
        {
            units = new List<GameObject>();
        }

        // Update is called once per frame
        void Update()
        {
            
        }
    }
}