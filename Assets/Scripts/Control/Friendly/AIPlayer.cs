using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using Unity.MLAgents;
using Unity.MLAgents.Sensors;
using UnityEngine;
using UnityEngine.AI;

namespace RTSGame
{
    [Serializable]
    public class AIPlayer : Agent, ICommonPlayer
    {
        public GameObject UnitProto;
        public GameObject EnemyProto;
        public Selector AIPlayerSelector;
        public GameObject MineProto;
        public GameObject BarrackProto;

        [field: SerializeField]
        public PlayerStats Stats { get; set; }

        protected List<Destroyable> enemyUnits;
        bool episodeBegin = false;
        string helpimlostfile;
        public static int agentId = 0;
        private int navMeshRadius = 5;
        private int episodeId = 0;

        int currentAgentId = 0;
        float timeSinceLastAction = 0;
        int explorationTreshold = 10;
        float explorationReward = 0.05f;



        public override void Initialize()
        {
            //moved from Start
            Stats.Units = new ObservableCollection<GameObject>();
            this.MaxStep = 1000; //it shouldn't take more than 100 steps to do something
            // Stats.Units.CollectionChanged += OnListChanged;

            AIPlayerSelector = GetComponent<Selector>();
            Stats.PlayerResourceManager = GetComponent<ResourceManager>();

            // if (Stats.Units.Count == 0) InstantiateUnit(UnitProto);

            //Debug.Log("Initialized!");

        }

        private void Awake()
        {
            Stats.GameEventManager = GetComponent<GameEvent>();
            currentAgentId = AIPlayer.agentId;

            helpimlostfile = Application.persistentDataPath + "-" + AIPlayer.agentId++ + "this is why nobody likes you my child.txt";

            //Debug.Log(Application.persistentDataPath);
        }

        public void WriteToFile(string message)
        {
            /* using (StreamWriter filewriter = File.AppendText(helpimlostfile))
             {
                 filewriter.WriteLine(System.DateTime.Now + "-" + message);
             }*/
        }

        public override void CollectObservations(VectorSensor sensor)
        {

            //Observe the summarized remaining health of our babies

            var nUnits = Stats.Units.Count();
            var sumHealth = Stats.Units.Sum(x => x != null ? x.GetComponent<Destroyable>().hp : 0);
            var sumMaxHealth = Stats.Units.Sum(x => x != null ? x.GetComponent<Destroyable>().maxHP : 1);

            float sumHealthRatio = nUnits > 0 ? (float)sumHealth / (float)sumMaxHealth : 0;
            sensor.AddObservation(sumHealthRatio);

            //Observe the distance from the closest enemy unit (currently only for primary unit)

            var dist = AIPlayerSelector.GetDistanceOfClosestEnemy();
            sensor.AddObservation(dist > 0 ? 1 / dist : 0);  //1/dist bcz it's more effective when normalized

            //TODO: figure out what else to observe

        }


