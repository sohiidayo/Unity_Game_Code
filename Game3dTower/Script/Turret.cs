using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public enum Level
{
    one,
    two,
    three
}
public class turret : MonoBehaviour
{
    public GameObject Upgraded;
    public Base _base;
    public float AttackRange = 5;
    //[HideInInspector]
    public List<GameObject> monsterList = new List<GameObject>();//存放进入触发器内的敌人
    private SphereCollider collider;
    public GameObject AttackRangeCircle;
    
    private GlobalValueManager globalValueManager;
    private AliceSohiiUniversalObjectPool objectPool;
    private void Start()
    {
        // 设置Turret图层  
        gameObject.layer = LayerMask.NameToLayer("Turret");  
        if (!gameObject.TryGetComponent<Collider>(out _))  
        {  
            collider = gameObject.AddComponent<SphereCollider>(); 
            collider.isTrigger = true; // 设置为触发器  
            collider.radius = AttackRange;
        }  
        GameObject globalManagerObject = GameObject.Find("GlobalManager");
        if (globalManagerObject != null)
        {
            objectPool = globalManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
            globalValueManager = globalManagerObject.GetComponent<GlobalValueManager>();
        }
        // else
        //     Debug.LogError("无法AliceSohiiUniversalObjectPool'的对象");
    }
    private void Update()
    {
        UpdateEnemys();

        if (globalValueManager._SelectBase == _base) 
        {
            DispAttackRangeCircle();
        }
        else
        {
            UnDispAttackRangeCircle();
        }
    }
    public void DispAttackRangeCircle()
    {
        AttackRangeCircle.transform.localScale = new Vector3(AttackRange*2, AttackRange*2, AttackRange*2);
    }
    public void UnDispAttackRangeCircle()
    {
        AttackRangeCircle.transform.localScale = new Vector3(0, 0, 0);
    }

    void OnTriggerEnter(Collider col)//敌人进入触发器范围
    {
        if (col.CompareTag("Monster"))
        {
            monsterList.Add(col.gameObject);
        }
    }
    void OnTriggerExit(Collider col)//敌人离开触发器范围
    {
        try{
            if (col.CompareTag("Monster"))
            {
                GameObject go = col.gameObject;
                if (monsterList.Contains(go))
                {
                    monsterList.Remove(go);
                }
            }
        }catch(Exception e)
        {
            UpdateEnemys();
        }
    }
    public bool GetListEnemys(int index ,out GameObject gameObject)
    {
        UpdateEnemys();
        if (index >= monsterList.Count)
        {
            gameObject = null;
            return true;
        }
        if (monsterList[index] is not null)
        {
            gameObject = monsterList[index];
            return true;
        }
        gameObject = null;
        return true;
        
    }
    public void UpdateEnemys() // 移除列表中因为销毁导致的空指针异常  
    {
        List<int> indicesToRemove = new List<int>();
        for (int index = 0; index < monsterList.Count; index++)
        {
            if (monsterList[index] == null || !monsterList[index].activeInHierarchy)
            {
                indicesToRemove.Add(index);
            }
        }
        // 逆序遍历索引列表，并从后往前移除元素  
        for (int i = indicesToRemove.Count - 1; i >= 0; i--)
        {
            monsterList.RemoveAt(indicesToRemove[i]);
        }
    }
}
