using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MissileTurret : MonoBehaviour
{
    
    public GameObject MissilePrefabs;
    public GameObject firePosition;
    public Transform fireTranform;
    public GameObject firePosition1;
    public Transform fireTranform1;
    public turret turret;
    public float attackInterval = 1f;
    public float timer ;
    private bool Use01fireTranform = true;//true代表0号开火点。
    private GlobalValueManager globalValueManager;
    private AliceSohiiUniversalObjectPool objectPool;
    void Start()
    {
        turret=gameObject.GetComponent<turret>();
        fireTranform = firePosition.transform;
        fireTranform1 = firePosition1.transform;
        Use01fireTranform = true;
        timer = attackInterval;
        GameObject globalManagerObject = GameObject.Find("GlobalManager");
        if (globalManagerObject != null)
        {
            objectPool = globalManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
            globalValueManager = globalManagerObject.GetComponent<GlobalValueManager>();
        }
    }

    // Update is called once per frame
    void Update()
    {
        if (turret.monsterList.Count != 0)
        {
            timer -= Time.deltaTime;
        }
        else
        {
            timer = attackInterval;
        }
        if (timer <= 0)
        {
            //攻击逻辑
            timer = attackInterval;
            GameObject obj = objectPool.Get(MissilePrefabs);
            if (Use01fireTranform)
            {
                obj.transform.position = firePosition.transform.position;
                Use01fireTranform = !Use01fireTranform;
               // Debug.Log("炮口0");
            }
            else
            {
                obj.transform.position = firePosition1.transform.position;
                Use01fireTranform = !Use01fireTranform;
               // Debug.Log("炮口1");
            }
            // GameObject obj = Instantiate(bulletPrefabs, firetranform.position, Quaternion.identity);
            Missile missile = obj.GetComponent<Missile>();
            missile.SetTarget(turret.monsterList[0]);
            
            //bullet.target = turret.monsterList[0].gameObject.transform;
            //Debug.Log("触发攻击");
        }
        
    }
}
