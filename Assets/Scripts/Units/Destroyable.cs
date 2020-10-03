using RTSGame;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Destroyable : MonoBehaviour
{
    public int maxHP;
    public int hp;
    public int Hp
    {
        get { return hp; }
        set
        {
            if (value > maxHP) hp = maxHP;
            else if (value <= 0)
            {
                hp = 0;
                Die();
            }
            else hp = value;
        }

    }
    public float HealthPercentage { get { return maxHP != 0 ? (float)Hp / (float)maxHP : 0; } }
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {
    }
    public void Damage(int amount)
    {
        Hp -= amount;
    }
    public void Heal(int amount)
    {
        Hp += amount;
    }
    public void Die()
    {
        ObjectInfo oinfo = gameObject.GetComponent<ObjectInfo>();
        oinfo.player.KillUnit(gameObject);
        Destroy(gameObject);
    }
}
