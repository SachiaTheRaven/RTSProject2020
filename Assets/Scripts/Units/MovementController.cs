using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.AI;
namespace RTSGame
{
    public class MovementController : MonoBehaviour
    {
        // Start is called before the first frame update

        NavMeshAgent agent;
        public GameObject rallyPoint;
        ObjectInfo oinfo;


        void Start()
        {
            agent = GetComponent<NavMeshAgent>();
            agent.SetDestination(rallyPoint.transform.position);
            oinfo = GetComponent<ObjectInfo>();
        }

        // Update is called once per frame
        void Update()
        {
            if (ReachedDestination())
            {
                Debug.Log("Distance: " + agent.remainingDistance);

                Debug.Log("Reseting destination.");
                agent.ResetPath();
                oinfo.SetTask(UnitTasks.IDLE);

            }


        }

        public void Move(Vector3 target)
        {
            Debug.Log("moving " + gameObject.name + " to " + target);
            GetComponent<ObjectInfo>().SetTask(UnitTasks.MOVING);
            agent.SetDestination(target);
            Debug.Log("Current pos: " + transform.position + " dest: " + agent.destination);
        }

        public bool ReachedDestination()
        {
            return !agent.pathPending && agent.remainingDistance < 0.005f && oinfo.task == UnitTasks.MOVING;
        }
    }
}