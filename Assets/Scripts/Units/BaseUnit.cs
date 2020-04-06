using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame
{


    public class BaseUnit : MonoBehaviour
    {
        // Start is called before the first frame update
        public int price = 1;
        public Queue<Action> taskList;
        public Action taskInProgress;

        

        void Start()
        {
            taskList = new Queue<Action>();
        }

        // Update is called once per frame
        void Update()
        {
            if(taskInProgress!=null)
            {
                if(taskInProgress.IsFinished())
                CancelAction();
            }
            else if (GetComponent<ObjectInfo>().task == UnitTasks.IDLE && taskList.Count > 0)
            {
                Debug.Log("Starting next task");
                taskInProgress = taskList.Dequeue();
                taskInProgress.Execute();
            }


        }

        public void AddTask(Action action)
        {
            Debug.Log("Task enqued");
            taskList.Enqueue(action);
        }

        public void  CancelAction()
        {
            Debug.Log("Cancelling Action");
            taskInProgress = null;
            GetComponent<ObjectInfo>().task = UnitTasks.IDLE;
        }
    }
}