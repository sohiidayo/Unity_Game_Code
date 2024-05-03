using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Waypoints : MonoBehaviour {
    public static Transform[] positions;
    //存储每一个路径点的位置
    void Awake()
    {
        positions = new Transform[transform.childCount];
        for (int i = 0; i < positions.Length; i++)
        {
            //获取每一个子WayPoint的坐标
            positions[i] = transform.GetChild(i);
        }
    }

    public Transform Get0Transform()
    {
        return positions[0];
    }
}
