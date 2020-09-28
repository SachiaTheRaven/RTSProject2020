using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

namespace RTSGame
{
    public class TaskItem : MonoBehaviour
    {
        public Action action;
        public Button button;
    void Start()
        {
            button = GetComponentInChildren<Button>();
            button.onClick.AddListener(OnClick);

        }

        void Update()
        {
            if (action.IsFinished())
            {
                Destroy(this.gameObject);
            }
        }
        public void OnClick()
        {
            action.Cancel();
            Destroy(this.gameObject);
        }
    }

}
