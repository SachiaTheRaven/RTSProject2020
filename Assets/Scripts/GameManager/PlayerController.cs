using System;
using System.Collections;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using TMPro;
using Unity.MLAgents;
using Unity.MLAgents.Actuators;
using Unity.MLAgents.Sensors;
using UnityEditor;
using UnityEngine;
namespace RTSGame
{
    public class PlayerController : Agent
    {
        // Start is called before the first frame update
        public GameObject unitProto;
        public ObservableCollection<GameObject> units;
        public List<GameObject> buildings;
        public Selector selector;
        public ResourceManager resourceManager;
        public bool isLearning = false;

        //A key-value set of enemy units in range
        Dictionary<GUID, GameObject> EnemiesInRange = new Dictionary<GUID, GameObject>();
        List<GameObject> FriendlyUnits = new List<GameObject>();
        string helpimlostfile;
        internal void AddFriendlyUnit(GameObject gameObject)
        {
            FriendlyUnits.Add(gameObject);

        }

       /* public void WriteToFile(string message)
        {
            using (StreamWriter filewriter = File.AppendText(helpimlostfile))
            {
                filewriter.WriteLine(System.DateTime.Now+"-" +message);
            }
        }*/
       /* private void Awake()
        {
            helpimlostfile = Application.persistentDataPath + "this is why nobody likes you my child.txt";
            
            Debug.Log(Application.persistentDataPath);
        }*/
        public override void Initialize()
        {
            //moved from Start
            units = new ObservableCollection<GameObject>();
            
            units.CollectionChanged += OnListChanged;
        }
        

        public override void CollectObservations(VectorSensor sensor)
        {

            //Observe the summarized remaining health of our babies
            float sumhealth = FriendlyUnits.Count()>0? (float)FriendlyUnits.Sum(x =>x!=null?x.GetComponent<Destroyable>().hp:0)/
                (float)FriendlyUnits.Sum(x=>x!=null?x.GetComponent<Destroyable>().maxHP:1):0; 
            sensor.AddObservation(sumhealth);
            //Observe the distance from the closest enemy unit (currently only for primary unit)

            var dist = selector.GetDistanceOfClosestEnemy();
            sensor.AddObservation(1/dist);
            //TODO: figure out what else to observe
            //WriteToFile("Collecting Observations" + sumhealth + " - " + 1/dist);

        }
        public override void OnActionReceived(float[] vectorAction)
        {
            //WriteToFile("Action recieved:");

            AddReward(0.05f); //congrats you're alive
            //switch on actiontype: discreteactions
            switch (vectorAction[0])
            {
                case float n when (n>=0.0 && n<0.1): //idle         
              //      WriteToFile("Nothing!");

                    break;
                case float n when (n >=0.1 && n < 0.2): //move
                    {
                      //  WriteToFile("Move!");
                        if(selector.primaryObject==null)
                        {
                            //What are you doing? There's nothing to move
                            AddReward(-0.1f);
                        }
                        else //Yes, you have something to work with, good job!
                        {
                            //calculating new position
                            Vector3 coords = selector.primaryObject.transform.position + new Vector3(vectorAction[1], 0, vectorAction[2]);
                            selector.PutOutNewAction(coords, ActionType.MOVE);
                            AddReward(0.1f);
                        }
                    
                    } break;
                case float n when (n >=0.2 && n < 0.3): //train
                    //WriteToFile("we can't even train yet lol");

                    break;
                case float n when (n >= 0.3 && n < 0.4): //select unit
                    {
                        //if there is no unit selected, go select one, good job
                        if (selector.primaryObject == null && FriendlyUnits.Count != 0)
                        {
                            AddReward(0.1f);

                        }
                        //if there is one, what are you even doing at this point
                        else
                        {
                            AddReward(-0.1f);
                            break;
                        }
                                               
                        int id = Mathf.RoundToInt(Mathf.Abs(vectorAction[1])*(FriendlyUnits.Count()-1));
                       // WriteToFile("Selection! "+ id);

                        if (FriendlyUnits[id]!=null)
                        {
                            //Good job, we have one like that!
                            AddReward(0.1f);
                            selector.Select(FriendlyUnits[id].GetComponent<ObjectInfo>());
                        }
                        else AddReward(-0.1f); //heh nope
                    }
                    break;
                case float n when (n >= 0.4 && n < 0.5): //select resource        
                    //WriteToFile("No resources for nasty AI");

                    break;
                default:
                    {
                        AddReward(-0.5f);
                      //  WriteToFile("You can't do that lol: " + vectorAction[0]);
                    } break;
            }
        }

        internal void RemoveEnemyFromRange(GameObject gameObject)
        {
            EnemiesInRange.Remove(EnemiesInRange.Where(x => x.Value == gameObject).FirstOrDefault().Key);
        }

        //when an enemy unit crosses its range border, any friendly unit will report it here
        internal void AddEnemyInRange(GameObject gameObject)
        {
            EnemiesInRange.Add(GUID.Generate(), gameObject);
        }

        public override void OnEpisodeBegin()
        {
            if(isLearning)
            {
                FriendlyUnits.Clear();
                var unitsPresent = FindObjectsOfType<ObjectInfo>().Where(x => x.player == this).ToList();
                if (unitsPresent.Count == 0)
                {
                    var newobject = GameObject.Instantiate(unitProto);
                    unitsPresent.Add(newobject.GetComponent<ObjectInfo>());
                    newobject.GetComponent<ObjectInfo>().player = this;
                }
                foreach (var o in unitsPresent)
                {
                    units.Add(o.gameObject);
                    AddFriendlyUnit(o.gameObject);
                }
                GetComponent<Selector>().ClearSelection();
                GameEvent.current.ClearListeners();
            }

        }

        public override void Heuristic(float[] actionsOut)
        {
            base.Heuristic(actionsOut);
        }
        private void OnListChanged(object sender, NotifyCollectionChangedEventArgs args)
        {
            if (units.Count == 0)
            {
                //FindObjectOfType<GameController>().CurrentGameState = GameState.LOST;
                selector.ReleaseUI();

                if (isLearning)
                {
                    EndEpisode();
                }
            }
        }

        public void KillUnit(GameObject unit)
        {
            resourceManager.AddResource(ResourceTypes.POPULATION, -1);
            units.Remove(unit);
            FriendlyUnits.Remove(unit);
            AddReward(-1.0f);

            GameEvent.current.OnObjectActionSent -= unit.GetComponent<TaskManager>().CreateTask;
            GameEvent.current.OnPositionActionSent -= unit.GetComponent<TaskManager>().CreateTask;

            if (selector.primaryObject == unit) selector.primaryObject = null;
            if (selector.selectedObjects.Contains(unit.GetComponent<ObjectInfo>())) selector.selectedObjects.Remove(unit.GetComponent<ObjectInfo>());

        }
    }
}