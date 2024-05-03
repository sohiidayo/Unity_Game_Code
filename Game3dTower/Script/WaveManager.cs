using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
[Serializable]
public class SmallWaveType
{
    public enum WaveType
    {                                    //num0                   num1                  num2
        Start,           //等待开始          
        Await,           //不可跳过的等待   秒数
        SkippableAwait,  //可跳过的等待。   秒数                    跳过后奖励金钱        
        SpawnMonster1,   //生成一个怪物。   多少秒进入下一波默认0.2s  击杀后赏金默认100     生成个数默认1
        SpawnMonster2,   //生成一个怪物。   多少秒进入下一波默认0.2s  击杀后赏金默认100     生成个数默认1
        SpawnMonster3,   //生成一个怪物。   多少秒进入下一波默认0.2s  击杀后赏金默认100     生成个数默认1
        SpawnMonster4,   //生成一个怪物。   多少秒进入下一波默认0.2s  击杀后赏金默认100     生成个数默认1
        GetMoney,        //获得金钱        多少秒进入下一波默认0.2s  给予玩家多少钱
        Win              //获得胜利        多少秒进入下一波默认0.2s
    }
    public WaveType waveType = WaveType.Start;
    //作为时间时单位为0.1秒 -1为空
    public int Num0 = -1;
    public int Num1 = -1;
    public int Num2 = -1;
}  


public class WaveManager : MonoBehaviour
{
    
    public int NowWave;    //现在是第几波
    public int TotalWave;  //总共有几波
    
    public SmallWaveType NowSmallWaveType;
    public int NowSmallWave = 0;
    
    public float SmallWaveLife = 0;
    public float TimeLine = 0f;
    
    public bool CanSkip = false;
    public bool isWin = false; //注意这里只是用来判断怪物有没有出完，真正的胜利还要判断怪物有没有击杀完
    private int NowWave_old=0;
    //开始点
    public GameObject StartPoint;
    public GameObject SkipBotton;

    private AliceSohiiUniversalObjectPool objectPool;
    private GlobalValueManager globalValueManager;
    private Transform monsterSpawnPoint;
    public List<SmallWaveType> Wave = new List<SmallWaveType>();
    private GlobalUiController globalUiController;

    private Vector3 b;
    private void Start()
    {
        CalculateTotalWave();
        NowSmallWaveType = Wave[0];
        
        GameObject globalValueManagerObject = GameObject.Find("GlobalManager"); 
        if (globalValueManagerObject != null)  
        {
            objectPool = globalValueManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
            globalValueManager = globalValueManagerObject.GetComponent<GlobalValueManager>();
            globalUiController = globalValueManagerObject.GetComponent<GlobalUiController>();
            monsterSpawnPoint = globalValueManager.monsterSpawnPoint;
        }

        var a = monsterSpawnPoint.position;
        var b = new Vector3(a.x, a.y,a.z);
        DispWave();
    }

    void DispWave() 
    {
        if (NowWave_old == NowWave) 
        {
            return;
        }
        NowWave_old = NowWave;
        globalUiController.SetWaveText(NowWave_old+"/"+ TotalWave);
    }

    //计算总波数
    void CalculateTotalWave()
    {
        TotalWave = 0;
        //计算总波速方法（不可跳过的波+Start）
        foreach (var s in Wave)
        {
            if (s.waveType == SmallWaveType.WaveType.SkippableAwait || s.waveType == SmallWaveType.WaveType.Start)
            {
                TotalWave += 1;
            }
        }
    }
    //跳过等待
    public void Skip()
    {
        if (CanSkip)
        {
            SmallWaveLife = 0;
            CanSkip = false;
        }
            
    }

    private void Update()
    {
        if (!isWin)
        {
            SmallWaveLife -= Time.deltaTime;
            TimeLine += Time.deltaTime;
            if (SmallWaveLife <= 0f)
            {
                SmallWaveLife = ProcessWaveType();
            }
        }
        DispWave();
        if (CanSkip)
        {
            SkipBotton.SetActive(true);
        }
        else 
        {
            SkipBotton.SetActive(false);
        }
    }

    float  Delay()
    {
        float s = 0f;
        if (NowSmallWaveType.Num0 < 0)
            s = 0.2f;
        else
            s =  0.1f * (NowSmallWaveType.Num0);
        return s;
    }
    public float ProcessWaveType()
    {
        //执行下一微波的时间
        float s =0;
        switch (NowSmallWaveType.waveType)  
        {  
            case SmallWaveType.WaveType.Start:
                Debug.Log("开始游戏");
                s = float.MaxValue;
                CanSkip = true;
                NowWave += 1;
                break;  
            case SmallWaveType.WaveType.Await:
                s = Delay();
                //Debug.Log("不可跳过的等待" + NowSmallWaveType.Num0);
                CanSkip = false;
                break;  
            case SmallWaveType.WaveType.SkippableAwait:
                s = Delay();
                //Debug.Log("可跳过的等待" + NowSmallWaveType.Num0);
                NowWave += 1;
                CanSkip = true;
                break;  
            case SmallWaveType.WaveType.SpawnMonster1:
                s = Delay();
                SpawnMonster0();
                //Debug.Log("生成怪物1");
                CanSkip = false;
                break;  
            case SmallWaveType.WaveType.SpawnMonster2:
                s = Delay();
                //Debug.Log("生成怪物2");
                SpawnMonster1();
                CanSkip = false;
                break;  
            case SmallWaveType.WaveType.SpawnMonster3:
                s = Delay();
                //Debug.Log("生成怪物3");
                SpawnMonster2();
                CanSkip = false;
                break;  
            case SmallWaveType.WaveType.SpawnMonster4:
                s = Delay();
                //Debug.Log("生成怪物4");
                SpawnMonster3();
                CanSkip = false;
                break;  
            case SmallWaveType.WaveType.GetMoney:
                s = Delay();
                //Debug.Log("发钱");
                CanSkip = false;
                break;  
            case SmallWaveType.WaveType.Win:
                s = Delay();
                //Debug.Log("胜利");
                CanSkip = false;
                isWin = true;
                return s =float.MaxValue;
            default:  
                break;  
        }

        NowSmallWave += 1;
        NowSmallWaveType = Wave[NowSmallWave];
        return s;
    }
    
    void SpawnMonster0()
    {
        GameObject obj;
        obj = objectPool.Get(globalValueManager.MonsterPrefab0);
        var waypoints = obj.GetComponent<Monster>();
        waypoints.ReStart();
        obj.gameObject.transform.position = StartPoint.transform.position;
        globalValueManager.MonsterCount += 1;
    }
    void SpawnMonster1()
    {
        GameObject obj;
        obj = objectPool.Get(globalValueManager.MonsterPrefab1);
        var waypoints = obj.GetComponent<Monster>();
        waypoints.ReStart();
        obj.gameObject.transform.position = StartPoint.transform.position;
        globalValueManager.MonsterCount += 1;
    }
    void SpawnMonster2()
    {
        GameObject obj;
        obj = objectPool.Get(globalValueManager.MonsterPrefab1);
        var waypoints = obj.GetComponent<Monster>();
        waypoints.ReStart();
        obj.gameObject.transform.position = StartPoint.transform.position;
        globalValueManager.MonsterCount += 1;
    }
    void SpawnMonster3()
    {
        GameObject obj;
        obj = objectPool.Get(globalValueManager.MonsterPrefab1);
        var waypoints = obj.GetComponent<Monster>();
        waypoints.ReStart();
        obj.gameObject.transform.position = StartPoint.transform.position;
        globalValueManager.MonsterCount += 1;
    }
}  


