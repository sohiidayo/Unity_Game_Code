using System.Collections;
using System.Collections.Generic;
using System.Timers;
using UnityEngine;

public class StarTurret : MonoBehaviour
{
    public turret turret;
    //有三级 一级为减速30% 二级为受到伤害增加30% 三级为赏金增加20%
    public float decelerate = 0.3f;
    public float frail = 0.3f;
    public float moreValuable = 0.2f;
    public Level level = Level.one;

    void Start()
    {
        turret=gameObject.GetComponent<turret>();
    }
    private float timer = 0;
    void Update()
    {
        timer += Time.deltaTime;
        if (timer > 0.4)
        {
            foreach (var i in turret.monsterList)
            {
                if (level==Level.one)
                    i.GetComponent<Monster>().SetBuff(decelerate,0f,0f);
                else if(level==Level.two)
                    i.GetComponent<Monster>().SetBuff(decelerate,frail,0f);
                else if(level==Level.three)
                    i.GetComponent<Monster>().SetBuff(decelerate,frail,moreValuable);
            }
            timer = 0;
        }
    }
}
