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
        bool movingFlag = false;
        RallyPoint rallyPoint;
        public GameObject selectedObject;
        ObjectInfo selectedInfo;
        EventSystem eventSystem;

        public GameObject taskQPanel;
        public GameObject taskPrefab;
        void Start()
        {
            eventSystem = FindObjectOfType<EventSystem>();

        }

        // Update is called once per frame
        void Update()
        {

            if (eventSystem.currentSelectedGameObject!=null && eventSystem.currentSelectedGameObject.layer == 5)
            {
                return;
            }
            else
            {
                GetSelection();
                GetDeselection();
            }
           
        }

        void DisplayActions()
        {
            //TODO: ennek nem itt a helye
            if (selectedObject != null)
            {
                BaseUnit bu = selectedObject.GetComponent<BaseUnit>();
                foreach (var action in bu.taskList)
                {
                    AddActionItemToDisplay(action);
                }
            }


        }
        void AddActionItemToDisplay(Action action)
        {
            GameObject t = Instantiate(taskPrefab);
            t.transform.SetParent(taskQPanel.transform, false);
            t.GetComponent<TaskItem>().action = action;
        }
        void ClearActionDisplay()
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
        private void GetDeselection()
        {
            if (Input.GetMouseButtonDown(1))
            {
                RaycastHit hit;
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                if (Physics.Raycast(ray, out hit))
                {
                   
                       


                    if (hit.collider.CompareTag("Ground") && selectedObject != null)
                    { 
                        if (selectedInfo.isSelected) selectedInfo.isSelected = false;
                        selectedObject = null;
                        selectedInfo = null;
                        rallyPoint = null;
                        movingFlag = false;
                        ClearActionDisplay();
                    }
                    else if (hit.collider.CompareTag("Resource"))
                    {
                        BaseUnit bu = selectedObject.GetComponent<BaseUnit>();
                        if (bu != null)
                        {
                            bu.AddTask(new ActionOnObject(selectedObject, hit.transform.gameObject, ActionType.HARVEST));
                        }
                    }
                }
            }
        }

        void GetSelection()
        {
            if (Input.GetMouseButtonDown(0))
            {
                RaycastHit hit;
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);

                if (Physics.Raycast(ray, out hit))
                {
                    //selecting destination for the selected units
                    if (selectedObject != null)
                    {
                        BaseUnit so = selectedObject.GetComponent<BaseUnit>();
                        if (hit.collider.CompareTag("Ground") && so != null)
                        {
                            Action newAction = new ActionOnPosition(selectedObject, hit.point, ActionType.MOVE);
                            so.AddTask(newAction);
                            AddActionItemToDisplay(newAction);

                        }
                    }
                    if (hit.collider.tag == "Selectable")
                    {
                        if (selectedObject != null) selectedInfo.ToggleSelection();
                        selectedObject = hit.collider.gameObject;
                        selectedInfo = selectedObject.GetComponent<ObjectInfo>();
                        ClearActionDisplay();
                        DisplayActions();

                        selectedInfo.ToggleSelection();
                    }
                    if (movingFlag)
                    {
                        rallyPoint.baseConnected.SetNewRallyPoint(hit.point);

                        movingFlag = false;
                    }
                    else
                    {
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
    }

}
