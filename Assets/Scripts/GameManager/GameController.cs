using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class GameController : MonoBehaviour
    {
        public bool UIon;

        private GameState gameState = GameState.RUNNING;
        public List<PlayerController> players = new List<PlayerController>();
        public GameObject trainingFieldPrefab;
       // public PlayerController mainPlayer;
        public GameState CurrentGameState
        {
            get { return gameState; }
            set
            {
                gameState = value;
                if(gameState==GameState.LOST || gameState== GameState.WON)
                {
                    EndGame(gameState);
                }
            }
        }

        private void Start()
        {
            /*for(int i = 0; i<10;i++)
            {
                for(int j = 0; j<10;j++)
                {
                    var newTrainingField = Instantiate(trainingFieldPrefab);
                    newTrainingField.transform.position += new Vector3(i*12, 0, j*12);
                }
            }
            Time.timeScale = 0;*/
            players = new List<PlayerController>(FindObjectsOfType<PlayerController>());
            DontDestroyOnLoad(this.gameObject);
        }
        void EndGame(GameState gameState) //TODO: reconsider whether gamestate check is needed
        {
            switch(gameState)
            {               
                case GameState.RUNNING: Debug.LogError("Error: Game Trying To End Without Ending State"); break;
                default: FindObjectOfType<SceneChangeControl>().LoadScene("EndScene");break;
            }
        }

    }
    
}