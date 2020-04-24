using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class TaskQueuePanelControl : MonoBehaviour
    {
        // Start is called before the first frame update
        public GameObject taskQPanel;
        public GameObject taskPrefab;
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {

        }

        public void DisplayActions(TaskManager taskmgr)
        {
            foreach (var action in taskmgr.taskList)
            {
                AddActionItemToDisplay(action);
            }
        }
        public void AddActionItemToDisplay(Action action)
        {
            GameObject newTaskItem = Instantiate(taskPrefab);
            newTaskItem.transform.SetParent(taskQPanel.transform, false);
            newTaskItem.GetComponent<TaskItem>().action = action;
        }
        
       
        public void ClearActionDisplay()
        {
            foreach (Transform child in taskQPanel.transform)
            {
                if (!child.Equals(transform))
                {
                    Destroy(child.gameObject);
                }
                transform.DetachChildren();
            }
        }
    }
}