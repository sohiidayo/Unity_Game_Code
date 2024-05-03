using System;
using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.EventSystems;
using UnityEngine.UIElements;

public class Base : MonoBehaviour
{
    //标记是否可以建造
    public bool isBuild = true;
    //在这之上建造的防御塔
    public GameObject Build = null;
    public turret turret;
    //临时 预制件种类
    public GameObject prefab;
    private GlobalValueManager globalValueManager;
    private AliceSohiiUniversalObjectPool objectPool;
    private bool hasAddedPhysics = false;
    private bool mouseInThis = false;
    //鼠标游动时上浮 最大距离
    public float moveDistance = 1f; // 最大位移距离
    public float frameMoveDistance = 0.1f; //每帧位移的距离
    private float nowMoveDistance; //已经移动的距离
    // private bool isTop = false;//表示是否到顶
    // private bool isUping = false;//表示是否在上升阶段
    // private bool isBottom = true;

    //private Ray ray;
    enum MovementStatus
    {
        Bottom,
        Uping,
        Top,
        Decline
    }

    private MovementStatus movementStatus = MovementStatus.Bottom;

    void Start()
    {
        //ray = Camera.main.ScreenPointToRay(Input.mousePosition); 
        isBuild = true;
        //自动添加触发器
        if (!hasAddedPhysics)
        {
            // 添加Rigidbody组件  
            Rigidbody rb = gameObject.AddComponent<Rigidbody>();
            rb.isKinematic = true; // 设置为动力学刚体，如果你不需要物理模拟可以设置为false  
            BoxCollider boxCollider = gameObject.AddComponent<BoxCollider>();
            boxCollider.isTrigger = true; // 设置为触发器  
            hasAddedPhysics = true;
        }

        GameObject globalManagerObject = GameObject.Find("GlobalManager");
        if (globalManagerObject != null)
        {
            objectPool = globalManagerObject.GetComponent<AliceSohiiUniversalObjectPool>();
            globalValueManager = globalManagerObject.GetComponent<GlobalValueManager>();
        }

    }

    //在基座之上建造炮塔
    public void Building()
    {
        //通过预制件种类来从对象池获取对象
        Build = objectPool.Get(prefab);
        //设定位置
        Build.transform.position = transform.position;
        //上偏移距离
        Vector3 position = Build.transform.position;
        Build.transform.position = new Vector3(position.x, position.y + .9f, position.z);
        turret = Build.GetComponent<turret>();
        turret._base = this;
    }

    //移除上面的塔
    public void Remove()
    {
        turret._base = null;
        turret = null;
        objectPool.Remove(Build);
    }

    public void Upgrade()
    {
        prefab = turret.Upgraded;
        turret._base = null;
        turret = null;
        objectPool.Remove(Build);
        Building();
    }

    // Update is called once per frame
    void Update()
    {
        if( globalValueManager._SelectBase == this)
        {
            OnMouseEnterRay();
        }
        else
        {
            OnMouseExitRay();
        }
        //UseRayGetMouseInThis();

        switch (movementStatus)
        {
            case MovementStatus.Bottom:
                if (isBuild == false)
                {
                    movementStatus = MovementStatus.Uping;
                    break;
                }
                if (mouseInThis && EventSystem.current.IsPointerOverGameObject() == false) //鼠标在这里 && 不在Ui上 && 在最底部
                {
                    movementStatus = MovementStatus.Uping;
                }
                break;
            case MovementStatus.Uping:
                if (mouseInThis && EventSystem.current.IsPointerOverGameObject() == false) //鼠标在这里 && 不在Ui上 
                {
                    Vector3 currentPosition = transform.position;
                    Vector3 newPosition = new Vector3(currentPosition.x, currentPosition.y + frameMoveDistance,
                        currentPosition.z);
                    transform.position = newPosition;
                    nowMoveDistance += frameMoveDistance;
                    //Debug.Log("已经上移了" + nowMoveDistance + " 每次移动" + frameMoveDistance);
                    if (nowMoveDistance >= moveDistance)
                    {
                        movementStatus = MovementStatus.Top;
                    }
                    if (isBuild == false) //代表有建筑物建造完成
                    {
                        Vector3 currentPosition0 = Build.transform.position;
                        Vector3 newPosition0 = new Vector3(currentPosition0.x, currentPosition0.y + frameMoveDistance,
                            currentPosition0.z);
                        Build.transform.position = newPosition0;
                    }
                }
                else
                {
                    movementStatus = MovementStatus.Decline;
                }

                break;
            case MovementStatus.Top:
                // if (mouseInThis || !isBuild) //鼠标不在这里 or 没建造过物体
                // {
                //     movementStatus = MovementStatus.Decline;
                // }
                if (isBuild == false)
                {
                    movementStatus = MovementStatus.Top;
                    break;
                }
                if (mouseInThis)
                {
                    movementStatus = MovementStatus.Top;
                }
                if (!mouseInThis)
                {
                    movementStatus = MovementStatus.Decline;
                }
                break;
            case MovementStatus.Decline:
                if (isBuild == false)
                {
                    movementStatus = MovementStatus.Uping;
                    break;
                }
                if (!mouseInThis) //鼠标不在这里
                {
                    Vector3 currentPosition = transform.position;
                    Vector3 newPosition = new Vector3(currentPosition.x, currentPosition.y - frameMoveDistance,
                        currentPosition.z);
                    transform.position = newPosition;
                    nowMoveDistance -= frameMoveDistance;
                    //Debug.Log("已经上移了"+ nowMoveDistance+" 每次移动" + frameMoveDistance);
                    if (nowMoveDistance <= 0)
                    {
                        movementStatus = MovementStatus.Bottom;
                    }
                }
                else
                {
                    movementStatus = MovementStatus.Uping;
                }

                break;
        }
        //下面是建造相关的
        if (Input.GetMouseButtonDown(0) && mouseInThis
                                        && EventSystem.current.IsPointerOverGameObject() == false)
            //鼠标左键按下 and 鼠标在这里 and 鼠标不在ui上
        {
            // Debug.Log("点击了物体");
            prefab = globalValueManager.SelectPrefab;
            if (isBuild && prefab != null)
            {
                //Debug.Log("建造物体");
                if (globalValueManager.SpendMoney(100))
                {
                    Building();
                    globalValueManager.Deselect();
                    isBuild = false;
                }

            }
        }

        if (Input.GetMouseButtonDown(1) && mouseInThis
                                        && EventSystem.current.IsPointerOverGameObject() == false)
            //鼠标右键键按下 and 鼠标在这里 and 鼠标不在ui上
        {
            if (Build is null)
            {
                Remove();
                globalValueManager.SpendMoney(50);
                isBuild = true;
                globalValueManager.Deselect();
            }
        }
        if (Input.GetMouseButtonDown(3) && mouseInThis
                                        && EventSystem.current.IsPointerOverGameObject() == false)
            //鼠标右键键中键 and 鼠标在这里 and 鼠标不在ui上
        {
            if (globalValueManager.SpendMoney(100))
            {
                Upgrade();
            }
        }

    }
    //在全局变量管理器内实现选择
    public void OnMouseEnterRay()
    {
        //Debug.Log("鼠标移入");
        mouseInThis = true;
    }
    public void OnMouseExitRay()
    {
        //鼠标移出
        //Debug.Log("鼠标移出");
        mouseInThis = false;
    }
}
