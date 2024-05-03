using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;

public class Monster : MonoBehaviour
{
    private AliceSohiiUniversalObjectPool objectPool;
    private GlobalValueManager globalValueManager;
    public float speed = 10;//移动速度
    public int hp = 150;
    public int attack=1;
    private int bounty=10;
    public Transform[] positions;//移动的路径点列表
    private int index = 0;//当前移动的路径点
    
    public float decelerate = 0;
    public float frail = 0;
    public float moreValuable = 0;

    public void SetBuff(float _decelerate =0f,float _frail = 0f,float _moreValuable = 0f)
    {
        decelerate = _decelerate;
        frail = _frail;
        moreValuable = _moreValuable;
    }

    void Move()
    {
        if (index > positions.Length - 1) return;
        //朝向路径点进行移动
        transform.Translate(Time.deltaTime * speed * (1 - decelerate) *
                            (positions[index].position - transform.position).normalized);
        if (Vector3.Distance(positions[index].position, transform.position) < 0.2f)
        {
            index++;//到达路径点后更新下一个路径点。
        }
        if (index > positions.Length - 1)
        {
            //到达最终路径点
            ReachDestination();
        }
    }
    private void Awake()  
    {  
        // 设置怪物对象的图层为"Monster"  
        int monsterLayer = LayerMask.NameToLayer("Monster");  
        gameObject.layer = monsterLayer;  
        this.tag = "Monster";
    }  
    void Start()
    {
        positions = Waypoints.positions;//获取路径点列表
        GameObject globalValueManagerObject = GameObject.Find("GlobalManager"); 
        if (globalValueManagerObject != null)  
        {
            objectPool = globalValueManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
            globalValueManager = globalValueManagerObject.GetComponent<GlobalValueManager>();
        }
    }
    public void ReStart()
    {
        index = 0;
        SetBuff();
    }
    private float timer; 
    void Update()
    {
        Move();
        timer += Time.deltaTime;
        if (timer > 1f)
        {
            SetBuff();
            timer = 0;
        }
    }
    public void TakeDamage(int damege = 0)
    {
        //Debug.Log("收到了伤害" + damege+"，实际受到伤害"+(int)(damege * (1 + frail)));
        damege = (int)(damege * (1 + frail));
        hp -= damege;
        if (hp <= 0)
        {
            Die();
        }
            
    }
    void Die()
    {
        //globalValueManager.MonsterCount -= 1;
        //Debug.Log("1");
        //Debug.Log("获得赏金" + bounty+"，实际获得赏金"+(int)(bounty*(1+moreValuable)));
        globalValueManager.ReLoadMonsterCount();
        globalValueManager.MakeMoney((int)(bounty*(1+moreValuable)));
        objectPool.Remove(gameObject);
        
    }
    void ReachDestination()//到达终点后销毁自己
    {
        //globalValueManager.MonsterCount -= 1;
        globalValueManager.TakeDamage(attack);
        objectPool.Remove(gameObject); 
    }
}
