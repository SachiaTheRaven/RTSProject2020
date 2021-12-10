using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using UnityEditor;
using UnityEngine;
namespace RTSGame
{
    [Serializable]
    public class PlayerController : MonoBehaviour, ICommonPlayer
    {

        public Selector PlayerSelector;
        [field: SerializeField]
        public PlayerStats Stats { get ; set; }

        public void KillUnit(GameObject unit)
        {
            Stats.KillUnit(unit);

            if (PlayerSelector.primaryObject == unit) PlayerSelector.primaryObject = null;
            if (PlayerSelector.selectedObjects.Contains(unit.GetComponent<ObjectInfo>())) PlayerSelector.selectedObjects.Remove(unit.GetComponent<ObjectInfo>());
            Destroy(unit);


        }
        public void Start()
        {
            Stats.GameEventManager = GetComponent<GameEvent>();
            Stats.Units = new ObservableCollection<GameObject>();
            Stats.Units.CollectionChanged += OnListChanged;



        }
        public void OnListChanged(object sender, NotifyCollectionChangedEventArgs args)
        {
            if (Stats.Units.Count == 0)
            {
                //TODO Loss Switch
                //FindObjectOfType<GameController>().CurrentGameState = GameState.LOST;
                PlayerSelector.ReleaseUI();
            }
        }

        public void ScoreKill()
        {
            Stats.PlayerResourceManager.AddResource(ResourceTypes.GOLD, 1); //TODO set amount
        }
    }
}