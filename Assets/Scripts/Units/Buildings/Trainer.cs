using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.AI;

namespace RTSGame
{
    public class Trainer : ObjectInfo
    {
        public List<GameObject> unitPrototypes;
        public GameObject rallyPoint;
        public GameObject rallyFlag;
        public Transform taskListPanel;
        public TextMeshPro cdText;
        public bool isDone = true;
        bool movingFlag = false;


        public List<Action> initialTaskList
        {
            get;
            protected set;

        } = new List<Action>();


        CreateUnitPanel createPanelController;

        private ResourceManager resourceManager;
        void Start()
        {
            cdText.enabled = false;
            resourceManager = Player.Stats.PlayerResourceManager;
            var createUnitPanel = Resources.FindObjectsOfTypeAll(typeof(CreateUnitPanel));
            if(createUnitPanel.Length>0)
            {
                createPanelController = (createUnitPanel[0] as CreateUnitPanel);

            }

        }

        IEnumerator CountdownCoroutine(int cooldown, GameObject prefab)
        {
            cdText.enabled = true;
            isDone = false;
            for (int i = 0; i < cooldown; i++)
            {
                cdText.text = (cooldown - i).ToString();
                yield return new WaitForSeconds(1.0f);

            }
            CreateUnit(prefab);
            isDone = true;
            cdText.enabled = false;
        }
        public void CreateUnit(GameObject proto)
        {
            GameObject newGO = Instantiate(proto);
            newGO.transform.SetParent(transform.parent);
            var agent = newGO.GetComponent<NavMeshAgent>();

            NavMeshHit hit;
            while (true) //todo favágó, szégyelld magad
            {
               if( NavMesh.SamplePosition(transform.position + Random.insideUnitSphere * Random.Range(2, 5), out hit, 5.0f, agent.areaMask))
                {
                    Vector3 newPos = hit.position;
                    agent.Warp(newPos);

                    break;

                }
                // Debug.Log("try " + t + " " + hit.position);

                //if (hit.position != Vector3.positiveInfinity) break;
            }


            newGO.GetComponent<MovementController>().rallyPoint = rallyPoint;

            newGO.GetComponent<ObjectInfo>().Player = this.Player;
            newGO.GetComponent<ObjectInfo>().PlayerObject = this.PlayerObject;

            var goTmg = newGO.GetComponent<TaskManager>();
            AddInitialTasks(goTmg);
            Player.Stats.AddFriendlyUnit(newGO);
        }

        public void SetNewRallyPoint(Vector3 point)
        {
            rallyFlag.transform.position = point + Vector3.up * 0.5f;
            rallyPoint.transform.position = point;
        }

        public void TrainNew(GameObject prefab)
        {
            if (isDone)
            {
                ObjectInfo objectInfo = prefab.GetComponent<ObjectInfo>();
                if (resourceManager.GetResourceAmount(ResourceTypes.GOLD) > objectInfo.price)
                {
                    resourceManager.AddResource(ResourceTypes.GOLD, -objectInfo.price);
                    resourceManager.AddResource(ResourceTypes.POPULATION, 1);
                    StartCoroutine(CountdownCoroutine(3, prefab));
                }
                else Debug.Log("Not enough money");

            }
            else Debug.Log("Not ready yet!");
        }

        public void ShowTrainingPanel()
        {
            createPanelController.trainer = this;
            createPanelController.Show();

        }

        public void RemoveInitialTask(Action task)
        {
            initialTaskList.Remove(task);
        }



        public void CreateInitialTask(Vector3 pos, ActionType type)
        {

            Action action = new ActionOnPosition(null, pos, type);
            initialTaskList.Add(action);

        }
        public void CreateInitialTask(GameObject target, ActionType type, int roundLimit)
        {
            Action action = new ActionOnObject(null, target, type, roundLimit);
            initialTaskList.Add(action);
        }


        public void AddInitialTasks(TaskManager tmg)
        {

            foreach (var t in initialTaskList)
            {
                switch (t.type)
                {
                    case ActionType.ATTACK: case  ActionType.HARVEST:
                        {
                            var to = t as ActionOnObject;
                            tmg.CreateTask(to.targetObject, to.type,to.maxRounds);

                        }
                        break;

                    case ActionType.MOVE:
                        {
                            var tp = t as ActionOnPosition;
                            tmg.CreateTask(tp.targetPosition, tp.type);
                        }
                        break;

                }
            }
        }

    }
}