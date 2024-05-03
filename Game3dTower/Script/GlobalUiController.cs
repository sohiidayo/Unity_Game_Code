using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;



public class GlobalUiController : MonoBehaviour
{
    private AliceSohiiUniversalObjectPool objectPool;
    private GlobalValueManager globalValueManager;
    
    public  Text moneyUIText;
    public Text hpUIText;
    public Text waveUIText;
    // Start is called before the first frame update
    //void Start()
    //{
        //moneyUIText = GameObject.Find("MoneyUIText").GetComponent<Text>();
        //hpUIText = GameObject.Find("HpUIText").GetComponent<Text>(); 
        //waveUIText = GameObject.Find("WaveUIText").GetComponent<Text>(); 
    //}
    public void SetMoneyText(string newText)
    {
        try
        {
            moneyUIText.text = newText;
        }
        catch { }
    }  
    public void SetHpText(string newText)  
    {  
        hpUIText.text = newText;  
    } 
    public void SetWaveText(string newText)  
    {  
        waveUIText.text = newText;  
    } 

}
