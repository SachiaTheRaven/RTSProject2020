﻿using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using System.Linq;

namespace RTSGame
{

    //TODO this is such a god class that MXTX would write a bl novel about it
    public class Selector : MonoBehaviour
    {

        //variables for box selection
        [SerializeField] Box box;
        Collider[] selection;
        private Vector3 startPos, dragPos;
        private Camera cam;
        private Ray ray;

        public Builder builder;

        public TaskQueuePanelControl taskQueuePanelControl;
        public UnitUIManager unitUIManager;

        TaskManager taskManagerSelected = null;

        bool movingFlag = false;

        [SerializeField]
        public HashSet<ObjectInfo> selectedObjects = new HashSet<ObjectInfo>();
        EventSystem eventSystem;


        public CanvasGroup objectPanel;

        public ObjectInfo primaryObject;

        private bool isSelecting;
        private RallyPoint rallyPointMoved;

        //TODO separate this pls, it's ugly
        private bool isBuilding = false;
        GameObject buildingproto;




        void Start()
        {
            eventSystem = FindObjectOfType<EventSystem>();
            cam = Camera.main;

        }

        // Update is called once per frame
        void Update()
        {

            if (eventSystem != null && eventSystem.currentSelectedGameObject != null && eventSystem.currentSelectedGameObject.layer == 5)
            {
                return;
            }
            else
            {
                //handling input
                if (Input.GetMouseButton(0))
                {
                    GetLeftButtonDown();
                }
                if (Input.GetMouseButtonDown(1))
                {
                    GetRightButtonDown();
                }
                if (Input.GetMouseButtonUp(0))
                {
                    if (isSelecting)
                    {
                        selection = Physics.OverlapBox(box.Center, box.Extents, Quaternion.identity);
                        foreach (var obj in selection)
                        {
                            ObjectInfo oinfo = obj.GetComponent<ObjectInfo>();
                            if (obj.CompareTag("Selectable") && oinfo != null && !oinfo.isSelected)
                            {
                                Select(oinfo);
                            }
                        }
                        isSelecting = false;
                    }
                }
            }
        }
        private void GetRightButtonDown()
        {

            RaycastHit hit;
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(ray, out hit))
            {
                if (taskManagerSelected != null)
                {
                    Debug.Log(hit.transform.gameObject.name);
                    //right click on ground: select where to move
                    if (hit.collider.CompareTag("Ground"))
                    {
                        PutOutNewAction(hit.point, ActionType.MOVE);
                    }
                    else if (hit.collider.CompareTag("Resource"))
                    {
                        PutOutNewAction(hit.transform.gameObject, ActionType.HARVEST, 5);
                    }
                    else if (hit.collider.CompareTag("Enemy")) // if we have a unit selected and we hit an enemy
                    {
                        Debug.Log("AAAATTAAAACK");
                        PutOutNewAction(hit.transform.gameObject, ActionType.ATTACK, 0);
                    }
                }
            }

        }

        void GetLeftButtonDown()
        {

            //casting a ray to our pointer
            RaycastHit hit;
            ray = Camera.main.ScreenPointToRay(Input.mousePosition);

            if (Physics.Raycast(ray, out hit))
            {
                ObjectInfo objectInfo = hit.transform.GetComponent<ObjectInfo>();
                if (hit.collider.CompareTag("Ground"))
                {
                    if (movingFlag)
                    {
                        MoveFlag(hit.point);
                    }
                    else if (isBuilding)
                    {
                        builder.PlaceBuilding(buildingproto, new Vector3(hit.point.x, 0.5f, hit.point.z));
                        isBuilding = false;
                        buildingproto = null;
                    }
                    else
                    {
                        if (Input.GetMouseButtonDown(0) && Input.GetKey(KeyCode.LeftShift))
                        {
                            Debug.Log("Starting selection");
                            startPos = hit.point;
                            box.baseMinimum = startPos;
                            isSelecting = true;
                        }
                        else
                        {
                            if (selectedObjects.Count != 0) ClearSelection();
                        }
                    }
                }
                else if (Input.GetMouseButtonDown(0) && hit.collider.CompareTag("Selectable"))
                {
                    if (selectedObjects.Count != 0) ClearSelection();
                    Select(hit.collider.GetComponent<ObjectInfo>());
                }

                else
                {
                    //TODO make a separate branch for these
                    Trainer trainer = hit.transform.gameObject.GetComponent<Trainer>();
                    rallyPointMoved = hit.transform.gameObject.GetComponent<RallyPoint>();
                    if (trainer != null && Input.GetMouseButtonDown(0))
                    {
                        //TODO add task queue to buildings
                        trainer.TrainNew();

                    }
                    else if (hit.transform.gameObject.CompareTag("RallyFlag") && rallyPointMoved != null)
                    {
                        movingFlag = true;
                    }
                }
            }
            if (isSelecting)
            {
                dragPos = hit.point;
                box.baseMaximum = dragPos;
            }

        }

