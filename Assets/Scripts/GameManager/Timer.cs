using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;

namespace RTSGame
{
    public class Timer : MonoBehaviour
    {
        private static Timer current;
        public static Timer Current
        {
            get
            {
                return current;
            }
        }
        public int currentSeconds = 0;
        private int timeLimit = 120;
        public TextMeshProUGUI timerText;
        GameController gc;
        private void Awake()
        {
            if (current == null) current = this;
            else if (current != this) Destroy(this);
        }
        void Start()
        {

            gc = GameController.Current;

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
               /* if (currentSeconds >= timeLimit)
                {
                    //gc.CurrentGameState = GameState.WON;
                    //TODO maybe külön kéne szedni a Timertől
                    gc.players.ForEach(x=> {
                        if (x is AIPlayer)
                        {
                            //(x as AIPlayer).AddReward(1.0f);
                            (x as AIPlayer).EndEpisode();
                        }
                    });
                    currentSeconds = 0;
                    Debug.Log("Time down!");

                }*/
            }

        }
        private void DisplayTime()
        {

            timerText.text = currentSeconds / 60 + ":" + currentSeconds % 60;
        }

    
    }
}