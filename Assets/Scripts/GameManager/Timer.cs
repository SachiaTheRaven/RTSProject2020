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
        GameController gc;
        void Start()
        {
            gc = FindObjectOfType<GameController>();

            StartCoroutine("Tick");

        }


        private IEnumerator Tick()
        {
            while (true)
            {
                yield return new WaitForSeconds(1);
                currentSeconds++;
                if (FindObjectOfType<GameController>().UIon)
                {
                    DisplayTime();
                }
                if (currentSeconds >= timeLimit)
                {
                    //gc.CurrentGameState = GameState.WON;
                    gc.players.ForEach(x=>x.AddReward(1.0f));
                    gc.players.ForEach(x => x.EndEpisode());

                }
            }

        }
        private void DisplayTime()
        {

            timerText.text = currentSeconds / 60 + ":" + currentSeconds % 60;
        }
    }
}