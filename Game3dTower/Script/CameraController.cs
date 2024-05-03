using System.Collections;
using System.Collections.Generic;
using UnityEngine;  
  
public class CameraController : MonoBehaviour  
{  
    public float speed = 5.0f; // 相机移动速度  
  
    void Update()  
    {  
        float moveHorizontal = Input.GetAxis("Horizontal");  
        float moveVertical = Input.GetAxis("Vertical");  
        float moveDistance = moveHorizontal * speed;
        Vector3 moveVector = new Vector3(moveDistance, 0, 0);  
        transform.Translate(moveVector * Time.deltaTime);  
        
    }  
}