        public void ClearSelection()
        {
            Debug.Log("Selection cleared");
            if (selectedObjects != null)
            {

                foreach (ObjectInfo i in selectedObjects)
                {
                    if (i != null)
                    {
                        i.ToggleSelection(false);

                    }
                }

                primaryObject = null;

                selectedObjects.Clear();

                movingFlag = false;
                taskManagerSelected = null;
                if (FindObjectOfType<GameController>().UIon)
                {
                    ReleaseUI();
                    Debug.Log("Unit Deselected Trigger Released");
                    unitUIManager.ReleaseGameObject();
                }


            }
        }
        public void Select(ObjectInfo oInfo)
        {
            selectedObjects.Add(oInfo);
            oInfo.ToggleSelection(true);
            if (primaryObject == null) SetPrimary(oInfo);
        }

        void SetPrimary(ObjectInfo objectInfo)
        {
            Debug.Log("primary selected");
            if (primaryObject != null && primaryObject != objectInfo) //if we already have a primary, clear the unit display
            {
                Debug.Log("we still have a primary");
                ReleaseUI();
            }
            primaryObject = objectInfo;
            taskManagerSelected = objectInfo.GetComponent<TaskManager>();
            if (FindObjectOfType<GameController>().UIon)
            {
                taskQueuePanelControl.ClearActionDisplay();
                taskQueuePanelControl.DisplayActions(taskManagerSelected);

                BindUI(objectInfo.gameObject);
                Debug.Log("Unit Selected Trigger Released");
            }

        }
        void MoveFlag(Vector3 dest)
        {
            rallyPointMoved.baseConnected.SetNewRallyPoint(dest);
            movingFlag = false;
        }

        public void PutOutNewAction(Vector3 pos, ActionType type)
        {
            GameEvent.current.SendAction(pos, type);
        }
        public void PutOutNewAction(GameObject target, ActionType type, int roundLimit)
        {
            GameEvent.current.SendAction(target, type, roundLimit);
        }

        public void ReleaseUI()
        {
            unitUIManager.GetComponent<Animator>().SetTrigger("UnitDeselected");
            unitUIManager.ReleaseGameObject();
        }
        public void BindUI(GameObject go)
        {
            unitUIManager.BindGameObject(go);
            unitUIManager.GetComponent<Animator>().SetTrigger("UnitSelected");
        }
        private void OnDrawGizmos()
        {
            Gizmos.color = Color.red;
            Gizmos.DrawCube(box.Center, box.Size);
        }
        //gets distance between primary object and closest enemy
        //TODO somehow do this for all units
        public float GetDistanceOfClosestEnemy()
        {
            List<GameObject> enemies = GameObject.FindGameObjectsWithTag("Enemy").ToList();
            if (enemies.Count > 0 && primaryObject != null)
            {
                var closest = enemies.Min(x =>
                {
                    return (primaryObject.transform.position - x.transform.position).magnitude;
                }
                );
                return closest;
            }
            else return -1.0f;
           
           

        }

        public void StartBuilding(GameObject bp)
        {
            isBuilding = true;
            buildingproto = bp;
            ClearSelection();
        }
    }


}
[Serializable]
public class Box
{
    public Vector3 baseMinimum, baseMaximum;
    public Vector3 Center
    {
        get
        {
            Vector3 center = baseMinimum + (baseMaximum - baseMinimum) * 0.5f;
            center.y = (baseMaximum - baseMinimum).magnitude * 0.5f;

            return center;
        }
    }
    public Vector3 Size
    {
        get
        {
            return new Vector3(Mathf.Abs(baseMaximum.x - baseMinimum.x), (baseMaximum - baseMinimum).magnitude, Mathf.Abs(baseMaximum.z - baseMinimum.z));

        }
    }

    public Vector3 Extents
    {
        get
        {
            return Size * 0.5f;
        }
    }

}