        public override void OnActionReceived(float[] vectorAction)
        {
            timeSinceLastAction += Time.deltaTime;
            bool successfulAction = false;
            WriteToFile("Action recieved:");

            AddReward(0.05f); //congrats you're alive
                              //switch on actiontype: discreteactions
            switch (vectorAction[0])
            {
                case float n when (n >= 0.0 && n < 0.1): //idle
                    {

                        WriteToFile("Nothing!");
                        var primary = AIPlayerSelector?.primaryObject;
                        if (primary != null)
                        {
                            var taskmgr = primary.GetComponent<TaskManager>();
                            if (taskmgr != null && taskmgr.IsTaskQueueFull())
                            {
                                AddReward(0.1f); //we encourage not adding to the pile if there are too many tasks. The developer might have ADHD, but the agent shouldn't
                                WriteToFile("As it should be, we're already full");
                            }
                            if (timeSinceLastAction > explorationTreshold)
                            {
                                AddReward(-0.5f); //*pokes AI* come on, do something
                            }
                        }

                    }
                    break;
                case float n when (n >= 0.1 && n < 0.2): //move
                    {
                        WriteToFile("Move!");
                        if (AIPlayerSelector.primaryObject == null)
                        {
                            //What are you doing? There's nothing to move
                            AddReward(-0.1f);
                            WriteToFile("But we can't move nothing");
                        }
                        else //Yes, you have something to work with, good job!
                        {
                            //calculating new position
                            var originalPosition = AIPlayerSelector.primaryObject.transform.position;
                            //distinction necessary due to legacy reasons; our vectorAction used to have only 3 indices
                            var scaleFactor = vectorAction.Length > 3 ? vectorAction[3] * navMeshRadius : 1;
                            Vector3 coords = originalPosition + new Vector3(vectorAction[1], 0, vectorAction[2]) * scaleFactor;
                            AIPlayerSelector.PutOutNewAction(coords, ActionType.MOVE);
                            AddReward(0.3f); //0.1
                            successfulAction = true;
                            //ebug.Log("From the scenic " + originalPosition + " to the wonderful place of " + coords);
                        }

                    }
                    break;
                case float n when (n >= 0.2 && n < 0.3): //train
                    {
                        //Debug.Log("Trying to train here");
                        //TODO this could be a function, but we have no time
                        var trainers = FindObjectsOfType<Trainer>().Where(x => x.GetComponent<ObjectInfo>().PlayerObject == this.gameObject).ToList();
                        int trainerId = Mathf.RoundToInt(Mathf.Abs(vectorAction[1]) * (trainers.Count() - 1));
                        var trainerSelected = trainers.Count() > 0 ? trainers[trainerId] : null;
                        if (trainerSelected == null || trainerSelected.unitPrototypes.Count == 0)
                        {
                            AddReward(-0.1f);
                        }
                        else
                        {
                            var unitProtoId = Mathf.RoundToInt(Mathf.Abs(vectorAction[2]) * (trainerSelected.unitPrototypes.Count() - 1));
                            var unitProto = trainerSelected.unitPrototypes[unitProtoId];
                            var taskmgr = trainerSelected.GetComponent<TaskManager>();
                            if(UnitProto.GetComponent<ObjectInfo>().price>Stats.PlayerResourceManager.GetResourceAmount(ResourceTypes.GOLD))
                            {
                                AddReward(-0.1f);
                                break;
                            }
                            taskmgr.CreateTask(unitProto, ActionType.BUILD, 0);
                            var goldAmount = Stats.PlayerResourceManager.GetResourceAmount(ResourceTypes.GOLD);
                            var unitCount = Stats.Units.Count(); 
                            var money_modifier = goldAmount>0? 1 /(goldAmount*100):1;
                            var amount_modifier = unitCount>0?1 / (unitCount*100):1;
                            AddReward(amount_modifier-money_modifier);
                            successfulAction = true;
                            //Debug.Log("successful training");
                        }


                    }
                    break;
                case float n when (n >= 0.3 && n < 0.4): //select unit --> add unit to selection
                    {
                        //if there is no unit selected, go select one, good job
                        if (AIPlayerSelector.primaryObject == null && Stats.Units.Count != 0)
                        {
                            AddReward(0.1f);
                        }
                        //if there is one, what are you even doing at this point
                        else if (Stats.Units.Count==0)
                          {
                              AddReward(-0.1f);
                             // Debug.Log("Can't select: " + Stats.Units.Count+" "+AIPlayerSelector.primaryObject);
                              break;
                          }

                        int id = Mathf.RoundToInt(Mathf.Abs(vectorAction[1]) * (Stats.Units.Count() - 1));

                        if (Stats.Units[id] != null)
                        {
                            var oinfo = Stats.Units[id].GetComponent<UnitObjectInfo>();
                            if (oinfo != null && !AIPlayerSelector.selectedObjects.Contains(oinfo))
                            {
                                //Good job, we have one like that!
                                AddReward(0.3f); //0.1
                                AIPlayerSelector.Select(oinfo);
                                successfulAction = true;
                                Debug.Log("Selection! " + id);

                            }
                            else
                            {
                                AddReward(-0.1f); //can't select something twice
                            }
                        }
                        else
                        {
                            AddReward(-0.1f); //heh nope
                            //Debug.Log("No such unit "+ id);
                        }
                    }
                    break;
                case float n when (n >= 0.4 && n < 0.5): //select resource     
                    {

                        var primary = AIPlayerSelector.primaryObject;
                        var gatherer = primary != null ? primary.GetComponent<GatheringController>() : null;
                        var movementctrl = primary != null ? primary.GetComponent<MovementController>() : null;
                        if (primary == null || gatherer == null || movementctrl == null)
                        {
                            AddReward(-0.1f); // nobody's working
                        }
                        else
                        {
                            var resources = GameObject.FindGameObjectsWithTag("Resource");
                            int resourceId = Mathf.RoundToInt(Mathf.Abs(vectorAction[1]) * (resources.Count() - 1));
                            var resourceSelected = resources.Count() > 0 ? resources[resourceId] : null;

                            if (resourceSelected != null && movementctrl.HasPathToDestination(resourceSelected?.transform.position))
                            {
                                AIPlayerSelector.PutOutNewAction(resourceSelected.transform.gameObject, ActionType.HARVEST, 5);
                                AddReward(0.2f);
                                successfulAction = true;
                                Debug.Log("Successful resource thingy");
                            }

                            else
                            {
                                AddReward(-0.1f);
                            }

                        }

                    }

                    break;
                case float n when (n >= 0.5 && n < 0.6): //attack
                    {
                        WriteToFile("Attack!");
                        var primary = AIPlayerSelector.primaryObject;
                        var damageDealer = primary != null ? primary.GetComponent<DamageDealer>() : null;
                        if (primary == null || damageDealer == null)
                        {
                            //What are you doing? There's nothing to attack with
                            AddReward(-0.1f);
                            WriteToFile("Nope, u can't do that with nothing");
                        }
                        else //Yes, you have something to work with, good job!
                        {
                            //calculating new target

                            int enemyId = Mathf.RoundToInt(Mathf.Abs(vectorAction[1]) * (enemyUnits.Count() - 1));
                            WriteToFile("Attack Selection! " + enemyId);

                            //do we have such an enemy?
                            var enemyUnitSelected = enemyUnits.Count() > 0 ? enemyUnits[enemyId] : null;
                            //is said enemy reachable?
                            bool hasPath = false;

                            var movementController = AIPlayerSelector.primaryObject.GetComponent<MovementController>();
                            if (enemyUnitSelected != null)
                            {
                                hasPath = movementController != null ? movementController.HasPathToDestination(enemyUnitSelected?.transform.position) : //if the object can move, does it have a path there?
                                Vector3.Distance(AIPlayerSelector.primaryObject.transform.position, enemyUnitSelected.transform.position) < damageDealer.attackRange; //if it can't, is it in attack range?
                            }

                            if (enemyUnitSelected != null && hasPath) //if we have an enemy chosen and it is reachable, do attack it and give the appropriate rewards
                            {
                                //Good job, we have one like that!
                                AddReward(0.1f);
                                AIPlayerSelector.PutOutNewAction(enemyUnitSelected.gameObject, ActionType.ATTACK, 0);
                                successfulAction = true;

                                //Debug.Log("ok, we can attack that");

                            }
                            else
                            {
                                AddReward(-0.2f); //NO *sprays AI with plant mister*
                                WriteToFile("You absolute dumpling, that's not how you attack " + enemyUnitSelected + " " + hasPath);
                            }
                        }
                    }
                    break;
                case float n when (n >= 0.6 && n < 0.7): //cancel action
                    {
                        var primary = AIPlayerSelector.primaryObject;

                        if (primary != null)
                        {
                            var tskmgr = primary == null ? null : primary.GetComponent<TaskManager>();
                            var dest = primary.GetComponent<Destroyable>();
                            var distanceParameter = 2;
                            var shouldBeCancelled = dest.IsUnderAttack && AIPlayerSelector.GetDistanceOfClosestEnemy() < distanceParameter;
                            if (tskmgr != null)
                            {
                                tskmgr.CancelAction();
                                if (shouldBeCancelled) AddReward(0.2f);
                               // Debug.Log("Cancelled an action");
                            }
                            else
                            {
                                AddReward(-0.1f);
                            }
                        }
                        else
                        {
                            AddReward(-0.1f);
                        }

                    }
                    break;
                case float n when (n >= 0.7 && n < 0.8): //clear selection
                    {
                        if (AIPlayerSelector.selectedObjects.Count == 0)
                        {
                            AddReward(-0.1f); //nothing to let go of
                            break;
                        }
                        else
                        {
                            AIPlayerSelector.ClearSelection(); //clear that selection
                        }
                    }
                    break;
                default:
                    {
                        AddReward(-0.5f);
                        WriteToFile("You can't do that lol: " + vectorAction[0]);
                    }
                    break;
            }

            if (timeSinceLastAction > explorationTreshold)
            {
                AddReward(-0.5f);
            }

            if (successfulAction)
            {

                timeSinceLastAction = 0;
                AddReward(explorationReward);

            }
        }


