using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Missile : MonoBehaviour
{

    public GameObject target;
    public int harm = 10;
    private AliceSohiiUniversalObjectPool objectPool;
    private Vector3 targetPos;
    public GameObject ThisObj;
    public float CurrentVelocity = 0.0f;//当前速度
    public float accelerationPeriod = 0.5f;//上升期时间
    public float lifeTime = 25.0f;//生命周期
    public float maximumVelocity = 30.0f;//最大速度
    public float AcceleratedVeocity = 12.8f;//加速度
    public float MaximumLifeTime = 100.0f;//最大生命周期
    public float maximumRotationSpeed = 120.0f;//最大转弯角度
    // Start is called before the first frame update
    public void SetTarget(GameObject _target)
    {
        target = _target;
    }

    private void Start()
    {
        GameObject globalManagerObject = GameObject.Find("GlobalManager");
        if (globalManagerObject != null)
        {
            objectPool = globalManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
        }
        ThisObj = gameObject;
    }

    void Update()
    {
        float deltaTime = Time.deltaTime;
        lifeTime += deltaTime;
        if( lifeTime > MaximumLifeTime )//超出时间线直接爆炸
        {
            Explode();
            return;
        }
        if (target == null || !target.activeInHierarchy )//目标消失
        {
            FindMonster();
            //Debug.Log(transform.forward * CurrentVelocity * deltaTime);
            // transform.position += transform.forward * CurrentVelocity * deltaTime;
            // return;
        }
        if (target  is null)
        {
            transform.position += CurrentVelocity * deltaTime * transform.forward ;
            return;
        }
        // 计算朝向目标的方向偏移量，如果处于上升期，则忽略目标
        // Vector3 offset =
        //     ((lifeTime < accelerationPeriod) && (target != null))
        //         ? Vector3.up
        //         : (target.transform.position - transform.position).normalized;
        //
        try
        {
            Vector3 offset =
                ((lifeTime < accelerationPeriod) && (target != null))
                    ? Vector3.up
                    : (target.transform.position - transform.position).normalized;

        // 计算当前方向与目标方向的角度差
        float angle = Vector3.Angle(transform.forward, offset);
        // 根据最大旋转速度，计算转向目标共计需要的时间
        float needTime = angle / ( maximumRotationSpeed * ( CurrentVelocity / maximumVelocity ));
        // 如果角度很小，就直接对准目标
        if (needTime < 0.001f)
        {
            transform.forward = offset;
        }
        else
        {
            // 当前帧间隔时间除以需要的时间，获取本次应该旋转的比例。
            transform.forward = Vector3.Slerp(transform.forward, offset, deltaTime / needTime).normalized;
        }
        // 如果当前速度小于最高速度，则进行加速
        if (CurrentVelocity < maximumVelocity )
            CurrentVelocity += deltaTime * AcceleratedVeocity;
        //位移
        //Debug.Log(transform.forward * CurrentVelocity * deltaTime);
        transform.position +=  deltaTime * CurrentVelocity * transform.forward  ;
            //Vector3 dir = target.transform.position - transform.position;
        }
        catch { }
    }
    private void Explode()
    {
        objectPool.Remove(this.gameObject);
        //Debug.Log("爆炸了");
    }
    void FindMonster()  
    {  
        GameObject[] monsters = GameObject.FindGameObjectsWithTag("Monster");  
        // 遍历物体数组  
        foreach (GameObject monster in monsters)  
        {  
            // 检查物体是否在场景中激活  
            if (monster.activeInHierarchy)  
            {  
                target = monster;
                return;
            }  
        }  
    }  
    private void OnCollisionEnter(Collision collision)
    {
        GameObject collidedObject = collision.gameObject; 
        //Debug.Log("碰撞到物体: " + collidedObject.name);
        if (collidedObject.CompareTag("Monster"))  
        {  
            var i = collidedObject.GetComponent<Monster>();
            i.TakeDamage(harm);
            //Debug.Log("碰撞到怪物: " + collidedObject.name);
            //objectPool.Remove(gameObject);
        }  
        objectPool.Remove(ThisObj);
    } 
}
