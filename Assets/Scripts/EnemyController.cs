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
        public float attackRadius = 0.25f;
        public float attackSpeed = 1.0f;
        public float attackCooldown = 0.0f;
        public int attackDamage = 10;
        // TODO ezt szétszedni külön komponensbe.
        //ScriptableObject? Egységenként, de inkább támadásonként

        List<Transform> inRange;
        public Transform target = null;
        NavMeshAgent agent;
        void Start()
        {
            inRange = new List<Transform>();
            agent = GetComponent<NavMeshAgent>();
            GetComponent<CapsuleCollider>().radius = lookRadius;
            attackCooldown = attackSpeed;
        }

        //TODO add tracking culling
        void Update()
        {
            attackCooldown += Time.deltaTime;
            if (target == null)
            {
                if (inRange.Count > 0)
                {
                    target = GetNewTarget();
                    if (target != null) inRange.Remove(target);

                }
            }
            else
            {
                float distance = Vector3.Distance(target.position, transform.position);
                if (distance > followRadius) target = null;
                else
                {
                    agent.SetDestination(target.position);

                    if (distance < attackRadius)
                    {
                        Attack(target.GetComponent<Destroyable>());
                    }

                }

            }
        }
        void Attack(Destroyable target)
        {
            if(attackCooldown>attackSpeed)
            {
                target.Damage(attackDamage);
                attackCooldown = 0.0f;
            }
        }
        private Transform GetNewTarget()
        {
            List<Transform> inAttackRange = inRange.Where(potentionalTarget => Vector3.Distance(potentionalTarget.position, transform.position) < followRadius).ToList();
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
            if (other.gameObject.CompareTag("Selectable")) inRange.Add(other.transform);
        }

        public void OnTriggerExit(Collider other)
        {
            if (other.gameObject.CompareTag("Selectable")) inRange.Remove(other.transform);

        }
    }
}