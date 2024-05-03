using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LaserTurret : MonoBehaviour
{
    public turret turret;
    public LineRenderer Line0;
    public LineRenderer Line1;
    public LineRenderer Line2;
    public GameObject firePosition;
    public float attackInterval =0.5f;
    // float WarmUpScale = 1;
    public int harm = 10;
    public Level level = Level.one;
    void Start()
    {
        turret=gameObject.GetComponent<turret>();
        Line0.SetPosition(0,Vector3.zero);
        Line1.SetPosition(0,Vector3.zero);
        Line2.SetPosition(0,Vector3.zero);
    }

    private float time;
    bool CanAttack = false;
    void Update()
    {
        time += Time.deltaTime;
        if (time >= attackInterval)
        {
            CanAttack = true;
        }
        //int count = turret.monsterList.Count;
        if (turret.monsterList.Count > 0 )
        {
            try
            {
                if (turret.monsterList[0] == null)
                    turret.UpdateEnemys();
                if (CanAttack && turret.monsterList.Count != 0)
                {
                    Line0.SetPosition(1, turret.monsterList[0].transform.position - Line0.transform.position);
                    turret.monsterList[0].GetComponent<Monster>().TakeDamage(harm);
                }
            }
            catch 
            { 
            }
        }
        else
        {
            Line0.SetPosition(1, Vector3.zero);
            //Line1.SetPosition(1, Vector3.zero);
            //Line2.SetPosition(1, Vector3.zero);
        }
        turret.UpdateEnemys();
        CanAttack = false;
    }
}