        public override void OnEpisodeBegin()
        {
            //Debug.Log("Start of Episode:" + CompletedEpisodes);
            episodeId++;
            //Debug.Log("---------------Welcome to the new episode" + episodeId + " of Exasperated Student Tries To Teach " + currentAgentId + ", One Of Their Ungrateful Children!---------------" + this.CompletedEpisodes);
            //Debug.Log("OnEpisodeBegin");
            episodeBegin = true;
            Stats.Units.Clear();
            Stats.PlayerResourceManager.ResetResources();
            if (enemyUnits != null) enemyUnits.Clear();
            // Debug.Log("Units cleared");
           // var unitsPresent = transform.parent.GetComponentsInChildren<UnitObjectInfo>().Where(x => x.PlayerObject == this.gameObject && x.GetComponent<Destroyable>()?.Hp > 0).ToList();
            var minePresent = transform.parent.GetComponentsInChildren<ObjectInfo>().Where(x => x.PlayerObject == this.gameObject && x.GetComponent<Destroyable>()?.Hp > 0 && x.gameObject.CompareTag("Resource")).ToList();
            var barrackPresent = transform.parent.GetComponentsInChildren<ObjectInfo>().Where(x => x.PlayerObject == this.gameObject && x.GetComponent<Destroyable>()?.Hp > 0 && x.gameObject.GetComponent<Trainer>() != null).ToList();

            enemyUnits = transform.parent.GetComponentsInChildren<Destroyable>().Where(x => x.GetComponent<ObjectInfo>().PlayerObject != this.gameObject && x.Hp > 0).ToList(); //solved problem of looking through ALL units

            if (enemyUnits.Count == 0)
            {
                var enemyObject = InstantiateUnit(EnemyProto);
                enemyUnits.Add(enemyObject.GetComponent<Destroyable>());
            }
            else
            {
                foreach (var unit in enemyUnits)
                {
                    ResetUnit(unit.gameObject);
                }
            }

            foreach(var unit in Stats.Units)
            {
                if(unit.GetComponent<UnitObjectInfo>()!=null)
                {
                    KillUnit(unit);
                }
            }

            /*if (unitsPresent.Count == 0)
            {
               // Debug.Log("Instantiating new units!");
                var newobject = InstantiateUnit(UnitProto);
                var oinfo = newobject.GetComponent<UnitObjectInfo>();

                unitsPresent.Add(oinfo);
                oinfo.Player = this;
                oinfo.PlayerObject = this.gameObject;

                var financial = newobject.GetComponent<FinancialModifier>();
                if (financial != null) financial.StartFinances();
            }
            else
            {
                foreach (var unit in unitsPresent)
                {
                    ResetUnit(unit.gameObject);
                }
            }
            foreach (var o in unitsPresent)
            {
                Stats.AddFriendlyUnit(o.gameObject);
            }*/

            //reset mines

            if (minePresent.Count == 0)
            {
               // Debug.Log("Instantiating new mines!");
                var newobject = InstantiateUnit(MineProto);
                var oinfo = newobject.GetComponent<ObjectInfo>();

                minePresent.Add(oinfo);
                oinfo.Player = this;
                oinfo.PlayerObject = this.gameObject;

                var financial = newobject.GetComponent<FinancialModifier>();
                if (financial != null) financial.StartFinances();
            }
            else
            {
                foreach (var unit in minePresent)
                {
                    ResetUnit(unit.gameObject);
                    (unit as NodeManager).enabled = true;
                }
            }
            foreach (var o in minePresent)
            {
                Stats.AddFriendlyUnit(o.gameObject);
            }
           //TODO create a friggen function pls

            //reset barracks
            if (barrackPresent.Count == 0)
            {
               // Debug.Log("Instantiating new barracks!");
                var newobject = InstantiateUnit(BarrackProto);
                var oinfo = newobject.GetComponent<ObjectInfo>();

                minePresent.Add(oinfo);
                oinfo.Player = this;
                oinfo.PlayerObject = this.gameObject;

                var financial = newobject.GetComponent<FinancialModifier>();
                if (financial != null) financial.StartFinances();
            }
            else
            {
                foreach (var unit in barrackPresent)
                {
                    ResetUnit(unit.gameObject);
                }
            }
            foreach (var o in barrackPresent)
            {
                Stats.AddFriendlyUnit(o.gameObject);
            }


            GetComponent<Selector>().ClearSelection();
            Stats.GameEventManager.ClearListeners();
            episodeBegin = false;
            //Debug.Log(agentId + " is Done with init " + episodeId);
        }

