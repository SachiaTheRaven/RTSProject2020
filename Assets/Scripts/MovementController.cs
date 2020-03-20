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

        void Start()
        {
            agent = GetComponent<NavMeshAgent>();
            agent.SetDestination(rallyPoint.transform.position);

        }

        // Update is called once per frame
        void Update()
        {
            if (agent.destination.x == rallyPoint.transform.position.x && agent.destination.z == rallyPoint.transform.position.z)
            {
                Debug.Log(agent.remainingDistance);
                if (agent.remainingDistance < 1.0f)
                {
                    agent.ResetPath();
                    Debug.Log("Path cleared");
                }
            }
        }

        public void Move(Vector3 target)
        {
            agent.SetDestination(target);
        }
    }
}