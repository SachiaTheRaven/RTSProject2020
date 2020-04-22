using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

namespace RTSGame
{
    public class TaskItem : MonoBehaviour
    {
        // Start is called before the first frame update
        public Action action;
        public Button button;
    void Start()
        {
            button = GetComponentInChildren<Button>();
            button.onClick.AddListener(OnClick);

        }

        // Update is called once per frame
        void Update()
        {
            if (action.IsFinished())
            {
                Destroy(this.gameObject);
                Debug.Log("We're finished here");
            }
        }
        public void OnClick()
        {
            action.Cancel();
            Destroy(this.gameObject);
        }
    }

}
