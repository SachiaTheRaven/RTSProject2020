using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame {
    public class FlyingMovementController : MovementController
    {
        // Start is called before the first frame update
        public float stoppingDistance=3;
       
        public override void Move(Vector3 target)
        {
            base.Move(target);
        }

        public override bool ReachedDestination(Vector3 pos)
        {
            return Vector3.Distance(transform.position, pos)<=stoppingDistance;
        }

    }
}