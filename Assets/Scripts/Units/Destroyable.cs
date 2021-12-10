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
    public HealthBar HealthBar;
    public HealthBar UnitUIHealthbar = null;
    public bool IsUnderAttack = false; //used by the AIPlayer to determine state of unit

    int attackTimeout = 5;
    float lastAttackTime = -1;

    public int Hp
    {
        get { return hp; }
        set
        {

            if (value > maxHP) hp = maxHP;
            else
            {
                var attacker = lastAttacker != null ? lastAttacker.GetComponent<Destroyable>() : null;
                if (value <= 0)
                {
                    hp = 0;
                    Die();
                    var lastDmg = lastAttacker != null ? lastAttacker.GetComponent<DamageDealer>():null;
                    if (lastDmg != null) lastDmg.ScoreKill();
                }
                else
                {
                   
                    if (attacker != null && value < hp && dmg != null && !dmg.inCombat && !IsUnderAttack)//only check the first time!
                    {
                        IsUnderAttack = true;
                        dmg.FightBack(attacker);
                    }
                    lastAttackTime = Time.time;

                    hp = value;
                }
            }
            if (HealthBar != null) HealthBar.UpdatePercentage(HealthPercentage);
            if (UnitUIHealthbar != null) UnitUIHealthbar.UpdatePercentage(HealthPercentage);
        }

    }
    public float HealthPercentage { get { return maxHP != 0 ? (float)Hp / (float)maxHP : 0; } }
    void Start()
    {
        dmg = GetComponent<DamageDealer>();
        ResetState();

    }
    private void Update()
    {
        if (IsUnderAttack && lastAttackTime != -1 && lastAttackTime + attackTimeout < Time.time) //if we haven't been attacked in a while, switch it off
        {
            IsUnderAttack = false;
            dmg.inCombat = false;
        }
    }
    public void ResetState()
    {
        hp = maxHP;
        lastAttacker = null;
        IsUnderAttack = false;
    }


    public void Damage(int amount, GameObject attacker)
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

        //if we have a player, they're gonna destroy us
        //(that sounds much more ominous than I intended)
        if (oinfo != null && oinfo.Player != null) oinfo.Player.KillUnit(gameObject);
        //otherwise it's time to grab those self-destructive tendencies (:
        else Destroy(gameObject);
    }
}
