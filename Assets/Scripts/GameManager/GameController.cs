using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class GameController : MonoBehaviour
    {
        private static GameController current;
        public static GameController Current
        {
            get
            {
                return current;
            }
        }
        public bool UIon;

        private GameState gameState = GameState.RUNNING;
        public List<ICommonPlayer> players; //don't believe it when it says new() can be simplified. Unity can't handle it.
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
        private void Awake()
        {
            
       /*   Time.timeScale = 0;
            for (int i = 0; i < 10; i++)
            {
                for (int j = 0; j < 10; j++)
                {
                     Instantiate(trainingFieldPrefab, new Vector3(i * 35, 0, j * 35),Quaternion.identity);
                   // tpf.transform.localPosition = new Vector3(i * 15, 0, j * 15);
                }
            }*/
            if (current == null) current = this;
            else if (current != this) Destroy(this);
        }
        private void Start()
        {

            players = new List<ICommonPlayer>();

            players.AddRange(FindObjectsOfType<PlayerController>());
            players.AddRange(FindObjectsOfType<AIPlayer>());
            players.AddRange(FindObjectsOfType<EnemyPlayerController>());

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