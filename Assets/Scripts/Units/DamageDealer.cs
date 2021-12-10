using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;

namespace RTSGame
{

    public class DamageDealer : MonoBehaviour
    {
        public int dmg = 7;
        public float attackCooldown = 1;
        public float attackRange = 3;

        Destroyable target;
        public bool inCombat = false;
        public bool startedAttack = false;

        private ObjectInfo oinfo;

        void Start()
        {
            oinfo = GetComponent<ObjectInfo>();
        }

        // Update is called once per frame
        void Update()
        {
            if (target != null && !startedAttack && GetTargetDistance() < attackRange)
            {
                StartCoroutine(AttackCoroutine());
                startedAttack = true;
            }
        }

        public void SetTarget(Destroyable targ)
        {
            target = targ;
            inCombat = true;
        }

        public void ClearTarget()
        {
            if (target != null) target.IsUnderAttack = false;
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

                    break;
                }
                target.Damage(dmg, gameObject);
                yield return new WaitForSeconds(attackCooldown);
            }
        }

        public void ScoreKill()
        {
            startedAttack = false;
            inCombat = false;
            if (oinfo.Player != null)
                oinfo.Player.ScoreKill();
          //  Debug.Log("we killed someone");
            target = null;
        }

        public void FightBack(Destroyable attacker)
        {
            var taskmgr = GetComponent<TaskManager>();

            if (taskmgr != null) //currently only player units have a task manager
            {
                taskmgr.CancelAction(); //drop everything
                taskmgr.CancelAllActions(); //forget what u were doing
                oinfo.Player.Stats.GameEventManager.SendAction(attacker.gameObject, ActionType.ATTACK, 0); //code duplication, but who cares, we're the god of this world
            }
            else //simpler units can just go in head first, whatever
            {
                SetTarget(attacker);
            }
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