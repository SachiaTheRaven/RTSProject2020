using RTSGame;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Destroyable : MonoBehaviour
{
    public int maxHP;
    public int hp;
    private DamageDealer dmg;
    private GameObject lastAttacker;
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
            else
            {
                var attacker = lastAttacker.GetComponent<Destroyable>();
                if (value<hp && dmg!=null && !dmg.inCombat && attacker!=null)
                {
                    dmg.FightBack(attacker);
                }
                hp = value;
            }
        }

    }
    public float HealthPercentage { get { return maxHP != 0 ? (float)Hp / (float)maxHP : 0; } }
    void Start()
    {
        dmg = GetComponent<DamageDealer>();
    }

    // Update is called once per frame
    void Update()
    {
    }
    public void Damage(int amount,GameObject attacker)
    {
        lastAttacker = attacker;
        Hp -= amount;
    }
    public void Heal(int amount)
    {
        Hp += amount;
    }
    public void Die()
    {
        ObjectInfo oinfo = gameObject.GetComponent<ObjectInfo>();
        if(oinfo!=null && oinfo.player!=null)oinfo.player.KillUnit(gameObject);
        Destroy(gameObject);
    }
}
