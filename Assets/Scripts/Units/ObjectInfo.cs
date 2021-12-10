using UnityEngine;

namespace RTSGame
{
    public class ObjectInfo : MonoBehaviour
    {
        public GameObject PlayerObject;
      //  [SerializeField, SerializeReference]
        // [RequireInterface(typeof(ICommonPlayer))] //TODO fix this
        public ICommonPlayer Player;
        public UnitType unitType;
        public UnitStatus status;
        /*public ICommonPlayer Player
        {
            get
            {
                return player as ICommonPlayer;
            }
            set
            {
                player = (Object)value;
            }
        }*/
        public int price = 1;
        public string objectName;

        protected virtual void Awake()        {

            if (Player == null && PlayerObject != null) Player = PlayerObject.GetComponent<ICommonPlayer>();
            if (Player != null)
            {
                Player.Stats.AddFriendlyUnit(this.gameObject);
            }
            //Debug.Log(Player);

        }

        protected void OnTriggerEnter(Collider other)
        {
            var oinfo = other.GetComponent<ObjectInfo>();
            if (Player!=null && oinfo != null && oinfo.Player != null && !oinfo.Player.Equals(Player))
            {
                Player.Stats.AddEnemyInRange(other.gameObject);
            }
        }

        protected void OnTriggerExit(Collider other)
        {
            var oinfo = other.GetComponent<ObjectInfo>();
            if (Player!=null && oinfo != null && oinfo.Player != null && !oinfo.Player.Equals(Player))
            {
                Player.Stats.RemoveEnemyFromRange(other.gameObject);
            }
        }

    }
}