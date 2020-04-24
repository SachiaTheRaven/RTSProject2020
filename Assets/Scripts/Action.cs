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
            //TODO: test whether it stops current tasks
            initiator.GetComponent<TaskManager>().RemoveAction(this);
        }
        //public abstract void Cancel();
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
            IsFinished = new IsFinishedDelegate(() => { Vector3 dest = pos;  return initiator.GetComponent<MovementController>().ReachedDestination(dest); });
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
        //TODO: set IsFinished
        public bool HasRoundLimit { get { return maxRounds != 0; } }
        public int maxRounds { get; set; }
        public int roundsFinished { get; set; }

        public GameObject targetObject;
        public ActionOnObject(GameObject init, GameObject targ, ActionType at,int roundLimit=0)
        {
            initiator = init;
            targetObject = targ;
            type = at;
            maxRounds = roundLimit;
            roundsFinished = 0;
            IsFinished = new IsFinishedDelegate(() => { return HasRoundLimit && roundLimit>roundsFinished ;});

        }

        

        public override void Execute()
        {
            switch (type)
            {
                case ActionType.HARVEST:
                    {
                        initiator.GetComponent<MovementController>().Move(targetObject.transform.position);
                        initiator.GetComponent<ObjectInfo>().Status=UnitStatus.GATHERING;

                    }

                    break;
                default: Debug.LogError("No such type of action"); break;

            }
        }
    }

}
