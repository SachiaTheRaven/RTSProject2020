using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Selector : MonoBehaviour
{
    // Start is called before the first frame update
    bool movingFlag = false;
    RallyPoint rallyPoint;
    GameObject selectedObject;
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
                    selectedObject = null;
                    selectedInfo = null;
                    rallyPoint = null;
                    movingFlag = false;
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
                if(selectedObject!=null)
                {
                    MovementController mc = selectedObject.GetComponent<MovementController>();
                    if (hit.collider.CompareTag("Ground") && mc!=null)
                    {
                        mc.Move(hit.point);
                    }
                }                
                else if (hit.collider.tag == "Selectable")
                {
                    selectedObject = hit.collider.gameObject;
                    selectedInfo = selectedObject.GetComponent<ObjectInfo>();

                    selectedInfo.isSelected = true;
                }
                else if (movingFlag)
                {
                    Debug.Log("Moving flag to:" + hit.point);
                    rallyPoint.baseConnected.SetNewRallyPoint(hit.point);
                    
                    movingFlag = false;
                }
                else
                {
                    Trainer trainer = hit.transform.gameObject.GetComponent<Trainer>();
                    rallyPoint= hit.transform.gameObject.GetComponent<RallyPoint>();
                    if (trainer!=null)
                    {
                        trainer.TrainNew();                   

                    }
                    else if (hit.transform.gameObject.CompareTag("RallyFlag") && rallyPoint!=null)
                    {
                        Debug.Log("Moving flag!");
                        movingFlag = true;
                    }
                }

            }
        }
      
    }
}
