using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class Infirmary : ObjectInfo
    {
        // Start is called before the first frame update
        public int healingPerSecond = 5;
        List<Destroyable> patients;
        void Start()
        {
            patients = new List<Destroyable>();
            StartCoroutine(HealingCoroutine());
        }

        private new void OnTriggerEnter(Collider other)
        {
            var destroyable = other.GetComponent<Destroyable>();
            var oinfo = other.GetComponent<ObjectInfo>();
            if (destroyable != null && oinfo!=null && oinfo.Player == this.Player)
            {

                patients.Add(destroyable);
            }
        }
        private new void OnTriggerExit(Collider other)
        {
            var destroyable = other.GetComponent<Destroyable>();
            var oinfo = other.GetComponent<ObjectInfo>();

            if (destroyable != null && oinfo != null && oinfo.Player == this.Player)
            {
                patients.Remove(destroyable);
            }
        }

        IEnumerator HealingCoroutine()
        {
            while (true)
            {
                foreach (var patient in patients)
                {
                    if (patient != null) patient.Heal(healingPerSecond);
                }
                yield return new WaitForSeconds(1);
            }
        }
    }
}