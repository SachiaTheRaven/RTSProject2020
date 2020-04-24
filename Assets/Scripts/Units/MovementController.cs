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
            agent.stoppingDistance = 0.5f;
            oinfo = GetComponent<ObjectInfo>();
        }

        // Update is called once per frame
        void Update()
        {
        }

        public void Move(Vector3 target)
        {
            GetComponent<ObjectInfo>().Status=UnitStatus.MOVING;
            agent.SetDestination(target);
        }

        public bool ReachedDestination(Vector3 pos)
        {
           // Debug.Log(agent.destination + "-" + pos + "-" + transform.position);
            return (agent.destination.x == pos.x && agent.destination.z == pos.z) &&
                !agent.pathPending &&
                agent.remainingDistance <= agent.stoppingDistance &&
                (!agent.hasPath || agent.velocity.sqrMagnitude == 0f);
        }
    }
}