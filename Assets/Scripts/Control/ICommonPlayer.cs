using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using UnityEngine;


namespace RTSGame {
    //things that are similar in all player types
    public interface ICommonPlayer
    {
        [property: SerializeField]
        PlayerStats Stats { get; set; }
        void KillUnit(GameObject unit);
        void OnListChanged(object sender, NotifyCollectionChangedEventArgs args);
        void ScoreKill();


    }
}