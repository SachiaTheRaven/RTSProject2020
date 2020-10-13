using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace RTSGame
{
    public class Timer : MonoBehaviour
    {
        public int currentSeconds = 0;
        private int timeLimit = 60;
        public TextMeshProUGUI timerText;
        void Start()
        {
            StartCoroutine("Tick");
        }


        private IEnumerator Tick()
        {
            while (true)
            {
                yield return new WaitForSeconds(1);
                currentSeconds++;
                DisplayTime();
                if (currentSeconds >= timeLimit)
                {
                    FindObjectOfType<GameController>().CurrentGameState = GameState.WON;

                }
            }

        }
        private void DisplayTime()
        {
            timerText.text = currentSeconds / 60 + ":" + currentSeconds % 60;
        }
    }
}