using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

namespace RTSGame
{
    public class WaveWrapper
    {       
        List<GameObject> attackers =null;
        GameObject target = null;
        public AttackWave wave = null;
        public List<UnitTypeDictionaryItem> actualFormation;

        public Vector3 Pivot { get { return attackers.Aggregate(Vector3.zero, (acc, x) => acc + x.transform.position) / attackers.Count(); } }
        public bool InProgress
        {
            //returns true if the combat is in progress
            get { return attackers.Count(x => x != null) > 0 && target != null; }

        }
        public float RemainingDistance
        {
            get { return Vector3.Distance(Pivot, target.transform.position); }
        }
        public WaveWrapper(List<GameObject> a, GameObject t,AttackWave w,List<UnitTypeDictionaryItem> f) => (attackers, target,wave,actualFormation) = (a, t,w,f);


    }
}