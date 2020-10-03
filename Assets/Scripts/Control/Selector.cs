using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;
using System.Linq;

namespace RTSGame
{
    public class Selector : MonoBehaviour
    {

        //variables for box selection
        [SerializeField] Box box;
        Collider[] selection;
        private Vector3 startPos, dragPos;
        private Camera cam;
        private Ray ray;

        public TaskQueuePanelControl taskQueuePanelControl;
        public UnitUIManager unitUIManager;

        TaskManager taskManagerSelected = null;

        bool movingFlag = false;

        [SerializeField] HashSet<ObjectInfo> selectedObjects = new HashSet<ObjectInfo>();
        EventSystem eventSystem;


        public CanvasGroup objectPanel;

        public ObjectInfo primaryObject;

        private bool isSelecting;
        private RallyPoint rallyPointMoved;




        void Start()
        {
            eventSystem = FindObjectOfType<EventSystem>();
            cam = Camera.main;

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
                    //right click on ground: select where to move
                    if (hit.collider.CompareTag("Ground"))
                    {
                        PutOutNewAction(hit.point,ActionType.MOVE);
                    }
                    else if (hit.collider.CompareTag("Resource"))
                    {     
                        PutOutNewAction(hit.transform.gameObject, ActionType.HARVEST, 5);
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
                            ClearSelection();
                        }
                    }
                }
                else if (Input.GetMouseButtonDown(0) && hit.collider.CompareTag("Selectable"))
                {
                    ClearSelection();
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

        void ClearSelection()
        {
            if (selectedObjects != null)
            {

                foreach(ObjectInfo i in selectedObjects)
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
                taskQueuePanelControl.ClearActionDisplay();

                unitUIManager.GetComponent<Animator>().SetTrigger("UnitDeselected");
                unitUIManager.ReleaseGameObject();
            }
        }
        void Select(ObjectInfo oInfo)
        {
            selectedObjects.Add(oInfo);  
            oInfo.ToggleSelection(true);
            if (primaryObject == null) SetPrimary(oInfo);
        }

        void SetPrimary(ObjectInfo objectInfo)
        {
            if (primaryObject!=null) //if we already have a primary, clear the unit display
            {
                unitUIManager.GetComponent<Animator>().SetTrigger("UnitDeselected");
                unitUIManager.ReleaseGameObject();
            }
            primaryObject = objectInfo;
            taskManagerSelected = objectInfo.GetComponent<TaskManager>();

            taskQueuePanelControl.ClearActionDisplay();
            taskQueuePanelControl.DisplayActions(taskManagerSelected);

            unitUIManager.BindGameObject(objectInfo.gameObject);
            unitUIManager.GetComponent<Animator>().SetTrigger("UnitSelected");
        }
        void MoveFlag(Vector3 dest)
        {
            rallyPointMoved.baseConnected.SetNewRallyPoint(dest);
            movingFlag = false;
        }

        void PutOutNewAction(Vector3 pos, ActionType type)
        {
            GameEvent.current.SendAction(pos, type);
        }
        void PutOutNewAction(GameObject target, ActionType type, int roundLimit)
        {
            GameEvent.current.SendAction(target, type, roundLimit);
        }


        private void OnDrawGizmos()
        {
            Gizmos.color = Color.red;
            Gizmos.DrawCube(box.Center, box.Size);
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
