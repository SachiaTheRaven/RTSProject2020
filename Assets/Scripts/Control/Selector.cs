using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

namespace RTSGame
{
    public class Selector : MonoBehaviour
    {
        // Start is called before the first frame update

        public TaskQueuePanelControl taskQueuePanelControl;
        public GameObject selectedObject;

        TaskManager taskManagerSelected = null;

        bool movingFlag = false;
        RallyPoint rallyPoint;
        ObjectInfo selectedInfo;
        EventSystem eventSystem;



        void Start()
        {
            eventSystem = FindObjectOfType<EventSystem>();

        }

        // Update is called once per frame
        void Update()
        {

            if (eventSystem.currentSelectedGameObject != null && eventSystem.currentSelectedGameObject.layer == 5)
            {
                return;
            }
            else
            {
                GetLeftButtonDown();
                GetRightButtonDown();
            }

        }


        private void GetRightButtonDown()
        {
            if (Input.GetMouseButtonDown(1))
            {
                RaycastHit hit;
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                if (Physics.Raycast(ray, out hit))
                {
                    if (taskManagerSelected != null)
                    {
                        //right click on ground: select where to move
                        if (hit.collider.CompareTag("Ground"))
                        {
                            Action newAction = new ActionOnPosition(selectedObject, hit.point, ActionType.MOVE);
                            PutOutNewAction(newAction);                           
                        }
                        else if (hit.collider.CompareTag("Resource"))
                        {
                            Action newAction=new ActionOnObject(selectedObject, hit.transform.gameObject, ActionType.HARVEST);
                            PutOutNewAction(newAction);
                        }
                    }
                }
            }
        }

        void GetLeftButtonDown()
        {
            if (Input.GetMouseButtonDown(0))
            {
                RaycastHit hit;
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                if (Physics.Raycast(ray, out hit))
                {
                    if (hit.collider.CompareTag("Ground"))
                    {
                        if (movingFlag)
                        {
                            MoveFlag(hit.point);
                        }
                        else if (selectedObject != null)
                        {
                            Deselect();
                        }
                    }
                    else if (hit.collider.CompareTag("Selectable"))
                    {
                        Select(hit.collider.gameObject);
                    }
                    else
                    {
                        //TODO make a separate branch for these
                        Trainer trainer = hit.transform.gameObject.GetComponent<Trainer>();
                        rallyPoint = hit.transform.gameObject.GetComponent<RallyPoint>();
                        if (trainer != null)
                        {
                            //TODO add task queue to buildings
                            trainer.TrainNew();

                        }
                        else if (hit.transform.gameObject.CompareTag("RallyFlag") && rallyPoint != null)
                        {
                            movingFlag = true;
                        }
                    }
                }
            }
        }

        void Deselect()
        {
            if (selectedObject != null)
            {
                if (selectedInfo.isSelected) selectedInfo.isSelected = false;
                selectedObject = null;
                selectedInfo = null;
                rallyPoint = null;
                movingFlag = false;
                taskManagerSelected = null;
                taskQueuePanelControl.ClearActionDisplay();
            }
        }
        void Select(GameObject go)
        {
            if (selectedObject != null) selectedInfo.ToggleSelection();

            selectedObject = go;
            selectedInfo = selectedObject.GetComponent<ObjectInfo>();
            taskManagerSelected = selectedObject.GetComponent<TaskManager>();

            taskQueuePanelControl.ClearActionDisplay();
            taskQueuePanelControl.DisplayActions(taskManagerSelected);

            selectedInfo.ToggleSelection();
        }
        void MoveFlag(Vector3 dest)
        {
            rallyPoint.baseConnected.SetNewRallyPoint(dest);
            movingFlag = false;
        }

        void PutOutNewAction(Action newAction)
        {
            taskManagerSelected.AddTask(newAction);
            taskQueuePanelControl.AddActionItemToDisplay(newAction);
        }
    }

}
