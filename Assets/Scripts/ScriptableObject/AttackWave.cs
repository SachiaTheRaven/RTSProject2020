using System.Collections.Generic;
using UnityEngine;
namespace RTSGame {
    public enum WaveType
    {
        NEAREST,
        WEAKEST
    }
    [CreateAssetMenu(fileName = "AttackWave", menuName = "ScriptableObjects/AttackWaveScriptableObject", order = 1)]
    public class AttackWave : ScriptableObject
    {
        public WaveType waveType;
        public float cooldown;
        public List<UnitTypeDictionaryItem> formation;

       
    }
}