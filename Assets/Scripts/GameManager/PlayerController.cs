using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using TMPro;
using UnityEngine;
namespace RTSGame
{
    public class PlayerController : MonoBehaviour
    {
        // Start is called before the first frame update
        public ObservableCollection<GameObject> units;
        public Selector selector;
        public ResourceManager resourceManager;
        void Start()
        {
            units = new ObservableCollection<GameObject>();
            units.CollectionChanged += OnListChanged;
        }      
            
          private void OnListChanged(object sender, NotifyCollectionChangedEventArgs args)
        {
             if (units.Count == 0)
            {
                FindObjectOfType<GameController>().CurrentGameState = GameState.LOST;
                Debug.Log("We lost");
            }
        }

        public void KillUnit(GameObject unit)
        {
            resourceManager.AddResource(ResourceTypes.POPULATION, -1);
            units.Remove(unit);
        }
    }
}