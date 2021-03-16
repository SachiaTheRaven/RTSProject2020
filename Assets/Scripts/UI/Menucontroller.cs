using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Menucontroller : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject menuPanel;
    public void ToggleMenuVisibility()
    {
        menuPanel.SetActive(!menuPanel.activeSelf);
    }
}
