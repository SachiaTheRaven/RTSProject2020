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
        public abstract void Cancel();
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
            IsFinished = new IsFinishedDelegate(() => { return initiator.GetComponent<MovementController>().ReachedDestination(); });
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
        public override void Cancel()
        {
            if (!inProgress)
            {
                //TODO itt is taskmgr csere
                initiator.GetComponent<BaseUnit>().taskList.Remove(this);
            }
        }
    }

    public class ActionOnObject : Action
    {
        //TODO: set IsFinished
        bool hasRoundLimit = false;
        int maxRounds;

        public GameObject targetObject;
        public ActionOnObject(GameObject init, GameObject targ, ActionType at,int roundLimit=0)
        {
            initiator = init;
            targetObject = targ;
            type = at;
            maxRounds = roundLimit;
            hasRoundLimit = maxRounds > 0;
            IsFinished = new IsFinishedDelegate(() => { return hasRoundLimit &&< roundLimit; });

        }

        public override void Cancel()
        {
            if (!inProgress)
            {
                initiator.GetComponent<BaseUnit>().taskList.Remove(this);
            }
        }

        public override void Execute()
        {
            switch (type)
            {
                case ActionType.HARVEST:
                    {
                        initiator.GetComponent<MovementController>().Move(targetObject.transform.position);
                        initiator.GetComponent<ObjectInfo>().SetTask(UnitTasks.GATHERING,maxRounds);

                    }

                    break;
                default: Debug.LogError("No such type of action"); break;

            }
        }
    }

}
