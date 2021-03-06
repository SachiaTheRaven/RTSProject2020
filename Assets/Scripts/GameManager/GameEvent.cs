﻿using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

namespace RTSGame
{
    public class GameEvent : MonoBehaviour
    {
        public static GameEvent current;
        private void Awake()
        {
            current = this;
        }

        public event System.Action<Vector3, ActionType> OnPositionActionSent;
        public event System.Action<GameObject, ActionType, int> OnObjectActionSent;
        public void SendAction(Vector3 pos, ActionType type)
        {
            OnPositionActionSent?.Invoke(pos, type);
        }
        public void SendAction(GameObject go, ActionType type, int roundLimit)
        {
            OnObjectActionSent?.Invoke(go, type, roundLimit);
        }

        public void ClearListeners()
        {
            OnPositionActionSent = null;
            OnObjectActionSent = null;
        }
    }
}