        private void ResetUnit(GameObject unit)
        {
            var destroyable = unit.GetComponent<Destroyable>();
            if (destroyable != null) destroyable.ResetState();
            var dmg = unit.GetComponent<DamageDealer>();
            if (dmg != null) dmg.ClearTarget();



            //unit.transform.position = hit.position;
        }
        private Vector3 GetRandomNavmeshPosition()
        {
            NavMeshHit hit = new NavMeshHit();
            Vector3 newPos = transform.position + UnityEngine.Random.insideUnitSphere * UnityEngine.Random.Range(2, navMeshRadius);
            newPos.y = 0;

            while (!NavMesh.SamplePosition(newPos, out hit, navMeshRadius, NavMesh.AllAreas))
            {
                newPos = transform.position + UnityEngine.Random.insideUnitSphere * UnityEngine.Random.Range(2, navMeshRadius);
                continue;
            }
            return hit.position;
        }
        public override void Heuristic(float[] actionsOut)
        {
            base.Heuristic(actionsOut);
        }
        //public void OnListChanged(object sender, NotifyCollectionChangedEventArgs args)
        //{
        //    if (Stats.Units.Count == 0 && !episodeBegin)
        //    {
        //        //FindObjectOfType<GameController>().CurrentGameState = GameState.LOST;
        //        //selector.ReleaseUI();



