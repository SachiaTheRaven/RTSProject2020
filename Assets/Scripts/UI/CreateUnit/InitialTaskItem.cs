using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class InitialTaskItem : TaskItem
    {
        // Start is called before the first frame update
        public Trainer trainer;
        public override void Start()
        {
            base.Start();
        }

       
        public override void OnClick()
        {
            trainer.RemoveInitialTask(this.AssignedAction);
            Destroy(gameObject);

        }
    }
}