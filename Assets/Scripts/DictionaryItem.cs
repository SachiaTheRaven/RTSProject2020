using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

namespace RTSGame
{
    // a class solely because Unity is still a half baked potato and doesn't serialize Dictionaries
    [Serializable]
    public class DictionaryItem
    {
        public ActionType type;
        public Sprite image;
    }
}