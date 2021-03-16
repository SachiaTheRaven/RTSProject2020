using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame
{
    public class TaskManager : MonoBehaviour
    {
        // Start is called before the first frame update
        public List<Action> taskList;
        public Action taskInProgress;
        public int maxNumberOfTasks = 10;

       ObjectInfo objectInfo;
        DamageDealer dmg;



        void Start()
        {
            taskList = new List<Action>();
            objectInfo = GetComponent<ObjectInfo>();
            dmg = GetComponent<DamageDealer>();

        }

        // Update is called once per frame
        void Update()
        {
            if (taskInProgress != null)
            {
                if (taskInProgress.IsFinished())
                {
                    CancelAction();

                }
            }
            else if (objectInfo.status == UnitStatus.IDLE && taskList.Count > 0)
            {

                taskInProgress = taskList[0];
                taskList.RemoveAt(0);
                taskInProgress.Execute();
            }
        }
        private void AddTask(Action action)
        {
            //check if in combat
            if(dmg!=null&& !dmg.inCombat)
            {
                //if it's an attack, switch to combat mode
                if (action.type == ActionType.ATTACK)
                {
                    dmg.inCombat = true;
                    foreach( var task in taskList)
                    {
                        RemoveAction(task);
                    }
                    taskList.Add(action);
                    
                }
                else //if not, commence normally
                {
                    if (taskList.Count < maxNumberOfTasks)
                    {
                        taskList.Add(action);
                    }
                    else
                    {
                        //TODO valami effektet megjeleníteni
                    }
                }
            }
            else  //if in combat deny non-combat action types
            {
                if(action.type==ActionType.ATTACK)
                {
                    taskList.Add(action);
                }
                else
                {
                    Debug.Log("Can't do that while in combat");
                }

            }

        }

        //TODO ez valószínűleg felesleges duplicate

        public void CreateTask(Vector3 pos, ActionType type)
        {
            Action action = new ActionOnPosition(gameObject, pos, type);
            AddTask(action);

            if (FindObjectOfType<GameController>().UIon)
                FindObjectOfType<TaskQueuePanelControl>().AddActionItemToDisplay(action);

        }
        public void CreateTask(GameObject target, ActionType type, int roundLimit)
        {
            Action action = new ActionOnObject(gameObject, target, type, roundLimit);
            AddTask(action);
            FindObjectOfType<TaskQueuePanelControl>().AddActionItemToDisplay(action);
        }
        public void CancelAction()
        {
            taskInProgress = null;
            objectInfo.status = UnitStatus.IDLE;
        }

        public void RemoveAction(Action toBeRemoved)
        {
            if (toBeRemoved == taskInProgress)
            {
                CancelAction();
            }
            else
            {
                taskList.Remove(toBeRemoved);
            }
        }

        private void OnDestroy()
        {
            GameEvent.current.OnObjectActionSent -= CreateTask;
            GameEvent.current.OnPositionActionSent -= GetComponent<TaskManager>().CreateTask;
        }
    }
}
