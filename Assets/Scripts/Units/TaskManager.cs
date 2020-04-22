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

        void Start()
        {
            taskList = new List<Action>();

        }

        // Update is called once per frame
        void Update()
        {
            if (taskInProgress != null)
            {
                if (taskInProgress.IsFinished())
                {
                    CancelAction();
                    Debug.Log("task finished");

                }
            }
            else if (GetComponent<ObjectInfo>().task == UnitTasks.IDLE && taskList.Count > 0)
            {
                Debug.Log("starting task");
                taskInProgress = taskList[0];
                taskList.RemoveAt(0);
                taskInProgress.Execute();
            }
        }
        public void AddTask(Action action)
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
        public void CancelAction()
        {
            taskInProgress = null;
            GetComponent<ObjectInfo>().task = UnitTasks.IDLE;
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
