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
        protected UnitObjectInfo oinfo;


        void Start()
        {
            agent = GetComponent<NavMeshAgent>();
            if(rallyPoint!=null)
            {
                agent.SetDestination(rallyPoint.transform.position);
            }
            agent.stoppingDistance = 0.7f;
            oinfo = GetComponent<UnitObjectInfo>();
        }

        public virtual void Move(Vector3 target)
        {
            oinfo.status=UnitStatus.MOVING;
            agent.SetDestination(target);
        }

        //check if destination is reachable
        public bool HasPathToDestination(Vector3? pos)
        {
            if (pos == null) return false;
            NavMeshPath path = new NavMeshPath();
            return agent.CalculatePath((Vector3)pos,path);
        }
        public virtual bool ReachedDestination(Vector3 pos)
        {
           // Debug.Log(agent.destination + "-" + pos + "-" + transform.position);
            return (agent.destination.x == pos.x && agent.destination.z == pos.z) &&
                !agent.pathPending &&
                agent.remainingDistance <= agent.stoppingDistance &&
                (!agent.hasPath || agent.velocity.sqrMagnitude == 0f);
        }
    }
}