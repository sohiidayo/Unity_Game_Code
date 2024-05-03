using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[System.Serializable]
public class AliceSohiiUniversalObjectType
{
    public GameObject prefab;
    public int defaultCount = 16;
    public int maxCount = 32;
    public void Set_Prefab_Def_max(GameObject prefab_,int def,int max)
    {
        prefab = prefab_;
        defaultCount = def;
        maxCount = max;
    }

    public AliceSohiiUniversalObjectType()
    {
    }

    public AliceSohiiUniversalObjectType(GameObject prefab,int def,int max)
    {
        Set_Prefab_Def_max(prefab, def, max);
    }
}
public class AliceSohiiUniversalObjectPool : MonoBehaviour
{
    public AliceSohiiUniversalObjectType[] ObjectTypes;
    //对象池列表
    public List<Queue<GameObject>> ObjectPoolList = new List<Queue<GameObject>>();
    //通过对象的引用作为key来获取 对象池列表的索引
    public Dictionary<GameObject,int> ObjectDic =new Dictionary<GameObject,int>();
    //通过预制体的引用作为key来获取 对象池列表的索引
    public Dictionary<GameObject,int> prefabDic =new Dictionary<GameObject,int>();

    public void Start()
    {
        Init();
    }
    public void Init()
    {
        GameObject obj;
        int poolIndex = 0;
        foreach (var type in ObjectTypes)
        {
            var objectPool = new Queue<GameObject>();//ObjectType
            for (int i = 0; i < type.defaultCount; i++)
            {
                obj = Instantiate(type.prefab, this.transform);
                objectPool.Enqueue(obj);
                ObjectDic[obj] = poolIndex;//使用对象作为key，存储着对象池的索引
                obj.SetActive(false);
            }
            ObjectPoolList.Add(objectPool);
            prefabDic[type.prefab] = poolIndex;//使用预制体作为key，存储着对象池的索引
            poolIndex++;
        }
        foreach (KeyValuePair<GameObject, int> entry in prefabDic)  
        {  
            GameObject prefab = entry.Key;  
            int count = entry.Value;  
            //Debug.Log($"Prefab: {prefab.name}, Count: {count}");  
        }  
    }

    public GameObject Get(GameObject prefab)
    {
        GameObject returnGameObject;
        int poolIndex = prefabDic[prefab];
        var Pool = ObjectPoolList[poolIndex];
        if (Pool.Count > 0)
        {
            returnGameObject = ObjectPoolList[poolIndex].Dequeue();
            returnGameObject.SetActive(true);
        }
        else
        {
            returnGameObject = Instantiate(ObjectTypes[poolIndex].prefab, this.transform);
            ObjectDic[returnGameObject] = poolIndex;//使用对象作为key，存储着对象池的索引
        }
        return returnGameObject;
    }
    //从对象池取出的物体要通过这个方法进行移除
    public void Remove(GameObject obj)
    {
        //obj.transform.position = new Vector3(999999, 999999, 999999);
        if(ObjectDic.TryGetValue(obj, out var poolIndex))
        {
            var Pool = ObjectPoolList[poolIndex];
            if (Pool.Count <= ObjectTypes[poolIndex].maxCount)
            {
                if (!Pool.Contains(obj))
                {
                    Pool.Enqueue(obj);
                    obj.SetActive(false);
                }
                else
                {
                    Destroy(obj);
                }
            }
        }
        else
        {
            Destroy(obj);
        }
    }
}
