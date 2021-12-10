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
        GameObject unitSelected = null;
        Destroyable dstSelected = null;

        public TextMeshProUGUI unitNameText;
        public HealthBar healthBar;
        public GameObject inventoryPanel;

        public GameObject inventoryItemPrefab;
        public AnimationClip appearAnimation;
        public AnimationClip disappearAnimation;


        public void BindGameObject(GameObject go)
        {
            unitSelected = go;
            dstSelected = go.GetComponent<Destroyable>();
            dstSelected.UnitUIHealthbar = healthBar;

            unitNameText.text = go.GetComponent<ObjectInfo>().objectName;
            healthBar.UpdatePercentage(dstSelected.HealthPercentage);
            GatheringController gc = go.GetComponent<GatheringController>();
            if (gc != null)
            {
                foreach (ResourceTypes type in gc.heldResources.Keys)
                {
                    InsertInventoryItem(gc, type, go.GetComponent<ObjectInfo>());
                }


            }
        }

        public void InsertInventoryItem(GatheringController gc, ResourceTypes type, ObjectInfo objectInfo)
        {

            GameObject invItem = Instantiate(inventoryItemPrefab);
            invItem.transform.SetParent(inventoryPanel.transform);
            invItem.GetComponent<InventoryItem>().AttachResource(gc.heldResources[type], objectInfo);
        }
        public void ReleaseGameObject()
        {
            if (dstSelected != null)
            {
                dstSelected.UnitUIHealthbar = null;
                dstSelected = null;
            }
           
            unitSelected = null;
            unitNameText.text = "";
            foreach (Transform child in inventoryPanel.transform)
            {
                if (!child.Equals(inventoryPanel.transform))
                {
                    Destroy(child.gameObject);
                }
                inventoryPanel.transform.DetachChildren();

            }

        }

    }
}