using RTSGame;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using TMPro;
using UnityEngine;

namespace RTSGame
{
    public class UnitUIManager : MonoBehaviour
    {
        // Start is called before the first frame update
        GameObject unitSelected = null;
        public TextMeshProUGUI unitNameText;
        public Transform healthBar;
        public GameObject inventoryPanel;

        public GameObject inventoryItemPrefab;
        public AnimationClip appearAnimation;
        public AnimationClip disappearAnimation;
       

        // Update is called once per frame
        void Update()
        {
            if (unitSelected != null)
                UpdateHealthPanel();
        }

        public void BindGameObject(GameObject go)
        {
            unitSelected = go;

            unitNameText.text = go.GetComponent<ObjectInfo>().objectName;
            UpdateHealthPanel();
            GatheringController gc = go.GetComponent<GatheringController>();
            if (gc != null)
            {
                foreach(ResourceTypes type in gc.heldResources.Keys)
                {
                    InsertInventoryItem(gc, type, go.GetComponent<ObjectInfo>());
                }
                

            }
        }

        public void InsertInventoryItem(GatheringController gc, ResourceTypes type, ObjectInfo objectInfo)
        {

            GameObject invItem = Instantiate(inventoryItemPrefab);
            invItem.transform.SetParent(inventoryPanel.transform);
            invItem.GetComponent<InventoryItem>().AttachResource(gc.heldResources[type],objectInfo);
        }
        public void ReleaseGameObject()
        {
            unitSelected = null;
            unitNameText.text = "";
            Debug.Log("GO released");
            foreach (Transform child in inventoryPanel.transform)
            {
                if (!child.Equals(inventoryPanel.transform))
                {
                    Destroy(child.gameObject);
                }
                inventoryPanel.transform.DetachChildren();

            }

        }

        public void UpdateHealthPanel()
        {
            healthBar.localScale = new Vector3(unitSelected.GetComponent<Destroyable>().HealthPercentage, 1, 1);

        }

       

    }
}