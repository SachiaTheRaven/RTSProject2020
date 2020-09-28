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

        void Start()
        {
            taskList = new List<Action>();
            objectInfo = GetComponent<ObjectInfo>();

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
            if (taskList.Count < maxNumberOfTasks)
            {
                taskList.Add(action);
            }
            else
            {
                //TODO valami effektet megjeleníteni
            }

        }

        //TODO ez valószínűleg felesleges duplicate
        
        public void CreateTask(Vector3 pos, ActionType type)
        {
            Action action = new ActionOnPosition(gameObject, pos, type);
            AddTask(action);
            FindObjectOfType<TaskQueuePanelControl>().AddActionItemToDisplay(action);

        }
        public void CreateTask(GameObject target, ActionType type, int roundLimit)
        {
            Action action = new ActionOnObject(gameObject, target,type,roundLimit);
            AddTask(action);
            FindObjectOfType<TaskQueuePanelControl>().AddActionItemToDisplay(action);
        }
        public void CancelAction()
        {
            taskInProgress = null;
            objectInfo.status = UnitStatus.IDLE;
        }

        public void RemoveAction( Action toBeRemoved)
        {
            if(toBeRemoved==taskInProgress)
            {
                CancelAction();
            }
            else
            {
                taskList.Remove(toBeRemoved);                
            }
        }
    }
}
