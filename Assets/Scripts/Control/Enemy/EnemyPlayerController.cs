using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using UnityEngine;
using UnityEngine.AI;

namespace RTSGame
{
    [Serializable]
    public class EnemyPlayerController : MonoBehaviour, ICommonPlayer
    {

        //do we want to start several ottacks at once?
        [field: SerializeField]
        public PlayerStats Stats { get; set; }
        public List<EnemySpawn> SpawnPoints;
        public List<AttackWave> AttackWaves;
        List<WaveWrapper> wavesLaunched = new List<WaveWrapper>();
        int lastAttackIDX = -1;
        public WaveAnnouncerControl WaveAnnouncer;


        //TODO maybe separate
        int penalty = 5;
        int killReward = 3;

        private void Start()
        {
            StartCoroutine(WaveCoroutine());
        }
        private void Update()
        {
            //Linq magic, maybe too much effort?

            WaveWrapper closest = wavesLaunched.Where(w=>w.InProgress).OrderBy(w => w.RemainingDistance).FirstOrDefault();
            if (closest == null) WaveAnnouncer.ToggleActiveStatus(false);
            else
            {

                if (!WaveAnnouncer.ActiveStatus)
                {
                    WaveAnnouncer.ToggleActiveStatus(true);
                }
                WaveAnnouncer.SetWaveDirection(closest.Pivot);
                WaveAnnouncer.SetDetailText(closest.actualFormation);
            }

        }
        public void KillUnit(GameObject unit)
        {

            Stats.KillUnit(unit);
            Destroy(unit);

        }

        public void OnListChanged(object sender, NotifyCollectionChangedEventArgs args)
        {
            if (args.OldItems.Count < args.NewItems.Count) Stats.PlayerResourceManager.AddResource(ResourceTypes.GOLD, -penalty);
        }


        public bool ReleaseNewWave(AttackWave wave)
        {
            List<GameObject> attackers = new List<GameObject>();
            List<UnitTypeDictionaryItem> actualFormation = new List<UnitTypeDictionaryItem>();
            foreach (var item in wave.formation)
            {
                var batch = Stats.Units.Where(x =>
                {
                    var oinfo = x.GetComponent<UnitObjectInfo>();
                    var dmg = x.GetComponent<DamageDealer>();
                    return oinfo != null && oinfo.unitType == item.key && oinfo.status == UnitStatus.IDLE && dmg != null && !dmg.inCombat && x.GetComponent<NavMeshAgent>() != null;
                }).Take(item.value).ToList();
                UnitTypeDictionaryItem formItem = new UnitTypeDictionaryItem(item.key,batch.Count);
                actualFormation.Add(formItem);
                attackers.AddRange(batch);

            }
            if (attackers.Count == 0) return false;

            GameObject target = null;

            List<GameObject> targets = FindObjectsOfType<GameObject>().Where(x => x.GetComponent<ObjectInfo>() != null && x.GetComponent<ObjectInfo>().PlayerObject != this.gameObject && x.GetComponent<Destroyable>() != null).ToList();
            if (targets.Count == 0) return false;

            switch (wave.waveType)
            {
                case WaveType.NEAREST:
                    {
                        Vector3 pivot = attackers.Aggregate(Vector3.zero, (acc, x) => acc + x.transform.position) / attackers.Count(); //avg position         

                        target = targets.OrderBy(x => Vector3.Distance(x.transform.position, pivot)).FirstOrDefault();

                    }
                    break;
                case WaveType.WEAKEST:
                    {
                        target = targets.OrderBy(x => x.GetComponent<Destroyable>().HealthPercentage).FirstOrDefault();
                    }
                    break; 
            }
            for (int i = 0; i < attackers.Count; i++)
            {
                var agent = attackers[i].GetComponent<NavMeshAgent>();

                //this expects the attacker to have a targetseeker
                agent.SetDestination(target.transform.position);
            }
            WaveWrapper wrapper = new WaveWrapper(attackers, target,wave,actualFormation);
            wavesLaunched.Add(wrapper);
            
            return true;
        }
        private IEnumerator WaveCoroutine()
        {
            while (true)
            {
                yield return new WaitForSeconds(10); //giving ourselves time to  do shit
                if (lastAttackIDX < AttackWaves.Count - 1)
                {
                    bool success = ReleaseNewWave(AttackWaves[lastAttackIDX + 1]);
                    //Debug.Log("Attack Release " + (lastAttackIDX + 1).ToString() + " successful? " + success);
                    if (success)
                    {
                        lastAttackIDX++;
                        yield return new WaitForSeconds(AttackWaves[lastAttackIDX].cooldown);
                       // Debug.Log("Last Attack Wave:" + lastAttackIDX);
                    }
                    else yield return new WaitForSeconds(1);

                }
                else break;
            }
        }

        public void ScoreKill()
        {
            Stats.PlayerResourceManager.AddResource(ResourceTypes.GOLD, killReward);
        }
    }
}