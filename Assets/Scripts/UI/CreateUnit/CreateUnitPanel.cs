using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;
using UnityEngine.UI;

namespace RTSGame
{

    public class CreateUnitPanel : MonoBehaviour
    {
        // Start is called before the first frame update
        public GameObject buttonPrefab;
        public Trainer trainer;
        public Transform trainPanel;
        public Transform initialTaskGrid;
        public GameObject initialTaskItemPrefab;

        public Button addActionButton;


        // Update is called once per frame
        void Update()
        {
            if (gameObject.activeInHierarchy && Input.GetKeyDown(KeyCode.Escape)) Hide();
        }

        public void Show()
        {
            foreach (var proto in trainer.unitPrototypes)
            {
                AddButtonToPanel(proto);
            }
            foreach(var action in trainer.initialTaskList)
            {
                AddButtonToTaskPanel(action);
            }
            this.gameObject.SetActive(true);
        }

        public void Hide()
        {
            foreach (var child in GetComponentsInChildren<CreateUnitButtonScript>())
            {
                Destroy(child.gameObject);
            }
            trainer = null;
            this.gameObject.SetActive(false);
        }

        private void AddButtonToPanel(GameObject prefab)
        {
            GameObject button = Instantiate(buttonPrefab);
            var buttonscript = button.GetComponent<CreateUnitButtonScript>();
            buttonscript.parentPanel = this;
            buttonscript.tmg = trainer.GetComponent<TaskManager>();
            buttonscript.unitPrefab = prefab;
            button.transform.SetParent(trainPanel);


        }

        //TODO possible duplicate from the original task Q panel

        public void AddButtonToTaskPanel(Action action)
        {

            GameObject button = Instantiate(initialTaskItemPrefab);
            button.transform.SetParent(initialTaskGrid);

            var taskItem = button.GetComponent<InitialTaskItem>();
            taskItem.AssignedAction = action;
            taskItem.trainer = this.trainer;

            /*            var img = TaskImages.Where(x => x.key == action.type).FirstOrDefault();
                        if (img != null)
                            taskItem.AssignImage(img.value);
            */

        }

        public void OnClickSelectAction()
        {
            //tell the selector that we are selecting a new action
            var selector = FindObjectOfType<Selector>(); //TODO consider whether multiple is possible
            selector.isAddingInitialTask = true;
            selector.trainerSelected = trainer;

            //hide panel
            Hide();
        }

    }
}