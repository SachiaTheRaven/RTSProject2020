using System;
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
        private Ray ray;

        public Builder builder;

        public TaskQueuePanelControl taskQueuePanelControl;
        public UnitUIManager unitUIManager;

        TaskManager taskManagerSelected = null;

        bool movingFlag = false;

        [SerializeField]
        public HashSet<ObjectInfo> selectedObjects = new HashSet<ObjectInfo>();
        EventSystem eventSystem;
        GameEvent gameEvent;


        public CanvasGroup objectPanel;

        public ObjectInfo primaryObject;

        private bool isSelecting;
        private RallyPoint rallyPointMoved;

        //TODO separate this pls, it's ugly
        private bool isBuilding = false;
        GameObject buildingproto;
        GameObject buildingBlueprint;

        public bool isAddingInitialTask = false;
        public Trainer trainerSelected = null;




        void Start()
        {
            eventSystem = FindObjectOfType<EventSystem>();
            gameEvent = GetComponent<GameEvent>();
        }

        // Update is called once per frame
        void Update()
        {
            if (isBuilding)
            {
                FollowCursorWithBlueprint();
            }
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
                            UnitObjectInfo oinfo = obj.GetComponent<UnitObjectInfo>();
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
        void GetRightButtonDown()
        {

            RaycastHit hit;
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(ray, out hit))
            {
                if (taskManagerSelected != null || trainerSelected != null)
                {
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
                        builder.PlaceBuilding(buildingproto, hit);
                        Destroy(buildingBlueprint);
                        isBuilding = false;
                        buildingproto = null;
                        buildingBlueprint = null;

                    }
                    else
                    {
                        if (Input.GetMouseButtonDown(0) && Input.GetKey(KeyCode.LeftShift))
                        {
                            startPos = hit.point;
                            box.baseMinimum = startPos;
                            isSelecting = true;
                        }
                        else
                        {
                            if (selectedObjects.Count != 0)
                            {
                                ClearSelection();

                            }
                        }
                    }
                }
                else if (Input.GetMouseButtonDown(0) && hit.collider.CompareTag("Selectable"))
                {
                    if (selectedObjects.Count != 0) ClearSelection();
                    Select(hit.collider.GetComponent<UnitObjectInfo>());
                }

                else
                {
                    //TODO make a separate branch for these
                    Trainer trainer = hit.transform.gameObject.GetComponent<Trainer>();
                    //Show training options
                    rallyPointMoved = hit.transform.gameObject.GetComponent<RallyPoint>();
                    if (trainer != null && Input.GetMouseButtonDown(0))
                    {
                        //show training panel
                        trainer.ShowTrainingPanel();
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
            trainerSelected = null;
            isAddingInitialTask = false;
            if (selectedObjects != null)
            {

                foreach (UnitObjectInfo i in selectedObjects)
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
                    unitUIManager.ReleaseGameObject();
                }


            }
        }
        public void Select(UnitObjectInfo oInfo)
        {
            selectedObjects.Add(oInfo);
            oInfo.ToggleSelection(true);
            if (primaryObject == null) SetPrimary(oInfo);
        }

        void SetPrimary(ObjectInfo objectInfo)
        {
            if (primaryObject != null && primaryObject != objectInfo) //if we already have a primary, clear the unit display
            {
                ReleaseUI();
            }
            primaryObject = objectInfo;
            taskManagerSelected = objectInfo.GetComponent<TaskManager>();
            if (FindObjectOfType<GameController>().UIon)
            {
                taskQueuePanelControl.ClearActionDisplay();
                taskQueuePanelControl.DisplayActions(taskManagerSelected);

                BindUI(objectInfo.gameObject);
            }

        }
        void MoveFlag(Vector3 dest)
        {
            rallyPointMoved.baseConnected.SetNewRallyPoint(dest);
            movingFlag = false;
        }

        public void PutOutNewAction(Vector3 pos, ActionType type)
        {
            if (trainerSelected != null)
            {
                //Add Task
                trainerSelected.CreateInitialTask(pos, type);
                //Showw panel again in case we want more
                trainerSelected.ShowTrainingPanel();
                //delete the trainer in case we don't want more
                trainerSelected = null;
                isAddingInitialTask = false;
            }
            else gameEvent.SendAction(pos, type);
        }
        public void PutOutNewAction(GameObject target, ActionType type, int roundLimit)
        {

            if (trainerSelected != null)
            {
                //Add Task
                trainerSelected.CreateInitialTask(target, type, roundLimit);
                //Showw panel again in case we want more
                trainerSelected.ShowTrainingPanel();
                //delete the trainer in case we don't want more
                trainerSelected = null;
                isAddingInitialTask = false;

            }
            else gameEvent.SendAction(target, type, roundLimit);
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

        public void StartBuilding(GameObject prefab, GameObject blueprint)
        {
            isBuilding = true;
            buildingproto = prefab;
            if(buildingBlueprint!=null)
            { Destroy(buildingBlueprint); }
            buildingBlueprint = Instantiate(blueprint);
            
            ClearSelection();
        }
        private void FollowCursorWithBlueprint()
        {
            Debug.Log("Bulding!");
            RaycastHit hit;
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            if (Physics.Raycast(ray, out hit)
            && hit.collider.CompareTag("Ground"))
            {

                Debug.Log(hit.point);
                buildingBlueprint.transform.position = hit.point;
                buildingBlueprint.transform.rotation = Quaternion.FromToRotation(Vector3.up, hit.normal);
            }

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
