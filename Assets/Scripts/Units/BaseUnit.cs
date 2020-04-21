using System.Collections;
using System.Collections.Generic;
using UnityEngine;
namespace RTSGame
{


    public class BaseUnit : MonoBehaviour
    {
        // Start is called before the first frame update
        public int price = 1;
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
            if(taskInProgress!=null)
            {
                if(taskInProgress.IsFinished())
                CancelAction();
            }
            else if (GetComponent<ObjectInfo>().task == UnitTasks.IDLE && taskList.Count > 0)
            {
                taskInProgress = taskList[0];
                taskList.RemoveAt(0);
                taskInProgress.Execute();
            }


        }

        public void AddTask(Action action)
        {
            if(taskList.Count<maxNumberOfTasks)
            {
                taskList.Add(action);
            }
            else
            {
                //TODO valami effektet megjeleníteni
            }

        }

        public void  CancelAction()
        {
            taskInProgress = null;
            GetComponent<ObjectInfo>().task = UnitTasks.IDLE;
        }
    }
}