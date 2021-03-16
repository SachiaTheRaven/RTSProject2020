using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

namespace RTSGame
{
    public class TaskQueuePanelControl : MonoBehaviour
    {
        // Start is called before the first frame update
        public GameObject taskQPanel;
        public GameObject taskPrefab;
        [SerializeField]
        public List<DictionaryItem> TaskImages;

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
            TaskItem taskItem = newTaskItem.GetComponent<TaskItem>();
            taskItem.AssignedAction = action;
            taskItem.AssignImage(TaskImages.Where(x=>x.type==action.type).First().image);


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