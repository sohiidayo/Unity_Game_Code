using System;
using Unity.VisualScripting;
using UnityEngine;  
  
public class Bullet : MonoBehaviour
{
    public GameObject target;
    public float speed = 10;
    public int harm = 10;
    private float life = 25f;
    private AliceSohiiUniversalObjectPool objectPool;
    private Vector3 targetPos;
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
    }
    void Update()
    {
        if (target != null)
        {
            var a = target.transform.position;
            transform.LookAt(a);
            targetPos = a;
        }
        // 移动物体朝向目标  
        var b = transform.position;
        //Vector3 movement = (targetPos - b).normalized * speed * Time.deltaTime;  
        // 计算从当前位置到目标位置的向量  
        Vector3 directionToTarget = targetPos - b;  
        // 归一化向量以获取方向  
        Vector3 normalizedDirection = directionToTarget.normalized;  
        // 根据速度和deltaTime计算移动向量  
        Vector3 movement = Time.deltaTime * speed  * normalizedDirection  ;

        transform.position += movement;

        life -= Time.deltaTime;
        if (life <= 0)
        {
            objectPool.Remove(gameObject);
        }
        Vector3 dir = targetPos - transform.position;
        if (dir.magnitude < 0.1f)
        {
            objectPool.Remove(gameObject);
        }
    }
    private void OnCollisionEnter(Collision collision)
    {
        GameObject collidedObject = collision.gameObject;  
        if (collidedObject.CompareTag("Monster"))  
        {  
            var i = collidedObject.GetComponent<Monster>();
            i.TakeDamage(harm);
            //Debug.Log("碰撞到怪物: " + collidedObject.name);
            objectPool.Remove(gameObject);
        }  
    } 
}