        //    }
        //}

        public void KillUnit(GameObject unit)
        {
            if(!episodeBegin) AddReward(-2.0f);
            if (AIPlayerSelector.primaryObject == unit) AIPlayerSelector.primaryObject = null;
            if (AIPlayerSelector.selectedObjects.Contains(unit.GetComponent<ObjectInfo>())) AIPlayerSelector.selectedObjects.Remove(unit.GetComponent<ObjectInfo>());
            WriteToFile("You Died Lol");
            Stats.KillUnit(unit);
            Destroy(unit);
            if (Stats.Units.Count(x=>x.GetComponent<UnitObjectInfo>()!=null)==0 && !episodeBegin)
            {
                EndEpisode();
            }

        }

        public void ScoreKill()
        {
            Debug.Log("the player knows we killed someone");
            WriteToFile("You Killed Someone!");
            AddReward(1.0f);
            //EndEpisode();

        }

        private GameObject InstantiateUnit(GameObject unit)
        {

            var newPos = GetRandomNavmeshPosition();
            var unitObject = Instantiate(unit, newPos, Quaternion.identity);
            unitObject.transform.parent = this.transform.parent;
            var navmeshagent = unit.GetComponent<NavMeshAgent>();
            if(navmeshagent!=null)
            {
                navmeshagent.Warp(newPos);
            }
            else
            {
                unitObject.transform.position = newPos;
            }
            ResetUnit(unitObject);
            return unitObject;
        }

        public void OnListChanged(object sender, NotifyCollectionChangedEventArgs args)
        {
            //throw new NotImplementedException();
        }
    }

}

