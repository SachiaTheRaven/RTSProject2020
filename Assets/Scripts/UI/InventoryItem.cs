using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RTSGame
{
    public class InventoryItem : MonoBehaviour
    {
        ResourceBlock childResource=null;
        ObjectInfo carrierUnit = null;
        TextMeshProUGUI numberText;
        public Image resourceImage;

        public  Material stoneMaterial;
        void Start()
        {
            numberText = GetComponentInChildren<TextMeshProUGUI>();
           // resourceImage = GetComponent<Image>();

        }

        void Update()
        {
            if(childResource!=null)
            {
                numberText.text = childResource.amount.ToString() + "/" + childResource.maxAmount.ToString();
                if (childResource.emptied)
                {

                    Destroy(this.gameObject);
                }
            }

        }

        public void AttachResource(ResourceBlock rb, ObjectInfo objectInfo)
        {
            childResource = rb;
            carrierUnit = objectInfo;
            //TODO: change for several materials


            resourceImage.material = stoneMaterial;
        }
    }

}
