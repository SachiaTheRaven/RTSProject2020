using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.AI;

namespace RTSGame
{
    public class EnemyController : MonoBehaviour
    {
        public float lookRadius = 10f;
        public float followRadius = 5.0f;
        // TODO ezt szétszedni külön komponensbe.
        //ScriptableObject? Egységenként, de inkább támadásonként


        DamageDealer dmg;
        List<Destroyable> inRange;
        //public Transform target = null;
        NavMeshAgent agent;
        void Start()
        {
            inRange = new List<Destroyable>();
            agent = GetComponent<NavMeshAgent>();
            GetComponent<CapsuleCollider>().radius = lookRadius;
            dmg= GetComponent<DamageDealer>();
        }

        void Update()
        {
            if (!dmg.HasTarget())
            {
                if (inRange.Count > 0)
                {
                    var target = GetNewTarget();
                    if (target != null)
                    {
                        inRange.Remove(target);
                        dmg.inCombat = true; //TODO bad design, move to DMG
                        dmg.SetTarget(target);
                    }

                }
            }
            else
            {
                float distance = dmg.GetTargetDistance();
                if (distance > followRadius) dmg.ClearTarget();
                else
                {
                    agent.SetDestination(dmg.GetTargetPosition());
                }

            }
        }
       
        //TODO remove dead person from attack list - is this still a problem?
        private Destroyable GetNewTarget()
        {
            List<Destroyable> inAttackRange = inRange.Where(potentionalTarget =>potentionalTarget!=null && Vector3.Distance(potentionalTarget.transform.position, transform.position) < followRadius).ToList();
            if (inAttackRange.Count > 0)
            {
                var target = inAttackRange.FirstOrDefault();
                return target;
            }
            return null;
        }
        private void OnDrawGizmosSelected()
        {
            Gizmos.color = Color.red;
            Gizmos.DrawWireSphere(transform.position, lookRadius);


        }
        public void OnTriggerEnter(Collider other)
        {
            var dest = other.GetComponent<Destroyable>();
            if (other.gameObject.CompareTag("Selectable") && dest!=null) inRange.Add(dest);
        }

        public void OnTriggerExit(Collider other)
        {
            var dest = other.GetComponent<Destroyable>();
            if (other.gameObject.CompareTag("Selectable")&& dest!=null) inRange.Remove(dest);

        }
    }
}