using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace RTSGame
{
    public class EndGameUIControl : MonoBehaviour
    {
        // Start is called before the first frame update
        public TextMeshProUGUI text;
        void Start()
        {
            switch (FindObjectOfType<GameController>().CurrentGameState)
            {
                case GameState.LOST: text.text = "DEFEAT"; break;
                case GameState.WON: text.text = "VICTORY"; break;
                default: text.text = "WTF SOMETHING IS WROMG"; break;
            }
        }

       
    }
}