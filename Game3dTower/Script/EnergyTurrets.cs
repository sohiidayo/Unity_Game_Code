using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class EnergyTurrets : MonoBehaviour
{
    public GameObject bulletPrefabs;
    public GameObject firePosition;
    public Transform firetranform;
    public turret turret;
    public float attackInterval = 1f;
    public float timer ;
    public int harm = 10;
    public Level level = Level.one;
    
    private GlobalValueManager globalValueManager;
    private AliceSohiiUniversalObjectPool objectPool;
    
    void Start()
    {
        turret=gameObject.GetComponent<turret>();
        firetranform = firePosition.transform;
        timer = attackInterval;
        GameObject globalManagerObject = GameObject.Find("GlobalManager");
        if (globalManagerObject != null)
        {
            objectPool = globalManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
            globalValueManager = globalManagerObject.GetComponent<GlobalValueManager>();
        }
    }
    
    void Update()
    {
        if (turret.monsterList.Count != 0)
        {
            if (level == Level.one)
                timer -= Time.deltaTime;
            if (level == Level.two)
                timer -= Time.deltaTime * 1.5f;
            if (level == Level.two)
                timer -= Time.deltaTime * 2f;
        }
        else
        {
            timer = attackInterval;
        }
        if (timer <= 0)
        {
            try
            {
                //攻击逻辑
                timer = attackInterval;
                GameObject obj = objectPool.Get(bulletPrefabs);
                obj.transform.position = firePosition.transform.position;
                // GameObject obj = Instantiate(bulletPrefabs, firetranform.position, Quaternion.identity);
                //优化不能，除非对象池缓存的是Bullet
                Bullet bullet = obj.GetComponent<Bullet>();
                if (level == Level.one)
                    bullet.harm = harm;
                if (level == Level.two)
                    bullet.harm = harm * 3 / 2;
                if (level == Level.two)
                    bullet.harm = harm * 2;
                bullet.SetTarget(turret.monsterList[0]);
                //bullet.target = turret.monsterList[0].gameObject.transform;
                //Debug.Log("触发攻击");
            }
            catch { }
        }
    }
}
