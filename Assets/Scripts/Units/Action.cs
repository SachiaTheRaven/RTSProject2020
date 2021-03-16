using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public delegate bool IsFinishedDelegate();

    public abstract class Action
    {
        public GameObject initiator;
        public ActionType type;
        public abstract void Execute();

        public void Cancel()
        {
            if (initiator != null)
                initiator.GetComponent<TaskManager>().RemoveAction(this);
        }
        public IsFinishedDelegate IsFinished = null;
        protected bool inProgress = false;
    }
    public class ActionOnPosition : Action
    {
        public Vector3 targetPosition;

        public ActionOnPosition(GameObject init, Vector3 pos, ActionType at)
        {
            initiator = init;
            targetPosition = pos;
            type = at;
            IsFinished = new IsFinishedDelegate(() =>
            {
                Vector3 dest = pos;
                if (initiator != null)
                    return initiator.GetComponent<MovementController>().ReachedDestination(dest);
                else return true;
            });
        }
        public override void Execute()
        {
            inProgress = true;
            switch (type)
            {
                case ActionType.MOVE:
                    {
                        initiator.GetComponent<MovementController>().Move(targetPosition);
                    }
                    break;
                default: Debug.LogError("No such type of action"); break;
            }
        }

    }

    public class ActionOnObject : Action
    {
        public bool HasRoundLimit { get { return maxRounds != 0; } }
        public int maxRounds { get; set; }
        public int roundsFinished { get; set; }

        public GameObject targetObject;
        public ActionOnObject(GameObject init, GameObject targ, ActionType at, int roundLimit = 0)
        {
            initiator = init;
            targetObject = targ;
            type = at;
            maxRounds = roundLimit;
            roundsFinished = 0;
            switch(at)
            {
                case ActionType.HARVEST:
                    {
                        IsFinished = new IsFinishedDelegate(() => { return HasRoundLimit && roundLimit <= roundsFinished; });
                    } break;
                case ActionType.ATTACK:
                    {
                        IsFinished = new IsFinishedDelegate(() => { return (HasRoundLimit && roundLimit <= roundsFinished )|| targetObject==null; });

                    }
                    break;
            }

        }



        public override void Execute()
        {
            MovementController mc = initiator.GetComponent<MovementController>();
            ObjectInfo oi = initiator.GetComponent<ObjectInfo>();
            switch (type)
            {
                case ActionType.HARVEST:
                    {
                        mc.Move(targetObject.transform.position);
                        oi.status = UnitStatus.GATHERING;

                    }
                    break;
                case ActionType.ATTACK:
                    {
                        mc.Move(targetObject.transform.position);
                        oi.status = UnitStatus.ATTACKING;
                        oi.GetComponent<DamageDealer>().SetTarget(targetObject.GetComponent<Destroyable>());
                    }
                    break;
                default: Debug.LogError("No such type of action"); break;

            }
        }
    }

}
