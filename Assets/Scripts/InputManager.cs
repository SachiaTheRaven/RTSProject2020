using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
public class InputManager : MonoBehaviour
{
    // Start is called before the first frame update

    public GameObject selectedObject;
    private ObjectInfo selectedInfo;
     void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        LeftClick();   
    }

    private void LeftClick()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit, 100))
        {
            if(hit.collider.CompareTag("Ground"))
            {
                selectedObject = null;
            }
            else if(hit.collider.tag=="Selectable")
            {
                selectedObject = hit.collider.gameObject;
                selectedInfo = selectedObject.GetComponent<ObjectInfo>();

                selectedInfo.isSelected = true;
            }
        }
    }
}
