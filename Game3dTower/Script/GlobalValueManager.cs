using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UI;

public class GlobalValueManager : MonoBehaviour
{
    //本类用于关卡内管理金钱，生命值。
    public int money = 1000;
    public int hp = 20;

    public GameObject turret0Prefab;
    public GameObject turret1Prefab;
    public GameObject turret2Prefab;
    public GameObject turret3Prefab;

    public GameObject turret0UpgradedPrefab;
    public GameObject turret1UpgradedPrefab;
    public GameObject turret2UpgradedPrefab;
    public GameObject turret3UpgradedPrefab;
    
    public GameObject MonsterPrefab0;
    public GameObject MonsterPrefab1;
    public GameObject MonsterPrefab2;
    public GameObject MonsterPrefab3;
    //选择的炮台
    public GameObject SelectPrefab;
    
    private AliceSohiiUniversalObjectPool objectPool;
    private GlobalUiController globalUiController;
    private Toggle toggle0;
    private Toggle toggle1;
    private Toggle toggle2;
    private Toggle toggle3;

    public int MonsterCount;
    private Waypoints waypoints;
    public Transform monsterSpawnPoint;
    private Camera camera;
    void Start()
    {
        camera = Camera.main;
        GameObject wayponits = GameObject.Find("Waypoints"); 
        waypoints = wayponits.GetComponent<Waypoints>();
        monsterSpawnPoint = waypoints.Get0Transform();
        toggle0 = GameObject.Find("Toggle 0").GetComponent<Toggle>();  
        toggle1 = GameObject.Find("Toggle 1").GetComponent<Toggle>();  
        toggle2 = GameObject.Find("Toggle 2").GetComponent<Toggle>();  
        toggle3 = GameObject.Find("Toggle 3").GetComponent<Toggle>();  
        
        GameObject globalValueManagerObject = GameObject.Find("GlobalManager"); 
        if (globalValueManagerObject != null)  
        {
            objectPool = globalValueManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
            globalUiController = globalValueManagerObject.GetComponent<GlobalUiController>();
        }
        // else 
        //     Debug.LogError("无法找到名为'GlobalValueManager'的对象"); 
        

        globalUiController.SetMoneyText("$"+money);
        globalUiController.SetHpText("" + hp);
        MonsterCount = 0;
    }
    public Base _SelectBase;
    private void Update()
    {

        //作弊1 生成一只怪
         if (Input.GetKeyDown(KeyCode.Alpha1))
         {
            try
            {
                GameObject obj;
                obj = objectPool.Get(MonsterPrefab0);
                var monster = obj.GetComponent<Monster>();
                monster.ReStart();
                var a = monsterSpawnPoint.position;
                obj.gameObject.transform.position = new Vector3(a.x, a.y, a.z);
                MonsterCount += 1;
            }
            catch { }

         }
        if (EventSystem.current.IsPointerOverGameObject() == false) //不在Ui层且没有选择
        {
            Ray ray = camera.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;
            bool isCollider = Physics.Raycast(ray, out hit, 1000, LayerMask.GetMask("Base")); //和Cube层做检测
            if (isCollider) //碰撞成功
            {
                //无法优化，对象池缓存的是GameObj;
                _SelectBase = hit.collider.GetComponent<Base>(); //直接获取碰撞到的物体。
                //_base.OnMouseEnterRay();
                //_base.OnMouseExitRay();
            }
            else
            {
                _SelectBase = null;
            }
        }
        ReLoadMonsterCount();
    }
    //花钱
    public bool SpendMoney(int cost)
    {
        if (money >= cost)
        {
            money -= cost;
            globalUiController.SetMoneyText("$"+money);  
            return true;
        }
        else
        {
            return false;
        }
        
    }
    //赚钱
    public void MakeMoney(int bounty)
    {
        money += bounty;
        globalUiController.SetMoneyText("$"+money);
    }

    public void TakeDamage(int damage)
    {
        hp -= damage;
        globalUiController.SetHpText(""+hp);
    
    }
    public void SelectTurret0(bool isNo)
    {
        if (isNo)
        {
            //Debug.Log("0被开启");
            SelectPrefab = turret0Prefab;
        }
        else
        {
            //Debug.Log("0被开启");
            SelectPrefab = null;
        }
    }
    public void SelectTurret1(bool isNo)
    {
        if (isNo)
        { 
            //Debug.Log("1被开启");
            SelectPrefab = turret1Prefab;
        }
        else
        {
            //Debug.Log("1被关闭");
            SelectPrefab = null;
        }
    }
    public void SelectTurret2(bool isNo)
    {
        if (isNo)
        {
            //Debug.Log("2被开启");
            SelectPrefab = turret2Prefab;
        }
        else
        {
            //Debug.Log("2被关闭");
            SelectPrefab = null;
        }
            
    }
    public void SelectTurret3(bool isNo)
    {
        if (isNo)
        {
            //Debug.Log("3被开启");
            SelectPrefab = turret3Prefab;
        }
        else
        {
            //Debug.Log("3被关闭");
            SelectPrefab = null;
        }
    }
    //取消选择
    public void Deselect()
    {
        toggle0.isOn = false;
        toggle1.isOn = false;
        toggle2.isOn = false;
        toggle3.isOn = false;
        SelectPrefab = null;
    }

    public int CountActiveChildrenWithTag(string tag = "Monster")
    {
        int count = 0;
        foreach (Transform child in transform)
        {
            if (child.gameObject.activeSelf && child.CompareTag(tag))
            {
                count++;
            }
        }
        return count;
    }
    public void ReLoadMonsterCount() 
    {
        MonsterCount = CountActiveChildrenWithTag();
    }

}
