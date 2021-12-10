using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;

namespace RTSGame
{
    public class TaskItem : MonoBehaviour
    {
        public Action AssignedAction;
        
        
        public Button button;
        public virtual void Start()
        {
            button = GetComponentInChildren<Button>();
            button.onClick.AddListener(OnClick);

        }

        
      public void AssignImage(Sprite image)
        {
            button.image.sprite = image;
        }

        void Update()
        {
            if (AssignedAction == null || AssignedAction.IsFinished())
            {
                Destroy(this.gameObject);
            }
        }
        public virtual void OnClick()
        {
            if (AssignedAction != null)
                AssignedAction.Cancel();
            Destroy(this.gameObject);
        }
    }

}
