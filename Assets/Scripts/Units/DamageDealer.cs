using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{

    public class DamageDealer : MonoBehaviour
    {
        public int dmg = 7;
        public float attackSpeed = 1;
        public float attackRange = 3;

        Destroyable target;
        public bool inCombat = false;
        public bool startedAttack = false;

        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {

            if (target != null && !startedAttack && GetTargetDistance() < attackRange)
            {
                Debug.Log("in range!");
                StartCoroutine(AttackCoroutine());
                startedAttack = true;
            }
        }

        public void SetTarget(Destroyable targ)
        {
            target = targ;
        }

        public void ClearTarget()
        {
            target = null;
            inCombat = false;
            startedAttack = false;
        }

        IEnumerator AttackCoroutine()
        {
            while (inCombat)
            {
                if (target == null)
                {
                    startedAttack = false;
                    inCombat = false;
                    break;
                }
                Debug.Log("boop");
                target.Damage(dmg, gameObject);
                yield return new WaitForSeconds(attackSpeed);
            }
        }

        public void FightBack(Destroyable attacker)
        {
            GameEvent.current.SendAction(attacker.gameObject, ActionType.ATTACK, 0); //code duplication
        }

        public bool HasTarget()
        {
            return target != null;
        }

        public float GetTargetDistance()
        {
            if (target != null)
            {
                return Vector3.Distance(target.transform.position, transform.position);
            }
            else return -1;
        }

        public Vector3 GetTargetPosition()
        {
            return target.transform.position;
        }
    }
}