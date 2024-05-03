using System.Collections;
using UnityEngine;

public class AliceSohiiScreenPartcle : MonoBehaviour
{
    [Header("鼠标轨迹")]
    //鼠标轨迹
    public GameObject mouseTrail;
    public float distanceFromCamera = 5;
    [Space(10)]
    [Header("鼠标左键点击粒子")]
    public GameObject clickParicle;
    public int clickParicleDefaultCount=16;
    public int clickParicleMaxCount=32;
    [Space(10)]
    [Header("鼠标左键长按拖动粒子")]
    public GameObject moveParicle;
    public int moveParicledDefaultCount=8;
    public int moveParicleMaxCount=16;
    
    [HideInInspector]
    public Vector3 mousePositionInWorld;
    
    private Camera thisCamera;
    private Vector3 mousePos ;
    private AliceSohiiUniversalObjectPool objectPool;
    private GameObject useMoveParicle;
    private float timer=-1.5f;
    private float delayTime = 0.1f;
    private Vector3 nowPos;
    private Vector3 oldPos;
    private float lengthCount;
    private float length=120;
    private GameObject useMoveParicle1;
    private GameObject useMoveParicle2;
    [Space(10)]
    public bool isOn = false;  
    void InstantiatePrefab()
    {
        //初始化拖尾
        mouseTrail = Instantiate(mouseTrail,mousePositionInWorld,Quaternion.identity);
        
        //初始化对象池
        AliceSohiiUniversalObjectType[] objectTypes = new AliceSohiiUniversalObjectType[2];
        objectTypes[0] = new AliceSohiiUniversalObjectType(clickParicle, clickParicleDefaultCount, clickParicleMaxCount);
        objectTypes[1] = new AliceSohiiUniversalObjectType(moveParicle, moveParicledDefaultCount, moveParicleMaxCount);
        objectPool=gameObject.AddComponent<AliceSohiiUniversalObjectPool>();
        objectPool.ObjectTypes = objectTypes;
        objectPool.Init();
        //初始化移动粒子
        //useMoveParicle = objectPool.Get(moveParicle);
        //useMoveParicle.SetActive(false);
        
    }
    void Start()
    {
        thisCamera = GetComponent<Camera>();
        CalculationMousePositionInWorld();
        InstantiatePrefab();
    }
    void Update()
    {
        // 检查是否按下了数字键1  
        //if (Input.GetKeyDown(KeyCode.Alpha1))  
        //{  
        //    // 切换布尔值的状态  
        //    isOn = !isOn;  
        //
        //}

        if (isOn)
        {        CalculationMousePositionInWorld();
            UseMouseTrail();
            UseClickParicle();
            UseMoveParicle();
        }


    }
    void CalculationMousePositionInWorld()
    {
        mousePos = Input.mousePosition;
        mousePositionInWorld=thisCamera.ScreenToWorldPoint(new Vector3(mousePos.x, mousePos.y, distanceFromCamera));
        
    }
    void UseMouseTrail()
    {
        mouseTrail.transform.position = mousePositionInWorld;
    }
    void UseClickParicle()
    {        
        if (Input.GetMouseButtonDown(0))
        {
            var Obj = objectPool.Get(clickParicle);
            Obj.transform.position = mousePositionInWorld;
            Obj.transform.LookAt(this.thisCamera.transform);
            StartCoroutine(RemoveAfterSeconds(3.0f, Obj));
        }
    }
    void UseMoveParicle()
    {
        //固定距离效果最好用
        nowPos = Input.mousePosition;
        if (Input.GetMouseButton(0))
        { //鼠标按下不松手
            Vector3 offset = nowPos - oldPos;
            float offsetFloat = Mathf.Abs(offset.x) + Mathf.Abs(offset.y);
            lengthCount += offsetFloat ;
            //Debug.Log(lengthCount+" and "+length+" and "+offsetFloat);
            if (lengthCount > length)
            {
                useMoveParicle = objectPool.Get(moveParicle);
                useMoveParicle.transform.position = mousePositionInWorld;
                StartCoroutine(RemoveAfterSeconds(.5f, useMoveParicle));
                lengthCount -= length;
                timer = -1.5f;

            }
            if(offsetFloat<5)
            {
                timer += Time.deltaTime;
                //Debug.Log(timer);
                if(timer >= delayTime)
                {
                    //按下左键每距离一秒发射粒子
                    useMoveParicle = objectPool.Get(moveParicle);
                    useMoveParicle.transform.position = mousePositionInWorld;
                    useMoveParicle1 = objectPool.Get(moveParicle);
                    useMoveParicle1.transform.position = mousePositionInWorld;
                    useMoveParicle2 = objectPool.Get(moveParicle);
                    useMoveParicle2.transform.position = mousePositionInWorld;
                    StartCoroutine(RemoveAfterSeconds(.5f, useMoveParicle));
                    StartCoroutine(RemoveAfterSeconds(.5f, useMoveParicle1));
                    StartCoroutine(RemoveAfterSeconds(.5f, useMoveParicle2));
                    timer = 0;
                }
            }

            
        }
        else
        {
            timer = -1.5f;
            //Debug.Log(timer);
        }

        oldPos = Input.mousePosition;
        //移动类粒子
        // if (Input.GetMouseButton(0))
        // {
        //     useMoveParicle.SetActive(true);
        //     useMoveParicle.transform.position = mousePositionInWorld;
        // }
        //
        // if (Input.GetMouseButtonUp(0))
        // {
        //     
        //     GameObject obj = useMoveParicle;
        //     useMoveParicle = objectPool.Get(moveParicle);
        //     useMoveParicle.SetActive(false);
        //     StartCoroutine(RemoveAfterSeconds(3.0f, obj));
        // }
        
        //按下鼠标后每隔0.1s发射一次粒子，效果不好
         // if (Input.GetMouseButton(0))
         // {
         //     timer += Time.deltaTime;
         //     if(timer >= delayTime)
         //     {
         //         //按下左键每距离一秒发射粒子
         //         
         //         useMoveParicle = objectPool.Get(moveParicle);
         //         useMoveParicle.transform.position = mousePositionInWorld;
         //         StartCoroutine(RemoveAfterSeconds(.3f, useMoveParicle));
         //         timer = 0;
         //     }
         // }
         // else
         // {
         //     timer = -3f;
         // }
    }
    IEnumerator RemoveAfterSeconds(float seconds,GameObject obj)
    {
        yield return new WaitForSeconds(seconds);
        objectPool.Remove(obj);
    }

}

