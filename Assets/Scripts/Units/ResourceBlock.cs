using System.Collections;
using System.Collections.Generic;
using UnityEditor.Experimental.GraphView;
using UnityEngine;

namespace RTSGame
{
    public class ResourceBlock
    {
        public ResourceTypes type;
        public int amount = 0;
        public int maxAmount = 0;
        public bool emptied = false;
        public bool IsFull {get{return amount>=maxAmount;} }
        public void AddResource(int a)
        {
            if (amount + a <= 0)
            {
                amount = 0;
                emptied = true;
                return;

            }
            if (amount + a <= maxAmount)
                amount += a;
            else amount = maxAmount;

            
        }
       
    }
}