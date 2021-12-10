using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

namespace RTSGame
{
    public class WaveAnnouncerControl : MonoBehaviour
    {
        public Image swordImage;
        public TextMeshProUGUI detailText;
        public GameObject parentPanel;

        public bool ActiveStatus
        {
            get { return parentPanel != null && parentPanel.activeInHierarchy; }
        }
      

        public void SetWaveDirection(Vector3 wavePos)
        {
            Vector2 screenPos = Camera.main.WorldToScreenPoint(wavePos);
            Vector2 center = new Vector2(Screen.width / 2, Screen.height / 2);
            Vector2 dir = (center - screenPos).normalized;
            float angle = getAngle(dir,Vector2.zero);
            swordImage.transform.rotation = Quaternion.Euler(0, 0, angle);


        }
        public void ToggleActiveStatus(bool stat)
        {
            parentPanel.SetActive(stat);

        }

        
        public void SetDetailText(List<UnitTypeDictionaryItem> formation)
        {
            string formationText = "";
            foreach (var f in formation)
            {
                //TODO: dictionary with names?
                formationText += f.key.ToString() + ":" + f.value.ToString() + "\n";
            }
            detailText.text = formationText;
        }
        public float getAngle(Vector2 me, Vector2 target)
        {
            return Mathf.Atan2(target.y - me.y, target.x - me.x) * (180 / Mathf.PI);
        }
    }
}