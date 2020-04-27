using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Destroyable : MonoBehaviour
{
    int hp;
    //TODO connect to HP panel
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (hp <= 0) Die();
    }
    public void Damage(int amount)
    { }
    public void Heal(int amount)
    {

    }
    public void Die()
    {
        Destroy(gameObject);
    }
}
