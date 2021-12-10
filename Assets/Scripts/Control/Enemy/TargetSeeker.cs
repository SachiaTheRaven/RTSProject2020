using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.AI;

namespace RTSGame
{
    public class TargetSeeker : MonoBehaviour
    {
        public float lookRadius = 10f;
        public float followRadius = 5.0f;
        ObjectInfo objectInfo;
        // TODO ezt szétszedni külön komponensbe.
        //ScriptableObject? Egységenként, de inkább támadásonként


        DamageDealer dmg;
        List<Destroyable> inRange;
        NavMeshAgent agent;
        void Start()
        {
            inRange = new List<Destroyable>();
            agent = GetComponent<NavMeshAgent>();
            GetComponent<CapsuleCollider>().radius = lookRadius;
            dmg= GetComponent<DamageDealer>();
            objectInfo = GetComponent<ObjectInfo>();
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
       
        private Destroyable GetNewTarget()
        {
            List<Destroyable> inAttackRange = inRange.Where(potentialTarget =>potentialTarget!=null && Vector3.Distance(potentialTarget.transform.position, transform.position) < followRadius) //Get targets in attack range
                .OrderBy(potentialTarget=> Vector3.Distance(potentialTarget.transform.position, transform.position)).ToList(); //order them by closeness

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
            if (IsEnemy(other) && dest!=null) inRange.Add(dest);
        }

        public void OnTriggerExit(Collider other)
        {
            var dest = other.GetComponent<Destroyable>();
            if (IsEnemy(other) && dest!=null) inRange.Remove(dest);

        }

        private bool IsEnemy(Collider other)
        {
            //Aki nem barátunk, az ellenségünk, I guess
            var oinfo = other!=null?other.GetComponent<ObjectInfo>():null;
            return objectInfo!=null &&(objectInfo.PlayerObject==null ||
                oinfo!=null&& oinfo.PlayerObject!=null && !oinfo.PlayerObject.Equals(this.objectInfo.PlayerObject));
        }
    }
}