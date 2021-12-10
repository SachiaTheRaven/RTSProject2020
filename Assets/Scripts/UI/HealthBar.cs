using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace RTSGame
{
    public class HealthBar : MonoBehaviour
    {
        // Start is called before the first frame update
        public Image healthBar;
        float updateLengthSeconds = 0.5f;
      

        // Update is called once per frame
        void Update()
        {
            transform.forward = -Camera.main.transform.forward;
        }

        public void UpdatePercentage(float prc)
        {
            StartCoroutine(ChangeToPercent(prc));
        }
        IEnumerator ChangeToPercent(float prc)
        {
            float timePassed = 0f;
            float prevPrc = healthBar.fillAmount;
            while (timePassed < updateLengthSeconds)
            {
                timePassed += Time.deltaTime;
                healthBar.fillAmount = Mathf.Lerp(prevPrc, prc, timePassed / updateLengthSeconds);
                yield return null;
            }

        }
    }
}