using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class Selector : MonoBehaviour
    {
        // Start is called before the first frame update
        bool movingFlag = false;
        RallyPoint rallyPoint;
        public GameObject selectedObject;
        ObjectInfo selectedInfo;
        void Start()
        {

        }

        // Update is called once per frame
        void Update()
        {
            GetSelection();
            GetDeselection();
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
                            Debug.Log("Adding task to " + selectedObject.name);

                            so.AddTask(new ActionOnPosition(selectedObject, hit.point, ActionType.MOVE));
                        }
                    }
                    if (hit.collider.tag == "Selectable")
                    {
                        if (selectedObject != null) selectedInfo.ToggleSelection();
                        selectedObject = hit.collider.gameObject;
                        selectedInfo = selectedObject.GetComponent<ObjectInfo>();

                        selectedInfo.ToggleSelection();
                    }
                    if (movingFlag)
                    {
                        Debug.Log("Moving flag to:" + hit.point);
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
                            Debug.Log("Moving flag!");
                            movingFlag = true;
                        }
                    }

                }
            }

        }
    }

}
