using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    // Start is called before the first frame update
    float cameraSpeed = 0.5f;
    float rotationSpeed = 2.5f;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        MoveCamera();
    }

    public void MoveCamera()
    {
        //move the camera around with keys
        
        Vector3 offset = new Vector3(Input.GetAxis("Horizontal"), 0.0f, Input.GetAxis("Vertical")).normalized*cameraSpeed;
        transform.Translate(offset);

        //Rotate the camera around axis X by pressing the scrollwheel or E/R
        if(Input.GetKey(KeyCode.Mouse2))
        {
            float rotationX = Mathf.Clamp(Input.GetAxis("Mouse X") * rotationSpeed + transform.eulerAngles.x, 0.0f, 7.5f);

            transform.eulerAngles = new Vector3(rotationX, 0.0f, 0.0f);
        }
    }
}
