﻿using System;
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
        private void GetRightButtonDown()
        {
            if (Input.GetMouseButtonDown(1))
            {
                RaycastHit hit;
                Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
                if (Physics.Raycast(ray, out hit))
                {
                    //TODO separate into TaskManager component, don't call in every update
                    BaseUnit bu = selectedObject.GetComponent<BaseUnit>();
                    //right click on ground: select where to move
                    if (hit.collider.CompareTag("Ground") && bu != null)
                    {
                        Action newAction = new ActionOnPosition(selectedObject, hit.point, ActionType.MOVE);
                        bu.AddTask(newAction);
                        AddActionItemToDisplay(newAction);
                    }
                    else if (hit.collider.CompareTag("Resource"))
                    {

                        if (bu != null)
                        {
                            bu.AddTask(new ActionOnObject(selectedObject, hit.transform.gameObject, ActionType.HARVEST));
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
                ClearActionDisplay();
            }
        }
        void Select(GameObject go)
        {
            if (selectedObject != null) selectedInfo.ToggleSelection();
            selectedObject = go;
            selectedInfo = selectedObject.GetComponent<ObjectInfo>();
            ClearActionDisplay();
            DisplayActions();
            selectedInfo.ToggleSelection();
        }
        void MoveFlag(Vector3 dest)
        {
            rallyPoint.baseConnected.SetNewRallyPoint(dest);
            movingFlag = false;
        }
    }

}
